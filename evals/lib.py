"""Shared helpers for the Blue Pencil evaluation pilot.

Everything here is plain Python 3 standard library. Model calls go through
`claude -p` (Claude Code in non-interactive mode), the same mechanism that
Anthropic's skill-creator scripts use, so no separate API key is required.
"""

import hashlib
import json
import os
import re
import shutil
import subprocess
import tempfile
import time
from pathlib import Path

EVALS = Path(__file__).resolve().parent
REPO = EVALS.parent

# One fixed executor model for both conditions. Graders default to a different
# model so the grader is not the same system whose output it is judging.
EXECUTOR_MODEL = "claude-sonnet-5-5"
GRADER_MODEL = "claude-opus-5-5"

FENCE = "```"


def read_json(path):
    return json.loads(Path(path).read_text())


def write_json(path, obj):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, indent=2, ensure_ascii=False) + "\n")


def git_sha():
    try:
        return subprocess.run(
            ["git", "-C", str(REPO), "rev-parse", "HEAD"],
            capture_output=True, text=True, timeout=10,
        ).stdout.strip()
    except Exception:
        return "unknown"


def skill_version():
    try:
        return (REPO / "VERSION").read_text().strip()
    except OSError:
        return "unknown"


# What make_workspace copies into a with-skill trial, relative to the repo root.
SKILL_FILES = ("SKILL.md", "references", "examples", ".claude/commands", ".claude/agents")


def skill_fingerprint():
    """Hash of every file a with-skill trial sees, so a resumed run can tell whether the
    skill changed even when VERSION did not."""
    h = hashlib.sha256()
    for name in SKILL_FILES:
        base = REPO / name
        files = [base] if base.is_file() else sorted(p for p in base.rglob("*") if p.is_file())
        for f in files:
            h.update(str(f.relative_to(REPO)).encode() + b"\0" + f.read_bytes() + b"\0")
    return h.hexdigest()[:16]


def rubric_version():
    """The version in rubric.md's title, e.g. "v0.3"."""
    m = re.search(r"\((?:draft )?(v[0-9.]+)\)", (EVALS / "rubric.md").read_text().splitlines()[0])
    return m.group(1) if m else "unknown"


def case_fingerprint(case_id):
    """Hash of the files that make up one case's prompt and original passage, plus its
    source in cases.json, which decides the example held out of the with-skill workspace."""
    h = hashlib.sha256()
    catalog = {c["id"]: c for c in read_json(EVALS / "cases" / "cases.json")["cases"]}
    h.update(str(catalog.get(case_id, {}).get("source")).encode() + b"\0")
    for name in ("context.txt", "request.txt", "input.txt"):
        h.update(name.encode() + b"\0" + (EVALS / "cases" / case_id / name).read_bytes() + b"\0")
    return h.hexdigest()[:16]


def changed_cases(meta, case_ids, root=None):
    """Cases whose files differ from the fingerprint the run recorded. Outputs of such
    a case were produced from different input, so they must not be graded against
    the current files. For a run that recorded no fingerprint for a case, every saved
    prompt.txt under `root` must equal the prompt the current case files give; a case
    with no saved prompt to check counts as changed."""
    recorded = meta.get("case_fingerprints", {})
    out = []
    for c in case_ids:
        if c in recorded:
            if recorded[c] != case_fingerprint(c):
                out.append(c)
            continue
        from run_pilot import build_prompt, load_case  # imported here: run_pilot imports lib
        case = load_case(c)
        prompts = list((Path(root) / f"eval-{c}").glob("*/run-*/prompt.txt")) if root else []
        if not prompts or not all(p.read_text() == build_prompt(case, p.parent.parent.name) for p in prompts):
            out.append(c)
    return out


def claude_version():
    try:
        return subprocess.run(
            ["claude", "--version"], capture_output=True, text=True, timeout=20
        ).stdout.strip()
    except Exception:
        return "unknown"


def total_tokens(model_usage):
    """All tokens of a session, summed over every model it used. The result's top-level
    `usage` covers only the final turn and leaves out subagent calls (paper-reviser), so
    it undercounts the with-skill condition; `modelUsage` has the aggregates."""
    keys = ("inputTokens", "outputTokens", "cacheReadInputTokens", "cacheCreationInputTokens")
    return sum(m.get(k, 0) for m in (model_usage or {}).values() for k in keys)


