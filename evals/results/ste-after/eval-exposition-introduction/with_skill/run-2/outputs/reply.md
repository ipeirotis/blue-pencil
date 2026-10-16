## Diagnosis

**Is it clear enough for a general Management Science reader? It assumes too much.** Empirical economists and IS researchers would follow the endogeneity framing and the terms "exogenous variation" and "quasi-random conditional on covariates". A general reader would stall in four places, and jargon density isn't the cause:

- **The outcome is never named.** "The effect" has no referent, because the passage never says what valence affects.
- **"Content moderation" and "review cohorts" are undefined.**
- **The step from unequal moderation to quasi-random assignment is asserted, not explained.**
- **The prior instrumental-variable approaches are unnamed.**

The reviser fixed what the page supports. The rest needs your input (see the questions below).

Other findings:
- **Terminology drift.** Sentence 2 describes variation across platforms. Sentence 3 describes variation across review cohorts. The text also calls the variation "exogenous" in one place and "quasi-random conditional on covariates" in another. These may be two sources and two claims, so I preserved them as written.
- **Unsupported superiority claim.** "Improves upon prior approaches" has no named approach and no citation.
- **No handle.** Your thesis phrase "unequal moderation" doesn't appear in the passage.
- **Hedges.** There are none to cut. "Conditional on observed covariates" is a scope limit, so it stays.

## Revised text

```
Review valence is endogenous with respect to unobserved product quality, a well-known obstacle to identification in the literature on the effect of review valence on sales. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply moderation policies differentially across review cohorts, and this variation generates quasi-random assignment conditional on observed covariates. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate the effect and find it to be positive and significant.
```

## Change rationale

The word count is essentially flat (about 90 words before and after). No number, statistic, or citation was touched.

- **Sentence 1.** The subject is now "review valence" instead of a nominalization. "This literature" had nothing before it to refer to, so it now names the literature. That also gives "the effect" in the last sentence a referent. I took "sales" from your `core_thesis`, so please confirm it.
- **Sentence 3.** The ambiguous "which" now has an antecedent ("this variation"). I cut "leverage" and the throat-clearing "Specifically, … the fact that".
- **Order.** I swapped the last two sentences, both verbatim. The strategy comparison now follows the description of the strategy, and the result closes the paragraph. This changes your closing emphasis, so it is the edit most worth checking.
- **Kept deliberately.** "Conditional on observed covariates", "differentially", "3.4 million", and "positive and significant".

## Author questions

1. Is the outcome sales and the treatment review valence, as in your thesis? Is valence a rating, a sentiment score, or something else?
2. What does moderation do to a review (removal, delay, down-ranking, flagging)? What is a "review cohort" (by time, rating, product, or something else)? One sentence each would help a non-specialist.
3. Which units are quasi-randomly assigned to what? Why is unequal moderation unrelated to unobserved quality, given that endogeneity with respect to quality is the stated obstacle? Should the intro give a one-sentence reason?
4. Is the variation across platforms, across cohorts within platforms, or both? Are "exogenous variation" and "quasi-random assignment conditional on covariates" the same claim?
5. Which prior IV approaches do you mean, and why is their validity questionable? Should the claim be argued or cited here? The reviser could not add or alter citations.
6. Is the sentence swap acceptable, or do you prefer your original closing?
7. Does "significant" mean statistically significant? Can the intro give the direction plus a magnitude from your results?
8. Is "unequal moderation" the phrase you want readers to carry away? If so, should it be used consistently in the intro?
9. Do the body sections fully support the "exogenous", "quasi-random", and superiority claims? I haven't seen those sections.
10. Would a concrete example fit, such as one moderated and one unmoderated review of comparable products?