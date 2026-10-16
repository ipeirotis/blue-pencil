Yes, it assumes too much in three places, and the main risk is for readers outside the review-valence literature:

- **The estimand is never named.** "The effect" has no stated outcome or treatment. I added "of valence on sales", taken from your thesis statement.
- **The endogeneity problem is stated only abstractly.** One clause on the mechanism (unobserved quality drives both valence and sales) makes it accessible without a literature detour.
- **The moderation mechanism is compressed.** "Platform-level heterogeneity" and "differentially apply" are jargon-heavy. I spelled out that platforms differ in how they moderate reviews, without adding any claim about direction.

```text
A well-known obstacle to identifying the effect of a review's valence on sales is
endogeneity: valence is correlated with unobserved product quality, which itself
drives sales. We exploit differences across platforms in how reviews are moderated
as a source of exogenous variation. Specifically, we leverage the fact that
platforms apply their moderation policies unequally across review cohorts, which
generates quasi-random assignment of moderation conditional on observed covariates.
Using a dataset of 3.4 million reviews, we estimate the effect of valence on sales
and find it to be positive and significant. Our identification strategy improves
upon prior approaches that rely on instrumental variables of questionable validity.
```

Two things I left alone because they are substantive claims, but a Management Science referee will probably press on them:

1. **What is quasi-randomly assigned?** Your original says "quasi-random assignment" without an object. I wrote "of moderation", which is my reading. If you mean something else, such as exposure to positive versus negative reviews, change that phrase.
2. **Exogeneity of the moderation itself.** Your thesis rests on unequal moderation being exogenous, but platforms may moderate unequally for reasons tied to product quality or sales. The opening asserts exogeneity without a sentence on why moderation is plausibly unrelated to quality. One sentence here would help readers who are skeptical of the identification strategy.

"Positive and significant" is also vague for this audience. You asked me not to change numbers, so I left it, but a magnitude would strengthen the paragraph if you want to add one.