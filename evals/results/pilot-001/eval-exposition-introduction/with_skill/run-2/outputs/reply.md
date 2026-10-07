## Diagnosis

Assumed context: none. All four `<paper_context>` fields were read from `AGENTS.md`.

**Short answer:** the passage assumes too much for a general Management Science reader. It states the problem and the fix in econometric shorthand, and it never says which effect it is about. I fixed what the text already supports and sent the rest to Author questions.

**Voice tics kept:** first-person plural ("We exploit", "we estimate"), short declarative sentences with no hedges, a formal econometric register, and a plain claim-first stance toward prior work.

**Reader map:** the reader knows causal-inference basics but not this platform setting. They need to learn that uneven moderation is the source of variation that identifies the valence effect. They should leave knowing that moderation varies across platforms and review cohorts, so the effect can be estimated without the instrumental variables of prior work.

1. **[P1] Definition debt.** "The effect" has no stated object, and "endogeneity" has no gloss. The rewrite names the effect as that of review valence on sales (taken from your core thesis) and glosses the problem.
2. **[P1] Buried tension and order.** The contrast with prior approaches comes after the result and is a bare claim. I reordered your own sentences: problem, then prior approaches, then our strategy, then data and result.
3. **[P1] Missing bridge.** The text never says why differential moderation yields quasi-random assignment, or assignment of what. The manuscript doesn't supply this, so I didn't write it (see Author questions).
4. **[P1] Precision tension.** "Exogenous variation" is stated flatly, then qualified by "quasi-random ... conditional on observed covariates". I kept both phrases and routed the reconciliation to you. "Questionable validity" is a swipe at prior work with no support in this passage.
5. **[P1] Terminology.** "Platform-level heterogeneity" and "across review cohorts" may describe different variation (across platforms versus across cohorts within a platform). "Review cohorts" is undefined. I kept both terms.
6. **[P1] Memorable idea.** Your core thesis says "unequal moderation", but the paragraph says "heterogeneity in content moderation". I didn't invent a slogan.
7. **[P1] Line level.** "Leverage" became "exploit" and "differentially apply" became "apply ... differently". "Positive and significant" gives no magnitude or unit.

## Revised text

```
Review valence moves with unobserved product quality, so a raw comparison of reviews cannot isolate the effect of valence itself. This endogeneity is a well-known obstacle to identification in this literature, and prior approaches rely on instrumental variables of questionable validity. Our identification strategy improves upon them by exploiting platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply moderation policies differently across review cohorts, which generates quasi-random assignment conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and significant.
```

## Change rationale

Word count: about 100 to about 105 (+5%). The added gloss and the named effect lengthen the text. Cutting the "Specifically, we leverage the fact that" opener offsets part of that.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. No pass was skipped, since this is a first-draft introduction.

- **Endogeneity gloss:** added a plain statement of the problem ("Review valence moves with unobserved product quality ...") before the label.
- **Named effect:** "the effect" became "the effect of review valence on sales", using your core-thesis wording.
- **Reorder:** the "improves upon prior approaches" sentence moved from last to third, and the result now closes the paragraph.
- **Split:** the nested prior-approaches sentence became a claim ("prior approaches rely on ...") and its target ("improves upon them").
- **Merge:** two sentences that stated the strategy twice became one. "Specifically, we leverage the fact that" was cut as a restatement, and "differentially apply" became "apply ... differently".
- **Kept:** "conditional on observed covariates" is unchanged in meaning, since it is a scope qualifier.
- **Numbers and citations:** "3.4 million" is unchanged, and the passage has no citations.

## Author questions

- Why does uneven moderation yield quasi-random assignment, and what is assigned? Is it which reviews are shown, removed or promoted, or the valence a product ends up with? One sentence of mechanism would carry the paper's main argument for a general reader.
- Is "exogenous variation" meant strictly, or as shorthand for the "quasi-random, conditional on observed covariates" claim? Should the first phrase be softened to match?
- Is the variation across platforms, across cohorts within a platform, or both? If both, should the paragraph name each?
- What is a "review cohort"? A definition or one concrete example would anchor non-specialists. The manuscript gives none, so I didn't supply one.
- I took the outcome as sales from your core thesis. Is "the effect of review valence on sales" the right estimand?
- Does the new gloss ("moves with unobserved product quality, so a raw comparison of reviews cannot isolate the effect of valence itself") state the endogeneity problem as you intend?
- Which prior IV approaches does "of questionable validity" refer to, and where does the paper explain why their instruments are weak? Choosing citations is your call. "Improves upon" is an unpaid debt until the body shows how.
- Does "significant" mean statistically significant? What are the magnitude, unit and significance marker? None was added because the manuscript states none, and no number or statistic was changed.
- Which phrase should readers carry away: "unequal moderation", "platform-level heterogeneity in content moderation", or something else?