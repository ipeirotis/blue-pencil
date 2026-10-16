# Pilot report: ste-before

- Executor model: `claude-sonnet-5-5` (Claude Code 2.1.301 (Claude Code))
- Blue Pencil version: 3.0.0, repo commit `382718be12`
- Cases: exposition-introduction, exposition-methods, exposition-results, worked-example; 3 runs per condition per case
- Rubric: `evals/rubric.md` v0.3. Revision stage: first draft.
- Resumed 2026-10-16T19:21:43 at repo commit `382718be12`
- **Caveat:** with-skill sessions also listed 21 other skills, built into Claude Code or installed for the user (artifact-capabilities, artifact-diagramming, batch, claude-api, code-review, dataviz, debug, deep-research, design, design-sync, doctor, fewer-permission-prompts, loop, plugin-authoring, run, run-skill-generator, simplify, slides, update-config, verify, workflow-authoring); the baseline, run without slash commands, listed none. No counted trial called one.

## 1. Preservation (all cases)

| Condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| With Blue Pencil | 12 | 10/12 (83%) | 5 / 7 / 0 | 3/12 (25%) | 0.92 | 0.67 |
| Without (plain Claude) | 12 | 9/12 (75%) | 3 / 9 / 0 | 3/12 (25%) | 2.58 | 0 |

## 2. Preservation by case

| Case / condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| exposition-introduction / With Blue Pencil | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 1.33 | 0 |
| exposition-introduction / Without (plain Claude) | 3 | 2/3 (66%) | 0 / 3 / 0 | 0/3 (0%) | 3 | 0 |
| exposition-methods / With Blue Pencil | 3 | 1/3 (33%) | 3 / 0 / 0 | 1/3 (33%) | 0 | 0 |
| exposition-methods / Without (plain Claude) | 3 | 1/3 (33%) | 0 / 3 / 0 | 0/3 (0%) | 3 | 0 |
| exposition-results / With Blue Pencil | 3 | 3/3 (100%) | 2 / 1 / 0 | 2/3 (66%) | 0.33 | 0 |
| exposition-results / Without (plain Claude) | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 4.33 | 0 |
| worked-example / With Blue Pencil | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 2 | 2.67 |
| worked-example / Without (plain Claude) | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |

Major problems per run:

- exposition-introduction / With Blue Pencil: 2, 1, 1
- exposition-introduction / Without (plain Claude): 4, 3, 2
- exposition-methods / With Blue Pencil: 0, 0, 0
- exposition-methods / Without (plain Claude): 4, 3, 2
- exposition-results / With Blue Pencil: 1, 0, 0
- exposition-results / Without (plain Claude): 4, 4, 5
- worked-example / With Blue Pencil: 2, 2, 2
- worked-example / Without (plain Claude): 0, 0, 0

## 3. Cost and speed

| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |
|---|---|---|---|
| With Blue Pencil | 252097.083 | 107.975 | 0.405 |
| Without (plain Claude) | 4264.417 | 11.8 | 0.017 |

