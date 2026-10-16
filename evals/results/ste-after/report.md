# Pilot report: ste-after

- Executor model: `claude-sonnet-5-5` (Claude Code 2.1.301 (Claude Code))
- Blue Pencil version: 3.0.0, repo commit `c3980c71db`
- Cases: exposition-introduction, exposition-methods, exposition-results, worked-example; 3 runs per condition per case
- Rubric: `evals/rubric.md` v0.3. Revision stage: first draft.
- Resumed 2026-10-16T19:33:00 at repo commit `c3980c71db`
- **Caveat:** with-skill sessions also listed 21 other skills, built into Claude Code or installed for the user (artifact-capabilities, artifact-diagramming, batch, claude-api, code-review, dataviz, debug, deep-research, design, design-sync, doctor, fewer-permission-prompts, loop, plugin-authoring, run, run-skill-generator, simplify, slides, update-config, verify, workflow-authoring); the baseline, run without slash commands, listed none. No counted trial called one.

## 1. Preservation (all cases)

| Condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| With Blue Pencil | 12 | 10/12 (83%) | 8 / 4 / 0 | 6/12 (50%) | 0.67 | 0.75 |
| Without (plain Claude) | 12 | 8/12 (66%) | 3 / 9 / 0 | 2/12 (16%) | 2.67 | 0.08 |

## 2. Preservation by case

| Case / condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| exposition-introduction / With Blue Pencil | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 2 | 0 |
| exposition-introduction / Without (plain Claude) | 3 | 2/3 (66%) | 0 / 3 / 0 | 0/3 (0%) | 3.33 | 0 |
| exposition-methods / With Blue Pencil | 3 | 1/3 (33%) | 3 / 0 / 0 | 1/3 (33%) | 0 | 0 |
| exposition-methods / Without (plain Claude) | 3 | 0/3 (0%) | 1 / 2 / 0 | 0/3 (0%) | 1.67 | 0 |
| exposition-results / With Blue Pencil | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| exposition-results / Without (plain Claude) | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 5.33 | 0 |
| worked-example / With Blue Pencil | 3 | 3/3 (100%) | 2 / 1 / 0 | 2/3 (66%) | 0.67 | 3 |
| worked-example / Without (plain Claude) | 3 | 3/3 (100%) | 2 / 1 / 0 | 2/3 (66%) | 0.33 | 0.33 |

Major problems per run:

- exposition-introduction / With Blue Pencil: 2, 2, 2
- exposition-introduction / Without (plain Claude): 4, 3, 3
- exposition-methods / With Blue Pencil: 0, 0, 0
- exposition-methods / Without (plain Claude): 4, 0, 1
- exposition-results / With Blue Pencil: 0, 0, 0
- exposition-results / Without (plain Claude): 5, 5, 6
- worked-example / With Blue Pencil: 2, 0, 0
- worked-example / Without (plain Claude): 0, 0, 1

## 3. Cost and speed

| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |
|---|---|---|---|
| With Blue Pencil | 275623.667 | 107.967 | 0.429 |
| Without (plain Claude) | 4267.25 | 10.692 | 0.016 |

