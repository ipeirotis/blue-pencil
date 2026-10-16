### 1. Diagnosis

**Assumed context:** none. Audience, stage (first draft), venue and thesis all come from `AGENTS.md`.

- **Voice to keep:** first-person "we", plain declaratives, hyphenated group names ("never-treated", "not-yet-treated", "post-rollout"), serial commas, and "alongside" for paired estimates.
- **Reader:** a quantitative marketing researcher who knows regression and fixed effects but not staggered-adoption designs.
- **Jargon to unpack:** "staggered rollout", "heterogeneity in treatment timing", "never-treated" and "not-yet-treated".
- **Buried lede:** stores got the program on different dates. This appears mid-way through sentence 4, after the model and controls, yet it explains both the choice of control group and the second estimator.

Problems found:
1. **Machinery before motive.** The model and coefficient come before the design fact that motivates them.
2. **Definition debt.** "Never-treated" and "not-yet-treated" are used without saying who is in each group, and "staggered" is never named.
3. **Overloaded sentence 4.** It carries three topics: why the controls are what they are, who is in them, and the second estimator.
4. **Abstract final clause.** "Heterogeneity in treatment timing" is not tied back to the rollout dates.
5. **Two senses of "controls".** Sentence 2 means covariates and sentence 4 means comparison stores.
6. **Thin payoff.** The paragraph ends on a procedure without saying that the second estimate responds to the timing problem.

### 2. Revised text

```
The loyalty program was rolled out to stores on different dates (a staggered rollout). We therefore use two kinds of stores as the control group: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it at a given date. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing across stores, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

### 3. Change rationale

**Length:** about 100 words became about 120 (+20%). The growth comes from plain definitions of the three design terms, built from your own wording.

**References loaded:** principles, edit-checks, structural-patterns, exposition, altitude, narrative-spine, reader-pleasure, sentence-patterns, subtraction, ai-tells-to-avoid, copyediting. **Skipped:** precision-budget, because this is a methods paragraph and no hedge was added or removed.

- **Rollout fact moved to the front.** It is now labeled "a staggered rollout" at first use.
- **Control stores defined.** "Never-treated" and "not-yet-treated" are defined where they first appear. "Therefore" preserves your original "Because … we use" link, and the old sentence 4 is split into separate sentences.
- **One word, one sense.** "Control group" now means comparison stores, and "controls" is kept only for covariates.
- **Estimator clause reordered.** The purpose clause now leads and ties back to the rollout dates ("across stores"). The paragraph ends on the estimator comparison, and no cause or mechanism was added.
- **Unchanged sentences.** The model sentence, the covariate sentence and the coefficient sentence are untouched.
- **Safeguards.** No number, statistic or citation was changed, and the order "Callaway and Sant'Anna", then the two-way fixed effects estimate, is preserved. No em-dashes or promotional wording were introduced.

### 4. Author questions

- Do "never-treated" stores never receive the program during your sample window, or at any time? I wrote "never receive the program" from the term's name, so please confirm it matches your definition.
- Does "not-yet-treated at a given date" match your definition, with comparisons made at each treated store's own rollout date?
- Do you want "control group" for comparison stores and "controls" for covariates, or a different split such as "comparison stores"?
- How is the post-rollout indicator defined when stores adopt on different dates? Is it a single calendar date or each store's own adoption date? A non-specialist reader will ask.
- Can you add one sentence on why the two-way fixed effects estimate is a concern under staggered timing and what the Callaway and Sant'Anna estimator does differently? I did not write this because the manuscript doesn't supply it.
- Does the treatment indicator mark ever-treated stores, so that its interaction with the post-rollout indicator is the effect on repeat purchase? The paragraph never names the outcome, and I did not supply it.