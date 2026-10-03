#!/usr/bin/env python3
"""Summarize a graded pilot run, and make a blinded sheet for human review.

Writes into results/<run-id>/:
  report.md              summary tables and every grader-flagged problem
  human_review.md        original + two unlabeled versions per pair, blank verdicts
  human_review_key.json  which version is which, plus the grader's verdict
If human_verdicts.json exists ({"<case>/run-<n>": "1" | "2" | "tie"}), the
report also shows how often the human and the quality grader agree.

Usage:  python3 report.py <run-id>
"""

import json
import statistics as st
import sys

from lib import EVALS, read_json, write_json

CONDS = ("with_skill", "without_skill")
NAMES = {"with_skill": "With Blue Pencil", "without_skill": "Without (plain Claude)"}


def load(root):
    runs = {c: [] for c in CONDS}
    for ed in sorted(root.glob("eval-*")):
        cid = ed.name[len("eval-"):]
        for cond in CONDS:
            for rd in sorted((ed / cond).glob("run-*")):
                cm = read_json(rd / "code_and_meaning.json") if (rd / "code_and_meaning.json").exists() else None
                tr = read_json(rd / "trial.json") if (rd / "trial.json").exists() else {}
                tm = read_json(rd / "timing.json") if (rd / "timing.json").exists() else {}
                n = int(rd.name.split("-")[1])
                runs[cond].append({"case": cid, "n": n, "cm": cm, "trial": tr, "timing": tm})
    pairs = []
    for f in sorted(root.glob("eval-*/comparison-run-*.json")):
        pairs.append(read_json(f))
    return runs, pairs


def verdict_of(r):
    mp = ((r["cm"] or {}).get("meaning") or {}).get("parsed")
    return mp.get("verdict") if mp else None


def preserved(r):
    """Both graders pass. None if the meaning grader did not run."""
    cm = r["cm"] or {}
    v = verdict_of(r)
    if v is None:
        return None
    return bool(cm.get("code", {}).get("passed")) and v == "preserved"


def pct(a, b):
    return f"{a}/{b}" + (f" ({100 * a // b}%)" if b else "")


def mean(xs):
    xs = [x for x in xs if x is not None]
    return round(st.mean(xs), 3) if xs else None


