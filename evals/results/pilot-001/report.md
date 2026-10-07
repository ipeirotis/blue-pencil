# Pilot report: pilot-001

- Executor model: `claude-sonnet-5-5` (Claude Code 2.1.289 (Claude Code))
- Blue Pencil version: 3.0.0, repo commit `7d9ed8b4a7`
- Cases: exposition-introduction, exposition-methods, exposition-results, worked-example; 3 runs per condition per case
- Rubric: `evals/rubric.md` v0.2. Revision stage: first draft.
- **Caveat:** this run predates equal workspaces: only the with-skill workspace held AGENTS.md with the paper context (both prompts included it), so the conditions differ in that as well as in the skill. Rerun under a new run id to isolate the skill.
- **Caveat:** with-skill sessions also listed 21 other skills, built into Claude Code or installed for the user (artifact-capabilities, artifact-diagramming, batch, claude-api, code-review, dataviz, debug, deep-research, design, design-sync, doctor, fewer-permission-prompts, loop, plugin-authoring, run, run-skill-generator, simplify, slides, update-config, verify, workflow-authoring); the baseline, run without slash commands, listed none. No counted trial called one.
- **Caveat:** 12 with-skill runs predate held-out examples: their workspace also held the example file the case was built from, which contains an authored revision of the same passage. No tool call in their transcripts named an example file.

## 1. Preservation (all cases)

| Condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| With Blue Pencil | 12 | 11/12 (91%) | 6 / 4 / 2 | 5/12 (41%) | 0.67 | 0.75 |
| Without (plain Claude) | 12 | 8/12 (66%) | 3 / 9 / 0 | 3/12 (25%) | 2.17 | 0.25 |

## 2. Preservation by case

| Case / condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| exposition-introduction / With Blue Pencil | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 1.33 | 0 |
| exposition-introduction / Without (plain Claude) | 3 | 2/3 (66%) | 0 / 3 / 0 | 0/3 (0%) | 2.33 | 0.67 |
| exposition-methods / With Blue Pencil | 3 | 2/3 (66%) | 3 / 0 / 0 | 2/3 (66%) | 0 | 0 |
| exposition-methods / Without (plain Claude) | 3 | 0/3 (0%) | 0 / 3 / 0 | 0/3 (0%) | 2.33 | 0.33 |
| exposition-results / With Blue Pencil | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| exposition-results / Without (plain Claude) | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 4 | 0 |
| worked-example / With Blue Pencil | 3 | 3/3 (100%) | 0 / 1 / 2 | 0/3 (0%) | 1.33 | 3 |
| worked-example / Without (plain Claude) | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |

Major problems per run:

- exposition-introduction / With Blue Pencil: 2, 1, 1
- exposition-introduction / Without (plain Claude): 3, 2, 2
- exposition-methods / With Blue Pencil: 0, 0, 0
- exposition-methods / Without (plain Claude): 2, 3, 2
- exposition-results / With Blue Pencil: 0, 0, 0
- exposition-results / Without (plain Claude): 6, 2, 4
- worked-example / With Blue Pencil: 2, 1, 1
- worked-example / Without (plain Claude): 0, 0, 0

## 3. Cost and speed

| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |
|---|---|---|---|
| With Blue Pencil | 227022.833 | 105.292 | 0.414 |
| Without (plain Claude) | 4046.25 | 9.792 | 0.017 |

