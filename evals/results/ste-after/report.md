# Pilot report: ste-after

- Executor model: `claude-sonnet-5-5` (Claude Code 2.1.301 (Claude Code))
- Blue Pencil version: 3.0.0, repo commit `2409c2f822`
- Cases: exposition-introduction, exposition-methods, exposition-results, worked-example; 3 runs per condition per case
- Rubric: `evals/rubric.md` v0.3. Revision stage: first draft.
- Resumed 2026-10-16T19:52:16 at repo commit `7a8512e7c7`
- **Caveat:** with-skill sessions also listed 21 other skills, built into Claude Code or installed for the user (artifact-capabilities, artifact-diagramming, batch, claude-api, code-review, dataviz, debug, deep-research, design, design-sync, doctor, fewer-permission-prompts, loop, plugin-authoring, run, run-skill-generator, simplify, slides, update-config, verify, workflow-authoring); the baseline, run without slash commands, listed none. No counted trial called one.

## 1. Preservation (all cases)

| Condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| With Blue Pencil | 12 | 11/12 (91%) | 7 / 5 / 0 | 6/12 (50%) | 0.67 | 0.75 |
| Without (plain Claude) | 12 | 9/12 (75%) | 4 / 8 / 0 | 3/12 (25%) | 2.25 | 0 |

## 2. Preservation by case

| Case / condition | Runs | Code check passes | Meaning: preserved / changed / unsure | Both pass | Avg major problems | Avg minor problems |
|---|---|---|---|---|---|---|
| exposition-introduction / With Blue Pencil | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 1.67 | 0 |
| exposition-introduction / Without (plain Claude) | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 3 | 0 |
| exposition-methods / With Blue Pencil | 3 | 2/3 (66%) | 3 / 0 / 0 | 2/3 (66%) | 0 | 0 |
| exposition-methods / Without (plain Claude) | 3 | 0/3 (0%) | 1 / 2 / 0 | 0/3 (0%) | 1.67 | 0 |
| exposition-results / With Blue Pencil | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |
| exposition-results / Without (plain Claude) | 3 | 3/3 (100%) | 0 / 3 / 0 | 0/3 (0%) | 4.33 | 0 |
| worked-example / With Blue Pencil | 3 | 3/3 (100%) | 1 / 2 / 0 | 1/3 (33%) | 1 | 3 |
| worked-example / Without (plain Claude) | 3 | 3/3 (100%) | 3 / 0 / 0 | 3/3 (100%) | 0 | 0 |

Major problems per run:

- exposition-introduction / With Blue Pencil: 2, 1, 2
- exposition-introduction / Without (plain Claude): 4, 2, 3
- exposition-methods / With Blue Pencil: 0, 0, 0
- exposition-methods / Without (plain Claude): 0, 2, 3
- exposition-results / With Blue Pencil: 0, 0, 0
- exposition-results / Without (plain Claude): 5, 4, 4
- worked-example / With Blue Pencil: 2, 1, 0
- worked-example / Without (plain Claude): 0, 0, 0

## 3. Cost and speed

| Condition | Mean tokens | Mean seconds | Mean cost (USD, list price) |
|---|---|---|---|
| With Blue Pencil | 261004.667 | 109.267 | 0.433 |
| Without (plain Claude) | 4403.833 | 11.5 | 0.018 |

