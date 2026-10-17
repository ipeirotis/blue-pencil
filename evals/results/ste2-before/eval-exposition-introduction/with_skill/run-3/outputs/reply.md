## 1. Diagnosis

**Short answer to your question:** For empirical economists and IS researchers, the jargon is fine. Endogeneity, identification, instrumental variables and covariates are standard for them. A broader Management Science reader would get lost at three missing bridges:

- why endogeneity blocks identification
- how moderation turns into variation in valence
- what is being estimated

I repaired the first and third bridges. The second needs material only you can supply.

**Findings**

1. **Compressed inference (S1).** The paragraph names the endogeneity problem but never says why it is a problem. I added one sentence that unpacks your own term, with no new claim.
2. **Buried tension (S2–S5).** The paragraph runs setup, solution, result, then the reason the solution was needed. The turn (prior IV approaches are questionable) comes last. I reordered to: valence is endogenous, prior IV fixes are questionable, platforms moderate unequally, so the effect can be estimated. I used only your sentences.
3. **Dangling referent (S4).** "The effect" never says of what on what. I named it from your `core_thesis` and flagged it below.
4. **Missing bridge I cannot repair (S3).** The text never says how unequal moderation produces variation in valence, what "assigned" means, or whether the variation lies across platforms or across cohorts within a platform. The whole identification claim rests on this step.
5. **Undefined terms.** "Valence," "review cohorts" and "quasi-random assignment" are never defined. I couldn't define them from the manuscript, so they go to the questions below.
6. **Precision debts (S4–S5).** The result has a direction and a significance marker but no magnitude. The contrast with prior work is asserted, not specified. There were no hedges to cut. The claims "quasi-random," "positive and significant" and "improves upon" need support in Methods and Results, which are outside this unit.
7. **Sentence level.** "Leverage" and "Specifically," went. The "which generates" clause had an unclear antecedent. "Unequal moderation," the memorable idea from your thesis, was latent and now sits in the stress position of its sentence.

## 2. Revised text

```
The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature. Unobserved quality can shape both a product's reviews and its sales, so the raw link between valence and sales does not isolate the effect of valence. Prior approaches to this problem rely on instrumental variables of questionable validity. Our identification strategy improves upon them by exploiting unequal moderation: platforms differentially apply moderation policies across review cohorts. This platform-level heterogeneity in content moderation is a source of exogenous variation: it generates quasi-random assignment conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and significant.
```

## 3. Change rationale

**Length:** about 90 words became about 130 (+45%). The growth comes from one bridge sentence and the named effect.

**References loaded:** principles, edit-checks, structural-patterns, exposition, altitude, precision-budget, narrative-spine, reader-pleasure, sentence-patterns, subtraction, ai-tells-to-avoid, copyediting. No pass was skipped. The whole-paper passes (cold-read, consistency-checks) don't apply to this unit.

- **Sentence 1:** unchanged. The topic sentence already comes first.
- **New sentence 2:** it restores the inference from "endogeneity" to the identification problem. It rests only on your own claim of endogeneity with respect to unobserved quality.
- **Sentences 3–4:** I moved the turn ahead of the solution, so the reader knows why the solution is needed. "To this problem" supplies the referent for "prior approaches." "Improves upon" and "questionable validity" are kept.
- **Sentences 4–5:** the plain fact now comes before the jargon, and "unequal moderation" is surfaced from your thesis. The unclear "which" clause now has the explicit subject "it" (the heterogeneity).
- **Cuts:** "leverage the fact that" became "exploiting." "Specifically," was cut because it announced instead of connecting. "Platform-level," "content moderation," "quasi-random" and "conditional on observed covariates" are all kept.
- **"The effect of review valence on sales":** this fixes the dangling referent, using the estimand from your `core_thesis`.
- **Numbers and citations:** "3.4 million reviews" is unchanged. No citation was added or removed.

## 4. Author questions

- What does "valence" measure (star rating, sentiment, or something else)? Should it be defined at first use for readers outside IS and marketing?
- Is the direction in the new sentence 2 what you intend, that unobserved quality shapes both a product's reviews and its sales? Is sales the outcome in every specification? I took "sales" from `core_thesis`, not from this passage.
- How does unequal moderation produce variation in valence? What does moderation do (remove, delay, flag), and what exactly is "assigned" in "quasi-random assignment"? Could you give one concrete example, such as two similar reviews treated differently?
- What is a "review cohort"? Does the variation run across platforms or across cohorts within a platform? I kept both phrases rather than collapse a possible distinction.
- Where does the body justify "quasi-random conditional on observed covariates" (which covariates, which balance or placebo evidence)? The reviser hasn't seen that section, so this is unverified. If the full statement narrows the claim, should the introduction change?
- Which prior IV approaches do you mean, and why is their validity questionable? Should those citations appear here? None were added. What exactly does "improves upon" claim?
- What is the magnitude of the effect, with units? Is "significant" statistical significance, and at what level? No numbers were changed.
- Which platforms, period and product categories does the 3.4 million-review dataset cover? A general reader will want one clause on this.
- Is "unequal moderation" the phrase you want readers to carry away? If you prefer another handle, the sentence that holds it can change.

No file was modified.