## Diagnosis

**Is it clear enough for a general Management Science reader?** The vocabulary suits your stated audience of empirical economists and IS researchers. The problem is missing objects, not hard words. The passage assumes four things the reader doesn't have:

- **The outcome is never named.** Only the paper context says "sales".
- **The effect of moderation is never described.** The reader isn't told what moderation does to a review.
- **"Assignment" has no object.** The text never says what is assigned.
- **"Review cohorts" is undefined.** "Valence" is never glossed either.

A reader who knows instrumental-variable (IV) methods but not your setting can't rebuild why unequal moderation is exogenous. In sentence 4, "the effect" has no referent. Your core idea, that platforms moderate reviews unequally, appears only in abstract form and never in plain words.

Other findings:
- **Order:** the prior-work contrast came after the result, so the paragraph ended on a comparison instead of its finding.
- **Result:** the result has a sign but no magnitude. "Significant" could mean statistical or economic.
- **Prior work:** the contrast with earlier IV approaches is uncited and doesn't say which instruments you mean.
- **Sentence level:** "leverage", "Specifically," and an ambiguous "which" in sentence 3.
- **Hedges:** none to classify. "Conditional on observed covariates" is a scope condition, so it stays.

## Revised text

```
Identifying the causal effect of review valence on sales is difficult because valence is endogenous with respect to unobserved product quality, a well-known obstacle in this literature. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply moderation policies differently across review cohorts, and conditional on observed covariates this generates quasi-random assignment. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate a positive and significant effect of review valence on sales.
```

## Change rationale

The text grows from about 90 to about 95 words (+4%) because the first sentence now names the outcome and the question. References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. All eleven passes applied.

- **Sentence 1:** it now names the question (the causal effect of valence on sales) before the obstacle, which gives "the effect" a referent. "Sales" and "causal" come from your core thesis, so please confirm them. "Well-known" and the claim are unchanged.
- **Sentence 2:** unchanged. These are your terms of art, and the sentence states the strategy plainly.
- **Sentence 3:** "Specifically, we leverage the fact that platforms differentially apply… which generates" became "Platforms apply moderation policies differently across review cohorts, and conditional on observed covariates this generates quasi-random assignment." This drops the filler, removes the ambiguous "which", and keeps every qualifier.
- **Prior-work sentence:** moved ahead of the result so the paragraph ends on its finding. The text is unchanged.
- **Result sentence:** it now names the effect and puts "sales" in the stress position. "Significant" is kept as you wrote it.
- **Untouched:** the 3.4 million figure and the sentence on instrumental variables. No number, statistic or citation was changed, and none was added.

## Author questions

- **Outcome and framing:** is sales the outcome and "causal" the intended framing? I took both from your core thesis.
- **Valence:** how is it measured (star rating, text sentiment, something else)? A few words of gloss at first use would help readers outside the review literature.
- **Moderation and assignment:** what does moderation do to a review (remove, delay, hide, reorder)? What exactly is "assigned" in "quasi-random assignment": moderation, exposure to a review, or valence?
- **Review cohorts:** what is a cohort? Does the exogenous variation come from differences across platforms, from differences across cohorts within a platform, or both?
- **Scope of "exogenous":** is the claim unconditional, or only conditional on observed covariates as sentence 3 says? If the latter, should sentence 2 be softened to match?
- **Identification logic:** why does unequal moderation yield quasi-random assignment? One sentence drawn from your Methods section would let a non-specialist follow. The Methods section was out of scope, so I couldn't check it against the introduction's claims.
- **Result:** can you add a magnitude? Does "significant" mean statistically significant, economically significant, or both? Which platform or platforms supply the 3.4 million reviews?
- **Prior IV approaches:** which ones do you mean, and why is their validity questionable? A referee may probe this uncited claim. Does "improves upon" mean you avoid instruments altogether, or use better ones?
- **Takeaway phrase:** what phrase should readers carry away? "Unequal moderation", from your thesis, would work, but I didn't invent a slogan.
- **"This literature":** which literature is meant, given that the opening hasn't named one yet?