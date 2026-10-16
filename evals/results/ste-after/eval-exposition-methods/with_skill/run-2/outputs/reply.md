## Diagnosis

Assumed context: none. All four `paper_context` fields were supplied.

- **Reader:** a quantitative marketing researcher who knows fixed-effects regression but not the staggered-rollout literature. They need to learn who is compared with whom and why a second estimator is reported.
- **Buried lede:** the program reached stores on different dates. That fact sits in the last sentence, though it motivates both the choice of control stores and the second estimator.
- **Last sentence:** it carries two topics in about 40 words, the control stores and the second estimator, under one "Because" clause.
- **Undefined terms:** "never-treated" and "not-yet-treated" have no gloss.
- **Word-sense clash:** "controls" means covariates in sentence 2 and comparison stores in sentence 4.
- **Undefined indicators:** the "post-rollout" and "treatment" indicators are not defined. Under different rollout dates, "post-rollout" has no single meaning.
- **Thin tension:** "heterogeneity in treatment timing" is a label with no stated consequence. The paragraph also ended on procedure rather than purpose. Both are Author questions, not edits.

## Revised text

```
The loyalty program was rolled out to stores on different dates, so we use two kinds of control stores: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

## Change rationale

Word count: about 90 to about 100 (+11%). The added words are two short glosses of the control-store types, built from the words "never" and "not yet". Nothing was cut. The paragraph had no numbers or citations, so none were changed.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped: precision-budget.md, because this is not an abstract, introduction, or contribution paragraph and no hedge was added or removed. Altitude found nothing to relocate, since this is a Methods paragraph.

- **Rollout dates moved first.** The dates now open the paragraph, so the motive comes before the machinery. The causal link is unchanged.
- **Control stores defined.** "The never-treated and not-yet-treated stores as controls" became "two kinds of control stores", each glossed. This also separates "control stores" from "controls" meaning covariates.
- **Sentence order.** The control stores now come before the model and the "treatment indicator", which needs the idea of treated versus control stores. The model, covariate, and coefficient sentences are otherwise verbatim.
- **Estimator sentence split off.** It is now its own closing sentence that starts with its purpose, so the paragraph ends on why the second estimator is reported.

## Author questions

- **Fixed effects:** should a clause explain what the store and week fixed effects absorb? If so, what should it say?
- **Consequence of timing heterogeneity:** what goes wrong with the two-way fixed effects estimate alone when timing differs across stores? A non-specialist needs one sentence on this, and I could not supply one without inventing it.
- **Indicators:** under different rollout dates, how is the post-rollout indicator set for each store, and which stores does the treatment indicator mark?
- **Not-yet-treated gloss:** does "not-yet-treated" mean a store counts as a control only in weeks before its own rollout?
- **Terminology:** I changed this paragraph's first use to "control stores" so "controls" means covariates only. Does that match your usage elsewhere?
- **Outcome:** the paragraph never names the outcome, which the thesis gives as repeat purchase. Is it stated earlier, or should this paragraph say what the coefficient measures?
- **Citation:** the Callaway and Sant'Anna estimator carries no citation here. Is it cited where it is first introduced?