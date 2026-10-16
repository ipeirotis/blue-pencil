# Pilot report: ste2-before

- Executor model: `claude-sonnet-5-5` (Claude Code 2.1.301 (Claude Code))
- Blue Pencil version: 3.0.0, repo commit `382718be12`
- Cases: exposition-introduction, exposition-methods, exposition-results, worked-example, ste-connectors, ste-procedure, ste-vague; 3 runs per condition per case
- Rubric: `evals/rubric.md` v0.3. Revision stage: first draft.
- Resumed 2026-10-16T21:10:26 at repo commit `382718be12`
- **Caveat:** with-skill sessions also listed 21 other skills, built into Claude Code or installed for the user (artifact-capabilities, artifact-diagramming, batch, claude-api, code-review, dataviz, debug, deep-research, design, design-sync, doctor, fewer-permission-prompts, loop, plugin-authoring, run, run-skill-generator, simplify, slides, update-config, verify, workflow-authoring); the baseline, run without slash commands, listed none. No counted trial called one.

## 1. Preservation (all cases)

| Condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| With Blue Pencil | 21 | 18/21 (85%) | 11 / 9 / 1 | 9/21 (42%) | 0.57 | 0.38 |
| Without (plain Claude) | 21 | 16/21 (76%) | 8 / 13 / 0 | 8/21 (38%) | 1.95 | 0.05 |

## 2. Preservation by case

| Case / condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| exposition-introduction / With Blue Pencil | 3 | 3/3 (100%) | 1 / 2 / 0 | 1/3 (33%) | 1 | 0 |
| exposition-introduction / Without (plain Claude) | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 3.33 | 0 |
| exposition-methods / With Blue Pencil | 3 | 1/3 (33%) | 3 / 0 / 0 | 1/3 (33%) | 0 | 0 |
| exposition-methods / Without (plain Claude) | 3 | 1/3 (33%) | 0 / 3 / 0 | 0/3 (0%) | 4 | 0 |
| exposition-results / With Blue Pencil | 3 | 3/3 (100%) | 1 / 2 / 0 | 1/3 (33%) | 0.67 | 0 |
| exposition-results / Without (plain Claude) | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 4.33 | 0 |
| ste-connectors / With Blue Pencil | 3 | 2/3 (66%) | 1 / 2 / 0 | 1/3 (33%) | 0.67 | 0 |
| ste-connectors / Without (plain Claude) | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| ste-procedure / With Blue Pencil | 3 | 3/3 (100%) | 2 / 1 / 0 | 2/3 (66%) | 0.33 | 0 |
| ste-procedure / Without (plain Claude) | 3 | 0/3 (0%) | 0 / 3 / 0 | 0/3 (0%) | 1.67 | 0 |
| ste-vague / With Blue Pencil | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| ste-vague / Without (plain Claude) | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| worked-example / With Blue Pencil | 3 | 3/3 (100%) | 0 / 2 / 1 | 0/3 (0%) | 1.33 | 2.67 |
| worked-example / Without (plain Claude) | 3 | 3/3 (100%) | 2 / 1 / 0 | 2/3 (66%) | 0.33 | 0.33 |

Major problems per run:

- exposition-introduction / With Blue Pencil: 0, 1, 2
- exposition-introduction / Without (plain Claude): 5, 2, 3
- exposition-methods / With Blue Pencil: 0, 0, 0
- exposition-methods / Without (plain Claude): 4, 4, 4
- exposition-results / With Blue Pencil: 1, 1, 0
- exposition-results / Without (plain Claude): 5, 3, 5
- ste-connectors / With Blue Pencil: 1, 1, 0
- ste-connectors / Without (plain Claude): 0, 0, 0
- ste-procedure / With Blue Pencil: 0, 1, 0
- ste-procedure / Without (plain Claude): 2, 1, 2
- ste-vague / With Blue Pencil: 0, 0, 0
- ste-vague / Without (plain Claude): 0, 0, 0
- worked-example / With Blue Pencil: 2, 0, 2
- worked-example / Without (plain Claude): 1, 0, 0

