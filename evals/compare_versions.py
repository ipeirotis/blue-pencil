#!/usr/bin/env python3
"""Blinded head-to-head of two skill versions' with_skill outputs, same cases and run numbers.

Reuses evals/grade_pilot.py's quality grader prompt, validator, and two-order rule:
a win counts only if it survives the order swap; otherwise a tie.

Usage: python3 compare_versions.py <evals_dir> <before_root> <after_root> <out.json>
"""
import json
import random
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

evals_dir, before_root, after_root, out_path = map(Path, sys.argv[1:5])
sys.path.insert(0, str(evals_dir))
import grade_pilot as gp  # noqa: E402
from lib import changed_cases, read_json  # noqa: E402

TEMPLATE = (evals_dir / "prompts" / "quality_grader.md").read_text()
ROOTS = {"before": before_root, "after": after_root}


def pair(case_id, n):
    rds = {v: r / f"eval-{case_id}" / "with_skill" / f"run-{n}" for v, r in ROOTS.items()}
    if not all(gp._valid_trial(rd, "with_skill") for rd in rds.values()):
        return {"case": case_id, "run": n, "consolidated": "skipped", "note": "invalid trial"}
    revised = {v: gp.revised_of(rd) for v, rd in rds.items()}
    original = (evals_dir / "cases" / case_id / "input.txt").read_text().strip()
    first = random.Random(f"bva-{case_id}-{n}").choice(("before", "after"))
    orders = []
    for a in (first, "after" if first == "before" else "before"):
        b = "after" if a == "before" else "before"
        prompt = gp.fill(TEMPLATE, AUDIENCE=gp.audience_of(case_id), ORIGINAL=original,
                         VERSION_A=revised[a], VERSION_B=revised[b])
        g = gp.model_json(prompt, gp.GRADER_MODEL, gp.quality_validator(revised[a], revised[b]))
        overall = (g["parsed"] or {}).get("overall")
        # Keep the full grader record (requested and actual models, environment, cache key,
        # raw reply), as grade_pilot.py does, so the verdict's provenance can be audited.
        orders.append({"A": a, "B": b, "winner": None if overall is None else {"A": a, "B": b, "tie": "tie"}[overall],
                       "grader": g})
    w1, w2 = orders[0]["winner"], orders[1]["winner"]
    cons = "ungraded" if None in (w1, w2) else (w1 if w1 == w2 else "tie")
    return {"case": case_id, "run": n, "consolidated": cons, "orders": orders}


# Refuse runs that cannot be compared: a case edited since either run, or runs that
# differ in executor model, Claude Code version, flags, case fingerprints, or runner code.
metas = {v: read_json(r / "run_meta.json") for v, r in ROOTS.items()}
case_ids = sorted(set(metas["before"].get("cases") or []) | set(metas["after"].get("cases") or []))
for v, r in ROOTS.items():
    stale = changed_cases(metas[v], case_ids, r)
    if stale:
        sys.exit(f"{v} run: case files changed since it ran: {', '.join(stale)}")
for key in ("executor_model", "claude_code_version", "flags", "preserve_instruction", "case_fingerprints",
            "runner_fingerprint"):
    if metas["before"].get(key) != metas["after"].get(key):
        sys.exit(f"before and after runs differ in {key}; they are not comparable")

# Both runs must cover the same planned cases and run count, and every planned with_skill
# run must exist in both, so a partial run cannot pass for a smaller complete comparison.
for key in ("cases", "runs_per_condition"):
    if metas["before"].get(key) != metas["after"].get(key):
        sys.exit(f"before and after runs differ in {key}; they are not comparable")
jobs = [(c, n) for c in sorted(metas["after"]["cases"]) for n in range(1, metas["after"]["runs_per_condition"] + 1)]
missing = [f"{v}: {c} run-{n}" for v, r in ROOTS.items() for c, n in jobs
           if not (r / f"eval-{c}" / "with_skill" / f"run-{n}").is_dir()]
if missing:
    sys.exit("runs missing, comparison would be incomplete: " + "; ".join(missing))
with ThreadPoolExecutor(max_workers=4) as ex:
    results = list(ex.map(lambda j: pair(*j), jobs))
out_path.write_text(json.dumps(results, indent=2))
tally = {}
for r in results:
    tally[r["consolidated"]] = tally.get(r["consolidated"], 0) + 1
print("before-vs-after:", tally)
for r in results:
    print(f"  {r['case']} run-{r['run']}: {r['consolidated']}")
