#!/usr/bin/env python3
"""Grade a pilot run with the three graders.

  1. Code grader      (protected.py)   did numbers/citations/math/quotes change?
  2. Meaning grader   (model)          did claim strength, scope, caveats change?
  3. Quality grader   (model, blinded) head-to-head: which version reads better?

The quality grader never sees which version came from Blue Pencil. Each pair is
judged twice with the order swapped; a win counts only if it survives the swap.

Usage:
    python3 grade_pilot.py <run-id> --stage code      # no model calls
    python3 grade_pilot.py <run-id> --stage meaning   # code + meaning grader
    python3 grade_pilot.py <run-id> --stage quality   # blinded head-to-head only
    python3 grade_pilot.py <run-id>                   # all graders
Saved verdicts are reused, so a stage is never paid for twice (use --force to redo).
A saved verdict is reused only if it was made by the same grader model with the same
prompt and texts; verdicts saved before this check existed are graded again.
"""

import argparse
import functools
import hashlib
import random
import re
import shutil
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from lib import (EVALS, GRADER_MODEL, call_claude, changed_cases, claude_version, extract_json,
                 outside_reads, read_json, rubric_version, write_json)
from protected import check

GRADER_FLAGS = ["--setting-sources", "project", "--disable-slash-commands", "--tools", ""]
CONDS = ("with_skill", "without_skill")


def fill(template, **kw):
    """Substitute every {NAME} field in one pass, so a passage that itself contains
    "{REVISED}" or the like is inserted as written and never substituted again."""
    return re.sub(r"\{(" + "|".join(map(re.escape, kw)) + r")\}", lambda m: kw[m.group(1)], template)


MEANING_VERDICTS = ("preserved", "changed", "unsure")
QUALITY_VERDICTS = ("A", "B", "tie")
# Each problem type has one severity in prompts/meaning_grader.md and rubric.md.
SEVERITY_OF = {"claim_strength": "major", "caveat_or_scope": "major", "new_content": "major",
               "lost_content": "major", "reassigned": "major", "qualifier_word": "minor",
               "voice": "recorded"}


# The one quote a problem type may leave empty: added text has nothing to quote in the
# original, and dropped text (content, a caveat, a qualifier) nothing in the revision.
_MAY_BE_EMPTY = {"new_content": "original_quote", "lost_content": "revised_quote",
                 "caveat_or_scope": "revised_quote", "qualifier_word": "revised_quote"}


def _norm(s):
    s = s.replace("\u201c", '"').replace("\u201d", '"').replace("\u2018", "'").replace("\u2019", "'")
    return re.sub(r"\s+", " ", s).strip()


def _quoted(quote, passage):
    """True if every part of the quote (split at "..." ellipses) occurs in the passage,
    ignoring whitespace and curly-versus-straight quote marks."""
    src = _norm(passage)
    parts = [p.strip() for p in re.split(r"\.\.\.|\u2026", _norm(quote)) if p.strip()]
    if _norm(quote) and not parts:
        return False  # a quote of only "..." cites nothing
    pos = 0
    for p in parts:  # the parts must appear in the quote's order
        pos = src.find(p, pos)
        if pos == -1:
            return False
        pos += len(p)
    return True


def meaning_validator(original, revised):
    """valid_meaning, plus: every quote must come from its passage, as the prompt requires."""
    def valid(parsed):
        return valid_meaning(parsed) and all(
            _quoted(p.get("original_quote") or "", original) and _quoted(p.get("revised_quote") or "", revised)
            for p in parsed["problems"])
    return valid


def valid_meaning(parsed):
    """The full reply the prompt asks for: a problems list (possibly empty) and a summary,
    and a verdict that agrees with the problems: "changed" exactly when at least one
    major problem is reported (see rubric.md)."""
    if not isinstance(parsed, dict) or parsed.get("verdict") not in MEANING_VERDICTS:
        return False
    probs = parsed.get("problems")
    if not _text(parsed.get("summary")):
        return False
    if not isinstance(probs, list) or not all(
            isinstance(p, dict) and p.get("type") in SEVERITY_OF
            and p.get("severity") == SEVERITY_OF[p["type"]]
            # evidence: a quote from both sides, except that added text has no original
            # and dropped text no revision; and an explanation
            and all(_text(p.get(side)) or side == _MAY_BE_EMPTY.get(p["type"])
                    for side in ("original_quote", "revised_quote"))
            and _text(p.get("explanation")) for p in probs):
        return False
    has_major = any(p.get("severity") == "major" for p in probs)
    if parsed["verdict"] == "changed":
        return has_major
    # "unsure" means no major problem could be asserted; a listed major problem means "changed".
    return not has_major