def main():
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    root = EVALS / "results" / sys.argv[1]
    runs, pairs = load(root)
    meta = read_json(root / "run_meta.json") if (root / "run_meta.json").exists() else {}
    L = [f"# Pilot report: {sys.argv[1]}", "",
         f"- Executor model: `{meta.get('executor_model')}` (Claude Code {meta.get('claude_code_version')})",
         f"- Blue Pencil version: {meta.get('blue_pencil_version')}, repo commit `{str(meta.get('repo_commit'))[:10]}`",
         f"- Cases: {', '.join(meta.get('cases', []))}; {meta.get('runs_per_condition')} trials per condition per case",
         "- Rubric: `evals/rubric.md` (draft v0.1). Revision stage: first draft.", "",
         "## 1. Preservation (Part A): did the edit keep meaning, numbers, citations?", "",
         "| Condition | Trials | Code check passes | Meaning: preserved | changed | unsure | Both pass |",
         "|---|---|---|---|---|---|---|"]
    for c in CONDS:
        rs = runs[c]
        code = sum(1 for r in rs if (r["cm"] or {}).get("code", {}).get("passed"))
        vs = [verdict_of(r) for r in rs]
        both = [preserved(r) for r in rs]
        L.append(f"| {NAMES[c]} | {len(rs)} | {pct(code, len(rs))} | {vs.count('preserved')} | "
                 f"{vs.count('changed')} | {vs.count('unsure')} | {pct(sum(1 for b in both if b), len(rs))} |")
    L += ["", "## 2. Cost and speed", "", "| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |", "|---|---|---|---|"]
    for c in CONDS:
        rs = runs[c]
        L.append(f"| {NAMES[c]} | {mean([r['timing'].get('total_tokens') for r in rs])} | "
                 f"{mean([r['timing'].get('total_duration_seconds') for r in rs])} | "
                 f"{mean([r['timing'].get('cost_usd_list_price') for r in rs])} |")
    skill_runs = runs["with_skill"]
    loaded = [r["trial"].get("skill_loaded") for r in skill_runs]
    L += ["", f"Blue Pencil was actually loaded in {loaded.count(True)}/{len(loaded)} with-skill trials "
          "(checked from the tool calls in each transcript).", ""]
    # head to head
    tally = {"with_skill": 0, "without_skill": 0, "tie": 0}
    for p in pairs:
        tally[p["consolidated"]] += 1
    L += ["## 3. Quality (Part B): head-to-head, blinded, each pair judged in both orders", "",
          f"Pairs: {len(pairs)}. Blue Pencil wins: **{tally['with_skill']}**, plain Claude wins: "
          f"**{tally['without_skill']}**, ties or order-dependent: **{tally['tie']}**.", "",
          "Quality must be read together with preservation. A win only counts as an improvement if that "
          "version also passed Part A; the table shows both.", "",
          "| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Counts as improvement? |",
          "|---|---|---|---|---|---|"]
    by = {(c, r["case"], r["n"]): r for c in CONDS for r in runs[c]}
    for p in pairs:
        wp = preserved(by[("with_skill", p["case"], p["run"])])
        np_ = preserved(by[("without_skill", p["case"], p["run"])])
        w = p["consolidated"]
        ok = {"with_skill": wp, "without_skill": np_}.get(w)
        L.append(f"| {p['case']} | {p['run']} | {w} | {wp} | {np_} | "
                 f"{'yes' if ok else ('no' if w != 'tie' else 'n/a (tie)')} |")
    # problems
    L += ["", "## 4. What the graders flagged", ""]
    for c in CONDS:
        for r in runs[c]:
            cm = r["cm"] or {}
            items = []
            for cls, d in (cm.get("code", {}).get("diffs") or {}).items():
                items.append(f"code [{cls}]: removed {d['removed']}, added {d['added']}")
            mp = ((cm.get("meaning") or {}).get("parsed")) or {}
            for pr in mp.get("problems", []):
                items.append(f"meaning [{pr.get('severity')}/{pr.get('type')}]: "
                             f"\"{pr.get('original_quote', '')}\" -> \"{pr.get('revised_quote', '')}\"")
            if items:
                L.append(f"**{NAMES[c]}, {r['case']}, run {r['n']}**")
                L += [f"- {i}" for i in items] + [""]
    # human review sheet
    sheet, key = ["# Human review sheet (blinded)", "",
                  "For each pair, read the original and both versions, then write your verdict "
                  "(1, 2, or tie) on the blank line. Judge only how well each reads, and separately note "
                  "any meaning change you spot. Do not open `human_review_key.json` until you are done.", ""], {}
    for p in pairs:
        o1 = p["orders"][0]
        pid = f"{p['case']}/run-{p['run']}"
        key[pid] = {"version_1": o1["A"], "version_2": o1["B"], "grader_consolidated": p["consolidated"],
                    "grader_winner_in_this_order": o1["winner"]}
        orig = (EVALS / "cases" / p["case"] / "input.txt").read_text().strip()
        v1 = (root / f"eval-{p['case']}" / o1["A"] / f"run-{p['run']}" / "outputs" / "revised.txt").read_text().strip()
        v2 = (root / f"eval-{p['case']}" / o1["B"] / f"run-{p['run']}" / "outputs" / "revised.txt").read_text().strip()
        sheet += [f"## {pid}", "", "**Original**", "", "```", orig, "```", "", "**Version 1**", "", "```", v1, "```", "",
                  "**Version 2**", "", "```", v2, "```", "",
                  "Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:", ""]
    (root / "human_review.md").write_text("\n".join(sheet) + "\n")
    write_json(root / "human_review_key.json", key)
    hv = root / "human_verdicts.json"
    if hv.exists():
        human = read_json(hv)
        agree = total = 0
        for pid, v in human.items():
            if pid not in key:
                continue
            k = key[pid]
            g = k["grader_consolidated"]
            gv = "tie" if g == "tie" else ("1" if k["version_1"] == g else "2")
            total += 1
            agree += (gv == str(v))
        L += ["## 5. Human vs. quality grader", "", f"Agreement on {total} pairs: **{agree}/{total}**.", ""]
    (root / "report.md").write_text("\n".join(L) + "\n")
    print(f"wrote {root / 'report.md'}, human_review.md, human_review_key.json")


if __name__ == "__main__":
    main()
