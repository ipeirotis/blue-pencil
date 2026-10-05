#!/usr/bin/env python3
"""Summarize a graded pilot run, and make a blinded sheet for human review.

Writes into results/<run-id>/:
  report.md              summary tables and every grader-flagged problem
  human_review.md        original + two unlabeled versions per pair, blank verdicts
  human_review_key.json  which version is which, plus the grader's verdict
If human_verdicts.json exists ({"<case>/run-<n>": "1" | "2" | "tie"}), the
report also shows how often the human and the quality grader agree.

Follows evals/rubric.md (v0.2): preservation, quality, and clean improvements
are reported separately and never combined into one score.

Usage:  python3 report.py <run-id>
"""

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


def meaning(r):
    return ((r["cm"] or {}).get("meaning") or {}).get("parsed")


def verdict_of(r):
    m = meaning(r)
    return m.get("verdict") if m else None


def code_passed(r):
    return bool((r["cm"] or {}).get("code", {}).get("passed"))


def preserved(r):
    """Code check and meaning check both pass. None if the meaning grader did not run."""
    v = verdict_of(r)
    if v is None:
        return None
    return code_passed(r) and v == "preserved"


def counts(r):
    """(major, minor) meaning problems. Voice is recorded only and not counted."""
    m = meaning(r)
    if not m:
        return None
    probs = m.get("problems", [])
    major = sum(1 for p in probs if p.get("severity") == "major")
    minor = sum(1 for p in probs if p.get("severity") not in ("major", "recorded"))
    return major, minor


def pct(a, b):
    return f"{a}/{b}" + (f" ({100 * a // b}%)" if b else "")


def mean(xs):
    xs = [x for x in xs if x is not None]
    return round(st.mean(xs), 3) if xs else None


def avg_counts(rs):
    cs = [counts(r) for r in rs if counts(r) is not None]
    if not cs:
        return None, None
    return round(st.mean(c[0] for c in cs), 2), round(st.mean(c[1] for c in cs), 2)


def summary_row(label, rs):
    code = sum(1 for r in rs if code_passed(r))
    vs = [verdict_of(r) for r in rs]
    both = [preserved(r) for r in rs]
    major, minor = avg_counts(rs)
    return (f"| {label} | {len(rs)} | {pct(code, len(rs))} | {vs.count('preserved')} / {vs.count('changed')} / "
            f"{vs.count('unsure')} | {pct(sum(1 for b in both if b), len(rs))} | {major} | {minor} |")