DIMENSIONS = ("clarity", "concision", "flow", "precision", "audience_fit")


def _text(x):
    return isinstance(x, str) and x.strip() != ""


def valid_quality(parsed):
    """The full reply the prompt asks for: an overall verdict, a verdict for each of the
    five dimensions, reasoning, and evidence for every dimension that is not a tie."""
    if not isinstance(parsed, dict) or parsed.get("overall") not in QUALITY_VERDICTS:
        return False
    dims, ev = parsed.get("dimensions"), parsed.get("evidence")
    if not isinstance(dims, dict) or set(dims) != set(DIMENSIONS) or not isinstance(ev, dict):
        return False
    if not (all(v in QUALITY_VERDICTS for v in dims.values()) and _text(parsed.get("reasoning"))
            and all(_text(ev.get(k)) for k, v in dims.items() if v != "tie")):
        return False
    # The overall verdict must follow from the dimensions: a winner needs at least one
    # dimension in its favor, and a tie cannot stand against dimensions that all favor
    # the same version.
    votes = set(dims.values())
    if parsed["overall"] in ("A", "B"):
        return parsed["overall"] in votes
    return votes not in ({"A"}, {"B"})


def quality_validator(version_a, version_b):
    """valid_quality, plus: each non-tie dimension's evidence ("A: '...' vs B: '...'") must
    quote at least one passage that really occurs in each version."""
    def side_ok(side, text):
        quotes = [q for pair in re.findall(r"'([^']{3,})'|\"([^\"]{3,})\"", side) for q in pair if q]
        # A quote that is only dots or spaces ("'...'") is not evidence.
        return any(q.strip(" .") and _quoted(q.strip(" ."), text) for q in quotes)

    def valid(parsed):
        if not valid_quality(parsed):
            return False
        for k, v in parsed["dimensions"].items():
            if v == "tie":
                continue
            m = re.match(r"\s*A:\s*(.*?)\s+vs\.?\s+B:\s*(.*)$", parsed["evidence"][k], re.S)
            if not (m and side_ok(m.group(1), version_a) and side_ok(m.group(2), version_b)):
                return False
        return True
    return valid


@functools.lru_cache(maxsize=None)
def _grader_env():
    return (tuple(GRADER_FLAGS), claude_version())


def grader_env():
    """The grading session's flags and Claude Code version, saved with each verdict."""
    flags, version = _grader_env()
    return {"flags": list(flags), "claude_code_version": version}


def same_env(saved):
    """A saved verdict is reused only under the same grader environment. Verdicts saved
    before the environment was recorded are kept; the report says when kinds are mixed."""
    return (saved or {}).get("env", grader_env()) == grader_env()


def grader_key(prompt, model):
    """Cache key for a saved verdict: the requested model and the full filled-in prompt
    (template, original, and revised text). A saved verdict is reused only if it matches."""
    return hashlib.sha256((model + "\0" + prompt).encode()).hexdigest()[:16]


def model_json(prompt, model, valid):
    """Call the grader model and parse its JSON reply (one retry on a bad reply).

    A reply counts only if `valid(parsed)` holds. Otherwise "parsed" is None, so the
    verdict is never mistaken for a real one and a later run grades it again.
    """
    ws = Path(tempfile.mkdtemp(prefix="bp-grade-"))
    last = None
    try:
        for _ in range(2):
            res = call_claude(prompt, model, ws, GRADER_FLAGS)
            parsed = extract_json(res["text"])
            ok = valid(parsed)
            last = {"parsed": parsed if ok else None, "key": grader_key(prompt, model), "env": grader_env(),
                    "requested_model": model, "raw": res["text"], "cost_usd": res["cost_usd"],
                    "seconds": res["seconds"], "models": list(res["model_usage"].keys())}
            if not ok:
                last["invalid_reply"] = parsed
            if ok:
                break
    finally:
        shutil.rmtree(ws, ignore_errors=True)
    return last