Blue Pencil was loaded in 12/12 with-skill runs (checked from each transcript's tool calls).

## 4. Quality (blinded, both orders)

| Pairs | Blue Pencil wins | Plain Claude wins | Ties or order-dependent |
|---|---|---|---|
| All (12) | 6 | 4 | 2 |
| Both passed preservation (0) | 0 | 0 | 0 |

## 5. Clean improvements (passes preservation and wins quality)

| Condition | Clean improvements |
|---|---|
| With Blue Pencil | 2/12 (16%) |
| Without (plain Claude) | 0/12 (0%) |

| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Clean improvement? |
|---|---|---|---|---|---|
| exposition-introduction | 1 | with_skill | False | False | no |
| exposition-introduction | 2 | tie | False | False | no |
| exposition-introduction | 3 | tie | False | False | no |
| exposition-methods | 1 | without_skill | False | False | no |
| exposition-methods | 2 | without_skill | False | False | no |
| exposition-methods | 3 | with_skill | True | False | yes |
| exposition-results | 1 | without_skill | False | False | no |
| exposition-results | 2 | with_skill | True | False | yes |
| exposition-results | 3 | without_skill | True | False | no |
| worked-example | 1 | with_skill | False | True | no |
| worked-example | 2 | with_skill | False | True | no |
| worked-example | 3 | with_skill | False | True | no |

## 6. What the graders flagged

**With Blue Pencil, exposition-introduction, run 1**
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "Estimating the effect of review valence on sales runs into a well-known obstacle to identification in this literature"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of valence on sales and find it positive and significant"

**With Blue Pencil, exposition-introduction, run 2**
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate a positive and statistically significant effect of review valence on sales"

**With Blue Pencil, exposition-introduction, run 3**
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it positive and statistically significant"

**With Blue Pencil, exposition-methods, run 1**
- code [numberwords]: removed [], added ['two']

**With Blue Pencil, exposition-methods, run 2**
- code [numberwords]: removed [], added ['two']

**With Blue Pencil, exposition-results, run 1**
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "and remains 0.15 (SE = 0.05) in column 3, after adding product fixed effects"

**With Blue Pencil, exposition-results, run 2**
- meaning [recorded/voice]: "Table 3 reports the estimates. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2. In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "Table 3 reports a positive coefficient on the identity-disclosed indicator that persists after product fixed effects are added: 0.18 (SE = 0.04) in column 2 and 0.15 (SE = 0.05) in column 3."

**With Blue Pencil, worked-example, run 1**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored"
- meaning [major/claim_strength]: "The results of our analysis demonstrate that reviewer identity has a significant effect." -> "In this dataset, reviewer identity has a significant effect."
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design" -> "This finding has implications for platform design"

**With Blue Pencil, worked-example, run 2**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "remains underexplored"
- meaning [major/new_content]: "reviewer identity has a significant effect" -> "reviewer identity has a significant effect on this relationship"
- meaning [minor/qualifier_word]: "has fundamentally transformed" -> "has transformed"
- meaning [minor/qualifier_word]: "a novel dataset" -> "a dataset"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design: managers should consider" -> "Platform managers should therefore consider"

**With Blue Pencil, worked-example, run 3**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "to the best of our knowledge, the question of whether reviewer identity affects this relationship remains underexplored"
- meaning [major/new_content]: "reviewer identity has a significant effect" -> "reviewer identity has a significant effect on this relationship"
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "has transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset" -> "we use a dataset"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design" -> "This finding has implications for platform design"
- meaning [recorded/voice]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"

**Without (plain Claude), exposition-introduction, run 1**
- code [numberwords]: removed [], added ['two']
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature." -> "because product quality affects both the reviews a product receives and its sales, a simple correlation between the two cannot be read as the causal effect of valence on sales"
- meaning [major/new_content]: "which generates quasi-random assignment conditional on observed covariates" -> "Because this unequal moderation is unrelated to a product's underlying quality, it generates quasi-random assignment conditional on observed covariates"
- meaning [major/new_content]: "which generates quasi-random assignment conditional on observed covariates." -> "that is, comparable reviews are exposed to different moderation regimes for reasons unrelated to the product itself"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"

**Without (plain Claude), exposition-introduction, run 2**
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "Estimating the causal effect of a review's valence on product sales is difficult because valence is endogenous: it is correlated with unobserved product quality, which also drives sales."
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"
- meaning [major/new_content]: "which generates quasi-random assignment conditional on observed covariates" -> "which generates quasi-random assignment of reviews to moderation treatment conditional on observed covariates"

**Without (plain Claude), exposition-introduction, run 3**
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "Do more favorable online reviews cause higher sales? The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature: the same unobserved quality that leads consumers to leave favorable reviews also leads them to buy the product."

**Without (plain Claude), exposition-methods, run 1**
- code [quotes]: removed [], added ['"after"', '"before"']
- code [numberwords]: removed [], added ['two-way']
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which captures the change in outcomes at a store after it receives the loyalty program, relative to stores that have not yet received it"
- meaning [major/new_content]: "Because the loyalty program was rolled out to stores on different dates," -> "In this setting, stores that were treated earlier can end up serving as implicit comparisons for stores treated later, which can distort the two-way fixed effects estimate when the effect differs across stores or over time."
- meaning [major/new_content]: "We estimate a two-way fixed effects model with store and week fixed effects," -> "The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks that affect all stores in a given week."
- meaning [major/new_content]: "Because the loyalty program was rolled out to stores on different dates," -> "(a staggered design), there is no single date that separates "before" from "after" for all stores."

**Without (plain Claude), exposition-methods, run 2**
- code [numberwords]: removed [], added ['two-way']
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "it captures the change in repeat purchase at a store after the loyalty program arrives, relative to the change at comparison stores over the same weeks"
- meaning [major/new_content]: "Because the loyalty program was rolled out to stores on different dates, we use the never-treated and not-yet-treated stores as controls" -> "a standard two-way fixed effects model can be misleading: it may use stores that were already treated as controls for stores treated later, which can distort the estimate when the program's effect changes over time or differs across stores"
- meaning [major/claim_strength]: "we use the never-treated and not-yet-treated stores as controls" -> "we compare each treated store only with stores that have not yet received the program at that time"
- meaning [recorded/voice]: "we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing" -> "To avoid this, we compare each treated store only with stores that have not yet received the program at that time, namely the never-treated and not-yet-treated stores."

**Without (plain Claude), exposition-methods, run 3**
- meaning [major/new_content]: "to address heterogeneity in treatment timing." -> "to address heterogeneity in treatment timing, that is, the possibility that the program's effect differs depending on when a store was treated."
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which captures how outcomes change at a store after it receives the program, relative to stores that have not received it."
- meaning [recorded/voice]: "We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level." -> "Store fixed effects absorb stable differences across stores, and week fixed effects absorb shocks common to all stores in a given week."

**Without (plain Claude), exposition-results, run 1**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and they show that who writes a review matters, not just what it says."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "It remains 0.15 (SE = 0.05) in column 3 after adding product fixed effects, so the identity effect is not an artifact of unobserved product differences."
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Reviewer tenure strengthens it: the interaction in column 4 is 0.09 (SE = 0.03)."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating, by comparison, carries a coefficient of 0.42 (SE = 0.02) across all specifications."

**Without (plain Claude), exposition-results, run 2**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and identity matters."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "it remains substantial at 0.15 (SE = 0.05) in column 3 after we add product fixed effects"
- meaning [major/claim_strength]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Reviewer tenure amplifies the effect: the interaction is 0.09 (SE = 0.03) in column 4."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating remains a strong predictor, with a coefficient of 0.42 (SE = 0.02) across all specifications, but it does not tell the whole story."
- meaning [recorded/voice]: "Table 3 reports the estimates. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2." -> "Table 3 reports the estimates, and identity matters."

**Without (plain Claude), exposition-results, run 3**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and they show that who writes a review matters alongside what it says."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "it remains substantial at 0.15 (SE = 0.05) in column 3 after we add product fixed effects"
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Identity also works in combination with experience: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating, by comparison, carries a coefficient of 0.42 (SE = 0.02) across all specifications."
- meaning [major/new_content]: "R-squared rises from 0.31 to 0.47 across the columns." -> "Explanatory power rises accordingly, with R-squared increasing from 0.31 to 0.47 across the columns."

