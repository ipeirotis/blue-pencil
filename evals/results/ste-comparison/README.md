# ASD-STE100 change: before/after benchmark

This is the before/after measurement for the ASD-STE100 change (PR #57), as `TASKS.md` requires.

## Setup

| | Before | After |
|---|---|---|
| Run | `results/ste-before` | `results/ste-after` |
| Skill content | `main` at `382718b` | PR branch at `2af2869` |
| Executor | `claude-sonnet-5-5`, Claude Code 2.1.301 | same |
| Graders | `claude-opus-5-5` | same |
| Corpus | the 4 cases in `cases/`, 3 runs per condition per case | same |

Both runs used `run_pilot.py --runs 3`, `grade_pilot.py`, and `report.py` without changes. In each run, one with-skill trial first failed with a runner error (`AttributeError: 'str' object has no attribute 'get'`) and passed when retried with the runner's resume. The same error appeared in every run made for this PR, so it looks like a bug in the runner's transcript parsing rather than a model failure.

**Provenance of the after run.** `run_meta.json` records `repo_commit` `2409c2f`, a local commit that only removed the earlier after results and was never pushed. It has the same skill files as `2af2869`. The run was resumed at `7a8512e`, which changes only `evals/compare_versions.py`. `run_pilot.py` refuses to resume when the skill fingerprint has changed, so the resume confirms the skill files were the same (fingerprint `3c651293d50e17b8`).

**What was not measured.** The final PR head differs from the measured content in two examples in `references/sentence-patterns.md`, both fixed after a code review: a restored article ("the" or "a") is now taken from the context or asked, and two numbers moving in opposite directions are no longer joined with "but" unless the paper presents them as a trade-off. Both changes make the editor ask instead of choosing; neither adds a pass or a rewrite.

## Results against plain Claude (from each run's `report.md`)

| With Blue Pencil | Before | After |
|---|---|---|
| Code check passes | 10/12 | 11/12 |
| Meaning preserved / changed | 5 / 7 | 7 / 5 |
| Both checks pass | 3/12 (25%) | 6/12 (50%) |
| Avg major meaning problems per run | 0.92 | 0.67 |
| Avg minor meaning problems per run | 0.67 | 0.75 |
| Quality vs plain Claude (win / loss / tie) | 6 / 4 / 2 | 4 / 6 / 2 |
| Clean improvements (preserved and won) | 2/12 | 1/12 |
| Mean cost per edit (USD, list) | 0.405 | 0.433 |
| Mean tokens per edit | 252k | 261k |

How much a run varies with no change at all: the plain-Claude baseline passed both checks in 3/12 runs in the before run and 3/12 in the after run, with 2.58 and 2.25 major problems per run. An earlier after run on nearly the same skill content (`c3980c7`, superseded by the review fixes) scored 6/12 on both checks and 0.67 major problems, matching this run. Its quality against plain Claude, though, was 7 / 3 / 2 where this run's is 4 / 6 / 2. The preservation numbers held steady across the two after runs; the quality numbers did not.

## Direct comparison: before against after

`compare_versions.py` shows the quality grader each case-and-run pair of with-skill outputs, before and after, with the version labels hidden. It uses the same `prompts/quality_grader.md`, validator, and two-order rule as `grade_pilot.py`: a win counts only if it holds when the order is swapped. The script refuses runs whose cases changed, whose executor, Claude Code version, flags, or case fingerprints differ, or that lack a planned run. One pair got no valid grader reply on the first pass and was retried alone. Raw verdicts, with each grader's full record, are in `before-vs-after.json`.

| Before wins | After wins | Ties or order-dependent |
|---|---|---|
| 7 | 5 | 0 |

The grader's reasons for the before wins are drafting choices that vary from run to run: a tighter sentence, which fact comes first, a vague connective, a restated contrast. One reason is worth watching. In `exposition-methods` run 2 the after version added parenthetical glosses of terms the audience already knows ("never-treated stores (stores that never received the program)"). The skill's own diagnosis for that run attributes the glosses to the exposition pass's "Jargon to unpack" step, which predates this PR, and no other after output adds glosses. It is one case, but the new reader-model line in `references/exposition.md` ("the reader may read English as a second language") could push in that direction.

## Reading

- **Preservation improved, consistently:** both after runs passed both checks in 6/12 runs, against 3/12 before, and had 0.67 major meaning problems per run, against 0.92. In this run the gains are spread across three cases, each by one run: `exposition-methods` 1/3 to 2/3 (on the code check), `exposition-results` 2/3 to 3/3, and `worked-example` 0/3 to 1/3. `exposition-introduction` still passes 0/3, and its major problems per run rose from 1.33 to 1.67.
- **No detectable change in quality:** against plain Claude the after side went from 6 / 4 / 2 to 4 / 6 / 2, but the earlier after run on nearly the same content scored 7 / 3 / 2, so this measure moves by that much between runs. The direct comparison is 7 to 5 for before, within chance (two-sided sign test, p ≈ 0.77).
- **Cost rose about 7%,** in line with longer reference files.
- **The corpus does not test the new rules directly.** None of the four cases is built around a dropped "that", a two-sense connective, a vague "with", or a procedural Methods passage, so this run measures whether the change does harm elsewhere, not whether the new diagnostics work. A case built for them is the natural next addition to `cases/`.

Total cost: about $5.06 (before) and $5.41 (after) to run the trials, about $1.9 each to grade them, and $0.92 for the direct comparison.
