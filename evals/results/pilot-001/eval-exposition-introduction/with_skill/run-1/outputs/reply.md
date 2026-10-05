## Diagnosis

Assumed context: none. The paper context comes from `AGENTS.md`. The stage is first draft, so structural moves are allowed.

**To your question:** the opening assumes too much for a general Management Science reader. It never states the research question. "The effect" in sentence 4 has no referent, and "in this literature" points at nothing. It also asks the reader to accept "quasi-random assignment" before showing why unequal moderation produces it.

1. **Machinery before motive.** The paragraph opens on an endogeneity nominalization and never names what is being identified. The outcome (sales) appears only in the thesis statement, not in your text.
2. **Compressed inference.** Nothing says what is being assigned, or why differential moderation yields quasi-random assignment. I can't supply this, so it goes to the questions below.
3. **Buried tension.** The gap (prior instrumental variables are of questionable validity) comes last and reads as an afterthought. The core idea, unequal moderation, sits inside a "the fact that" clause.
4. **Undefined jargon.** "Valence", "review cohorts" and "quasi-random assignment" are not unpacked.
5. **Terminology risk.** "Platform-level heterogeneity" and "differentially apply … across review cohorts" may name different variation. I kept both phrases verbatim.
6. **Sentence-level tells.** "Leverage", "Specifically", "the fact that", "the endogeneity of … with respect to", and "find it to be".

## Revised text

```
Review valence is endogenous to unobserved product quality, a well-known obstacle to identifying its effect on sales. Prior approaches rely on instrumental variables of questionable validity. Our identification strategy improves upon these approaches: we exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply moderation policies differently across review cohorts, which generates quasi-random assignment conditional on observed covariates. In a dataset of 3.4 million reviews, we estimate the effect of valence on sales and find it positive and significant.
```

## Change rationale

Word count: about 90 to about 80 (-10%).

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. No pass was skipped.

- **Sentence 1:** "The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature" became "Review valence is endogenous to unobserved product quality, a well-known obstacle to identifying its effect on sales". The nominalization is now a verb, and the question (effect on sales) is named before the machinery. "Sales" comes from your thesis statement.
- **"In this literature":** cut, because it had no referent. The named estimand now carries the scope.
- **Reorder:** the "prior approaches" sentence moved from last to second. The tension now comes before your strategy, which gives a "problem, but, solution" spine instead of a list. The claim and wording are unchanged.
- **"Improves upon these approaches:"** replaces the longer relative clause, so the contrast sits next to the strategy it contrasts with.
- **Sentence 3:** "Specifically, we leverage the fact that platforms differentially apply" became "Platforms apply … differently". This removes a filler transition and "the fact that". "Quasi-random assignment conditional on observed covariates" is kept verbatim.
- **Last sentence:** "Using a dataset of 3.4 million reviews, we estimate the effect and find it to be positive and significant" became "In a dataset of 3.4 million reviews, we estimate the effect of valence on sales and find it positive and significant". This gives "the effect" its referent. The number and the finding are unchanged.
- **Unchanged:** the passage has no citations, so none were added or moved. No hedges were added.

## Author questions

- Is sales the dependent variable? I took it from your thesis statement.
- What does "valence" measure (star rating, text sentiment, something else)? A one-clause definition at first use would help general readers.
- What is quasi-randomly assigned, to whom, and why does differential moderation produce it? Where is this stated in full, and should the introduction point to it?
- Are "platform-level heterogeneity" and differences "across review cohorts" the same variation or two? What is a "review cohort"?
- Are "exogenous variation" and "quasi-random assignment conditional on observed covariates" two claims? I kept both.
- Which prior IV approaches do you mean by "questionable validity"? Should they, or the "well-known obstacle" claim, carry a citation? I added none.
- Is moving the "improves upon prior approaches" sentence from last to second acceptable?
- Can you give one concrete example of a platform moderating two comparable review cohorts differently?
- Do you want a magnitude, platforms, or time period next to "positive and significant"? Is "significant" meant in the statistical sense?
- Is there a short phrase you want readers to carry away, such as "unequal moderation as identification"?