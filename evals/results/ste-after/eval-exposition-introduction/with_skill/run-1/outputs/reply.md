### 1. Diagnosis

Assumed context: none. The paper context came from `AGENTS.md` (first draft; audience empirical economists and IS researchers).

**Short answer to your question:** the opening assumes too much for a general Management Science reader. It starts with the identification problem before saying what is being estimated, and "the effect" in the fourth sentence has no referent.

- **Undefined terms:** "review valence" is never glossed. "Review cohorts" is undefined. "Quasi-random assignment" doesn't say assignment of what.
- **Endogeneity:** the passage names it but doesn't say why it is an obstacle (unobserved quality drives both reviews and sales).
- **Order:** the sentences run obstacle, fix, result, then a boast about prior work. The tension, that prior instruments are doubtful, comes last. It should come before your strategy, as the reason for it.
- **Redundancy:** the two moderation sentences say the same thing twice. In the second, the antecedent of "which" is unclear.
- **Missing step:** the passage never says why unequal moderation shifts the valence consumers see, or why it affects sales only through valence. I can't supply that, so it is in the questions below.
- **Wording:** "leverage" is a banned word, and I replaced it.
- **Unverified claims:** "quasi-random conditional on observed covariates," "exogenous," and "instruments of questionable validity" depend on sections I haven't seen. The result also gives a direction but no magnitude.

### 2. Revised text

```
Estimating the effect of review valence on sales faces a well-known obstacle to identification in this literature: valence is endogenous with respect to unobserved product quality. How positive or negative a product's reviews are reflects that quality, which also shapes sales. Prior approaches rely on instrumental variables of questionable validity. We instead exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply their moderation policies unequally across review cohorts, and conditional on observed covariates, this unequal application generates quasi-random assignment. Our identification strategy improves upon these prior approaches. Using a dataset of 3.4 million reviews, we estimate the effect and find it to be positive and significant.
```

### 3. Change rationale

The text grew from about 90 to about 120 words (+33%). Most of the growth is the missing referent and the glosses a general reader needs.

- **Opening:** the question and outcome (the effect of valence on sales) now come first. "Sales" is taken from your `core_thesis`.
- **Added sentence:** "How positive or negative a product's reviews are reflects that quality, which also shapes sales." It defines valence and states the endogeneity story.
- **Prior-IV sentence:** moved from last to third, with its wording unchanged, so the tension comes before your strategy. "Instead" makes the contrast explicit.
- **Moderation sentences:** merged. "Leverage" and "Specifically" are gone, and "differentially" became "unequally," which matches your thesis wording. The antecedent problem with "which" is fixed.
- **Improvement claim:** now follows the strategy it describes, and the repeated modifier is dropped. The claim itself is unchanged.
- **Final sentence:** kept verbatim.
- **Left alone:** all numbers and claims. The passage contains no citations.

The reviser loaded the full reference set: principles, edit-checks, structural-patterns, exposition, altitude, precision-budget, narrative-spine, reader-pleasure, sentence-patterns, subtraction, ai-tells-to-avoid, and copyediting. It skipped none.

### 4. Author questions

- Is sales the outcome? Is "valence" the star rating, the review text's sentiment, or both?
- Does the added sentence state the endogeneity story you intend, with unobserved quality driving both reviews and sales?
- What exactly is quasi-randomly assigned: a review's exposure to moderation, or the valence consumers see? Why does unequal moderation move the valence consumers see, and why does it affect sales only through valence? This is the central identification step, and the passage doesn't contain it.
- Is the variation between platforms, across review cohorts within a platform, or both? What is a review cohort?
- Is "exogenous variation" the same claim as "quasi-random assignment conditional on observed covariates," or the stronger one?
- Which prior approaches do you mean, and why is their validity questionable (for example, a violated exclusion restriction)? I added no citation.
- Can the effect carry a magnitude and significance level alongside "positive and significant"?
- Which platforms and time span make up the 3.4 million reviews? Is there one concrete case of a moderated versus an unmoderated review that could anchor the strategy?
- Is "unequal moderation" the phrase you want readers to carry away?
- Do your Methods and Results sections fully support the quasi-random assignment claim and the criticism of prior instruments? I couldn't check, because those sections weren't supplied.