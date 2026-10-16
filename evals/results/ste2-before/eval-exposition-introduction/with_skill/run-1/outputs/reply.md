## Diagnosis

**Your question: is it clear enough, or does it assume too much?** The vocabulary is fine for empirical economists and IS researchers, and mostly fine for a general Management Science reader. The problem is the logic, not the terms. The passage assumes five things the reader hasn't been given:

- what the outcome is,
- what moderation does to a review,
- what a "cohort" is,
- why unequal moderation is unrelated to unobserved quality,
- why the earlier instruments are questionable.

A trained reader can follow each sentence but can't see why the identification works. Prose edits can't fix that, because the missing material isn't on the page. I made the safe edits and routed the rest to the questions below.

Specific issues:
1. **The identifying assumption is asserted, not shown.** The passage says unequal moderation "generates quasi-random assignment" but never says why moderation differences would be independent of unobserved quality. That is your core thesis and the reader's first question.
2. **"The effect" has no stated outcome.** The passage gives no magnitude either.
3. **Terminology and claim strength drift.**
   - "Platform-level heterogeneity" means variation across platforms, but "across review cohorts" may mean variation within platforms. "Cohorts" is never defined.
   - "Exogenous" in sentence 2 is a stronger claim than "quasi-random … conditional on observed covariates" in sentence 3.
   - I left both unchanged and flagged them.
4. **The central idea is only half-surfaced.** Your thesis is "unequal moderation," but the passage names it only through "heterogeneity" and "differentially apply."
5. **The contrast with prior work came too early.** It followed the result, before the reader knew the strategy it refers to. Your wording is untouched. The "questionable validity" claim has no reason or citation on the page.
6. **Sentence-level fixes.** "The endogeneity of … with respect to" was a nominalization. "Specifically, we leverage the fact that" was filler, and "which generates" had an unclear antecedent.

## Revised text

```
Review valence is endogenous to unobserved product quality, a well-known obstacle to identification in this literature. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms differentially apply moderation policies across review cohorts, and this differential application generates quasi-random assignment conditional on observed covariates. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate the effect of review valence. We find it positive and significant.
```

## Change rationale

Word count fell from about 90 to about 80 (-11%). The reviser loaded all twelve applicable reference passes and skipped none. The two whole-paper passes (cold-read and consistency-checks) don't apply to a single section.

- **Sentence 1:** the nominalization became a predicate, "Review valence is endogenous to…".
- **Sentence 3:** "Specifically, we leverage the fact that" was cut, and "which generates" became "this differential application generates" to fix the antecedent.
- **Prior-work sentence:** moved up to follow the mechanism sentence. The wording is unchanged.
- **Final sentences:** "we estimate the effect and find it to be positive and significant" became two sentences, with "of review valence" added. "Of review valence" is inferred from sentence 1.
- **Kept verbatim:** all numbers, scope qualifiers, terms of art and claims. There are no citations in the passage, and none were added or reordered. No content was deleted.

## Author questions

- What outcome is the effect measured on? Your paper context says sales. Should the last sentences read "the effect of review valence on sales"?
- What does moderation do to a review (removal, suppression, ranking)? A one-line example would help.
- What is a "review cohort" (time window, category, reviewer group)? Is the variation across platforms, or across cohorts within a platform?
- Why would moderation be unrelated to unobserved product quality? Which covariates are conditioned on, and where does the paper argue this?
- Should "exogenous variation" in sentence 2 be softened to match the conditional claim in sentence 3?
- Which prior instruments are you contrasting with, and why is their validity questionable? Should "well-known" and "prior approaches" carry citations?
- Is "unequal moderation" the phrase you want readers to take away? If so, should the introduction use it explicitly?
- What are the magnitude and unit of the effect, and what does "significant" refer to?
- Which platforms and time period does the 3.4 million reviews dataset cover?