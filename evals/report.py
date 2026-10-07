#!/usr/bin/env python3
"""Summarize a graded pilot run, and make a blinded sheet for human review.

Writes into results/<run-id>/:
  report.md              summary tables and every grader-flagged problem
  human_review.md        original + two unlabeled versions per pair, blank verdicts
                         (never overwritten once it exists; a fresh copy goes to
                         human_review.new.md if the pairs changed)
  human_review_key.json  which version is which, plus the grader's verdict
If human_verdicts.json exists ({"<case>/run-<n>": "1" | "2" | "tie"}), the
report also shows how often the human and the quality grader agree.

Follows evals/rubric.md: preservation, quality, and clean improvements
are reported separately and never combined into one score. Runs whose `claude -p`
call failed, and with-skill runs that never loaded Blue Pencil, are excluded from
every table (and so are their head-to-head pairs); they are listed in the report.

Usage:  python3 report.py <run-id>
"""

import re
import statistics as st
import sys

import json

from lib import EVALS, changed_cases, reads_outside_workspace, read_json, total_tokens, write_json

CONDS = ("with_skill", "without_skill")
NAMES = {"with_skill": "With Blue Pencil", "without_skill": "Without (plain Claude)"}


def invalid_reason(r, cond):
    """Why a run cannot count as a model outcome, or None if it can."""
    if not r["trial"]:
        return "no trial.json (the call did not finish)"
    if r["trial"].get("is_error"):
        return "claude -p reported an error"
    if cond == "with_skill" and r["trial"].get("skill_loaded") is not True:
        return "Blue Pencil was not loaded, or loading was not recorded"
    if cond == "with_skill" and r["outside"]:
        return "read or listed files outside its workspace: " + ", ".join(r["outside"])
    return None


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
                outside, examples = [], False
                if cond == "with_skill" and (rd / "transcript.jsonl").exists():
                    events = [json.loads(ln) for ln in (rd / "transcript.jsonl").read_text().splitlines() if ln.strip()]
                    outside = reads_outside_workspace(events)
                    # Did any tool call name an example file (for runs made before held-out examples)?
                    examples = any(item.get("type") == "tool_use" and "examples" in json.dumps(item.get("input"))
                                   for e in events for item in (e.get("message", {}).get("content") or [])
                                   if isinstance(item, dict))
                runs[cond].append({"case": cid, "n": n, "cm": cm, "trial": tr, "timing": tm, "outside": outside,
                                   "examples": examples})
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
    """True or False, or None if the code grader has not been run on this run."""
    code = (r["cm"] or {}).get("code")
    return None if code is None else bool(code.get("passed"))


def preserved(r):
    """Code check and meaning check both pass. None if the meaning grader has no valid
    verdict (not run, or every reply was invalid): such runs are ungraded, not failed.
    A run with no revised text at all is a failure."""
    if r["cm"] and not r["cm"].get("has_revised_text", True):
        return False
    v = verdict_of(r)
    if v is None:
        return None
    c = code_passed(r)
    return None if c is None else (c and v == "preserved")


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
    codes = [c for c in (code_passed(r) for r in rs) if c is not None]  # unrun code grades left out
    vs = [verdict_of(r) for r in rs]
    both = [b for b in (preserved(r) for r in rs) if b is not None]  # ungraded runs left out
    ungraded = len(rs) - len(both)
    major, minor = avg_counts(rs)
    no_code = len(rs) - len(codes)
    return (f"| {label} | {len(rs)} | {pct(sum(codes), len(codes))}"
            + (f" ({no_code} not graded)" if no_code else "")
            + f" | {vs.count('preserved')} / {vs.count('changed')} / "
            f"{vs.count('unsure')}" + (f" ({ungraded} not graded)" if ungraded else "")
            + f" | {pct(sum(both), len(both))} | {major} | {minor} |")


def run_counts(runs):
    """Runs per condition per case, read from the run directories (a resumed run may differ by case)."""
    cases = sorted({r["case"] for c in CONDS for r in runs[c]})
    n = {(case, c): sum(r["case"] == case for r in runs[c]) for case in cases for c in CONDS}
    if len(set(n.values())) <= 1:
        return f"{next(iter(n.values()), 0)} runs per condition per case"
    return "runs per condition: " + "; ".join(
        f"{case} " + ", ".join(f"{c} {n[(case, c)]}" for c in CONDS) for case in cases)


def _verdicts(runs, pairs):
    """Every saved grader reply: meaning verdicts and both orders of each head-to-head."""
    return ([r["cm"]["meaning"] for c in CONDS for r in runs[c] if r["cm"] and r["cm"].get("meaning")]
            + [o["grader"] for p in pairs for o in p.get("orders", []) if o.get("grader")])


