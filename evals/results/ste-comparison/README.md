# ASD-STE100 change: before/after benchmark

This is the before/after measurement for the ASD-STE100 change (PR #57), as `TASKS.md` requires. It covers seven cases: the four built from the repo's examples and three written for this change (`ste-connectors`, `ste-procedure`, `ste-vague`), each built around the diagnostics the change adds.

## Setup

| | Before | After |
|---|---|---|
| Run | `results/ste2-before` | `results/ste2-after` |
| Skill content | `main` at `382718b` (fingerprint `b2b3826ef8223166`) | PR branch at `3a88c84` (fingerprint `49bc3a041b16cd70`) |
| Executor | `claude-sonnet-5-5`, Claude Code 2.1.301 | same |
| Graders | `claude-opus-5-5` | same |
| Runner | fingerprint `a76413854f201083` | same |
| Corpus | 7 cases, 3 runs per condition per case | same |

Both runs used `run_pilot.py --runs 3`, `grade_pilot.py`, and `report.py` without changes. The before run used a checkout of `main` with the three `ste-*` case folders and the PR's `cases/cases.json` copied in; its runner, graders, and grading prompts are identical to the branch's, and `compare_versions.py` confirmed that both runs record the same case fingerprints. In the before run, two with-skill trials failed with the runner error seen in every run for this PR (`AttributeError: 'str' object has no attribute 'get'`) and passed when retried with the runner's resume. The after run had no failed trials.

**What was not measured.** After the run, one change was made to `references/sentence-patterns.md`: when a vague-"with" clause that carries a number is split off, the editor now also flags it for human review under the numerical-claim constraint. It only adds a flag.

Earlier runs for this PR (four cases, at `c3980c7` and `2af2869`) are in this branch's git history, before the commit that replaced them with these.

## Results against plain Claude (from each run's `report.md`)

| With Blue Pencil, all 7 cases | Before | After |
|---|---|---|
| Code check passes | 18/21 | 19/21 |
| Meaning preserved / changed / unsure | 11 / 9 / 1 | 15 / 6 / 0 |
| Both checks pass | 9/21 (43%) | 13/21 (62%) |
| Avg major meaning problems per run | 0.57 | 0.43 |
| Avg minor meaning problems per run | 0.38 | 0.43 |
| Quality vs plain Claude (win / loss / tie) | 13 / 7 / 1 | 13 / 5 / 3 |
| Clean improvements (preserved and won) | 5/21 | 8/21 |
| Mean cost per edit (USD, list) | 0.389 | 0.430 |
| Mean tokens per edit | 249k | 260k |

Both checks pass, by case (with Blue Pencil):

| Case | Before | After |
|---|---|---|
| `exposition-introduction` | 1/3 | 0/3 |
| `exposition-methods` | 1/3 | 1/3 |
| `exposition-results` | 1/3 | 3/3 |
| `worked-example` | 0/3 | 1/3 |
| `ste-connectors` | 1/3 | 3/3 |
| `ste-procedure` | 2/3 | 2/3 |
| `ste-vague` | 3/3 | 3/3 |

How much a run varies with no change at all: the plain-Claude baseline passed both checks in 8/21 runs in the before run and 9/21 in the after run, with 1.95 and 1.90 major problems per run.

## Direct comparison: before against after

`compare_versions.py` shows the quality grader each case-and-run pair of with-skill outputs, before and after, with the version labels hidden. It uses the same `prompts/quality_grader.md`, validator, and two-order rule as `grade_pilot.py`: a win counts only if it holds when the order is swapped. Every one of the 21 pairs got a valid verdict. Raw verdicts, with each grader's full record, are in `before-vs-after.json`.

| | Before wins | After wins | Ties or order-dependent |
|---|---|---|---|
| All 7 cases (21 pairs) | 8 | 11 | 2 |
| The 4 example cases | 5 | 7 | 0 |
| The 3 `ste-*` cases | 3 | 4 | 2 |

`worked-example` went to the before version in all three runs; `exposition-introduction` went to the after version in all three.

## What the targeted cases show

- **`ste-connectors`** (dropped "that", two-sense "since" / "as" / "while", a vague "with"): both versions restore the dropped "that" and remove the two-sense connectives, so the base skill already handles the surface repair. The difference is in what the editor does with the relations those words left unstated. The after version raised them as author questions far more often (8, 10, and 3 mentions of the relation in the three runs, against 4, 0, and 1 before), and all three after runs passed both checks, against one before.
- **`ste-procedure`** (bundled steps, unclear order, a stacked verb phrase): no change, 2/3 passing on both sides. Plain Claude failed the code check in every run on both sides, so this case is hard to edit without dropping protected content.
- **`ste-vague`** (vague verbs, phrasal verbs, a noun pile-up, a limitation with no consequence): both versions passed 3/3. In two after runs "addresses" was replaced, with neutral wording ("developed a model for", "targets") rather than a stronger claim, and the run asked about it; the meaning grader passed all three.

## Reading

- **Preservation improved.** With the skill, runs passing both checks rose from 9/21 to 13/21, and major meaning problems fell from 0.57 to 0.43 per run. Most of the gain is in `ste-connectors` (1 to 3) and `exposition-results` (1 to 3). `exposition-introduction` lost its one passing run. The earlier four-case runs showed the same direction (3/12 to 6/12, twice).
- **Quality held, with no detectable change.** Against plain Claude the skill won 13 of 21 on both sides. In the direct comparison the after version won 11 to 8 (two-sided sign test on the 19 decided pairs, p ≈ 0.65). The earlier four-case runs leaned the other way (5 to 7 and 3 to 6 against the after version), so the quality measure moves by that much between runs.
- **Cost rose about 11%** per edit, from $0.389 to $0.430, in line with the longer reference files.
- **The new diagnostics show up where they were aimed,** in what the editor asks the author, not in a higher quality score. That is the behavior the change asks for: name a relation only when the text supports it, and ask otherwise.

Total cost: about $8.53 (before) and $9.37 (after) to run the trials, $3.16 and $3.12 to grade them, and $1.65 for the direct comparison.
