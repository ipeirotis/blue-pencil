# Pilot report: pilot-001

- Executor model: `claude-sonnet-5-5` (Claude Code 2.1.289 (Claude Code))
- Blue Pencil version: 3.0.0, repo commit `7d9ed8b4a7`
- Cases: exposition-introduction, exposition-methods, exposition-results, worked-example; 3 runs per condition per case
- Rubric: `evals/rubric.md` v0.2. Revision stage: first draft.

## 1. Preservation (all cases)

| Condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| With Blue Pencil | 12 | 11/12 (91%) | 0 / 0 / 0 | 0/12 (0%) | None | None |
| Without (plain Claude) | 12 | 8/12 (66%) | 0 / 0 / 0 | 0/12 (0%) | None | None |

## 2. Preservation by case

| Case / condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| exposition-introduction / With Blue Pencil | 3 | 3/3 (100%) | 0 / 0 / 0 | 0/3 (0%) | None | None |
| exposition-introduction / Without (plain Claude) | 3 | 2/3 (66%) | 0 / 0 / 0 | 0/3 (0%) | None | None |
| exposition-methods / With Blue Pencil | 3 | 2/3 (66%) | 0 / 0 / 0 | 0/3 (0%) | None | None |
| exposition-methods / Without (plain Claude) | 3 | 0/3 (0%) | 0 / 0 / 0 | 0/3 (0%) | None | None |
| exposition-results / With Blue Pencil | 3 | 3/3 (100%) | 0 / 0 / 0 | 0/3 (0%) | None | None |
| exposition-results / Without (plain Claude) | 3 | 3/3 (100%) | 0 / 0 / 0 | 0/3 (0%) | None | None |
| worked-example / With Blue Pencil | 3 | 3/3 (100%) | 0 / 0 / 0 | 0/3 (0%) | None | None |
| worked-example / Without (plain Claude) | 3 | 3/3 (100%) | 0 / 0 / 0 | 0/3 (0%) | None | None |

Major problems per run:

- exposition-introduction / With Blue Pencil: n/a, n/a, n/a
- exposition-introduction / Without (plain Claude): n/a, n/a, n/a
- exposition-methods / With Blue Pencil: n/a, n/a, n/a
- exposition-methods / Without (plain Claude): n/a, n/a, n/a
- exposition-results / With Blue Pencil: n/a, n/a, n/a
- exposition-results / Without (plain Claude): n/a, n/a, n/a
- worked-example / With Blue Pencil: n/a, n/a, n/a
- worked-example / Without (plain Claude): n/a, n/a, n/a

## 3. Cost and speed

| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |
|---|---|---|---|
| With Blue Pencil | 58425.167 | 105.292 | 0.414 |
| Without (plain Claude) | 4046.25 | 9.792 | 0.017 |

Blue Pencil was loaded in 12/12 with-skill runs (checked from each transcript's tool calls).

## 4. Quality (blinded, both orders)

| Pairs | Blue Pencil wins | Plain Claude wins | Ties or order-dependent |
|---|---|---|---|
| All (0) | 0 | 0 | 0 |
| Both passed preservation (0) | 0 | 0 | 0 |

## 5. Clean improvements (passes preservation and wins quality)

| Condition | Clean improvements |
|---|---|
| With Blue Pencil | 0/0 |
| Without (plain Claude) | 0/0 |

| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Clean improvement? |
|---|---|---|---|---|---|

## 6. What the graders flagged

**With Blue Pencil, exposition-methods, run 3**
- code [numberwords]: removed [], added ['two']

**Without (plain Claude), exposition-introduction, run 1**
- code [numberwords]: removed [], added ['two']

**Without (plain Claude), exposition-methods, run 1**
- code [quotes]: removed [], added ['"after"', '"before"']
- code [numberwords]: removed [], added ['two-way']

**Without (plain Claude), exposition-methods, run 2**
- code [numberwords]: removed [], added ['two']

**Without (plain Claude), exposition-methods, run 3**
- code [numberwords]: removed [], added ['two']

