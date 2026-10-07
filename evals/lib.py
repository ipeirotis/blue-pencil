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


def claude_version():
    try:
        return subprocess.run(
            ["claude", "--version"], capture_output=True, text=True, timeout=20
        ).stdout.strip()
    except Exception:
        return "unknown"


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


def extract_revised(text):
    """Return the revised passage from a model reply, or None.

    Blue Pencil replies have a '### 2. Revised text' heading followed by a
    fenced block; a plain Claude reply may have no heading, so fall back to the
    first fenced block.
    """
    m = re.search(r"###\s*2\.\s*Revised text\s*\n+" + FENCE + r"[^\n]*\n(.*?)\n" + FENCE,
                  text, re.S)
    if m:
        return m.group(1).strip()
    m = re.search(FENCE + r"[^\n]*\n(.*?)\n" + FENCE, text, re.S)
    return m.group(1).strip() if m else None


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


def skill_was_loaded(events):
    """True if the event stream shows a tool call that invokes or reads Blue Pencil.

    Looks only at tool calls (the Agent call to the paper-reviser subagent, or a
    Read of the skill's SKILL.md), never at free text, so the mere presence of
    the word in the prompt cannot count.
    """
    markers = ("blue-pencil", "paper-reviser")
    for e in events or []:
        if e.get("type") != "assistant":
            continue
        for item in (e.get("message", {}).get("content") or []):
            if item.get("type") == "tool_use":
                payload = json.dumps(item.get("input", {})) + item.get("name", "")
                if any(mk in payload for mk in markers):
                    return True
    return False


def make_workspace(with_skill, paper_context):
    """Create a throwaway working directory for one trial.

    with_skill=True: a mini paper repo with Blue Pencil's commands, subagent and
    skill installed project-locally, plus an AGENTS.md carrying the paper
    context, which is how a real user's repo looks after `install.sh --init`.
    with_skill=False: an empty directory, so nothing from this repo is visible.
    """
    ws = Path(tempfile.mkdtemp(prefix="bp-eval-"))
    if with_skill:
        shutil.copytree(REPO / ".claude" / "commands", ws / ".claude" / "commands")
        shutil.copytree(REPO / ".claude" / "agents", ws / ".claude" / "agents")
        skill_dir = ws / ".claude" / "skills" / "blue-pencil"
        skill_dir.mkdir(parents=True)
        shutil.copy(REPO / "SKILL.md", skill_dir / "SKILL.md")
        shutil.copytree(REPO / "references", skill_dir / "references")
        shutil.copytree(REPO / "examples", skill_dir / "examples")
        (ws / "AGENTS.md").write_text("# Paper context\n\n" + paper_context.strip() + "\n")
    return ws