def call_claude(prompt, model, cwd, flags=(), timeout=600, stream=False):
    """Run one clean `claude -p` session and return a result dict.

    Each call is a fresh session (nothing persisted, nothing shared with other
    calls). With stream=True the full event stream is captured so we can later
    check, for example, whether the Blue Pencil skill was really loaded.
    """
    cmd = ["claude", "-p", prompt, "--model", model, "--no-session-persistence"]
    if stream:
        cmd += ["--output-format", "stream-json", "--verbose"]
    else:
        cmd += ["--output-format", "json"]
    cmd += list(flags)
    env = {k: v for k, v in os.environ.items() if k != "CLAUDECODE"}
    start = time.time()
    proc = subprocess.run(
        cmd, cwd=str(cwd), env=env, capture_output=True, text=True, timeout=timeout,
        stdin=subprocess.DEVNULL,
    )
    elapsed = time.time() - start
    out = {"returncode": proc.returncode, "seconds": round(elapsed, 1),
           "stderr": proc.stderr[-2000:], "text": "", "usage": {}, "cost_usd": None,
           "model_usage": {}, "events": None, "raw": proc.stdout}
    if stream:
        events = []
        for line in proc.stdout.splitlines():
            line = line.strip()
            if not line:
                continue
            try:
                events.append(json.loads(line))
            except json.JSONDecodeError:
                pass
        out["events"] = events
        result = next((e for e in reversed(events) if e.get("type") == "result"), {})
    else:
        try:
            result = json.loads(proc.stdout)
        except json.JSONDecodeError:
            result = {}
    out["text"] = result.get("result") or ""
    out["usage"] = result.get("usage", {})
    out["cost_usd"] = result.get("total_cost_usd")
    out["model_usage"] = result.get("modelUsage", {})
    out["is_error"] = bool(result.get("is_error")) or proc.returncode != 0
    return out


def extract_revised(text, original=None):
    """Return the revised passage from a model reply, or None.

    Blue Pencil replies have a '### 2. Revised text' heading followed by a
    fenced block; a plain Claude reply may have no heading, and then the first
    fenced block is taken.
    """
    m = re.search(r"###\s*2\.\s*Revised text\s*\n+(?= {0,3}(?:```|~~~))", text)
    # With the heading present, only the block under it counts: falling back to the whole
    # reply could pick up an earlier, unrelated block.
    return _fenced_block(text[m.end():], original) if m else _fenced_block(text, original)


def _fence_lines(text):
    return sum(bool(re.match(r"\s*(`{3,}|~{3,})", ln)) for ln in text.split("\n"))


def _fenced_block(text, original=None):
    """Contents of the first fenced block in text, or None.

    A passage may itself contain fenced blocks, so the closing fence is matched by
    nesting: a fence line with an info string ("```python") opens an inner block, a
    bare fence closes the innermost open one, and the outer block ends at the bare
    fence that closes it (at least as long as the opening fence, per CommonMark).
    A bare inner block is ambiguous (its opening fence looks like the outer close), so
    when the original passage is given, the outer block ends at the first bare fence
    that leaves inside it as many fence lines as the original has; code blocks are
    protected, so a faithful revision keeps them all.
    """
    lines = text.split("\n")
    for i, ln in enumerate(lines):
        m = re.match(r"\s*(`{3,}|~{3,})", ln)
        if not m:
            continue
        outer, depth = m.group(1), 0
        if original is not None and _fence_lines(original):
            want = _fence_lines(original)
            for j in range(i + 1, len(lines)):
                f = re.match(r"\s*(`{3,}|~{3,})\s*$", lines[j])
                if (f and f.group(1)[0] == outer[0] and len(f.group(1)) >= len(outer)
                        and _fence_lines("\n".join(lines[i + 1:j])) == want):
                    return "\n".join(lines[i + 1:j]).strip()
        for j in range(i + 1, len(lines)):
            f = re.match(r"\s*(`{3,}|~{3,})(.*)$", lines[j])
            if not f or f.group(1)[0] != outer[0]:
                continue
            if f.group(2).strip():
                depth += 1
            elif depth:
                depth -= 1
            elif len(f.group(1)) >= len(outer):
                return "\n".join(lines[i + 1:j]).strip()
        return None
    return None


def extract_json(text):
    """Pull the last JSON object out of a model reply (graders reply in JSON)."""
    blocks = re.findall(FENCE + r"(?:json)?\s*\n(.*?)\n" + FENCE, text, re.S)
    candidates = blocks[::-1] + [text]
    for cand in candidates:
        start = cand.find("{")
        end = cand.rfind("}")
        if start != -1 and end > start:
            try:
                return json.loads(cand[start:end + 1])
            except json.JSONDecodeError:
                continue
    return None


def skill_was_loaded(events, workspace):
    """True if the event stream shows the trial's own copy of Blue Pencil being loaded.

    Counts only a Read of the workspace's .claude/skills/blue-pencil/SKILL.md (the
    subagent's tool calls are in the stream) or a Skill call for blue-pencil. The
    Agent call that starts the paper-reviser subagent does not count, since the
    subagent can fail before it reads the skill, and neither does a Read of a copy
    installed elsewhere on the machine, or a call whose result is an error. Free
    text never counts.
    """
    skill_md = str(Path(workspace) / ".claude" / "skills" / "blue-pencil" / "SKILL.md")
    calls, ok = set(), set()
    for e in events or []:
        for item in (e.get("message", {}).get("content") or []):
            if not isinstance(item, dict):
                continue
            if e.get("type") == "assistant" and item.get("type") == "tool_use":
                inp = item.get("input") or {}
                if ((item.get("name") == "Read" and inp.get("file_path") == skill_md)
                        or (item.get("name") == "Skill"
                            and str(inp.get("skill", "")).split(":")[-1] == "blue-pencil")):
                    calls.add(item.get("id"))
            # The call counts only if its result came back without an error.
            elif e.get("type") == "user" and item.get("type") == "tool_result" and not item.get("is_error"):
                ok.add(item.get("tool_use_id"))
    return bool(calls & ok)


