#!/usr/bin/env python3
"""Grade a pilot run with the three graders.

  1. Code grader      (protected.py)   did numbers/citations/math/quotes change?
  2. Meaning grader   (model)          did claim strength, scope, caveats change?
  3. Quality grader   (model, blinded) head-to-head: which version reads better?

The quality grader never sees which version came from Blue Pencil. Each pair is
judged twice with the order swapped; a win counts only if it survives the swap.

Usage:
    python3 grade_pilot.py <run-id>                 # all graders
    python3 grade_pilot.py <run-id> --code-only     # no model calls
"""

import argparse
import random
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from lib import EVALS, GRADER_MODEL, call_claude, extract_json, read_json, write_json
from protected import check

GRADER_FLAGS = ["--setting-sources", "project", "--disable-slash-commands", "--tools", ""]
CONDS = ("with_skill", "without_skill")


def fill(template, **kw):
    for k, v in kw.items():
        template = template.replace("{" + k + "}", v)
    return template


def model_json(prompt, model):
    """Call the grader model and parse its JSON reply (one retry on a bad reply)."""
    ws = Path(tempfile.mkdtemp(prefix="bp-grade-"))
    last = None
    for _ in range(2):
        res = call_claude(prompt, model, ws, GRADER_FLAGS)
        parsed = extract_json(res["text"])
        last = {"parsed": parsed, "raw": res["text"], "cost_usd": res["cost_usd"],
                "seconds": res["seconds"], "models": list(res["model_usage"].keys())}
        if parsed is not None:
            break
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


def grade_run(case_id, original, run_dir, model, code_only):
    revised = revised_of(run_dir)
    out = {"case": case_id, "run_dir": str(run_dir.relative_to(EVALS)), "has_revised_text": revised is not None}
    if revised is None:
        out["code"] = {"passed": False, "diffs": {}, "note": "no revised text extracted"}
        out["meaning"] = None
    else:
        out["code"] = check(original, revised)
        prior = run_dir / "code_and_meaning.json"
        if code_only and prior.exists():
            out["meaning"] = read_json(prior).get("meaning")  # keep earlier model verdicts
        if not code_only:
            m = model_json(fill((EVALS / "prompts" / "meaning_grader.md").read_text(),
                                ORIGINAL=original, REVISED=revised), model)
            out["meaning"] = m
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


def head_to_head(case_id, original, eval_dir, n, model):
    revised = {c: revised_of(eval_dir / c / f"run-{n}") for c in CONDS}
    if not all(revised.values()):
        return None
    rng = random.Random(f"{case_id}-{n}")
    first = rng.choice(CONDS)               # which condition is shown as "A" in order 1
    orders = []
    for a_cond in (first, CONDS[1] if first == CONDS[0] else CONDS[0]):
        b_cond = CONDS[1] if a_cond == CONDS[0] else CONDS[0]
        g = model_json(fill((EVALS / "prompts" / "quality_grader.md").read_text(),
                            AUDIENCE=audience_of(case_id), ORIGINAL=original,
                            VERSION_A=revised[a_cond], VERSION_B=revised[b_cond]), model)
        overall = (g["parsed"] or {}).get("overall")
        winner = None if overall is None else {"A": a_cond, "B": b_cond}.get(overall, "tie")
        orders.append({"A": a_cond, "B": b_cond, "grader": g, "winner": winner})
    w1, w2 = orders[0]["winner"], orders[1]["winner"]
    consolidated = w1 if (w1 == w2 and w1 is not None) else "tie"
    note = "" if w1 == w2 else "order-dependent verdict, counted as tie"
    result = {"case": case_id, "run": n, "orders": orders, "consolidated": consolidated, "note": note}
    write_json(eval_dir / f"comparison-run-{n}.json", result)
    return result


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawTextHelpFormatter)
    ap.add_argument("run_id")
    ap.add_argument("--code-only", action="store_true", help="skip every model call")
    ap.add_argument("--model", default=GRADER_MODEL)
    ap.add_argument("--workers", type=int, default=4)
    args = ap.parse_args()
    root = EVALS / "results" / args.run_id
    if not root.is_dir():
        sys.exit(f"no such run: {root}")
    jobs, h2h = [], []
    for ed in sorted(root.glob("eval-*")):
        cid = ed.name[len("eval-"):]
        original = (EVALS / "cases" / cid / "input.txt").read_text().strip()
        for cond in CONDS:
            for rd in sorted((ed / cond).glob("run-*")):
                jobs.append((cid, original, rd))
        if not args.code_only:
            ns = sorted({int(p.name.split("-")[1]) for p in (ed / "with_skill").glob("run-*")})
            h2h += [(cid, original, ed, n) for n in ns]
    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        list(ex.map(lambda j: grade_run(*j, args.model, args.code_only), jobs))
        if h2h:
            list(ex.map(lambda j: head_to_head(*j, args.model), h2h))
    print(f"graded {len(jobs)} runs" + (f" and {len(h2h)} head-to-head pairs" if h2h else "")
          + f" in {root}")


if __name__ == "__main__":
    main()
