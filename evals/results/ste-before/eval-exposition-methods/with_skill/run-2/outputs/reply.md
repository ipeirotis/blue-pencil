## 1. Diagnosis

Assumed context: none. Audience, stage, venue and thesis come from the `<paper_context>` in `AGENTS.md`. The stage is first draft, and the reader is a quantitative marketing researcher who doesn't work with staggered designs.

**Voice tics:**
- First-person plural with plain active verbs ("We estimate", "we use", "we report").
- Short declarative sentences with no hedging.
- Hyphenated technical compounds (two-way fixed effects, never-treated, not-yet-treated).
- Method names stated as bare facts.
- "alongside" as the connective between the two estimators.

**Problems found:**
1. **Machinery before motive (sentences 1 and 4).** The staggered rollout explains the control group and the second estimator, but it arrives last.
2. **Definition debt (sentence 4).** "Never-treated" and "not-yet-treated" are used without saying which stores each covers.
3. **Terminology collision (sentences 2 and 4).** "Controls" means covariates in one place and comparison stores in another.
4. **Overloaded closing sentence.** It holds the motive, the control group and a second estimator.
5. **Echo risk.** Once the rollout fact moves to the front, the closing "heterogeneity in treatment timing" could restate it.
6. **Compressed inference (sentence 3).** The post-rollout × treatment interaction has no hint of what it captures when dates differ. The paragraph doesn't contain this bridge, so it goes to Author questions.
7. **Ending.** The paragraph ended on estimator names. The purpose clause now sits in the stress position.

## 2. Revised text

```
The loyalty program was rolled out to stores on different dates. We therefore use two groups of stores as controls: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

## 3. Change rationale

Word count: about 90 to about 100 (+11%). The growth comes from two short glosses defining "never-treated" and "not-yet-treated," built from the terms' own wording.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. precision-budget.md was read only to check its gate and is skipped. This is a methods paragraph, and no hedge was added, removed or deferred.

- **New opening sentence.** The rollout fact moves to the front, so the question precedes the machinery.
- **Control-group sentence.** Both terms are defined at first use. "Therefore" carries the author's original "Because."
- **"Includes controls for" → "controls for."** This removes the collision with control stores. The covariate list is unchanged.
- **Reordering.** The order is now design and controls, model, covariates, coefficient, second estimator. The reader meets one new object at a time.
- **Clustering clause.** It stays attached to the model sentence, unchanged.
- **Closing sentence.** The second estimator gets its own sentence, so the purpose clause ends the paragraph.
- **Kept verbatim.** "Heterogeneity in treatment timing" and the estimator names are unchanged.
- **Numbers and citations.** The paragraph had no numbers, statistics or formal citations, and none were added or changed.

## 4. Author questions

- Which estimator uses the never-treated and not-yet-treated stores as controls: two-way fixed effects, Callaway and Sant'Anna, or both? The original didn't say, and the new order could suggest it applies to the two-way fixed effects model.
- Do the glosses "never receive the program" and "have not yet received it" match what you mean?
- How is the post-rollout indicator defined when stores were treated on different dates? Does the treatment indicator mark every store that eventually gets the program?
- Should the paragraph name the outcome (repeat purchase) and say what the interaction coefficient captures?
- Would a plain-language sentence help on what store and week fixed effects absorb, why standard errors are clustered by store, and what Callaway and Sant'Anna does differently? Please supply the wording or point to where the manuscript already explains them.
- Does the manuscript give a reason why the two-way fixed effects estimate alone is insufficient under staggered timing? If so, should it appear here?
- Is there a reference for the Callaway and Sant'Anna estimator elsewhere in the manuscript that should attach to this sentence?