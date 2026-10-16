## Diagnosis

**Short answer:** No, it isn't yet clear enough for a general Management Science reader. It assumes too much, mainly at points 1 to 3 below.

Stage is `first draft`, taken from your `AGENTS.md`. The jargon the reviser found (review valence, endogeneity with respect to unobserved quality, review cohorts) can't be glossed from the manuscript, so those items are in Author questions.

1. **The estimand is unnamed.** "The effect" never says what is estimated. I named it from your core thesis (the effect of review valence on sales), and I flag it below because it touches a claim.
2. **The central inferential step is missing.** The passage says moderation varies and yields "exogenous variation" and "quasi-random assignment". It never says how moderation moves valence. This is the largest gap, and the manuscript doesn't supply the step.
3. **The level of variation is ambiguous.** Sentence 2 says "platform-level heterogeneity" and sentence 3 says "across review cohorts". It isn't clear whether the variation is between platforms, within a platform over cohorts, or both. "Cohort" is undefined.
4. **The identification claims have no signpost.** "Exogenous" and "quasi-random conditional on observed covariates" are claims of different strength, and nothing says where they are defended. The passage has no hedges, so there are none to classify.
5. **The contrast with prior work is asserted, not specified.** No prior approach is named or cited, and "improves upon" doesn't say on what dimension. Whether to change this is your call, so I left the claim alone.
6. **"This literature" names no literature.** "Valence" and "endogeneity" go unglossed.
7. **Sentence-level problems.** "Leverage" is a weak verb, "Specifically" is filler, and "significant" could mean statistical or economic significance.

The spine is sound: endogeneity is the obstacle, unequal moderation is the way around it, and the result follows. Nothing was reordered.

## Revised text

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identification in this literature. We address this obstacle
by exploiting platform-level heterogeneity in content moderation as a source of
exogenous variation. Platforms apply their moderation policies unequally across
review cohorts, and this generates quasi-random assignment conditional on observed
covariates. Using a dataset of 3.4 million reviews, we estimate a positive and
statistically significant effect of review valence on sales. Our identification
strategy improves upon prior approaches that rely on instrumental variables of
questionable validity.
```

## Change rationale

The word count is essentially unchanged, at about 90 words before and after. Numbers (3.4 million) and meaning are untouched, and there were no citations to preserve.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. The cold-read and consistency-check references were not loaded because they belong to whole-paper passes.

- **"We exploit…" became "We address this obstacle by exploiting…".** This ties the approach to the problem sentence 1 opened.
- **"Specifically, we leverage the fact that platforms differentially apply…, which generates" became "Platforms apply their moderation policies unequally…, and this generates".** It drops "leverage" and "Specifically". It also uses your thesis word "unequally" and gives the trailing clause a clear referent.
- **"Estimate the effect and find it to be positive and significant" became "estimate a positive and statistically significant effect of review valence on sales".** This names the estimand and removes the ambiguity in "significant".
- **Cut:** "Specifically", "the fact that" and "find it to be". Nothing else was deleted.
- **Left alone:** Sentences 1 and 5 had no safe improvement. Sentence 5 carries a comparative claim only you can adjust.
- **Declined:** Glosses of "valence" and "endogeneity", a mechanism sentence, and a defence of exogeneity. Each would add substance the manuscript doesn't contain.

## Author questions

- Is "of review valence on sales" the right estimand for the 3.4 million reviews? I took it from your core thesis.
- Does "significant" mean statistically significant? Should the passage also give the effect's size, since a general reader currently gets only "positive and significant"?
- How does unequal moderation move valence? For example, which reviews are removed or altered, and in which direction? One sentence on this would let a non-specialist see why the variation is exogenous.
- Is the variation between platforms, across cohorts within a platform, or both? How would you define "review cohort" for an outside reader?
- Can you give a one-sentence gloss of "review valence" (star rating, text sentiment, or something else) and of why it is endogenous to unobserved quality?
- Where are "exogenous" and "quasi-random assignment conditional on observed covariates" defended? Do you want a forward pointer to that section here, and are the two terms meant to be the same claim?
- Which prior approaches does the last sentence refer to? Can they be cited, and how exactly does your strategy improve on them (for example, no instrument is needed)?
- Which literature does "this literature" mean?
- Is there a phrase you want readers to carry away for the design, such as a name for the unequal-moderation approach?
- Does the manuscript already have a concrete example of an unequally moderated review that could anchor this opening?