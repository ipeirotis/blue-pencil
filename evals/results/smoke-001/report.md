# Pilot report: smoke-001

- Executor model: `claude-sonnet-5-5` (Claude Code 2.1.288 (Claude Code))
- Blue Pencil version: 3.0.0, repo commit `fc7eee0c0d`
- Cases: worked-example; 1 runs per condition per case
- Rubric: `evals/rubric.md` v0.2. Revision stage: first draft.

## 1. Preservation (all cases)

| Condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| With Blue Pencil | 1 | 1/1 (100%) | 1 / 0 / 0 | 1/1 (100%) | 0 | 2 |
| Without (plain Claude) | 1 | 0/1 (0%) | 0 / 1 / 0 | 0/1 (0%) | 4 | 2 |

## 2. Preservation by case

| Case / condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| worked-example / With Blue Pencil | 1 | 1/1 (100%) | 1 / 0 / 0 | 1/1 (100%) | 0 | 2 |
| worked-example / Without (plain Claude) | 1 | 0/1 (0%) | 0 / 1 / 0 | 0/1 (0%) | 4 | 2 |

Major problems per run:

- worked-example / With Blue Pencil: 0
- worked-example / Without (plain Claude): 4

## 3. Cost and speed

| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |
|---|---|---|---|
| With Blue Pencil | 72918 | 135.4 | 0.464 |
| Without (plain Claude) | 4168 | 15.2 | 0.021 |

Blue Pencil was loaded in 1/1 with-skill runs (checked from each transcript's tool calls).

## 4. Quality (blinded, both orders)

| Pairs | Blue Pencil wins | Plain Claude wins | Ties or order-dependent |
|---|---|---|---|
| All (1) | 0 | 1 | 0 |
| Both passed preservation (0) | 0 | 0 | 0 |

## 5. Clean improvements (passes preservation and wins quality)

| Condition | Clean improvements |
|---|---|
| With Blue Pencil | 0/1 (0%) |
| Without (plain Claude) | 0/1 (0%) |

| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Clean improvement? |
|---|---|---|---|---|---|
| worked-example | 1 | without_skill | True | False | no |

## 6. What the graders flagged

**With Blue Pencil, worked-example, run 1**
- meaning [minor/qualifier_word]: "has
fundamentally transformed the way in which consumers make purchasing
decisions" -> "have transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising
of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"

**Without (plain Claude), worked-example, run 1**
- code [citation_order]: removed ['Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003'], added ['Chevalier and Mayzlin 2006; Dellarocas 2003; Forman et al. 2008']
- meaning [major/claim_strength]: "these studies found that reviews matter, a one-star increase leads to a 5-9% increase in revenue" -> "with estimates suggesting that a one-star increase in average rating is associated with a 5-9% increase in revenue"
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "remains underexplored"
- meaning [major/new_content]: "an investigation of the relationship between online reviews and sales was conducted by several researchers" -> "A substantial literature links online reviews to sales"
- meaning [major/new_content]: "" -> "Yet this work treats a review largely as a rating."
- meaning [minor/qualifier_word]: "fundamentally transformed" -> "transformed"
- meaning [minor/qualifier_word]: "important implications for platform design" -> "direct implications for platform design"