Blue Pencil was loaded in 12/12 with-skill runs (checked from each transcript's tool calls).

## 4. Quality (blinded, both orders)

| Pairs | Blue Pencil wins | Plain Claude wins | Ties or order-dependent |
|---|---|---|---|
| All (12) | 7 | 3 | 2 |
| Both passed preservation (1) | 1 | 0 | 0 |

## 5. Clean improvements (passes preservation and wins quality)

| Condition | Clean improvements |
|---|---|
| With Blue Pencil | 3/12 (25%) |
| Without (plain Claude) | 0/12 (0%) |

| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Clean improvement? |
|---|---|---|---|---|---|
| exposition-introduction | 1 | tie | False | False | no |
| exposition-introduction | 2 | with_skill | False | False | no |
| exposition-introduction | 3 | without_skill | False | False | no |
| exposition-methods | 1 | with_skill | True | False | yes |
| exposition-methods | 2 | with_skill | False | False | no |
| exposition-methods | 3 | with_skill | False | False | no |
| exposition-results | 1 | tie | True | False | no |
| exposition-results | 2 | without_skill | True | False | no |
| exposition-results | 3 | without_skill | True | False | no |
| worked-example | 1 | with_skill | False | True | no |
| worked-example | 2 | with_skill | True | True | yes |
| worked-example | 3 | with_skill | True | False | yes |

## 6. What the graders flagged

**With Blue Pencil, exposition-introduction, run 1**
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature" -> "In research on the effect of review valence on sales, the endogeneity of valence with respect to unobserved product quality is a well-known obstacle to identification"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"

**With Blue Pencil, exposition-introduction, run 2**
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "Estimating the causal effect of a review's valence on sales is difficult"
- meaning [major/caveat_or_scope]: "Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity." -> "Prior approaches rely on instrumental variables of questionable validity. Our identification strategy improves upon these approaches"

**With Blue Pencil, exposition-introduction, run 3**
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "The effect of review valence on sales is hard to identify because valence is endogenous to unobserved product quality"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"

**With Blue Pencil, exposition-methods, run 2**
- code [numberwords]: removed [], added ['two']

**With Blue Pencil, exposition-methods, run 3**
- code [numberwords]: removed [], added ['two']

**With Blue Pencil, worked-example, run 1**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "remains underexplored"
- meaning [major/new_content]: "reviewer identity has a significant effect" -> "Reviewer identity has a significant effect on the relationship between reviews and sales"
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers" -> "has transformed how consumers"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design" -> "This finding has implications for platform design"

**With Blue Pencil, worked-example, run 2**
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "have transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset comprising 1.2 million reviews"
- meaning [minor/qualifier_word]: "It should be noted that this finding has important implications for platform design: managers should consider highlighting reviewer credentials." -> "Platform managers should therefore consider highlighting reviewer credentials."

**With Blue Pencil, worked-example, run 3**
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "has transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design" -> "This finding has implications for platform design"

**Without (plain Claude), exposition-introduction, run 1**
- meaning [major/new_content]: "a well-known obstacle to identification in this literature" -> "a well-known obstacle to identifying the causal effect of reviews on sales"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of valence on sales and find it to be positive and significant"
- meaning [major/new_content]: "which generates quasi-random assignment conditional on observed covariates" -> "This generates quasi-random assignment of review valence conditional on observed covariates, so that otherwise comparable products are exposed to different sets of reviews for reasons unrelated to their quality."
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature." -> "a product that receives favorable reviews may also simply be a better product."

**Without (plain Claude), exposition-introduction, run 2**
- code [numberwords]: removed [], added ['one', 'two']
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"
- meaning [major/new_content]: "" -> "A central question in this literature is how a review's valence, meaning whether it is positive or negative, affects a product's sales."
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature." -> "is a well-known obstacle to identification: quality shapes both the reviews a product receives and its sales, so the two may be correlated without one causing the other."

**Without (plain Claude), exposition-introduction, run 3**
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "A well-known obstacle to identifying the causal effect of review valence on sales is endogeneity: valence is correlated with unobserved product quality, which itself affects sales."
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of valence on sales and find it to be positive and significant"
- meaning [major/caveat_or_scope]: "a well-known obstacle to identification in this literature" -> "A well-known obstacle to identifying the causal effect of review valence on sales"
- meaning [recorded/voice]: "platform-level heterogeneity in content moderation" -> "differences across platforms in how they moderate content"

**Without (plain Claude), exposition-methods, run 1**
- code [numberwords]: removed [], added ['two-way']
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "it captures the change in repeat purchase at a store after it receives the loyalty program, relative to stores that have not yet received it or never do."
- meaning [major/new_content]: "Because the loyalty program was rolled out to stores on different dates, we use the never-treated and not-yet-treated stores as controls" -> "Because the loyalty program was rolled out to stores on different dates, a single before-and-after comparison is not available."
- meaning [major/new_content]: "to address heterogeneity in treatment timing." -> "A known concern with two-way fixed effects under staggered timing is that effects can differ across stores that are treated at different times, and the pooled estimate may then compare already-treated stores with later-treated ones in ways that distort the result."
- meaning [major/new_content]: "We estimate a two-way fixed effects model with store and week fixed effects" -> "In other words, the model compares each store's outcomes to its own baseline (store fixed effects) and removes shocks common to all stores in a given week (week fixed effects)."

**Without (plain Claude), exposition-methods, run 2**
- code [numberwords]: removed [], added ['two-way']
- meaning [recorded/voice]: "We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level." -> "We estimate a two-way fixed effects model, which includes a separate intercept for each store and each week. The store effects absorb stable differences across stores, and the week effects absorb shocks common to all stores in a given week."
- meaning [recorded/voice]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures how outcomes change at a store once it receives the loyalty program, relative to stores that have not received it."
- meaning [recorded/voice]: "we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing." -> "Because two-way fixed effects estimates can be hard to interpret when treatment timing differs across stores, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing."

**Without (plain Claude), exposition-methods, run 3**
- code [numberwords]: removed [], added ['two-way']
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which captures the change in outcomes for a store after the loyalty program arrives, relative to stores without it"
- meaning [recorded/voice]: "We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level." -> "We estimate a two-way fixed effects model, which includes a separate intercept for each store and each week. The store effects absorb stable differences across stores, and the week effects absorb shocks that affect all stores in a given week."

**Without (plain Claude), exposition-results, run 1**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and identity matters."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "it holds up when product fixed effects are added in column 3, where it is 0.15 (SE = 0.05)"
- meaning [major/claim_strength]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Reviewer tenure strengthens the effect: the interaction in column 4 is 0.09 (SE = 0.03)."
- meaning [major/claim_strength]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating remains a powerful driver throughout, with a coefficient of 0.42 (SE = 0.02) across all specifications."
- meaning [major/new_content]: "R-squared rises from 0.31 to 0.47 across the columns." -> "Explanatory power rises accordingly, as R-squared climbs from 0.31 to 0.47 across the columns."
- meaning [recorded/voice]: "Table 3 reports the estimates. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2." -> "Table 3 reports the estimates, and identity matters."

**Without (plain Claude), exposition-results, run 2**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and they point to a clear role for reviewer identity."
- meaning [major/claim_strength]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "It remains substantial after we add product fixed effects in column 3, where it is 0.15 (SE = 0.05)."
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Identity also conditions the effect of a review: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating matters throughout, with a coefficient of 0.42 (SE = 0.02) across all specifications, yet identity adds to it rather than being absorbed by it."
- meaning [major/new_content]: "R-squared rises from 0.31 to 0.47 across the columns." -> "Model fit improves accordingly, as R-squared rises from 0.31 to 0.47 across the columns."

**Without (plain Claude), exposition-results, run 3**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and they point to a clear role for reviewer identity."
- meaning [major/claim_strength]: "The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2." -> "Disclosing the reviewer's identity raises the outcome by 0.18 (SE = 0.04) in column 2"
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "the effect holds when we add product fixed effects in column 3"
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Identity also conditions the weight a review carries: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating matters as well, with a coefficient of 0.42 (SE = 0.02) across all specifications, but it does not account for the identity effects, which persist alongside it."
- meaning [major/reassigned]: "R-squared rises from 0.31 to 0.47 across the columns." -> "Model fit improves as identity measures enter, with R-squared rising from 0.31 to 0.47 across the columns."
- meaning [recorded/voice]: "Table 3 reports the estimates. The coefficient on the identity-disclosed indicator is 0.18" -> "Disclosing the reviewer's identity raises the outcome by 0.18"

**Without (plain Claude), worked-example, run 2**
- meaning [minor/qualifier_word]: "Crucially, however, the question of whether" -> "However, whether"

**Without (plain Claude), worked-example, run 3**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "remains, to the best of our knowledge, underexplored"

