Mostly clear for empirical economists and IS researchers, but a general Management Science reader would stumble in a few places:

- **"The effect" is never defined.** The opening never says that the outcome is sales or that the treatment is review valence, so a reader has to infer it from "estimate the effect."
- **"Endogeneity of review valence" is stated, not explained.** Specialists will get it, but a general reader needs the one-clause reason: valence is correlated with unobserved quality that also drives sales.
- **"Quasi-random assignment conditional on observed covariates" is dense.** It helps to say what is being assigned, namely whether a review is moderated.
- **"Platform-level heterogeneity" and "across review cohorts" blur together.** I've kept both, but made clear that the variation is in how platforms moderate.

I changed only the wording needed to fix these. The claims and the figure (3.4 million) are untouched, and the passage contains no citations.

```
A well-known obstacle to identifying the causal effect of review valence on sales is endogeneity: valence is correlated with unobserved product quality, which itself affects sales. We exploit differences across platforms in how they moderate content as a source of exogenous variation. Specifically, we leverage the fact that platforms differentially apply moderation policies across review cohorts, which generates quasi-random assignment of moderation conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of valence on sales and find it to be positive and significant. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity.
```

Two content points are beyond what I should change in a clarity edit. Your thesis is that the unequal moderation is what delivers identification, and the paragraph says this only implicitly. Also, "quasi-random" is the claim referees will press on, so a later sentence on why moderation is unrelated to unobserved quality would help. I haven't added either, since they would change your claims.