def other_skills_used(events):
    """Skills other than Blue Pencil that a trial invoked with the Skill tool. A user-level
    skill installed on the machine is visible to the trial, so a call to one means the
    trial did not run on Blue Pencil alone."""
    names = set()
    for e in events or []:
        if e.get("type") != "assistant":
            continue
        for item in (e.get("message", {}).get("content") or []):
            if isinstance(item, dict) and item.get("type") == "tool_use" and item.get("name") == "Skill":
                name = str((item.get("input") or {}).get("skill", ""))
                if name != "blue-pencil" and not name.startswith(("paper:", "blue-pencil:")):
                    names.add(name)
    return sorted(names)


def transcript_events(run_dir):
    p = Path(run_dir) / "transcript.jsonl"
    return [json.loads(ln) for ln in p.read_text().splitlines() if ln.strip()] if p.exists() else []


def outside_reads(run_dir):
    """reads_outside_workspace for a saved trial's transcript ([] when there is none)."""
    p = Path(run_dir) / "transcript.jsonl"
    if not p.exists():
        return []
    return reads_outside_workspace([json.loads(ln) for ln in p.read_text().splitlines() if ln.strip()])


def reads_outside_workspace(events):
    """Paths that Read, Grep, or Glob calls touched outside the trial's own workspace.

    The workspace is the bp-eval-* temp directory the trial ran in. A with-skill trial
    that reads elsewhere (for example a Blue Pencil copy installed in the home
    directory) did not run only on the skill files the run recorded."""
    calls, ok, cwd = {}, set(), None
    for e in events or []:
        if e.get("type") == "system" and e.get("subtype") == "init":
            cwd = e.get("cwd") or cwd
        for item in (e.get("message", {}).get("content") or []):
            if not isinstance(item, dict):
                continue
            if (e.get("type") == "assistant" and item.get("type") == "tool_use"
                    and item.get("name") in ("Read", "Grep", "Glob")):
                inp = item.get("input") or {}
                # Glob may give no path and put the location in its pattern ("../outside/**").
                where = inp.get("file_path") or inp.get("path") or (
                    inp.get("pattern") if item.get("name") == "Glob" else "")
                calls[item.get("id")] = str(where or "")
            elif e.get("type") == "user" and item.get("type") == "tool_result" and not item.get("is_error"):
                c = item.get("content")
                text = c if isinstance(c, str) else json.dumps(c)
                if not re.match(r"\s*No (files|matches) found", text):
                    ok.add(item.get("tool_use_id"))
    ws = cwd or next((m.group(0) for p in calls.values() for m in [re.match(r".*/bp-eval-[^/]+", p)] if m), None)
    # A relative path ("../other") is resolved against the trial's working directory.
    if cwd:
        calls = {k: (os.path.normpath(os.path.join(cwd, p)) if p and not p.startswith(("/", "~")) else p)
                 for k, p in calls.items()}
    # "..", ".", and doubled slashes are resolved in every path before the containment check.
    calls = {k: (os.path.normpath(p) if p.startswith("/") else p) for k, p in calls.items()}
    # Only calls that returned something count: a read that was blocked or failed, or a
    # search that found nothing, saw no files.
    return sorted({p for cid, p in calls.items() if cid in ok and p.startswith(("/", "~"))
                   and not (ws and (p == ws or p.startswith(ws.rstrip("/") + "/")))})


def make_workspace(with_skill, paper_context, held_out=()):
    """Create a throwaway working directory for one trial.

    Both conditions get the same AGENTS.md carrying the paper context, so the only
    difference between them is the skill.
    with_skill=True: also Blue Pencil's commands, subagent and skill installed
    project-locally, which is how a real user's repo looks after `install.sh --init`.
    with_skill=False: nothing else, so nothing from this repo is visible.
    held_out: example files (names under examples/) left out of the skill copy.
    The case being edited is held out, because its example file holds the
    authored answer for that same passage.
    """
    ws = Path(tempfile.mkdtemp(prefix="bp-eval-"))
    if with_skill:
        shutil.copytree(REPO / ".claude" / "commands", ws / ".claude" / "commands")
        shutil.copytree(REPO / ".claude" / "agents", ws / ".claude" / "agents")
        skill_dir = ws / ".claude" / "skills" / "blue-pencil"
        skill_dir.mkdir(parents=True)
        shutil.copy(REPO / "SKILL.md", skill_dir / "SKILL.md")
        shutil.copytree(REPO / "references", skill_dir / "references")
        shutil.copytree(REPO / "examples", skill_dir / "examples",
                        ignore=lambda d, names: [n for n in names if n in held_out])
    (ws / "AGENTS.md").write_text("# Paper context\n\n" + paper_context.strip() + "\n")
    return ws
