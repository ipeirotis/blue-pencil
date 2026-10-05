### 1. Diagnosis

Assumed context: none. Audience, revision stage (first draft), target venue, and core thesis all come from `AGENTS.md`.

**Voice tics:** first-person "we" with plain declaratives. Lists of three with the serial comma. Full technical terms with no abbreviations. "Alongside" for pairing estimators. No hedges.

**Reader map:** The reader is a trained marketing-methods reader who knows two-way fixed effects (TWFE) but not staggered-adoption estimators. They need to learn that stores got the program on different dates. That fact is why the paragraph uses two kinds of control stores and a second estimator. They should leave with that reason, and with what the coefficient of interest is.

**Jargon to unpack:** "never-treated", "not-yet-treated", and "heterogeneity in treatment timing". Each is used before its meaning is stated.

**Buried lede:** The staggered rollout explains the control-store choice and the second estimator. It only appears in the middle of the final sentence.

**Concrete anchor:** The rollout of the loyalty program to stores on different dates, which is already in the paragraph.

1. **[Paragraph, sentence 4] Machinery before motive.** The reason for the design arrives after the model, the covariates, and the coefficient. Until then, "post-rollout indicator" and "treatment indicator" have no visible referent.
2. **[Sentence 4] Compressed inference.** One sentence stacks two undefined control groups, a named estimator, and "heterogeneity in treatment timing". Nothing says what the second estimator is for.
3. **[Sentences 2 and 4] "Controls" means two things.** It names covariates in one sentence and comparison stores in another.
4. **[Sentence 4] Weak ending.** The sentence ends on a purpose clause, so the payoff sits in the weakest position and the paragraph closes on procedure.
5. **[Sentence 3] Undefined indicator.** The manuscript does not say how the post-rollout indicator is defined when stores start on different dates. Routed to Author questions.
6. **[Sentence 4] Missing motivation.** The manuscript does not say why TWFE alone is inadequate under staggered timing. Supplying it would be new substance. Routed to Author questions.

### 2. Revised text

```
The loyalty program was rolled out to stores on different dates, so treatment timing is staggered. We therefore use as control stores the never-treated stores, which never receive the program, and the not-yet-treated stores, which have not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

Added bridges: None.

### 3. Change rationale

Word count: ~90 to ~110 (+22%). The rewrite is longer because it defines the two control groups and "staggered" at first use.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. precision-budget.md was skipped because this is a methods paragraph, not an abstract, introduction, or contribution paragraph, and no hedge was added or removed.

- **Fronted the rollout sentence.** It is now sentence 1, moved from the middle of the original last sentence. The motive now comes before the machinery, and "post-rollout" and "treatment" have a referent.
- **Defined the two control groups.** "the never-treated and not-yet-treated stores as controls" became "as control stores the never-treated stores, which never receive the program, and the not-yet-treated stores, which have not yet received it". Each term is defined at first use, in the author's own wording.
- **"controls" became "control stores".** This separates the comparison stores from the covariate controls in the specification sentence.
- **Placed the control-store sentence right after the rollout sentence.** The cause and its first consequence sit together, so the order runs rollout, controls, model, coefficient.
- **Split the final 43-word sentence.** The staggered-timing idea and the estimator pairing no longer share a sentence. The pairing of Callaway and Sant'Anna with TWFE now sits in the stress position.
- **Moved the purpose clause to the front.** "To address heterogeneity in treatment timing, we report ..." now echoes the opening sentence's "treatment timing is staggered".
- **Dropped "Because" and "and" from the original sentence 4.** "So" and "therefore" carry the causal link, with no change in meaning.
- **Left the three model sentences verbatim** (original sentences 1 to 3). They clear the restraint checks and already carry the TWFE audience.
- **No numbers, statistics, or citations** appear in the paragraph, and none were changed. No em-dashes were introduced. "Heterogeneity in treatment timing" was kept as written.

### 4. Author questions

- Do the glosses "never receive the program" and "have not yet received it" match how you code never-treated and not-yet-treated stores? They are the reviser's reading of the standard terms.
- Does "we therefore use ... as control stores" apply to both the TWFE estimate and the Callaway and Sant'Anna estimate, or only to the latter? The original leaves this open, so the revision does not resolve it.
- How is the post-rollout indicator defined when stores start on different dates (store-specific start date, or a single date)? A reader unfamiliar with staggered designs will ask, and the paragraph does not say.
- Can you add one sentence of your own on why the TWFE estimate alone is not enough under staggered timing? That would motivate "heterogeneity in treatment timing" for non-specialists. The reviser did not write it, because it would assert a mechanism the manuscript does not contain.
- Do you want to add one sentence of your own on how the Callaway and Sant'Anna estimator uses the control stores, as another bridge for non-specialists?
- The paragraph does not name the outcome (the core thesis mentions repeat purchase). Should it be stated here, or is it defined earlier in the paper?
- "Callaway and Sant'Anna estimator" appears with no citation in this paragraph. Is it cited where the estimator is first introduced, or should a citation be added here? None was added.