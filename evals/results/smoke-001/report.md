# Pilot report: smoke-001

- Executor model: `claude-sonnet-5-5` (Claude Code 2.1.288 (Claude Code))
- Blue Pencil version: 3.0.0, repo commit `fc7eee0c0d`
- Cases: worked-example; 1 trials per condition per case
- Rubric: `evals/rubric.md` (draft v0.1). Revision stage: first draft.

## 1. Preservation (Part A): did the edit keep meaning, numbers, citations?

| Condition | Trials | Code check passes | Meaning: preserved | changed | unsure | Both pass |
|---|---|---|---|---|---|---|
| With Blue Pencil | 1 | 1/1 (100%) | 0 | 1 | 0 | 0/1 (0%) |
| Without (plain Claude) | 1 | 1/1 (100%) | 0 | 1 | 0 | 0/1 (0%) |

## 2. Cost and speed

| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |
|---|---|---|---|
| With Blue Pencil | 72918 | 135.4 | 0.464 |
| Without (plain Claude) | 4168 | 15.2 | 0.021 |

Blue Pencil was actually loaded in 1/1 with-skill trials (checked from the tool calls in each transcript).

## 3. Quality (Part B): head-to-head, blinded, each pair judged in both orders

Pairs: 1. Blue Pencil wins: **0**, plain Claude wins: **1**, ties or order-dependent: **0**.

Quality must be read together with preservation. A win only counts as an improvement if that version also passed Part A; the table shows both.

| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Counts as improvement? |
|---|---|---|---|---|---|
| worked-example | 1 | without_skill | False | False | no |

## 4. What the graders flagged

**With Blue Pencil, worked-example, run 1**
- meaning [major/lost_content]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"
- meaning [possible/claim_strength]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "have transformed how consumers make purchasing decisions"
- meaning [possible/claim_strength]: "The results of our analysis demonstrate that reviewer identity has a significant effect." -> "We find that reviewer identity has a significant effect."
- meaning [possible/lost_content]: "this finding has important implications for platform design: managers should consider highlighting reviewer credentials" -> "Platform managers should therefore consider highlighting reviewer credentials."

**Without (plain Claude), worked-example, run 1**
- meaning [major/claim_strength]: "these studies found that reviews matter, a one-star increase leads to a 5-9% increase in revenue" -> "with estimates suggesting that a one-star increase in average rating is associated with a 5-9% increase in revenue"
- meaning [major/new_content]: "" -> "Yet this work treats a review largely as a rating."
- meaning [major/qualification]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "remains underexplored"
- meaning [possible/scope]: "an investigation of the relationship between online reviews and sales was conducted by several researchers" -> "A substantial literature links online reviews to sales"
- meaning [possible/scope]: "a one-star increase leads to" -> "a one-star increase in average rating"
- meaning [possible/claim_strength]: "has fundamentally transformed" -> "have transformed"
- meaning [possible/scope]: "The results of our analysis demonstrate that reviewer identity has a significant effect." -> "We find that reviewer identity significantly affects the review-sales relationship."
- meaning [possible/claim_strength]: "Whether the identity of reviewers affects this relationship" -> "Whether the identity of the reviewer changes how much a review moves sales"
- meaning [possible/claim_strength]: "this finding has important implications for platform design" -> "This result has direct implications for platform design"