## 3. Cost and speed

| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |
|---|---|---|---|
| With Blue Pencil | 248576.524 | 95.319 | 0.389 |
| Without (plain Claude) | 4251.905 | 10.595 | 0.017 |

Blue Pencil was loaded in 21/21 with-skill runs (checked from each transcript's tool calls).

## 4. Quality (blinded, both orders)

| Pairs | Blue Pencil wins | Plain Claude wins | Ties or order-dependent |
|---|---|---|---|
| All (21) | 13 | 7 | 1 |
| Both passed preservation (4) | 4 | 0 | 0 |

## 5. Clean improvements (passes preservation and wins quality)

| Condition | Clean improvements |
|---|---|
| With Blue Pencil | 5/21 (23%) |
| Without (plain Claude) | 0/21 (0%) |

| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Clean improvement? |
|---|---|---|---|---|---|
| exposition-introduction | 1 | without_skill | True | False | no |
| exposition-introduction | 2 | without_skill | False | False | no |
| exposition-introduction | 3 | tie | False | False | no |
| exposition-methods | 1 | with_skill | False | False | no |
| exposition-methods | 2 | with_skill | False | False | no |
| exposition-methods | 3 | with_skill | True | False | yes |
| exposition-results | 1 | without_skill | False | False | no |
| exposition-results | 2 | with_skill | False | False | no |
| exposition-results | 3 | without_skill | True | False | no |
| ste-connectors | 1 | with_skill | False | True | no |
| ste-connectors | 2 | with_skill | False | True | no |
| ste-connectors | 3 | with_skill | True | True | yes |
| ste-procedure | 1 | without_skill | True | False | no |
| ste-procedure | 2 | without_skill | False | False | no |
| ste-procedure | 3 | without_skill | True | False | no |
| ste-vague | 1 | with_skill | True | True | yes |
| ste-vague | 2 | with_skill | True | True | yes |
| ste-vague | 3 | with_skill | True | True | yes |
| worked-example | 1 | with_skill | False | False | no |
| worked-example | 2 | with_skill | False | True | no |
| worked-example | 3 | with_skill | False | True | no |

## 6. What the graders flagged

**With Blue Pencil, exposition-introduction, run 2**
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "We study the effect of review valence on sales, where valence is how positive or negative a review is."

**With Blue Pencil, exposition-introduction, run 3**
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "Unobserved quality can shape both a product's reviews and its sales, so the raw link between valence and sales does not isolate the effect of valence."
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"
- meaning [recorded/voice]: "We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Specifically, we leverage the fact that platforms differentially apply moderation policies" -> "by exploiting unequal moderation: platforms differentially apply moderation policies across review cohorts. This platform-level heterogeneity in content moderation is a source of exogenous variation"

**With Blue Pencil, exposition-methods, run 1**
- code [numberwords]: removed [], added ['two']

**With Blue Pencil, exposition-methods, run 2**
- code [numberwords]: removed [], added ['two']
- meaning [recorded/voice]: "to address heterogeneity in treatment timing" -> "to address the differences across stores in when treatment began"

**With Blue Pencil, exposition-results, run 1**
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "the identity-disclosed indicator survives the addition of product fixed effects"

**With Blue Pencil, exposition-results, run 2**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Identity disclosure matters over and above the star rating."

**With Blue Pencil, ste-connectors, run 1**
- code [numberwords]: removed [], added ['doubled']
- meaning [major/claim_strength]: "Since the retriever was frozen, accuracy on frequent questions did not change" -> "With the retriever frozen, accuracy on frequent questions did not change"

**With Blue Pencil, ste-connectors, run 2**
- meaning [major/claim_strength]: "Since the retriever was frozen, accuracy on frequent questions did not change" -> "With the retriever frozen, accuracy on frequent questions did not change"

**With Blue Pencil, ste-procedure, run 2**
- meaning [major/lost_content]: "Responses were screened and recoded after the field period closed" -> "After the field period closed, responses were screened"

**With Blue Pencil, ste-vague, run 1**
- meaning [recorded/voice]: "We came up with a two-stage model that deals with sparse interaction histories" -> "We developed a two-stage model that addresses the cold-start problem in recommender systems by handling sparse interaction histories"

**With Blue Pencil, worked-example, run 1**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "remains underexplored in the literature"
- meaning [major/new_content]: "reviewer identity has a significant effect" -> "reviewer identity has a significant effect on this relationship"
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "has transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design" -> "This finding has implications for platform design"

**With Blue Pencil, worked-example, run 2**
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "has transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"

**With Blue Pencil, worked-example, run 3**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "To the best of our knowledge, however, whether the identity of reviewers affects this relationship remains underexplored"
- meaning [major/new_content]: "reviewer identity has a significant effect" -> "reviewer identity has a significant effect on the relationship between reviews and sales"
- meaning [minor/qualifier_word]: "has fundamentally transformed" -> "has transformed"
- meaning [minor/qualifier_word]: "a novel dataset comprising of 1.2 million reviews" -> "a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design" -> "This finding has implications for platform design"

**Without (plain Claude), exposition-introduction, run 1**
- meaning [major/new_content]: "a well-known obstacle to identification in this literature" -> "a well-known obstacle to identifying the causal effect of valence on sales in this literature"
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "the same unobserved quality that leads consumers to rate a product highly also leads them to buy it"
- meaning [major/new_content]: "platforms differentially apply moderation policies across review cohorts, which generates quasi-random assignment conditional on observed covariates" -> "so that comparable reviews are moderated differently"
- meaning [major/new_content]: "which generates quasi-random assignment conditional on observed covariates" -> "This generates quasi-random assignment, conditional on observed covariates, of the moderation regime a review faces."
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"

**Without (plain Claude), exposition-introduction, run 2**
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "Estimating the causal effect of a review's valence on sales is difficult because valence is endogenous: it is correlated with unobserved product quality, which also drives sales."
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of valence on sales and find it to be positive and significant"

**Without (plain Claude), exposition-introduction, run 3**
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature." -> "is a well-known obstacle to identification in this literature: higher-quality products tend to receive more favorable reviews and also to sell more, so the observed relationship between valence and sales cannot be read as causal."
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"
- meaning [major/new_content]: "which generates quasi-random assignment conditional on observed covariates" -> "which generates quasi-random assignment of cohorts to differing moderation exposure, conditional on observed covariates"

**Without (plain Claude), exposition-methods, run 1**
- meaning [major/new_content]: "we use the never-treated and not-yet-treated stores as controls" -> "As a result, we do not need a separate group of stores that never receive the program."
- meaning [major/new_content]: "We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level." -> "The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks common to all stores in a given week."
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which captures the change in outcomes for a store after the loyalty program reaches it, relative to the change at other stores over the same period"
- meaning [major/new_content]: "to address heterogeneity in treatment timing" -> "Because a two-way fixed effects estimate can be sensitive to differences in when stores are treated"
- meaning [recorded/voice]: "Because the loyalty program was rolled out to stores on different dates, we use the never-treated and not-yet-treated stores as controls" -> "a staggered design in which stores enter treatment at different times rather than all at once"

**Without (plain Claude), exposition-methods, run 2**
- code [quotes]: removed [], added ['"after"', '"before"']
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which compares the change in repeat purchase at stores after they receive the loyalty program with the change at stores that have not received it"
- meaning [major/new_content]: "and we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing." -> "Because differences in treatment timing can complicate the interpretation of the two-way fixed effects estimate, we report the Callaway and Sant'Anna estimator alongside it"
- meaning [major/new_content]: "We estimate a two-way fixed effects model with store and week fixed effects," -> "The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks that affect all stores in the same week."
- meaning [major/new_content]: "Because the loyalty program was rolled out to stores on different dates," -> "there is no single "before" and "after" period shared by all treated stores."
- meaning [recorded/voice]: "we use the never-treated and not-yet-treated stores as controls" -> "We therefore use the never-treated stores (those that never receive the program) and the not-yet-treated stores (those that will receive it later but have not yet) as controls."

**Without (plain Claude), exposition-methods, run 3**
- code [numberwords]: removed [], added ['two-way']
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which captures the change in repeat purchase after a store receives the loyalty program, relative to comparison stores"
- meaning [major/new_content]: "to address heterogeneity in treatment timing" -> "Two-way fixed effects estimates can be difficult to interpret when treatment timing varies, because the effect of the program may differ across stores or over time."
- meaning [major/new_content]: "we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate" -> "This estimator compares each group of stores that began treatment on the same date only with stores not yet treated or never treated, and then aggregates those comparisons."
- meaning [major/new_content]: "with store and week fixed effects" -> "These fixed effects absorb stable differences across stores and shocks common to all stores in a given week."

**Without (plain Claude), exposition-results, run 1**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and they point to a clear role for reviewer identity."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "Adding product fixed effects in column 3 trims it only modestly, to 0.15 (SE = 0.05), so the effect does not hinge on differences across products."
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Identity matters more as reviewers gain experience: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating remains a strong driver of sales throughout, with a coefficient of 0.42 (SE = 0.02)"
- meaning [major/reassigned]: "R-squared rises from 0.31 to 0.47 across the columns." -> "yet identity adds explanatory power beyond it, as R-squared rises from 0.31 to 0.47 across the columns."

**Without (plain Claude), exposition-results, run 2**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and they show that who writes a review matters."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "It remains substantial after we add product fixed effects in column 3, where it is 0.15 (SE = 0.05)."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating, by contrast, carries a steady coefficient of 0.42 (SE = 0.02) across all specifications."

**Without (plain Claude), exposition-results, run 3**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and they point to a clear role for reviewer identity."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "It remains substantial after we add product fixed effects in column 3, where it is 0.15 (SE = 0.05)."
- meaning [major/claim_strength]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Identity also conditions the influence of a review: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating matters as well, with a coefficient of 0.42 (SE = 0.02) across all specifications, but identity adds to its effect rather than being absorbed by it."
- meaning [major/new_content]: "R-squared rises from 0.31 to 0.47 across the columns." -> "Model fit improves accordingly, as R-squared rises from 0.31 to 0.47 across the columns."

**Without (plain Claude), ste-procedure, run 1**
- code [numberwords]: removed [], added ['four']
- meaning [major/lost_content]: "Responses were screened and recoded after the field period closed" -> "First, we screened the responses and excluded respondents"
- meaning [major/claim_strength]: "Raking weights would have been expected to have been applied to the merged file before estimation" -> "we processed the data in four steps. ... Fourth, before estimation, raking weights were to be applied to the merged file"

**Without (plain Claude), ste-procedure, run 2**
- code [numberwords]: removed [], added ['four']
- meaning [major/claim_strength]: "Raking weights would have been expected to have been applied to the merged file before estimation" -> "Fourth, raking weights were expected to be applied to the merged file before estimation"

**Without (plain Claude), ste-procedure, run 3**
- code [numberwords]: removed [], added ['four']
- meaning [major/claim_strength]: "Raking weights would have been expected to have been applied to the merged file before estimation" -> "Fourth, before estimation, raking weights were applied to the merged file"
- meaning [major/lost_content]: "Responses were screened and recoded after the field period closed" -> "First, responses were screened"

**Without (plain Claude), ste-vague, run 1**
- meaning [recorded/voice]: "We came up with a two-stage model that deals with sparse interaction histories, and the results point out that" -> "We developed a two-stage model that handles sparse interaction histories, and the results show that"

**Without (plain Claude), ste-vague, run 2**
- meaning [recorded/voice]: "We came up with a two-stage model that deals with sparse interaction histories" -> "We developed a two-stage model for sparse interaction histories"

**Without (plain Claude), worked-example, run 1**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored"

**Without (plain Claude), worked-example, run 2**
- meaning [minor/qualifier_word]: "Crucially, however, the question of whether the identity of reviewers affects this relationship remains" -> "However, to the best of our knowledge, whether the identity of reviewers affects this relationship remains"

