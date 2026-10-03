# Blue Pencil evaluation pilot

This folder tests one question: **does Blue Pencil improve academic writing
while preserving the author's meaning, technical content, and voice?**

It is a first, small, working version (a "pilot"). It runs the same editing
request with and without Blue Pencil, grades the results, and saves everything
so a person can check the grading. Nothing here changes Blue Pencil itself.

## The idea in plain terms

1. Take a rough passage and an editing request, for example "tighten this and
   make it flow".
2. Give it to Claude twice: once **with Blue Pencil** (`/paper:revise`), once
   **without** (plain Claude, no skills, no tools). Same model, same settings,
   same request, a fresh session each time. Repeat 3 times per condition,
   because the answer varies from run to run.
3. Grade each result with three separate graders (below).
4. Read the outputs yourself and compare your judgment with the graders'.

## The three graders

| Grader | Type | Question it answers | File |
|---|---|---|---|
| Code grader | plain code | Did any number, citation, equation, cross-reference, or quote change? | `protected.py` |
| Meaning grader | model | Did claim strength, scope, or a caveat change? Was something added or lost? | `prompts/meaning_grader.md` |
| Quality grader | model, blinded | Which of two versions reads better? | `prompts/quality_grader.md` |

Writing quality and meaning preservation are scored **separately**. A smoother
passage that changes the findings fails the meaning check, and its quality win
is not counted as an improvement. The written definition of "good" is in
[`rubric.md`](rubric.md).

Why three graders and not one: code is exact but only sees exact tokens; a
model can judge meaning and style but can be inconsistent and biased. Each
covers the other's blind spot. (This follows Anthropic's guidance in
[Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents):
combine code, model, and human graders, and calibrate model graders against
people.)

Safeguards built in:

- **Blinded.** The quality grader sees "Version A" and "Version B", never which
  is Blue Pencil.
- **Order swapped.** Every pair is judged twice, once in each order. A win
  counts only if it survives the swap; otherwise it is recorded as a tie. This
  guards against the known tendency of model judges to favor the first answer.
- **A different, stronger model grades.** Graders default to a different model
  than the one being graded, so the judge is not marking its own work.
- **Quotes required.** The meaning grader must quote the original and revised
  wording for every problem it reports.

## How to run it

All commands run from this folder. Python 3 only, no packages to install.
Model calls use `claude -p` (Claude Code in non-interactive mode), so they run
on your Claude Code plan and need no separate API key.

```bash
python3 build_cases.py                          # make cases from the repo's examples
python3 run_pilot.py --dry-run                  # show the plan and prompts, no model calls
python3 run_pilot.py --runs 3 --run-id pilot-001
python3 grade_pilot.py pilot-001                # code + meaning + blinded head-to-head
python3 report.py pilot-001                     # report.md and a blinded human review sheet
```

Offline self-test of the code grader (no model calls, runs in a second):

```bash
python3 -m unittest evals/grader_tests/test_protected.py     # from the repo root
```

## What gets saved

Everything for a run is under `results/<run-id>/`:

- `run_meta.json`: model, Claude Code version, Blue Pencil version, repo commit, settings.
- `eval-<case>/<with_skill|without_skill>/run-<n>/`: the exact `prompt.txt`, the
  full `transcript.jsonl`, `outputs/reply.md` (full reply), `outputs/revised.txt`
  (the extracted passage), `timing.json` (tokens, seconds, cost), `trial.json`
  (models used, flags, whether Blue Pencil was really loaded), and the grading files.
- `eval-<case>/comparison-run-<n>.json`: both orders of each head-to-head.
- `report.md`, `human_review.md` (blinded sheet to fill in), `human_review_key.json`.

The layout matches Anthropic's `skill-creator`, so its benchmark script
(`aggregate_benchmark.py`) and review viewer can read these folders directly.

## What we reused from skill-creator, and what we did not

Reused (the ideas and the folder/JSON layout, not its code):

- **A/B against a baseline in separate clean sessions**, with timing and token
  counts saved (its Step 1 and `timing.json`).
- **Blind comparison** with no knowledge of which output came from the skill
  (its `agents/comparator.md`), here extended with order swapping.
- **A grader that must cite evidence** for each verdict, and that is told that
  a pass on a weak check is worse than useless (its `agents/grader.md`).
- **`claude -p` as the execution engine**, which is why no API key is needed.
- **The workspace layout and `grading.json` format**, so its viewer works later.

Not used yet, but worth knowing about:

- Its **description optimizer** (`run_loop.py`) tunes when a skill triggers,
  using a 60/40 train/test split to avoid overfitting. It could later be used
  on Blue Pencil's `description`. It is about triggering, not edit quality.
- Its **analyzer** step, which looks for checks that always pass or always fail
  and so tell you nothing. Worth running once there is more data.

## Limits you should know about (threats to validity)

- **Tiny sample.** The starter cases are 4 passages, and each is 3 runs per
  condition. That is enough to debug the pipeline, not to draw conclusions.
- **The starter cases come from Blue Pencil's own examples.** They were written
  to show the skill off, so results on them say little about real papers. Fresh
  cases from published papers are the next step.
- **Blinding leaks style.** Blue Pencil never uses em-dashes and plain Claude
  often does, so a grader can sometimes guess which is which.
- **The two conditions are not identical in format.** Blue Pencil returns a
  four-part report; plain Claude returns whatever it likes. We extract only the
  revised passage from both, but the skill's other output (its questions to the
  author) is not graded. A change Blue Pencil made but flagged for the author
  still counts as a change here.
- **Model graders are not yet calibrated.** Until people grade a sample and we
  measure agreement, treat model verdicts as provisional.
- **The code grader cannot see everything.** It compares which tokens exist, so
  it cannot catch two numbers swapped between sentences, or "associated with"
  becoming "causes". Those need the meaning grader (see `grader_tests/`).
- **Voice is not measured.** The rubric flags voice concerns; there is no
  agreed way yet to score them.
- **Cost.** With Blue Pencil is roughly 20 times the cost and 9 times the time
  of plain Claude per edit (one smoke-test pair: about $0.46 and 135 seconds,
  versus $0.02 and 15 seconds, at list price). A grader pass adds more.

## Testing the graders themselves

`grader_tests/cases.json` holds deliberately damaged revisions (a swapped
coefficient, "associated with" changed to "causes", a dropped qualification, a
changed citation year) next to harmless paraphrases, each labeled with what the
grader should do. `test_protected.py` checks the code grader against them. The
model graders still need to be run on the same set; this is the next milestone.
The self-test has already paid off once: it exposed a false alarm where
reordering a citation group looked like a changed citation, now fixed.

## Files

```
evals/
  README.md  rubric.md
  lib.py                shared helpers (runs `claude -p`, extracts text)
  build_cases.py        examples -> cases/
  run_pilot.py          runs with/without Blue Pencil, N trials each
  grade_pilot.py        runs the three graders
  report.py             tables, flagged problems, blinded human sheet
  protected.py          the code grader
  prompts/              meaning grader and quality grader prompts
  cases/                the test passages (input, context, request)
  grader_tests/         damaged and harmless revisions, offline test
  results/              saved runs (smoke-001 is the first end-to-end check)
```
