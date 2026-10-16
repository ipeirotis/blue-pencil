## Diagnosis

Assumed context: none. All four `paper_context` fields were present.

- **Reader:** quantitative marketing researchers who know fixed-effects regression but not staggered-adoption designs. They should leave knowing which stores are the controls, what the coefficient of interest is, and why two estimators appear.
- **Buried lede:** the design logic, that different rollout dates are what supply the control stores. It sat in a subordinate clause at the start of the last sentence, after the machinery.
- **Definition debt:** "never-treated" and "not-yet-treated" were used with no gloss. "Heterogeneity in treatment timing" can't be unpacked from the manuscript (see questions below).
- **Overloaded last sentence:** it carried the rollout rationale, the control-group choice, the second estimator, and its purpose.
- **Terminology collision:** "controls" meant control stores in the last sentence and covariates in the second.

## Revised text

```
The loyalty program was rolled out to stores on different dates, so we use two kinds of stores as the control group: never-treated stores, which never receive the program, and not-yet-treated stores, which have not received it yet. We estimate a two-way fixed effects model with store and week fixed effects and controls for foot traffic, local unemployment, and promotional intensity, clustering standard errors at the store level. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

## Change rationale

The text grew from about 90 to about 100 words (+11%). The growth comes from two inline glosses of your own terms.

- **Moved the rollout rationale to the opening.** The design logic now comes before the specification. "Because ... we use" became "so we use", which puts cause before effect in the reader's order.
- **Glossed both control types.** The glosses come from the terms' own meaning and trail the noun, so the main clause isn't interrupted.
- **"As controls" became "as the control group".** This removes the clash with "controls for foot traffic".
- **Folded the covariate sentence into the model sentence.** The three controls and the clustering clause are kept.
- **Gave the Callaway and Sant'Anna estimator its own sentence.** It now ends on the estimator pairing and carries one new idea.
- **Left the coefficient-of-interest sentence unchanged.**
- **Unchanged items:** no number, statistic, or citation changed, and nothing was deleted.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. The precision-budget pass was skipped because this is Methods prose and no hedge was added or removed.

## Author questions

- Does the never-treated and not-yet-treated control group apply to the two-way fixed effects estimate, the Callaway and Sant'Anna estimate, or both? The original didn't say, so the rewrite says "the control group" for the whole analysis.
- Do "never receive" and "have not received it yet" mean within your sample window? If so, should the gloss say "in the sample period"?
- What does "heterogeneity in treatment timing" mean for your reader, and what goes wrong with the two-way fixed effects estimate under staggered rollout? A non-specialist needs one plain sentence on this. The manuscript doesn't contain it, so I didn't write it.
- Which outcome does the model estimate? The section never names it, though your thesis refers to repeat purchase.
- How are the post-rollout and treatment indicators defined when stores start on different dates? Is the post-rollout indicator store-specific? Does the treatment indicator mean ever-treated or currently treated?
- Is a citation for the Callaway and Sant'Anna estimator supplied elsewhere in the manuscript? It is named here without one, and I added none.