def audience_of(case_id):
    ctx = (EVALS / "cases" / case_id / "context.txt").read_text()
    for line in ctx.splitlines():
        if line.startswith("audience:"):
            return line.split(":", 1)[1].strip()
    return "academic readers"


def revised_of(run_dir):
    p = run_dir / "outputs" / "revised.txt"
    return p.read_text().strip() if p.exists() else None


def grade_run(case_id, original, run_dir, model, do_meaning, force):
    revised = revised_of(run_dir)
    out = {"case": case_id, "run_dir": str(run_dir.relative_to(EVALS)), "has_revised_text": revised is not None}
    if revised is None:
        out["code"] = {"passed": False, "diffs": {}, "note": "no revised text extracted"}
        out["meaning"] = None
    else:
        out["code"] = check(original, revised)
        prior = run_dir / "code_and_meaning.json"
        out["meaning"] = read_json(prior).get("meaning") if prior.exists() else None  # keep earlier verdicts
        prompt = fill((EVALS / "prompts" / "meaning_grader.md").read_text(), ORIGINAL=original, REVISED=revised)
        valid = meaning_validator(original, revised)
        done = (valid((out["meaning"] or {}).get("parsed"))
                and (out["meaning"] or {}).get("key") == grader_key(prompt, model) and same_env(out["meaning"]))
        if do_meaning and (force or not done):
            out["meaning"] = {**model_json(prompt, model, valid), "rubric": rubric_version()}
    write_json(run_dir / "code_and_meaning.json", out)
    # skill-creator compatible grading.json
    exps = [{"text": "Protected content unchanged (code grader)", "passed": out["code"]["passed"],
             "evidence": "; ".join(f"{c}: -{d['removed']} +{d['added']}" for c, d in out["code"]["diffs"].items())
             or "no differences in citations, numbers, math, cross-references, quotes, markup"}]
    mp = (out.get("meaning") or {}).get("parsed")
    if mp:
        exps.append({"text": "Meaning preserved (meaning grader)", "passed": mp.get("verdict") == "preserved",
                     "evidence": f"verdict={mp.get('verdict')}: {mp.get('summary', '')}"})
    passed = sum(e["passed"] for e in exps)
    write_json(run_dir / "grading.json", {
        "expectations": exps,
        "summary": {"passed": passed, "failed": len(exps) - passed, "total": len(exps),
                    "pass_rate": round(passed / len(exps), 3)}})
    return out


def head_to_head(case_id, original, eval_dir, n, model, force):
    revised = {c: revised_of(eval_dir / c / f"run-{n}") for c in CONDS}
    if not all(revised.values()):
        return None
    rng = random.Random(f"{case_id}-{n}")
    first = rng.choice(CONDS)               # which condition is shown as "A" in order 1
    plan = []
    for a_cond in (first, CONDS[1] if first == CONDS[0] else CONDS[0]):
        b_cond = CONDS[1] if a_cond == CONDS[0] else CONDS[0]
        plan.append((a_cond, b_cond, fill((EVALS / "prompts" / "quality_grader.md").read_text(),
                                          AUDIENCE=audience_of(case_id), ORIGINAL=original,
                                          VERSION_A=revised[a_cond], VERSION_B=revised[b_cond]),
                     quality_validator(revised[a_cond], revised[b_cond])))
    prior = eval_dir / f"comparison-run-{n}.json"
    if prior.exists() and not force:
        old = read_json(prior)
        if all(valid((o["grader"] or {}).get("parsed"))
               and (o["grader"] or {}).get("key") == grader_key(prompt, model) and same_env(o["grader"])
               for o, (_, _, prompt, valid) in zip(old["orders"], plan)):
            return old  # already judged with this model and prompt; do not spend model calls again
    orders = []
    for a_cond, b_cond, prompt, valid in plan:
        g = model_json(prompt, model, valid)
        overall = (g["parsed"] or {}).get("overall")
        winner = None if overall is None else {"A": a_cond, "B": b_cond, "tie": "tie"}[overall]
        orders.append({"A": a_cond, "B": b_cond, "grader": g, "winner": winner})
    w1, w2 = orders[0]["winner"], orders[1]["winner"]
    if w1 is None or w2 is None:
        # No valid verdict in at least one order: the pair is ungraded, not a tie.
        consolidated, note = "ungraded", "no valid grader verdict; rerun the quality stage"
    else:
        consolidated = w1 if w1 == w2 else "tie"
        note = "" if w1 == w2 else "order-dependent verdict, counted as tie"
    result = {"case": case_id, "run": n, "orders": orders, "consolidated": consolidated, "note": note}
    write_json(eval_dir / f"comparison-run-{n}.json", result)
    return result


