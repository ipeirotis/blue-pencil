# Blue Pencil evaluation pilot

This folder tests whether Blue Pencil improves academic writing while preserving the author's meaning, technical content, and voice.

This folder contains a pilot with 12 viewable examples. It runs the same editing prompt with and without Blue Pencil and grades the results.

## Methodology

1. Take a rough passage and an editing request.
2. Give it to Claude twice: once with Blue Pencil (`/paper:revise`), once without, and repeat 3 times per condition.
3. Grade each result with three separate graders.
4. Outputs are read by human reviewers and compared with the graders.

## The three graders

| Grader | Type | Question it answers | File |
|---|---|---|---|
| Code grader | plain code | Did any number, citation, equation, cross-reference, or quote change? | `protected.py` |
| Meaning grader | model | Did claim strength, scope, or a caveat change? Was something added or lost? | `prompts/meaning_grader.md` |
| Quality grader | model, blinded | Which of two versions reads better? | `prompts/quality_grader.md` |

Writing quality and meaning preservation are scored separately. A smoother passage that changes findings fails the meaning check, regardless of the quality grader's judgement. The written definition of "good" is in [`rubric.md`](rubric.md).

Safeguards:

- **Blinded:** The quality grader doesn't know which is Blue Pencil.
- **Order is swapped:** Every pair is judged twice, once in each order. Unless the same version passes both times, the result is a tie. A pair without a valid verdict in both orders is left ungraded, not counted as a tie.
- **Quotes required:** The meaning grader must quote the original and the revised wording for every problem it reports.

## How to run it

All commands run from this folder, and model calls use `claude -p` so they need no separate API key.

```bash
python3 build_cases.py                          # make cases from the repo's examples
python3 run_pilot.py --dry-run                  # show the plan and prompts, no model calls
python3 run_pilot.py --runs 3 --run-id pilot-001
python3 grade_pilot.py pilot-001                # code + meaning + blinded head-to-head
python3 report.py pilot-001                     # report.md and a blinded human review sheet
python3 -m unittest grader_tests/test_protected.py   # offline test of the code grader
```

The last command can also be run from the repo root with `make eval-selftest`. `run_pilot.py` skips runs that already finished for a run id, so use a new id to repeat the pilot; a run that errored or never loaded Blue Pencil is run again. It refuses to resume a run id if the model, flags, Claude Code version, skill files, or the runner code have changed since the run started (`--allow-mixed` overrides this and records it), and always refuses if a case's files have changed. With-skill trials cannot read the home directory, so they see only the skill copy installed in their workspace. In the with-skill condition, the example file a case was built from is left out of the installed skill, because it contains the authored answer for that passage. `grade_pilot.py` reuses a saved verdict only if the same grader model graded the same prompt and texts. `report.py` leaves out runs where `claude -p` failed or Blue Pencil was not loaded, and never overwrites an existing `human_review.md`.

## What gets saved

Everything for a run is under `results/<run-id>/`:

- `run_meta.json`: model, Claude Code version, Blue Pencil version, a hash of the skill files, repo commit, settings, and a record of every resume.
- `eval-<case>/<with_skill|without_skill>/run-<n>/`: the exact `prompt.txt`, the full `transcript.jsonl`, `outputs/reply.md` (full reply), `outputs/revised.txt` (the extracted passage), `timing.json` (tokens, seconds, cost), `trial.json` (models used, flags, whether Blue Pencil was really loaded), and the grading files.
- `eval-<case>/comparison-run-<n>.json`: both orders of each head-to-head.
- `report.md`, `human_review.md` (blinded sheet to fill in), `human_review_key.json`.
- `review.md`: the observations and all 12 pairs with the reviewer's verdicts and notes.
- `human_verdicts.json`, `human_notes.json`: the reviewer's verdicts and notes.

## Skill-creator

Reused from Anthropic's skill-creator:

- A/B against a baseline in separate clean sessions, with timing and token counts saved
- Blind comparison with no knowledge of which output came from the skill
- A grader that must cite evidence for each verdict
- `claude -p` as the execution engine
- The workspace layout and `grading.json` format

## Limits

- Small sample
- The starter cases come from Blue Pencil's own examples, so aren't generalized to all papers
- Blue Pencil has banned phrases and punctuation, so a grader might guess which section is Blue Pencil based on writing style.
- The two conditions are not identical in format, since Blue Pencil returns a four-part report. Only the revised passage is extracted, but the skill's other output is not graded.
- Model graders are not yet calibrated. Until people grade a sample and agreement is measured, treat model verdicts as provisional.
- Voice is not yet measured. The rubric flags voice concerns, but there isn't an agreed way to score them yet.
- Blue Pencil is roughly 20 times the cost and takes 10 times as long compared to plain Claude per edit (side by side, it's about $0.41 and 105 seconds with Blue Pencil and $0.02 and 10 seconds without)

## Files

- `README.md`: this file.
- `rubric.md`: the written definition of "good" for each of the three graders.
- `build_cases.py`: builds the test cases from the repo's examples.
- `run_pilot.py`: runs each case with and without Blue Pencil and saves every run.
- `grade_pilot.py`: runs the graders. Use `--stage code`, `meaning`, or `quality` to grade in parts.
- `report.py`: writes `report.md` and the blinded human review sheet.
- `protected.py`: the code grader.
- `lib.py`: shared helpers (runs `claude -p`, extracts the revised text).
- `prompts/`: the meaning grader and quality grader prompts.
- `cases/`: the 4 test passages. Each has `input.txt` (the passage), `context.txt` (paper context), and `request.txt` (the editing request).
- `grader_tests/`: damaged and harmless revisions (`cases.json`) and the offline code grader test (`test_protected.py`).
- `results/pilot-001/`: the saved pilot. Start with `review.md`.
