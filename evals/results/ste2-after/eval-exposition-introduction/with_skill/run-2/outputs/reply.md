### 1. Diagnosis

**Answer to your question:** The paragraph is clear about the problem and the claimed strategy. It assumes too much about why the strategy identifies the effect. Empirical economists and IS researchers will follow the obstacle in sentence 1, the claim of exogenous variation, and the result. It assumes too much in four places:

1. It asserts that unequal moderation is exogenous to unobserved quality but never says why. A skeptical reader will want that step most.
2. "Review valence", "review cohorts" and "assignment" are undefined, and it is unclear what is assigned to what.
3. "The effect" had no referent, because neither the treatment nor the outcome was named.
4. "Questionable validity" does not say what is wrong with prior instruments or which approaches you mean.

I fixed the referent and the ordering. The other gaps need your material, so they are in the author questions below.

Other findings:
- **Paragraph order:** The contrast with instrumental-variable approaches came after the result, so "Our identification strategy" had no fresh referent.
- **Repetition:** Sentences 2 and 3 stated the same strategy twice.
- **Ambiguous "which":** The antecedent of "which generates" could be the policies, the cohorts, or the whole fact.
- **Terminology drift:** "Platform-level heterogeneity" implies variation across platforms, but "across review cohorts" implies variation within platforms.
- **Unnamed idea:** Your core thesis calls the idea "unequal moderation", but the paragraph never names it.
- **Sentence level:** "Leverage" was a banned word, "Specifically, we leverage the fact that" was throat-clearing, and "significant" could be read two ways.

### 2. Revised text

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identification in this literature. We exploit
platform-level heterogeneity in content moderation as a source of exogenous
variation: platforms apply moderation policies differentially across review
cohorts, and this differential application generates quasi-random assignment
conditional on observed covariates. Our identification strategy improves upon
prior approaches that rely on instrumental variables of questionable validity.
Using a dataset of 3.4 million reviews, we estimate the effect of review valence
on sales and find it to be positive and statistically significant.
```

### 3. Change rationale

Word count is about 90 before and after. The agent loaded twelve reference passes (all except the two whole-paper ones) and kept all twelve.

- **Sentences 2 and 3 merged:** The "Specifically" restatement and "leverage" are gone. "This differential application" gives "generates" a clear antecedent. The exogenous-variation claim and the quasi-random condition are both kept.
- **Contrast sentence moved:** It now directly follows the strategy it contrasts with. The wording is unchanged. The result now closes the paragraph, which shifts the emphasis.
- **"The effect" is now "the effect of review valence on sales":** The wording comes from your core thesis, not from new substance.
- **"Significant" is now "statistically significant":** This removes the double reading.
- **Unchanged:** Sentence 1 is unchanged. No hedges were added or removed, and no numbers or citations were touched.
- **Declined:** I added no definitions, no reason why moderation is exogenous, no example and no specific criticism of prior instruments, because each would add substance only you can supply.

### 4. Author questions

- Is it right to name the outcome as "sales" and the treatment as "review valence"? I took both from your core thesis.
- Is "statistically significant" the sense you intend? The paragraph gives no effect size or unit. Should it include one, with a significance marker such as a p-value?
- Why is differential application of moderation unrelated to unobserved product quality, given the observed covariates? Does the Methods section state this, and which covariates does the conditioning use? Until it is confirmed, "exogenous" and "quasi-random" are unverified claims.
- In "quasi-random assignment", what is assigned to what: reviews to moderation treatment, reviews to valence levels, or something else?
- How should "review valence" be defined for readers outside IS (star rating, sentiment, or something else)?
- What is a "review cohort" (a time window, a product group, or something else)?
- Does the variation run across platforms, across cohorts within a platform, or both?
- Which prior approaches and instruments do you mean by "instrumental variables of questionable validity"? What makes them questionable, and how does your strategy improve on them? Do you want to add citations or a one-clause reason?
- Is it the emphasis you want for the paragraph to end on the finding instead of the comparison with prior work?
- Do you want "unequal moderation" from your core thesis used as the paragraph's memorable handle?
- Can you supply one concrete anchor, such as an example of a moderated versus an unmoderated review, or the platforms and period covered?