def _valid_trial(rd, cond):
    """The trials report.py counts: finished without error and, with the skill, loaded it
    and read nothing outside its workspace."""
    if not (rd / "trial.json").exists():
        return False
    t = read_json(rd / "trial.json")
    return not t.get("is_error") and (cond != "with_skill" or (
        t.get("skill_loaded") is True and not outside_reads(rd)))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawTextHelpFormatter)
    ap.add_argument("run_id")
    ap.add_argument("--stage", choices=["code", "meaning", "quality", "all"], default="all",
                    help="code: no model calls; meaning: code + meaning grader; "
                         "quality: head-to-head only; all: everything (default)")
    ap.add_argument("--code-only", action="store_true", help="same as --stage code")
    ap.add_argument("--force", action="store_true", help="grade again even if a verdict is already saved")
    ap.add_argument("--model", default=GRADER_MODEL)
    ap.add_argument("--workers", type=int, default=4)
    args = ap.parse_args()
    if args.code_only:
        args.stage = "code"
    do_meaning = args.stage in ("meaning", "all")
    do_quality = args.stage in ("quality", "all")
    root = EVALS / "results" / args.run_id
    if not root.is_dir():
        sys.exit(f"no such run: {root}")
    meta = read_json(root / "run_meta.json") if (root / "run_meta.json").exists() else {}
    changed = changed_cases(meta, [ed.name[len("eval-"):] for ed in root.glob("eval-*")], root)
    if changed:
        sys.exit(f"case files changed since {args.run_id} ran: {', '.join(changed)}. Its outputs "
                 "would be graded against a passage the executor never saw; restore the files.")
    jobs, h2h = [], []
    for ed in sorted(root.glob("eval-*")):
        cid = ed.name[len("eval-"):]
        original = (EVALS / "cases" / cid / "input.txt").read_text().strip()
        for cond in CONDS:
            for rd in sorted((ed / cond).glob("run-*")):
                jobs.append((cid, original, rd, _valid_trial(rd, cond)))
        if do_quality:
            ns = sorted({int(p.name.split("-")[1]) for p in (ed / "with_skill").glob("run-*")})
            h2h += [(cid, original, ed, n) for n in ns
                    if all(_valid_trial(ed / c / f"run-{n}", c) for c in CONDS)]
    missing = []
    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        if args.stage != "quality":
            # The code grader is free and runs on every trial; the paid meaning grader runs
            # only on trials the report counts.
            graded = list(ex.map(lambda j: grade_run(*j[:3], args.model, do_meaning and j[3], args.force), jobs))
            # A requested meaning verdict that is still missing after the retry.
            missing += [out["run_dir"] for out, j in zip(graded, jobs)
                        if do_meaning and j[3] and out["has_revised_text"] and not (out["meaning"] or {}).get("parsed")]
        if h2h:
            pairs = list(ex.map(lambda j: head_to_head(*j, args.model, args.force), h2h))
            missing += [f"{j[0]} pair run-{j[3]}" for r, j in zip(pairs, h2h)
                        if r is None or r["consolidated"] == "ungraded"]
    print(f"graded {len(jobs)} runs" + (f" and {len(h2h)} head-to-head pairs" if h2h else "")
          + f" in {root}")
    if missing:
        # The rest is saved; the report leaves these out until a later run grades them.
        print(f"{len(missing)} verdicts are missing (no valid grader reply): {', '.join(missing)}. "
              "Run the same command again to retry them.", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