def _pair_texts(sheet):
    """The texts shown for each pair on a review sheet ("## case/run-n" sections), up to
    the line where the reviewer writes verdicts; anything the reviewer adds is left out."""
    out, pid = {}, None
    for ln in sheet.splitlines():
        if re.fullmatch(r"## \S+/run-[0-9]+", ln):  # pair headers only, not headings in a passage
            pid = ln[3:].strip()
            out[pid] = []
        elif ln.startswith("Better written"):
            pid = None
        elif pid:
            out[pid].append(ln)
    return {k: "\n".join(v).strip() for k, v in out.items()}


def _fence_for(*texts):
    """A backtick fence longer than any backtick run in the texts, so a passage that
    contains its own fenced block cannot close the wrapper early."""
    longest = max((len(m) for t in texts for m in re.findall(r"`+", t)), default=0)
    return "`" * max(3, longest + 1)


def main():
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    root = EVALS / "results" / sys.argv[1]
    runs, pairs = load(root)
    meta = read_json(root / "run_meta.json") if (root / "run_meta.json").exists() else {}
    changed = changed_cases(meta, sorted({r["case"] for c in CONDS for r in runs[c]}), root)
    if changed:
        sys.exit(f"case files changed since this run: {', '.join(changed)}; restore them first.")
    all_runs = runs
    excluded = [(c, r, invalid_reason(r, c)) for c in CONDS for r in runs[c] if invalid_reason(r, c)]
    runs = {c: [r for r in runs[c] if not invalid_reason(r, c)] for c in CONDS}
    valid_ids = {(c, r["case"], r["n"]) for c in CONDS for r in runs[c]}
    ungraded = [p for p in pairs if p["consolidated"] not in CONDS + ("tie",)]
    pairs = [p for p in pairs if p not in ungraded
             and all((c, p["case"], p["run"]) in valid_ids for c in CONDS)]
    # Meaning verdicts saved before the rubric version was recorded were graded under v0.2.
    rubrics = " and ".join(sorted({((r["cm"] or {}).get("meaning") or {}).get("rubric", "v0.2")
                                   for c in CONDS for r in runs[c] if meaning(r)})) or "(meaning not graded)"
    L = [f"# Pilot report: {sys.argv[1]}", "",
         f"- Executor model: `{meta.get('executor_model')}` (Claude Code {meta.get('claude_code_version')})",
         f"- Blue Pencil version: {meta.get('blue_pencil_version')}, repo commit `{str(meta.get('repo_commit'))[:10]}`",
         f"- Cases: {', '.join(meta.get('cases', []))}; {run_counts(all_runs)}",
         f"- Rubric: `evals/rubric.md` {rubrics}. Revision stage: first draft."]
    for res in meta.get("resumes", []):
        L.append(f"- Resumed {res.get('started')} at repo commit `{str(res.get('repo_commit'))[:10]}`"
                 + (f"; configuration differed: {', '.join(res['config_differs'])}"
                    if res.get("config_differs") else ""))
    if excluded:
        L.append(f"- Excluded {len(excluded)} invalid runs: "
                 + "; ".join(f"{NAMES[c]}, {r['case']}, run {r['n']} ({why})" for c, r, why in excluded))
    if meta.get("workspace_context") != "both conditions":
        # Runs made before the workspaces were equalized gave only the with-skill workspace
        # the paper context as AGENTS.md (both prompts carried it), so the conditions
        # differed in that as well as in the skill.
        L.append("- **Caveat:** this run predates equal workspaces: only the with-skill workspace held "
                 "AGENTS.md with the paper context (both prompts included it), so the conditions differ "
                 "in that as well as in the skill. Rerun under a new run id to isolate the skill.")
    # Trials that read outside their workspace are not counted (see invalid_reason).
    legacy = [r for r in runs["with_skill"] if r["trial"] and "held_out_examples" not in r["trial"]]
    if legacy:
        touched = [f"{r['case']} run {r['n']}" for r in legacy if r["examples"]]
        L.append(f"- **Caveat:** {len(legacy)} with-skill runs predate held-out examples: their workspace "
                 "also held the example file the case was built from, which contains an authored revision "
                 "of the same passage. " + (f"Tool calls in these runs named example files: {', '.join(touched)}."
                                            if touched else "No tool call in their transcripts named an example file."))
    envs = [json.dumps(g.get("env"), sort_keys=True) for g in _verdicts(runs, pairs)]
    if len(set(envs)) > 1:
        L.append("- **Caveat:** the saved verdicts come from more than one grader environment (flags or "
                 "Claude Code version; \"null\" means not recorded): "
                 + "; ".join(f"{e} ({envs.count(e)})" for e in sorted(set(envs))))
    if ungraded:
        L.append(f"- {len(ungraded)} head-to-head pairs have no valid quality verdict and are left out: "
                 + ", ".join(f"{p['case']} run {p['run']}" for p in ungraded))
    L.append("")

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
        # Tokens come from the per-model aggregates in trial.json, which include subagents.
        toks = [total_tokens(r["trial"]["model_usage"]) if r["trial"].get("model_usage")
                else r["timing"].get("total_tokens") for r in rs]
        L.append(f"| {NAMES[c]} | {mean(toks)} | "
                 f"{mean([r['timing'].get('total_duration_seconds') for r in rs])} | "
                 f"{mean([r['timing'].get('cost_usd_list_price') for r in rs])} |")
    loaded = [r["trial"].get("skill_loaded") for r in all_runs["with_skill"]]
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
    decided = 0  # pairs whose clean-improvement status is known (the winner's meaning was graded)
    rows = []
    for p in pairs:
        wp = preserved(by[("with_skill", p["case"], p["run"])])
        np_ = preserved(by[("without_skill", p["case"], p["run"])])
        w = p["consolidated"]
        winner_preserved = {"with_skill": wp, "without_skill": np_}.get(w, False)
        if winner_preserved is None:
            status = "n/a (meaning not graded)"
        else:
            decided += 1
            is_clean = (w in CONDS) and winner_preserved
            if is_clean:
                clean[w] += 1
            status = "yes" if is_clean else "no"
        rows.append(f"| {p['case']} | {p['run']} | {w} | {wp} | {np_} | {status} |")
    ta, tb = tally(pairs), tally(both_ok)
    L += ["## 4. Quality (blinded, both orders)", "",
          "| Pairs | Blue Pencil wins | Plain Claude wins | Ties or order-dependent |", "|---|---|---|---|",
          f"| All ({len(pairs)}) | {ta['with_skill']} | {ta['without_skill']} | {ta['tie']} |",
          f"| Both passed preservation ({len(both_ok)}) | {tb['with_skill']} | {tb['without_skill']} | {tb['tie']} |",
          "", "## 5. Clean improvements (passes preservation and wins quality)", "",
          "| Condition | Clean improvements |", "|---|---|",
          f"| {NAMES['with_skill']} | {pct(clean['with_skill'], decided)} |",
          f"| {NAMES['without_skill']} | {pct(clean['without_skill'], decided)} |", "",
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
        fence = _fence_for(orig, v1, v2)
        sheet += [f"## {pid}", "", "**Original**", "", fence, orig, fence, "", "**Version 1**", "", fence, v1, fence, "",
                  "**Version 2**", "", fence, v2, fence, "",
                  "Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:", ""]
    # The sheet is where a reviewer writes verdicts, so an existing one is never replaced.
    # Its key stays with it: a changed sheet and its key go to *.new.* side by side.
    sheet_text, sheet_path = "\n".join(sheet) + "\n", root / "human_review.md"
    key_path = root / "human_review_key.json"
    reviewed = _pair_texts(sheet_path.read_text()) if sheet_path.exists() else {}
    fresh = _pair_texts(sheet_text)
    if sheet_path.exists() and sheet_path.read_text() != sheet_text:
        (root / "human_review.new.md").write_text(sheet_text)
        write_json(root / "human_review_key.new.json", key)
        print("kept existing human_review.md and its key; a fresh sheet and key are in "
              "human_review.new.md and human_review_key.new.json")
        if key_path.exists():
            key = read_json(key_path)  # human verdicts refer to the kept sheet
    else:
        sheet_path.write_text(sheet_text)
        write_json(key_path, key)

    hv = root / "human_verdicts.json"
    if hv.exists():
        human = read_json(hv)
        agree = total = 0
        # The key maps versions 1/2 of the reviewed sheet to conditions; the grader's
        # verdict is the current one, the same that section 4 reports.
        current = {f"{p['case']}/run-{p['run']}": p["consolidated"] for p in pairs}
        # A pair whose outputs changed after the sheet was reviewed is left out: the
        # human judged other text than the grader did.
        stale = sorted(pid for pid in human if pid in reviewed and reviewed[pid] != fresh.get(pid))
        for pid, v in human.items():
            if pid not in key or pid not in current or pid in stale:
                continue
            k = key[pid]
            g = current[pid]
            gv = "tie" if g == "tie" else ("1" if k["version_1"] == g else "2")
            total += 1
            agree += (gv == str(v))
        L += ["## 7. Human vs. quality grader", "", f"Agreement on {total} pairs: **{agree}/{total}**."
              + (f" Left out, as their outputs changed after review: {', '.join(stale)}." if stale else ""), ""]
    (root / "report.md").write_text("\n".join(L) + "\n")
    print(f"wrote {root / 'report.md'}")


if __name__ == "__main__":
    main()
