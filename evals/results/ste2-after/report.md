# Pilot report: ste2-after

- Executor model: `claude-sonnet-5-5` (Claude Code 2.1.301 (Claude Code))
- Blue Pencil version: 3.0.0, repo commit `3a88c84179`
- Cases: exposition-introduction, exposition-methods, exposition-results, worked-example, ste-connectors, ste-procedure, ste-vague; 3 runs per condition per case
- Rubric: `evals/rubric.md` v0.3. Revision stage: first draft.
- Resumed 2026-10-16T21:11:42 at repo commit `7d066635fb`
- **Caveat:** with-skill sessions also listed 21 other skills, built into Claude Code or installed for the user (artifact-capabilities, artifact-diagramming, batch, claude-api, code-review, dataviz, debug, deep-research, design, design-sync, doctor, fewer-permission-prompts, loop, plugin-authoring, run, run-skill-generator, simplify, slides, update-config, verify, workflow-authoring); the baseline, run without slash commands, listed none. No counted trial called one.

## 1. Preservation (all cases)

| Condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| With Blue Pencil | 21 | 19/21 (90%) | 15 / 6 / 0 | 13/21 (61%) | 0.43 | 0.43 |
| Without (plain Claude) | 21 | 15/21 (71%) | 9 / 12 / 0 | 9/21 (42%) | 1.9 | 0.1 |

## 2. Preservation by case

| Case / condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| exposition-introduction / With Blue Pencil | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 1.67 | 0.33 |
| exposition-introduction / Without (plain Claude) | 3 | 2/3 (66%) | 0 / 3 / 0 | 0/3 (0%) | 3.33 | 0 |
| exposition-methods / With Blue Pencil | 3 | 1/3 (33%) | 3 / 0 / 0 | 1/3 (33%) | 0 | 0 |
| exposition-methods / Without (plain Claude) | 3 | 1/3 (33%) | 0 / 3 / 0 | 0/3 (0%) | 4 | 0 |
| exposition-results / With Blue Pencil | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| exposition-results / Without (plain Claude) | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 4.67 | 0 |
| ste-connectors / With Blue Pencil | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| ste-connectors / Without (plain Claude) | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| ste-procedure / With Blue Pencil | 3 | 3/3 (100%) | 2 / 1 / 0 | 2/3 (66%) | 0.33 | 0 |
| ste-procedure / Without (plain Claude) | 3 | 0/3 (0%) | 0 / 3 / 0 | 0/3 (0%) | 1.33 | 0 |
| ste-vague / With Blue Pencil | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| ste-vague / Without (plain Claude) | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| worked-example / With Blue Pencil | 3 | 3/3 (100%) | 1 / 2 / 0 | 1/3 (33%) | 1 | 2.67 |
| worked-example / Without (plain Claude) | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0.67 |

Major problems per run:

- exposition-introduction / With Blue Pencil: 2, 1, 2
- exposition-introduction / Without (plain Claude): 4, 4, 2
- exposition-methods / With Blue Pencil: 0, 0, 0
- exposition-methods / Without (plain Claude): 4, 5, 3
- exposition-results / With Blue Pencil: 0, 0, 0
- exposition-results / Without (plain Claude): 4, 5, 5
- ste-connectors / With Blue Pencil: 0, 0, 0
- ste-connectors / Without (plain Claude): 0, 0, 0
- ste-procedure / With Blue Pencil: 0, 0, 1
- ste-procedure / Without (plain Claude): 1, 2, 1
- ste-vague / With Blue Pencil: 0, 0, 0
- ste-vague / Without (plain Claude): 0, 0, 0
- worked-example / With Blue Pencil: 0, 1, 2
- worked-example / Without (plain Claude): 0, 0, 0

## 3. Cost and speed

| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |
|---|---|---|---|
| With Blue Pencil | 260230.857 | 107.629 | 0.43 |
| Without (plain Claude) | 4217.143 | 10.824 | 0.016 |