Blue Pencil was loaded in 12/12 with-skill runs (checked from each transcript's tool calls).

## 4. Quality (blinded, both orders)

| Pairs | Blue Pencil wins | Plain Claude wins | Ties or order-dependent |
|---|---|---|---|
| All (12) | 6 | 5 | 1 |
| Both passed preservation (0) | 0 | 0 | 0 |

## 5. Clean improvements (passes preservation and wins quality)

| Condition | Clean improvements |
|---|---|
| With Blue Pencil | 0/12 (0%) |
| Without (plain Claude) | 0/12 (0%) |

| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Clean improvement? |
|---|---|---|---|---|---|
| exposition-introduction | 1 | with_skill | False | False | no |
| exposition-introduction | 2 | with_skill | False | False | no |
| exposition-introduction | 3 | without_skill | False | False | no |
| exposition-methods | 1 | without_skill | True | False | no |
| exposition-methods | 2 | tie | True | False | no |
| exposition-methods | 3 | with_skill | False | False | no |
| exposition-results | 1 | without_skill | True | False | no |
| exposition-results | 2 | without_skill | True | False | no |
| exposition-results | 3 | without_skill | True | False | no |
| worked-example | 1 | with_skill | False | True | no |
| worked-example | 2 | with_skill | False | True | no |
| worked-example | 3 | with_skill | False | True | no |

## 6. What the graders flagged

**With Blue Pencil, exposition-introduction, run 1**
- meaning [major/new_content]: "a well-known obstacle to identification in this literature" -> "a well-known obstacle to identifying its effect on sales"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of valence on sales and find it positive and significant"

**With Blue Pencil, exposition-introduction, run 2**
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"

**With Blue Pencil, exposition-introduction, run 3**
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"

**With Blue Pencil, exposition-methods, run 3**
- code [numberwords]: removed [], added ['two']

**With Blue Pencil, exposition-results, run 1**
- meaning [recorded/voice]: "The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2. In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "Alongside it, the identity-disclosed indicator is positive: 0.18 (SE = 0.04) in column 2. After adding product fixed effects in column 3, the coefficient stays positive at 0.15 (SE = 0.05)."

**With Blue Pencil, worked-example, run 1**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored"
- meaning [major/new_content]: "reviewer identity has a significant effect" -> "reviewer identity has a significant effect on this relationship"
- meaning [minor/qualifier_word]: "has fundamentally transformed" -> "has transformed"
- meaning [minor/qualifier_word]: "a novel dataset" -> "a dataset"
- meaning [minor/qualifier_word]: "has important implications for platform design" -> "has implications for platform design"

**With Blue Pencil, worked-example, run 2**
- meaning [major/new_content]: "reviewer identity has a significant effect" -> "reviewer identity has a significant effect on the relationship between reviews and sales"
- meaning [minor/qualifier_word]: "has fundamentally transformed" -> "has transformed"
- meaning [minor/qualifier_word]: "a novel dataset comprising of 1.2 million reviews" -> "a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "has important implications for platform design" -> "has implications for platform design"

**With Blue Pencil, worked-example, run 3**
- meaning [major/new_content]: "reviewer identity has a significant effect" -> "reviewer identity has a significant effect on this relationship"
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which" -> "has transformed how"
- meaning [minor/qualifier_word]: "we leverage a novel dataset" -> "we use a dataset"
- meaning [minor/qualifier_word]: "has important implications for platform design" -> "has implications for platform design"

**Without (plain Claude), exposition-introduction, run 1**
- code [numberwords]: removed [], added ['two']
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature." -> "products of higher quality tend to attract more favorable reviews and higher sales, so the two are correlated even absent any causal effect of reviews"
- meaning [major/new_content]: "which generates quasi-random assignment conditional on observed covariates." -> "That is, otherwise comparable cohorts are exposed to different moderation, and hence differ in the valence of the reviews consumers see, for reasons unrelated to product quality."

**Without (plain Claude), exposition-introduction, run 2**
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature." -> "is a well-known obstacle to identification in this literature: because quality affects both the reviews a product receives and its sales, a naive comparison conflates the effect of valence with the effect of quality."
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant." -> "we estimate the effect of review valence on sales and find it to be positive and significant."
- meaning [minor/new_content]: "as a source of exogenous variation. ... which generates quasi-random assignment conditional on observed covariates." -> "as a source of exogenous variation in valence. ... which generates quasi-random assignment of valence conditional on observed covariates."

**Without (plain Claude), exposition-introduction, run 3**
- meaning [major/new_content]: "a well-known obstacle to identification in this literature" -> "a well-known obstacle to identifying the causal effect of online reviews on sales"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"
- meaning [minor/new_content]: "which generates quasi-random assignment conditional on observed covariates" -> "which generates quasi-random assignment of review cohorts to moderation conditional on observed covariates"

**Without (plain Claude), exposition-methods, run 1**
- code [quotes]: removed [], added ['"after"', '"before"']
- code [numberwords]: removed [], added ['two-way']
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "it captures how much repeat purchase changes in a store after it receives the program, relative to stores that have not received it"
- meaning [major/new_content]: "we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing." -> "stores do not share a single "before" and "after" period, and a standard two-way fixed effects estimate can be distorted when treatment timing varies"
- meaning [minor/new_content]: "We estimate a two-way fixed effects model with store and week fixed effects" -> "The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks that affect all stores in the same week."

**Without (plain Claude), exposition-methods, run 2**
- code [numberwords]: removed [], added ['two']
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which captures how repeat purchase changes in a store once the loyalty program reaches it, relative to stores where it has not"
- meaning [major/new_content]: "We estimate a two-way fixed effects model with store and week fixed effects," -> "Store fixed effects absorb stable differences across stores, and week fixed effects absorb shocks common to all stores in a given week."
- meaning [major/new_content]: "to address heterogeneity in treatment timing." -> "Because treatment timing varies, the effect of the program may differ depending on when a store adopts it."

**Without (plain Claude), exposition-methods, run 3**
- code [numberwords]: removed [], added ['two']
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which captures how outcomes change at a store once it receives the loyalty program, relative to stores that have not received it"
- meaning [major/new_content]: "We estimate a two-way fixed effects model with store and week fixed effects," -> "The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks that affect all stores in a given week."

**Without (plain Claude), exposition-results, run 1**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and identity matters."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "It holds up in column 3, where adding product fixed effects leaves it at 0.15"
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "The interaction with reviewer tenure, 0.09 (SE = 0.03) in column 4, shows that the effect of disclosure grows with tenure."
- meaning [major/claim_strength]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating remains a strong driver of sales"
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "of sales"
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "yet identity adds to it"
- meaning [recorded/voice]: "Table 3 reports the estimates. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2." -> "Table 3 reports the estimates, and identity matters."

**Without (plain Claude), exposition-results, run 2**
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating remains a strong predictor throughout, at 0.42 (SE = 0.02) in every specification."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "it holds at 0.15 (SE = 0.05) in column 3 once we add product fixed effects"

**Without (plain Claude), exposition-results, run 3**
- meaning [major/new_content]: "Table 3 reports the estimates. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2." -> "Identity matters over and above the rating itself."
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Who the reviewer is also conditions the effect: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4."
- meaning [major/claim_strength]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "and it holds at 0.15 (SE = 0.05) in column 3 once product fixed effects are added"
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating, by comparison, carries a coefficient of 0.42 (SE = 0.02) across all specifications."

## 7. Human vs. quality grader

Agreement on 12 pairs: **4/12**.

