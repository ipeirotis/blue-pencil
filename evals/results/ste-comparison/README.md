# ASD-STE100 change: before/after benchmark

This is the before/after measurement for the ASD-STE100 change (PR #57), as `TASKS.md` requires.

## Setup

| | Before | After |
|---|---|---|
| Run | `results/ste-before` | `results/ste-after` |
| Repo commit | `382718b` (`main`) | `c3980c7` (PR branch) |
| Executor | `claude-sonnet-5-5`, Claude Code 2.1.301 | same |
| Graders | `claude-opus-5-5` | same |
| Corpus | the 4 cases in `cases/`, 3 runs per condition per case | same |

Both runs used `run_pilot.py --runs 3`, `grade_pilot.py`, and `report.py` without changes. In each run, the same with-skill trial (`exposition-methods`, run 3) first failed with a runner error (`AttributeError: 'str' object has no attribute 'get'`) and passed when retried with the runner's resume.

`c3980c7` is not the final PR head. The later commit `37c830d` makes three wording fixes from code review in `references/` and one in `SKILL.md`. It changes no pass, gate, or output format, so it was not re-measured.

## Results against plain Claude (from each run's `report.md`)

| With Blue Pencil | Before | After |
|---|---|---|
| Code check passes | 10/12 | 10/12 |
| Meaning preserved / changed | 5 / 7 | 8 / 4 |
| Both checks pass | 3/12 (25%) | 6/12 (50%) |
| Avg major meaning problems per run | 0.92 | 0.67 |
| Avg minor meaning problems per run | 0.67 | 0.75 |
| Quality vs plain Claude (win / loss / tie) | 6 / 4 / 2 | 7 / 3 / 2 |
| Clean improvements (preserved and won) | 2/12 | 3/12 |
| Mean cost per edit (USD, list) | 0.405 | 0.429 |
| Mean tokens per edit | 252k | 276k |

The plain-Claude baseline gives a sense of the noise between two runs with no change at all: both checks passed in 3/12 runs the first time and 2/12 the second, with 2.58 and 2.67 major problems per run.

## Direct comparison: before against after

`compare_versions.py` shows the quality grader each case-and-run pair of with-skill outputs, before and after, with the version labels hidden. It uses the same `prompts/quality_grader.md`, validator, and two-order rule as `grade_pilot.py`: a win counts only if it holds when the order is swapped. Raw verdicts are in `before-vs-after.json`.

| Before wins | After wins | Ties or order-dependent |
|---|---|---|
| 6 | 3 | 3 |

Five of the six before wins came from the grader preferring one version's drafting choices: which fact comes first, a tighter opener, a dropped hedge, a consistent subject, fewer connectives. The sixth (`exposition-results` run 2) came from the after version keeping the original's flat "Table 3 reports the estimates" opener. None of the six explanations cites a meaning change in the after version or a pattern this PR added. The three `exposition-methods` pairs were all ties.

## Reading

- **Preservation improved:** runs that pass both checks went from 3/12 to 6/12, and major meaning problems fell from 0.92 to 0.67 per run. The cases with the largest gains were `exposition-results` (2/3 to 3/3) and `worked-example` (0/3 to 2/3).
- **Quality is mixed:** the version with the change did slightly better against plain Claude (7/3/2 against 6/4/2) but lost the direct comparison 3 to 6. With 9 decided pairs, a 6 to 3 split is well within chance (two-sided sign test p ≈ 0.51). Treat the quality result as no detectable change, not as a regression or a gain.
- **Cost rose about 6%,** in line with longer reference files.
- **The corpus does not test the new rules directly.** None of the four cases is built around a dropped "that", a two-sense connective, a vague "with", or a procedural Methods passage, so this run measures whether the change does harm elsewhere, not whether the new diagnostics work. A case built for them is the natural next addition to `cases/`.

Total cost: about $5.06 (before) and $5.34 (after) to run the trials, $1.89 and $1.90 to grade them, and $0.88 for the direct comparison.
