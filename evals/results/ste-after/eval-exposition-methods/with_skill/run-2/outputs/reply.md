## 1. Diagnosis

Assumed context: none. `AGENTS.md` supplies all four fields. I read the audience (quantitative marketing researchers) as trained in causal inference but not in staggered designs, as your request states. The stage is first draft, so reordering within the paragraph is allowed.

Reader map: the reader knows fixed effects and clustering but not staggered-design vocabulary. They need to learn that stores got the program on different dates and that this explains the choice of controls and the second estimator. They should also leave knowing that the coefficient of interest is the interaction term.

1. **Structure:** The model comes first and the design fact that motivates the controls and second estimator comes last. Reordering fixes this.
2. **Jargon:** "Never-treated", "not-yet-treated" and "heterogeneity in treatment timing" are used without a plain meaning. Each can be glossed from its own name and your "different dates".
3. **Jargon:** The two indicators are named but not described. Each gets a short gloss from its name.
4. **Missing reason:** The paragraph never says what goes wrong with a two-way fixed effects estimate when rollout dates differ. That is the reason for the Callaway and Sant'Anna estimator. The manuscript doesn't say it, so the reviser did not supply it (see Author questions).
5. **One word, two senses:** "Controls" means covariates in sentence two and comparison stores in sentence four. I kept "controls" for the stores and reworded the covariate sentence.
6. **Overloaded sentence:** Sentence four held three topics. It is now split.

## 2. Revised text

```
The loyalty program was rolled out to stores on different dates, so we use the never-treated stores (stores that never received the program) and the not-yet-treated stores (stores that had not yet received it) as controls. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The coefficient of interest is the interaction between the post-rollout indicator (weeks after rollout) and the treatment indicator (stores that received the program). The specification also adjusts for foot traffic, local unemployment, and promotional intensity. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing, meaning that stores entered treatment on different dates.
```

## 3. Change rationale

The paragraph grows from about 100 to about 120 words (+20%) because of the inline glosses. Each gloss restates a term from your own wording.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped: precision-budget.md, because this is a Methods paragraph and no hedge was added or removed.

- **Order:** The rollout dates now open the paragraph, followed by the controls and then the model. The reader learns why the controls and estimators are chosen before the specification appears.
- **Control stores:** "Never-treated" and "not-yet-treated" are glossed inline, using only the terms' own meanings.
- **Indicators:** I added "(weeks after rollout)" and "(stores that received the program)", taken from the variable names.
- **"Controls" vs. "adjusts for":** "Controls" now means only the comparison stores.
- **Estimator sentence:** It is split out, with "meaning that stores entered treatment on different dates" trailing so the gloss doesn't interrupt the core.
- **"Because… we use" → "was rolled out… so we use":** Your causal link is kept, with the cause moved to the opening slot.
- **Kept verbatim:** the estimator names, "two-way fixed effects", the clustering statement and the covariate list. The paragraph contains no numbers, statistics or citations, and none were added or changed.

## 4. Author questions

- Does the post-rollout indicator equal one from each store's own rollout date, and does the treatment indicator mark every store that eventually receives the program? The glosses follow the names, so correct them if the definitions differ.
- Do the never-treated and not-yet-treated controls apply to both the two-way fixed effects estimate and the Callaway and Sant'Anna estimate, or only the latter? Your original is ambiguous, and the reordering could make readers assume both. The ambiguity was preserved.
- What goes wrong in a two-way fixed effects estimate when stores get the program on different dates? A non-specialist needs this reason, and the manuscript doesn't state it. Do you want to add it in your own words?
- The outcome (repeat purchase) isn't named in this paragraph. Is it defined earlier, or should one clause here name it?
- The Callaway and Sant'Anna estimator has no citation here. Is it cited elsewhere, or should one be added? None was added.
- Is there a worked example in the paper, such as one store's timeline or a rollout figure, that this paragraph could point to?