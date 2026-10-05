## Diagnosis

Assumed context: none. The paper context comes from `AGENTS.md`.

**Your question:** the opening is clear on the econometrics but assumes too much about what the paper studies. Your audience knows "endogeneity" and "instrumental variables", so those need no gloss. The gaps are elsewhere:
- The text never says what "the effect" is an effect on.
- It never says what is quasi-randomly assigned, or what a "review cohort" is.
- It never says why unequal moderation is unrelated to product quality.

A reader from outside your subfield has to guess all three.

**Main problems:**
1. In "we estimate the effect", the effect has no referent. The passage never says valence or sales.
2. The step from "platforms moderate differently" to "exogenous variation in valence" is missing. I can't supply it, so it goes to Author questions.
3. The paragraph runs problem, method, result, comparison. The gap that motivates the paper (questionable IVs) arrives last, after the result.
4. The first sentence puts the abstraction in the subject slot ("The endogeneity of ... is a well-known obstacle"), and "Specifically, we leverage the fact that" is throat-clearing.
5. "Quasi-random" and "conditional on observed covariates" stay. They are the claim's one qualification, and dropping them would overclaim.

## Revised text

```
Review valence is endogenous to unobserved product quality, a well-known obstacle to identification in this literature. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms differentially apply moderation policies across review cohorts, which generates quasi-random assignment conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and significant.
```

## Change rationale

Word count: about 100 to about 90.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md.

- **Sentence 1:** "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle" became "Review valence is endogenous to unobserved product quality, a well-known obstacle". Valence is now the subject. The claim is unchanged.
- **Reordering:** your "improves upon prior approaches" sentence moved from last to second. The gap now comes before your method, and the paragraph ends on the result. Its wording is unchanged.
- **"Specifically, we leverage the fact that platforms differentially apply..." became "Platforms differentially apply...":** this removes the throat-clearing opener and "leverage".
- **"we estimate the effect" became "we estimate the effect of review valence on sales":** this gives the effect a referent. I took valence and sales from your `core_thesis`.
- **Unchanged:** "3.4 million", "positive and significant", "quasi-random" and "conditional on observed covariates". The text contains no citations.

## Author questions

- I added "of review valence on sales". Please confirm this is the effect you estimate, and that "positive" is the sign of valence's effect on sales.
- What exactly is quasi-randomly assigned: the moderation treatment, the visibility of a review, or the valence a consumer sees?
- What is a "review cohort" (a time window, a product category, a platform-period)? Is it the same unit as the "platform-level" variation in the previous sentence?
- Why is differential moderation unrelated to unobserved product quality? This carries your identification claim, and the passage doesn't state it. Can you give it in a sentence or two, or tell me which later section does?
- Do you have a short phrase for the idea, such as how you describe "unequal moderation" to a colleague? I didn't invent one.
- Does the introduction have a stakes sentence (why valence's effect on sales matters, or what a platform would do differently) that could open the paragraph?
- Should the headline include the effect's magnitude? If one exists, one number would complete the finding. It is yours to supply.
- Does the Results section give the full result (magnitude, specification, any fragility)? I couldn't check, because that section isn't in the text you sent.
- Does the body support the quasi-random claim, for example with covariate balance or a falsification test? Neither is visible here, so this is unverified.