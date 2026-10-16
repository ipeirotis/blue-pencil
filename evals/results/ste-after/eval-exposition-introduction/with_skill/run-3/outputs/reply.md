## 1. Diagnosis

**Short answer:** It's mostly clear to empirical economists and IS researchers, but it assumes too much in four places:
- The effect is never named. "Sales" appears only in your thesis, not in the passage.
- Content moderation is never explained.
- The step from unequal moderation to variation in valence is skipped.
- The contrast with prior work names no alternative.

Other issues:
- **Definition debt (S1, S4):** S4 says "the effect," but S1 never names an effect or an outcome. I used "sales" from your thesis. Please confirm it.
- **Compressed inference (S2, S3):** The passage jumps from "platforms moderate differently" to "quasi-random assignment." A non-specialist can't rebuild the step, and the passage doesn't supply it, so it's an author question.
- **Possible logic gap (S1 vs S3):** S1 names *unobserved* quality as the obstacle, but S3 claims quasi-random assignment *conditional on observed covariates*. A reviewer will ask why conditioning on observables handles unobserved quality. I kept the qualifier because it is the identifying condition.
- **Level inconsistency (S2 vs S3):** S2 says "platform-level" heterogeneity, but S3 says variation "across review cohorts." Those are different sources of variation, and the text doesn't say which one you mean.
- **Expert-only contrast (S5):** "Instrumental variables of questionable validity" names no approach and has no citation. I left the sentence verbatim.
- **Result (S4):** It gives direction and significance but no magnitude. The dataset's source isn't named.
- **Sentence level:** S1 is a nominalization that puts the machinery before the question. "Leverage" is on the banned-verb list. In S3, "which generates" can attach to "cohorts."

I couldn't check the Methods and Results sections because they weren't supplied.

## 2. Revised text

```
The effect of review valence on sales is hard to identify because valence is endogenous to unobserved product quality, a well-known obstacle in this literature. We exploit differences in content moderation across platforms as a source of exogenous variation. Specifically, we use the fact that platforms apply moderation policies differently across review cohorts. This difference generates quasi-random assignment conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and significant. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity.
```

## 3. Change rationale

Length goes from about 90 to about 100 words (+11%). The additions are the missing outcome ("on sales," twice) and one sentence split.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. No pass was gated off. `cold-read.md` and `consistency-checks.md` are whole-paper passes and were not loaded.

- **S1:** "The effect of review valence on sales is hard to identify because valence is endogenous to unobserved product quality…" puts the question first and names the missing object. "Unobserved" and "well-known" are kept.
- **S2:** "differences in content moderation across platforms" replaces the abstract "platform-level heterogeneity."
- **S3:** "leverage" becomes "use," and the sentence is split so "this difference" fixes the referent. The quasi-random and conditional-on-observed-covariates claim is carried over verbatim.
- **S4:** "the effect" becomes "the effect of review valence on sales," because two sentences about moderation had intervened.
- **S5:** Unchanged. It already ends on the contribution claim, and its gaps are substance rather than wording.
- **Numbers and claims:** "3.4 million" and "positive and significant" are verbatim. The passage had no citations, and I added none.

## 4. Author questions

- Is the outcome "sales," as your thesis says? The pasted text never named it.
- What does moderation do to a review (removal, down-ranking, delayed display)? How does unequal moderation turn into variation in valence? I did not supply that step.
- What licenses quasi-random assignment conditional on *observed* covariates when the obstacle is *unobserved* quality? Do you want a one-clause pointer to where the paper argues it?
- Is the variation across platforms, across cohorts within a platform, or both? The two sentences should use one level or say how they relate.
- Should "valence" be glossed as star rating, text sentiment, or both?
- Which prior IV approaches do you mean, and why is their validity questionable? Should the sentence carry one or two citations?
- Can the opening report a magnitude next to "positive and significant"? Is "significant" statistical significance, and at what level? Any change here is a numerical claim for you to decide.
- Which platforms, products, and period make up the 3.4 million reviews?
- Do you want a named handle for the idea, such as "unequal moderation" from your thesis? I did not invent one.
- Where in Methods and Results are the identifying assumptions and full specification stated?