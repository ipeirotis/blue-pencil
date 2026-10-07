#!/usr/bin/env python3
"""Run the editing request with and without Blue Pencil, several times each.

For every case and every trial this starts a brand-new `claude -p` session in a
throwaway directory (nothing shared between trials), with the same model, the
same flags, and the same request text in both conditions. The only difference
is that the with_skill condition has Blue Pencil installed in the directory and
invokes it with /paper:revise; the without_skill condition has no skills,
no slash commands, and no tools.

Results are saved in a layout that skill-creator's benchmark tools can read:

    results/<run-id>/eval-<case>/<with_skill|without_skill>/run-<n>/
        prompt.txt  transcript.jsonl  timing.json  trial.json
        outputs/reply.md  outputs/revised.txt

Usage:
    python3 run_pilot.py --dry-run
    python3 run_pilot.py --cases worked-example --runs 1        # one run per condition, quick check
    python3 run_pilot.py --runs 3 --run-id pilot-001            # full pilot

Rerunning with an existing run id resumes it: finished trials are skipped, and
trials that errored or never loaded Blue Pencil are run again. The resume is
refused if the model, flags, Claude Code version, skill files, or runner code
differ from the original run (pass --allow-mixed to override; the mix is then
recorded). A change to a shared case's files is always refused.

In the with_skill condition, the example file a case was built from is left out of
the installed skill, since it holds the authored answer for that passage.
"""

import argparse
import datetime
import hashlib
import inspect
import json
import shutil
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

from lib import (EVALS, EXECUTOR_MODEL, call_claude, case_fingerprint, claude_version,
                 extract_revised, git_sha, make_workspace, read_json, skill_fingerprint,
                 skill_version, skill_was_loaded, total_tokens, write_json)

CONDITIONS = ("with_skill", "without_skill")

# Same session settings for both conditions except what defines the condition.
COMMON = ["--setting-sources", "project"]
FLAGS = {
    # Read(~/**) keeps the trial inside its workspace: without it the subagent also read
    # Blue Pencil copies installed in the home directory (~/.claude/skills, ~/.agents/skills),
    # which are not the files the trial installed. Read rules also cover Grep and Glob.
    "with_skill": COMMON + ["--allowedTools", "Read,Grep,Glob,Skill,Agent,Task",
                            "--disallowedTools", "Bash,Write,Edit,WebFetch,WebSearch,NotebookEdit,Read(~/**)"],
    "without_skill": COMMON + ["--disable-slash-commands", "--tools", ""],
}


# Added to the request in both conditions, so the plain-Claude baseline is also told what to protect.
PRESERVE = ("Preserve my meaning, claims, and voice, and do not change any number, statistic, "
            "or citation, including the order of citations.")


def load_case(case_id, source=None):
    d = EVALS / "cases" / case_id
    return {"id": case_id, "source": source,
            "context": (d / "context.txt").read_text().strip(),
            "request": (d / "request.txt").read_text().strip(),
            "passage": (d / "input.txt").read_text().strip()}


def build_prompt(case, condition):
    """The request is identical in both conditions; only the slash command differs."""
    body = (f"{case['context']}\n\n{case['request']}\n\n{PRESERVE}\n\n{case['passage']}\n\n"
            "Put the revised text in a single fenced code block.")
    return ("/paper:revise " + body) if condition == "with_skill" else body


def completed(run_dir, condition):
    """A trial counts as done only if it produced a revision without an error and,
    with the skill, actually loaded Blue Pencil. Anything else is run again."""
    if not (run_dir / "outputs" / "revised.txt").exists() or not (run_dir / "trial.json").exists():
        return False
    t = read_json(run_dir / "trial.json")
    return not t.get("is_error") and (condition != "with_skill" or t.get("skill_loaded") is True)


def run_trial(case, condition, n, out_root, model, provenance):
    run_dir = out_root / f"eval-{case['id']}" / condition / f"run-{n}"
    if completed(run_dir, condition):
        return run_dir, "skipped (already done)"
    shutil.rmtree(run_dir, ignore_errors=True)  # a failed earlier attempt; start clean
    (run_dir / "outputs").mkdir(parents=True, exist_ok=True)
    prompt = build_prompt(case, condition)
    (run_dir / "prompt.txt").write_text(prompt)
    source = case["source"] or ""
    held_out = [source.split("/", 1)[1]] if source.startswith("examples/") else []
    ws = make_workspace(condition == "with_skill", case["context"], held_out)
    try:
        res = call_claude(prompt, model, ws, FLAGS[condition], stream=True)
    finally:
        shutil.rmtree(ws, ignore_errors=True)
    events = res.pop("events") or []
    kept = [e for e in events if e.get("type") != "stream_event"]  # partial fragments duplicate the full messages
    (run_dir / "transcript.jsonl").write_text("\n".join(json.dumps(e) for e in kept) + "\n")
    reply = res["text"]
    (run_dir / "outputs" / "reply.md").write_text(reply)
    revised = extract_revised(reply)
    if revised:
        (run_dir / "outputs" / "revised.txt").write_text(revised + "\n")
    usage = res["usage"]
    write_json(run_dir / "timing.json", {
        "total_tokens": total_tokens(res["model_usage"]), "total_duration_seconds": res["seconds"],
        "cost_usd_list_price": res["cost_usd"]})
    write_json(run_dir / "trial.json", {
        "case": case["id"], "condition": condition, "run": n,
        "models_used": list(res["model_usage"].keys()), "usage": usage,
        "model_usage": res["model_usage"], "flags": FLAGS[condition],
        "returncode": res["returncode"], "is_error": res["is_error"],
        "skill_loaded": skill_was_loaded(events, ws) if condition == "with_skill" else None,
        "held_out_examples": held_out if condition == "with_skill" else None,
        "revised_text_found": bool(revised), "stderr_tail": res["stderr"], "provenance": provenance})
    status = "ok" if revised and not res["is_error"] else "PROBLEM (see trial.json)"
    return run_dir, status


