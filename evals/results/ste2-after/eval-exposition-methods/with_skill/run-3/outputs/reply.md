## Diagnosis

Assumed context: none. Audience, revision stage (first draft), venue and thesis come from `AGENTS.md`.

- **Reader:** a quantitative marketing researcher who knows two-way fixed effects (TWFE) but not staggered designs.
- **Buried lede:** the program reached stores on different dates. The draft says this only in the last sentence, after the model is described.
- **Undefined jargon:** "never-treated," "not-yet-treated," and "heterogeneity in treatment timing."
- **Overloaded last sentence:** it is about 45 words and holds two topics, the choice of controls and the second estimator.
- **One word, two senses:** "controls" means covariates in sentence 2 and comparison stores in sentence 4.
- **Substance gaps** (sent to Author questions): the post-rollout indicator is undefined under staggered dates, the outcome variable is not named, and the paragraph never says why TWFE alone is not enough.

## Revised text

```
The loyalty program was rolled out to stores on different dates, so the set of treated stores changes over time. We therefore use two kinds of control stores: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received the program at a given date. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

## Change rationale

Word count grew from about 90 to about 120 (+33%). The additions are the rollout motive and the two glosses, which the non-specialist request calls for.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. No pass was skipped. precision-budget.md ran, but its gate was not met and the hedge census found nothing.

- **Rollout first:** your "Because the program was rolled out on different dates" clause now opens the paragraph, so the reader meets the reason for the design before the machinery.
- **Control stores defined:** "never-treated" and "not-yet-treated" each get a gloss that uses only the rollout fact already on the page. The "because ... we use" link is kept as "therefore."
- **"Controls" disambiguated:** the comparison stores are now "control stores," so "controls for foot traffic..." keeps the covariate meaning.
- **Last sentence split:** the Callaway and Sant'Anna estimator gets its own sentence, and its terms keep your order.
- **Sentences 1–3 of your original:** unchanged in wording.
- **Numbers, statistics, citations:** none changed, added or removed.

## Author questions

- Do never-treated stores never get the program during the sample window, or at all? The gloss "never receive the program" assumes the former is acceptable.
- How is the post-rollout indicator defined when stores start on different dates? Is it 1 from each store's own rollout week? A non-specialist needs this to see what the interaction coefficient measures.
- Which outcome does this model use (the thesis mentions repeat purchase)? Should the coefficient sentence name it?
- Why does TWFE alone need a companion estimator when timing varies? One sentence from you would help non-specialists most.
- Should the Callaway and Sant'Anna estimator carry a citation here? None is present, and none was added.
- Does "heterogeneity in treatment timing" mean start dates vary across stores, or effects differ by start date? The revision keeps your phrase unchanged.