Blue Pencil was loaded in 12/12 with-skill runs (checked from each transcript's tool calls).

## 4. Quality (blinded, both orders)

| Pairs | Blue Pencil wins | Plain Claude wins | Ties or order-dependent |
|---|---|---|---|
| All (12) | 4 | 6 | 2 |
| Both passed preservation (1) | 1 | 0 | 0 |

## 5. Clean improvements (passes preservation and wins quality)

| Condition | Clean improvements |
|---|---|
| With Blue Pencil | 1/12 (8%) |
| Without (plain Claude) | 0/12 (0%) |

| Case | Run | Quality winner | Blue Pencil preserved? | Plain Claude preserved? | Clean improvement? |
|---|---|---|---|---|---|
| exposition-introduction | 1 | without_skill | False | False | no |
| exposition-introduction | 2 | without_skill | False | False | no |
| exposition-introduction | 3 | with_skill | False | False | no |
| exposition-methods | 1 | tie | False | False | no |
| exposition-methods | 2 | without_skill | True | False | no |
| exposition-methods | 3 | tie | True | False | no |
| exposition-results | 1 | without_skill | True | False | no |
| exposition-results | 2 | without_skill | True | False | no |
| exposition-results | 3 | without_skill | True | False | no |
| worked-example | 1 | with_skill | False | True | no |
| worked-example | 2 | with_skill | False | True | no |
| worked-example | 3 | with_skill | True | True | yes |

## 6. What the graders flagged

**With Blue Pencil, exposition-introduction, run 1**
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "Estimating the effect of review valence on sales faces a well-known obstacle to identification in this literature"
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality" -> "How positive or negative a product's reviews are reflects that quality, which also shapes sales."

**With Blue Pencil, exposition-introduction, run 2**
- meaning [major/new_content]: "a well-known obstacle to identification in this literature" -> "a well-known obstacle to identification in the literature on the effect of review valence on sales"

**With Blue Pencil, exposition-introduction, run 3**
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature" -> "Identifying the causal effect of review valence on sales is difficult"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate a positive and significant effect of review valence on sales"

**With Blue Pencil, exposition-methods, run 1**
- code [numberwords]: removed [], added ['two']

**With Blue Pencil, worked-example, run 1**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored"
- meaning [major/new_content]: "The results of our analysis demonstrate that reviewer identity has a significant effect." -> "Reviewer identity has a significant effect on the relationship between reviews and sales."
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "has transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design" -> "This finding has implications for platform design"

**With Blue Pencil, worked-example, run 2**
- meaning [major/claim_strength]: "remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "remains underexplored in the literature, to the best of our knowledge"
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "has transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design" -> "For platform design, this finding implies that"

**With Blue Pencil, worked-example, run 3**
- meaning [minor/qualifier_word]: "has fundamentally transformed the way in which consumers make purchasing decisions" -> "has transformed how consumers make purchasing decisions"
- meaning [minor/qualifier_word]: "we leverage a novel dataset comprising of 1.2 million reviews" -> "we use a dataset of 1.2 million reviews"
- meaning [minor/qualifier_word]: "this finding has important implications for platform design: managers should consider highlighting reviewer credentials" -> "Platform managers should therefore consider highlighting reviewer credentials"

**Without (plain Claude), exposition-introduction, run 1**
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature" -> "A well-known obstacle to identifying the effect of a review's valence on sales"
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality" -> "valence is correlated with unobserved product quality, which itself drives sales"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of valence on sales and find it to be positive and significant"
- meaning [major/caveat_or_scope]: "a well-known obstacle to identification in this literature" -> "A well-known obstacle to identifying the effect of a review's valence on sales"
- meaning [recorded/voice]: "We exploit platform-level heterogeneity in content moderation" -> "We exploit differences across platforms in how reviews are moderated"

**Without (plain Claude), exposition-introduction, run 2**
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of valence on sales and find it to be positive and significant"
- meaning [major/new_content]: "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature." -> "Estimating the effect of a review's valence (how positive or negative it is) on sales is difficult because valence is endogenous: unobserved product quality shapes both the reviews a product receives and how well it sells."

**Without (plain Claude), exposition-introduction, run 3**
- meaning [major/new_content]: "is a well-known obstacle to identification in this literature." -> "because quality affects both the reviews a product receives and its sales, a raw correlation between valence and sales cannot be read as the causal effect of valence"
- meaning [major/new_content]: "we estimate the effect and find it to be positive and significant" -> "we estimate the effect of review valence on sales and find it to be positive and significant"
- meaning [major/new_content]: "platforms differentially apply moderation policies across review cohorts, which generates quasi-random assignment conditional on observed covariates" -> "so that the valence consumers encounter varies with platform moderation rather than with product quality"

**Without (plain Claude), exposition-methods, run 1**
- code [numberwords]: removed [], added ['two']

**Without (plain Claude), exposition-methods, run 2**
- code [numberwords]: removed [], added ['two']
- meaning [major/new_content]: "to address heterogeneity in treatment timing" -> "To address heterogeneity in treatment timing, that is, the possibility that the program's effect differs across stores that adopted it on different dates"
- meaning [major/new_content]: "we use the never-treated and not-yet-treated stores as controls" -> "never-treated stores, which do not receive the program during our data window, and not-yet-treated stores, which have not yet received it at a given point in time"
- meaning [recorded/voice]: "Because the loyalty program was rolled out to stores on different dates, we use the never-treated and not-yet-treated stores as controls" -> "The loyalty program was rolled out to stores on different dates (a staggered rollout), so stores move from untreated to treated at different times. Because of this, we use two groups of stores as controls:"

**Without (plain Claude), exposition-methods, run 3**
- code [numberwords]: removed [], added ['two', 'two-way']
- meaning [major/new_content]: "We estimate a two-way fixed effects model with store and week fixed effects," -> "which absorb stable differences across stores and shocks that affect all stores in a given week"
- meaning [major/new_content]: "The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator." -> "which captures the change in outcomes after the program arrives in a treated store, relative to stores that did not receive it at that time"
- meaning [major/new_content]: "to address heterogeneity in treatment timing" -> "Differences in treatment timing can distort two-way fixed effects estimates when the program's effect varies across stores or over time."

**Without (plain Claude), exposition-results, run 1**
- meaning [major/new_content]: "The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2." -> "Identity disclosure carries its own weight: the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2"
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Disclosure also matters more for some reviewers than others."
- meaning [major/claim_strength]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "so the effect of disclosure grows with tenure"
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "star rating stays a strong predictor"
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "so identity effects appear alongside the rating effect rather than in place of it"
- meaning [recorded/voice]: "Table 3 reports the estimates. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2." -> "Identity disclosure carries its own weight:"

**Without (plain Claude), exposition-results, run 2**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and they point to a clear role for reviewer identity."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "Adding product fixed effects in column 3 leaves the effect largely intact, at 0.15 (SE = 0.05)."
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "The identity effect also grows with reviewer credibility: the interaction with reviewer tenure in column 4 is 0.09 (SE = 0.03)."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating remains a strong predictor, with a coefficient of 0.42 (SE = 0.02) across all specifications, yet it does not displace identity."

**Without (plain Claude), exposition-results, run 3**
- meaning [major/new_content]: "Table 3 reports the estimates." -> "Table 3 reports the estimates, and they point to a consistent role for reviewer identity."
- meaning [major/new_content]: "In column 3, after adding product fixed effects, the coefficient is 0.15 (SE = 0.05)." -> "It remains sizable after we add product fixed effects in column 3, at 0.15 (SE = 0.05)."
- meaning [major/new_content]: "The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "Identity also conditions on who is speaking: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4."
- meaning [major/new_content]: "The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." -> "Star rating matters throughout, with a coefficient of 0.42 (SE = 0.02) across all specifications, yet identity adds to it rather than merely echoing it."