def runner_fingerprint():
    """Hash of the code that decides what a trial is: how the prompt is built, how the
    workspace is set up, how the revision is extracted, and how skill loading is judged."""
    import lib
    parts = [inspect.getsource(f) for f in (build_prompt, run_trial, completed, lib.make_workspace,
                                            lib.extract_revised,
                                            lib._fenced_block, lib.skill_was_loaded, lib.call_claude)]
    return hashlib.sha256("\n".join(parts).encode()).hexdigest()[:16]


def resume_meta(meta, config, provenance, ids, runs, allow_mixed):
    """Keep the original run's metadata and record this resume in it.

    Trials already in the directory were produced under `meta`; adding new ones under
    a different configuration would mix the two, so that is refused unless allowed.
    Fields the original run did not record (older runs) cannot be checked.
    """
    diffs = {k: (meta[k], v) for k, v in config.items()
             if k in meta and k != "case_fingerprints" and meta[k] != v}
    # A case's files must match for the cases both runs share; new cases may be added.
    # This is refused even with --allow-mixed: grading reads the current case files, so
    # trials made from the old files could never be graded correctly.
    old_cases = meta.get("case_fingerprints", {})
    changed = [cid for cid, fp in config["case_fingerprints"].items()
               if cid in old_cases and old_cases[cid] != fp]
    if changed:
        sys.exit(f"refusing to resume {meta.get('run_id')}: case files changed since it started: "
                 f"{', '.join(changed)}. Restore them or use a new --run-id.")
    if diffs and not allow_mixed:
        lines = "\n".join(f"  {k}: run has {old!r}, now {new!r}" for k, (old, new) in diffs.items())
        sys.exit(f"refusing to resume {meta.get('run_id')}: configuration differs from the original run\n"
                 f"{lines}\nUse a new --run-id, or pass --allow-mixed to resume anyway.")
    meta = dict(meta)
    meta["case_fingerprints"] = {**config["case_fingerprints"], **old_cases}
    meta["cases"] = list(dict.fromkeys(meta.get("cases", []) + ids))
    meta["runs_per_condition"] = max(meta.get("runs_per_condition") or 0, runs)
    meta.setdefault("resumes", []).append(
        {**provenance, "cases": ids, "runs_per_condition": runs, "config_differs": sorted(diffs)})
    return meta


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawTextHelpFormatter)
    ap.add_argument("--cases", nargs="*", help="case ids (default: all in cases/cases.json)")
    ap.add_argument("--runs", type=int, default=3, help="trials per condition per case")
    ap.add_argument("--model", default=EXECUTOR_MODEL)
    ap.add_argument("--run-id", default="pilot-" + datetime.datetime.now().strftime("%Y%m%d-%H%M"))
    ap.add_argument("--workers", type=int, default=3)
    ap.add_argument("--dry-run", action="store_true", help="print the plan and one prompt; make no model calls")
    ap.add_argument("--allow-mixed", action="store_true",
                    help="resume an existing run even if its configuration differs (recorded in run_meta.json)")
    args = ap.parse_args()

    catalog = {c["id"]: c for c in read_json(EVALS / "cases" / "cases.json")["cases"]}
    ids = list(dict.fromkeys(args.cases or catalog))  # each case once, in order
    cases = [load_case(i, catalog.get(i, {}).get("source")) for i in ids]
    out_root = EVALS / "results" / args.run_id
    jobs = [(c, cond, n) for c in cases for cond in CONDITIONS for n in range(1, args.runs + 1)]
    print(f"run id: {args.run_id}\nmodel: {args.model}\ncases: {ids}\n"
          f"trials: {len(jobs)} ({args.runs} per condition per case)")
    if args.dry_run:
        for cond in CONDITIONS:
            print(f"\n--- example prompt, {cond} ---\n{build_prompt(cases[0], cond)}\n--- flags: {FLAGS[cond]}")
        return

    now = datetime.datetime.now().isoformat(timespec="seconds")
    config = {"executor_model": args.model, "claude_code_version": claude_version(),
              "blue_pencil_version": skill_version(), "skill_fingerprint": skill_fingerprint(),
              "flags": FLAGS, "preserve_instruction": PRESERVE,
              "case_fingerprints": {i: case_fingerprint(i) for i in ids},
              "runner_fingerprint": runner_fingerprint()}
    provenance = {"started": now, "repo_commit": git_sha(), **config}
    meta_path = out_root / "run_meta.json"
    if meta_path.exists():
        meta = resume_meta(read_json(meta_path), config, provenance, ids, args.runs, args.allow_mixed)
    else:
        meta = {"run_id": args.run_id, "started": now, **config, "repo_commit": provenance["repo_commit"],
                "cases": ids, "runs_per_condition": args.runs,
                "note": "Each trial is a fresh `claude -p` session in an empty temp directory."}
    write_json(meta_path, meta)
    t0 = time.time()
    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        futs = {ex.submit(run_trial, c, cond, n, out_root, args.model, provenance): (c["id"], cond, n)
                for c, cond, n in jobs}
        for f in as_completed(futs):
            cid, cond, n = futs[f]
            try:
                _, status = f.result()
            except Exception as e:  # keep going; one failed trial must not lose the rest
                status = f"ERROR {type(e).__name__}: {e}"
            print(f"  {cid} / {cond} / run-{n}: {status}", flush=True)
    print(f"done in {time.time() - t0:.0f}s. Results in {out_root}")


if __name__ == "__main__":
    sys.exit(main())