def main():
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    root = EVALS / "results" / sys.argv[1]
    runs, pairs = load(root)
    meta = read_json(root / "run_meta.json") if (root / "run_meta.json").exists() else {}
    L = [f"# Pilot report: {sys.argv[1]}", "",
         f"- Executor model: `{meta.get('executor_model')}` (Claude Code {meta.get('claude_code_version')})",
         f"- Blue Pencil version: {meta.get('blue_pencil_version')}, repo commit `{str(meta.get('repo_commit'))[:10]}`",
         f"- Cases: {', '.join(meta.get('cases', []))}; {meta.get('runs_per_condition')} runs per condition per case",
         "- Rubric: `evals/rubric.md` v0.2. Revision stage: first draft.", ""]

    # 1. Preservation, by condition
    head = ("| {} | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | "
            "Avg major problems | Avg minor problems |")
    sep = "|---|---|---|---|---|---|---|"
    L += ["## 1. Preservation (all cases)", "", head.format("Condition"), sep]
    for c in CONDS:
        L.append(summary_row(NAMES[c], runs[c]))

    # 2. Preservation, by case (the individual runs stay visible)
    L += ["", "## 2. Preservation by case", "", head.format("Case / condition"), sep]
    cases = sorted({r["case"] for c in CONDS for r in runs[c]})
    for case in cases:
        for c in CONDS:
            rs = [r for r in runs[c] if r["case"] == case]
            L.append(summary_row(f"{case} / {NAMES[c]}", rs))
    L += ["", "Major problems per run:", ""]
    for case in cases:
        for c in CONDS:
            per = [str(counts(r)[0]) if counts(r) else "n/a" for r in runs[c] if r["case"] == case]
            L.append(f"- {case} / {NAMES[c]}: {', '.join(per)}")

    # 3. Cost and speed
    L += ["", "## 3. Cost and speed", "",
          "| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |", "|---|---|---|---|"]
    for c in CONDS:
        rs = runs[c]
        L.append(f"| {NAMES[c]} | {mean([r['timing'].get('total_tokens') for r in rs])} | "
                 f"{mean([r['timing'].get('total_duration_seconds') for r in rs])} | "
                 f"{mean([r['timing'].get('cost_usd_list_price') for r in rs])} |")
    loaded = [r["trial"].get("skill_loaded") for r in runs["with_skill"]]
    L += ["", f"Blue Pencil was loaded in {loaded.count(True)}/{len(loaded)} with-skill runs "
          "(checked from each transcript's tool calls).", ""]

    # 4. Quality, and clean improvements
    by = {(c, r["case"], r["n"]): r for c in CONDS for r in runs[c]}

    def tally(ps):
        t = {"with_skill": 0, "without_skill": 0, "tie": 0}
        for p in ps:
            t[p["consolidated"]] += 1
        return t

    both_ok = [p for p in pairs if preserved(by[("with_skill", p["case"], p["run"])])
               and preserved(by[("without_skill", p["case"], p["run"])])]
    clean = {c: 0 for c in CONDS}
    rows = []
    for p in pairs:
        wp = preserved(by[("with_skill", p["case"], p["run"])])
        np_ = preserved(by[("without_skill", p["case"], p["run"])])
        w = p["consolidated"]
        is_clean = (w in CONDS) and bool({"with_skill": wp, "without_skill": np_}[w])
        if is_clean:
            clean[w] += 1
        rows.append(f"| {p['case']} | {p['run']} | {w} | {wp} | {np_} | {'yes' if is_clean else 'no'} |")
    ta, tb = tally(pairs), tally(both_ok)
    L += ["## 4. Quality (blinded, both orders)", "",
          "| Pairs | Blue Pencil wins | Plain Claude wins | Ties or order-dependent |", "|---|---|---|---|",
          f"| All ({len(pairs)}) | {ta['with_skill']} | {ta['without_skill']} | {ta['tie']} |",
          f"| Both passed preservation ({len(both_ok)}) | {tb['with_skill']} | {tb['without_skill']} | {tb['tie']} |",
          "", "## 5. Clean improvements (passes preservation and wins quality)", "",
          "| Condition | Clean improvements |", "|---|---|",
          f"| {NAMES['with_skill']} | {pct(clean['with_skill'], len(pairs))} |",
          f"| {NAMES['without_skill']} | {pct(clean['without_skill'], len(pairs))} |", "",
          "| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Clean improvement? |",
          "|---|---|---|---|---|---|"] + rows

    # 6. Flagged problems
    L += ["", "## 6. What the graders flagged", ""]
    for c in CONDS:
        for r in runs[c]:
            cm = r["cm"] or {}
            items = []
            for cls, d in (cm.get("code", {}).get("diffs") or {}).items():
                items.append(f"code [{cls}]: removed {d['removed']}, added {d['added']}")
            for pr in (meaning(r) or {}).get("problems", []):
                items.append(f"meaning [{pr.get('severity')}/{pr.get('type')}]: "
                             f"\"{pr.get('original_quote', '')}\" -> \"{pr.get('revised_quote', '')}\"")
            if items:
                L.append(f"**{NAMES[c]}, {r['case']}, run {r['n']}**")
                L += [f"- {i}" for i in items] + [""]

    # Blinded human review sheet
    sheet, key = ["# Human review sheet (blinded)", "",
                  "For each pair, read the original and both versions, then write your verdict "
                  "(1, 2, or tie) on the blank line. Judge how well each reads, and note any meaning "
                  "change you spot. Do not open `human_review_key.json` until you are done.", ""], {}
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
        L += ["## 7. Human vs. quality grader", "", f"Agreement on {total} pairs: **{agree}/{total}**.", ""]
    (root / "report.md").write_text("\n".join(L) + "\n")
    print(f"wrote {root / 'report.md'}, human_review.md, human_review_key.json")


if __name__ == "__main__":
    main()
