## Diagnosis

Short answer: it assumes too much in four places. The audience-level jargon (endogeneity, instrumental variables, exogenous variation) is fine for Management Science. I read the stored audience and stage from `AGENTS.md`, so no context was assumed.

1. **Definition debt.** The paragraph never names the treatment or the outcome, so "the effect" in the fourth sentence has no referent. "Valence" is used before it is defined. I filled both from your stated thesis.
2. **Compressed inference.** The paragraph says differential moderation "generates quasi-random assignment" but not assignment to what, or why moderation is as-if random given covariates. That is the paper's core claim and it isn't on the page, so I didn't supply it.
3. **Undefined terms.** "Content moderation" and "review cohorts" carry the identification strategy, but they aren't defined.
4. **Ordering.** The comparison with prior approaches sat apart from the strategy it evaluates, and the result was buried mid-paragraph.
5. **Expert-only contrast.** "Prior approaches" and "questionable validity" are asserted without saying which approaches or why. There are no citations on the page, so I added none.
6. **No handle for the idea.** The paragraph reads as a method plus a result. "Unequal moderation" is the natural handle, but I didn't coin a slogan.
7. **Sentence level.** "Platform-level heterogeneity in" is a stack of abstract nouns, and "leverage" is a verb to avoid.

## Revised text

```
We study the effect of review valence on sales, where valence is how positive or negative a review is. Review valence is endogenous with respect to unobserved product quality, a well-known obstacle to identification in this literature. We exploit differences across platforms in content moderation as a source of exogenous variation. Specifically, we use the fact that platforms differentially apply moderation policies across review cohorts, which generates quasi-random assignment conditional on observed covariates. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate this effect and find it to be positive and significant.
```

## Change rationale

The text grew by about 22%, from one added opening sentence.

- **New first sentence.** It names the treatment and outcome and defines valence at first use. The outcome (sales) comes from your `core_thesis`.
- **Second sentence.** "The endogeneity of review valence … is a well-known obstacle" became "Review valence is endogenous …, a well-known obstacle …". This puts a concrete subject up front and keeps your "well-known" and "in this literature".
- **Third sentence.** "Platform-level heterogeneity in content moderation" became "differences across platforms in content moderation", which says in plain words what the abstract noun meant.
- **Fourth sentence.** "Leverage" became "use".
- **Order.** The sentence order is now strategy, then the comparison with prior approaches, then the result. The comparison sits next to the strategy it evaluates, and the result ends the paragraph.
- **Fifth sentence.** "Estimate the effect" became "estimate this effect", so the referent is clear.
- **Kept verbatim.** I left "quasi-random assignment conditional on observed covariates", "positive and significant", "3.4 million reviews" and the prior-approaches claim as written.
- **Numbers and citations.** I changed no number, statistic or citation. None existed to reorder.
- **Passes.** All 11 per-section reference passes ran. The altitude and precision-budget passes found nothing to change.

## Author questions

- Is sales the outcome? Is "how positive or negative a review is" the right gloss for valence (a star rating, or text sentiment)? I took the outcome from your `core_thesis` because the paragraph never names it.
- What does content moderation do to a review on these platforms (remove, hide, delay, rank)? One sentence on this would help readers outside the subfield.
- How are review cohorts defined (posting period, product category, something else)?
- Why does differential moderation across cohorts generate quasi-random assignment, and assignment to what: reviews to being visible, or products to a valence level? This step carries your thesis, and I didn't supply it. Where in the body is it fully stated?
- Are "exogenous variation" and "quasi-random assignment" the same construct? If they are, should the paragraph use one term?
- Which prior approaches does the last comparison refer to, and why is their instrument validity questionable? Should the claim carry citations or a one-clause reason?
- Can the introduction state the effect's size as well as its direction, with a baseline that makes the size interpretable? I changed no numbers.
- Do you want a phrase for the paper's idea, perhaps built on "unequal moderation"?
- Is it acceptable that I moved the prior-approaches sentence ahead of the result? If not, I can restore the original order.
- Do the body sections state the "positive and significant" result in full? That check is outside this passage, so I couldn't verify it.