Blue Pencil was loaded in 21/21 with-skill runs (checked from each transcript's tool calls).

## 4. Quality (blinded, both orders)

| Pairs | Blue Pencil wins | Plain Claude wins | Ties or order-dependent |
|---|---|---|---|
| All (21) | 13 | 5 | 3 |
| Both passed preservation (7) | 5 | 1 | 1 |

## 5. Clean improvements (passes preservation and wins quality)

| Condition | Clean improvements |
|---|---|
| With Blue Pencil | 8/21 (38%) |
| Without (plain Claude) | 1/21 (4%) |

| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Clean improvement? |
|---|---|---|---|---|---|
| exposition-introduction | 1 | tie | False | False | no |
| exposition-introduction | 2 | with_skill | False | False | no |
| exposition-introduction | 3 | with_skill | False | False | no |
| exposition-methods | 1 | tie | False | False | no |
| exposition-methods | 2 | with_skill | True | False | yes |
| exposition-methods | 3 | with_skill | False | False | no |
| exposition-results | 1 | with_skill | True | False | yes |
| exposition-results | 2 | with_skill | True | False | yes |
| exposition-results | 3 | without_skill | True | False | no |
| ste-connectors | 1 | with_skill | True | True | yes |
| ste-connectors | 2 | with_skill | True | True | yes |
| ste-connectors | 3 | with_skill | True | True | yes |
| ste-procedure | 1 | without_skill | True | False | no |
| ste-procedure | 2 | without_skill | True | False | no |
| ste-procedure | 3 | without_skill | False | False | no |
| ste-vague | 1 | tie | True | True | no |
| ste-vague | 2 | without_skill | True | True | yes |
| ste-vague | 3 | with_skill | True | True | yes |
| worked-example | 1 | with_skill | True | True | yes |
| worked-example | 2 | with_skill | False | True | no |
| worked-example | 3 | with_skill | False | True | no |

## 6. What the graders flagged

**With Blue Pencil, exposition-introduction, run 1**
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "Identifying the effect of review valence on sales faces a well-known obstacle in this literature"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find that effect to be positive and significant"

**With Blue Pencil, exposition-introduction, run 2**
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and statistically significant"

**With Blue Pencil, exposition-introduction, run 3**
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature" -> "which obstructs identification of its effect on sales"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and statistically significant"
- meaning [minor/qualifier_word]: "is a well-known obstacle to identification" -> "which obstructs identification"

**With Blue Pencil, exposition-methods, run 1**
- code [numberwords]: removed [], added ['two']

**With Blue Pencil, exposition-methods, run 3**
- code [numberwords]: removed [], added ['two']

**With Blue Pencil, ste-procedure, run 3**
- meaning [major/claim_strength]: "Raking weights would have been expected to have been applied to the merged file before estimation" -> "Raking weights were expected to have been applied to the merged file before estimation"

**With Blue Pencil, ste-vague, run 2**
- meaning [recorded/voice]: "We came up with a two-stage model that deals with sparse interaction histories" -> "We developed a two-stage model for the cold-start problem in recommender systems, where interaction histories are sparse"

**With Blue Pencil, ste-vague, run 3**
- meaning [recorded/voice]: "We came up with a two-stage model that deals with sparse interaction histories, and the results point out that" -> "Our two-stage model targets the cold-start problem in recommender systems, where new users have sparse interaction histories."

**With Blue Pencil, worked-example, run 1**
- meaning [minor/qualifier_word]: "has
fundamentally transformed the way in which consumers make purchasing
decisions" -> "has transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising
of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "this finding has
important implications for platform design" -> "This finding has implications for platform design"

**With Blue Pencil, worked-example, run 2**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored"
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "has transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design" -> "This finding has implications for platform design"

**With Blue Pencil, worked-example, run 3**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored"
- meaning [major/new_content]: "reviewer identity has a significant effect" -> "Reviewer identity has a significant effect on this relationship."
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "has transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"

**Without (plain Claude), exposition-introduction, run 1**
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature" -> "is a well-known obstacle to identifying the causal effect of valence on sales: the same quality that makes reviews favorable also makes a product sell"
- meaning [major/new_content]: "which generates quasi-random assignment conditional on observed covariates." -> "Because this unequal moderation is unrelated to product quality, it lets us isolate the effect of valence on sales."
- meaning [major/caveat_or_scope]: "quasi-random assignment conditional on observed covariates" -> "this unequal moderation is unrelated to product quality"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate this effect and find it to be positive and significant"

**Without (plain Claude), exposition-introduction, run 2**
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"
- meaning [major/new_content]: "a well-known obstacle to identification in this literature" -> "a well-known obstacle to identification in the literature on how online reviews affect sales"
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality" -> "Reviews that are more favorable tend to accompany products that are better, which makes it hard to tell whether a review's valence (how positive or negative it is) causes sales or merely reflects unobserved product quality."
- meaning [major/new_content]: "as a source of exogenous variation" -> "as a source of exogenous variation, that is, variation in which reviews are seen that is unrelated to product quality"

**Without (plain Claude), exposition-introduction, run 3**
- code [numberwords]: removed [], added ['two']
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "Do more positive reviews cause higher sales? ... a high-quality product tends to receive better reviews and to sell more, so a simple correlation between the two does not reveal the effect of the reviews themselves."

**Without (plain Claude), exposition-methods, run 1**
- code [numberwords]: removed [], added ['two']
- meaning [major/new_content]: "the interaction between the post-rollout indicator and the treatment indicator" -> "the post-rollout indicator (whether a given week falls after the program launched) and the treatment indicator (whether a store ever received the program)"
- meaning [major/new_content]: "we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing" -> "Because treatment timing varies, a two-way fixed effects estimate alone can be difficult to interpret."
- meaning [major/new_content]: "we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate" -> "This estimator compares each group of stores that launched on the same date with its control stores"
- meaning [major/new_content]: "we use the never-treated and not-yet-treated stores as controls" -> "never-treated stores, which do not receive the program during the sample, and not-yet-treated stores, which have not yet received it at the time of comparison"
- meaning [recorded/voice]: "We estimate a two-way fixed effects model with store and week fixed effects" -> "a two-way fixed effects model, which includes a separate intercept for each store and each week"

**Without (plain Claude), exposition-methods, run 2**
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which captures the change in repeat purchase at a store after the loyalty program arrives there, relative to stores without it"
- meaning [major/new_content]: "Because the loyalty program was rolled out to stores on different dates, we use the never-treated and not-yet-treated stores as controls" -> "a simple comparison of treated and untreated stores is not sufficient: a store treated early could otherwise serve as a comparison for a store treated later"
- meaning [major/new_content]: "to address heterogeneity in treatment timing." -> "that is, the possibility that the program's effect differs depending on when a store was treated."
- meaning [major/new_content]: "We estimate a two-way fixed effects model with store and week fixed effects" -> "The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks that affect all stores in the same week."
- meaning [major/new_content]: "we use the never-treated and not-yet-treated stores as controls" -> "meaning stores that have not received the program by the period being compared"

**Without (plain Claude), exposition-methods, run 3**
- code [numberwords]: removed [], added ['two-way']
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which captures the change in repeat purchase after a store receives the loyalty program, relative to stores that have not received it"
- meaning [major/new_content]: "Because the loyalty program was rolled out to stores on different dates, we use the never-treated and not-yet-treated stores as controls" -> "a simple two-way fixed effects comparison can be misleading: stores treated earlier can end up serving as controls for stores treated later, and this can distort the estimate when the effect varies across stores or over time"
- meaning [major/new_content]: "we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing" -> "which addresses heterogeneity in treatment timing by estimating the effect separately for each group of stores treated at the same time and then averaging across groups"

**Without (plain Claude), exposition-results, run 1**
- meaning [major/new_content]: "Table 3 reports the estimates. The coefficient on the identity-disclosed indicator" -> "Identity disclosure carries weight beyond the rating itself:"
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09
(SE = 0.03) in column 4." -> "The effect also grows with reviewer tenure, with an interaction coefficient of 0.09 (SE = 0.03) in column 4."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across
all specifications." -> "Star rating remains a strong predictor throughout, with a coefficient of 0.42 (SE = 0.02) across all specifications, so identity matters alongside the rating, not in place of it."
- meaning [major/claim_strength]: "In column 3, after adding product fixed effects,
the coefficient is 0.15 (SE = 0.05)." -> "and it persists at 0.15 (SE = 0.05) in column 3 after adding product fixed effects."
- meaning [recorded/voice]: "The coefficient on the identity-disclosed indicator
is 0.18 (SE = 0.04) in column 2." -> "Identity disclosure carries weight beyond the rating itself: the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2"

**Without (plain Claude), exposition-results, run 2**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and they point to a clear role for reviewer identity."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "Adding product fixed effects in column 3 leaves the effect largely intact, at 0.15 (SE = 0.05)."
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Identity also conditions the weight a review carries: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating remains a strong predictor, with a coefficient of 0.42 (SE = 0.02) across all specifications"
- meaning [major/reassigned]: "R-squared rises from 0.31 to 0.47 across the columns." -> "yet identity adds explanatory power beyond it, as R-squared rises from 0.31 to 0.47 across the columns."

**Without (plain Claude), exposition-results, run 3**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and the pattern is clear: who writes a review matters, not just what it says."
- meaning [major/claim_strength]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "It remains substantial in column 3 after we add product fixed effects, at 0.15 (SE = 0.05)."
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "The effect also grows with experience: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4."
- meaning [major/claim_strength]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating, as expected, carries a strong effect of its own, with a coefficient of 0.42 (SE = 0.02) across all specifications."
- meaning [major/new_content]: "R-squared rises from 0.31 to 0.47 across the columns." -> "Model fit improves accordingly, as R-squared rises from 0.31 to 0.47 across the columns."
- meaning [recorded/voice]: "Table 3 reports the estimates. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2." -> "Table 3 reports the estimates, and the pattern is clear: who writes a review matters, not just what it says."

**Without (plain Claude), ste-procedure, run 1**
- code [numberwords]: removed [], added ['four']
- meaning [major/claim_strength]: "Raking weights would have been expected to have been applied to the merged file before estimation" -> "Fourth, before estimation, we applied raking weights to the merged file"

**Without (plain Claude), ste-procedure, run 2**
- code [numberwords]: removed [], added ['four']
- meaning [major/lost_content]: "Responses were screened and recoded after the field period closed" -> "First, responses were screened, and respondents were excluded"
- meaning [major/claim_strength]: "Raking weights would have been expected to have been applied to the merged file before estimation" -> "Fourth, raking weights were expected to be applied to the merged file before estimation"

**Without (plain Claude), ste-procedure, run 3**
- code [numberwords]: removed [], added ['four']
- meaning [major/lost_content]: "Responses were screened and recoded after the field period closed" -> "First, we screened responses and excluded respondents"
- meaning [recorded/voice]: "Raking weights would have been expected to have been applied to the merged file before estimation" -> "raking weights were to be applied to the merged file before estimation"

**Without (plain Claude), ste-vague, run 2**
- meaning [recorded/voice]: "We came up with a two-stage model that deals with sparse interaction histories, and the results point out that" -> "Our two-stage model addresses the cold-start problem by handling sparse interaction histories. It improves"

**Without (plain Claude), worked-example, run 1**
- meaning [minor/qualifier_word]: "Crucially, however, the question of whether the identity of reviewers affects this relationship remains" -> "However, to the best of our knowledge, whether reviewer identity affects this relationship remains"

**Without (plain Claude), worked-example, run 3**
- meaning [minor/qualifier_word]: "Crucially, however, the question of whether the identity of reviewers affects this relationship remains" -> "However, whether the identity of reviewers affects this relationship remains"

