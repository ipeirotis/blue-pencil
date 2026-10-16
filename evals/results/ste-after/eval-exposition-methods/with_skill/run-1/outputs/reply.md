## Diagnosis

Assumed context: none. `AGENTS.md` supplies all four fields: audience is quantitative marketing researchers, stage is `first draft`, venue is Journal of Marketing Research, and the core thesis is the staggered-rollout identification claim. The section is a single methods paragraph, labelled [P1].

Voice tics: first-person plural ("We estimate", "we report"); short declarative sentences that name the specification piece by piece; spelled-out "two-way fixed effects" and "Callaway and Sant'Anna"; serial commas; the author's own terms of art ("coefficient of interest", "never-treated", "not-yet-treated").

Reader map: starts with [a quantitative marketing researcher who knows two-way fixed effects and clustering but not staggered-adoption estimators]; must learn [the staggered rollout supplies the control stores, and a second estimator is reported because treatment timing differs across stores]; should leave with [how the effect is identified and why two estimators appear].

Jargon to unpack [P1]: "never-treated" and "not-yet-treated" stores; "heterogeneity in treatment timing", which has no visible link to the rollout; "staggered", which this paragraph never names.

Buried lede [P1]: the rollout dates differ across stores, and that is where the control stores come from. The paragraph states it in its last sentence, after the model machinery.

Concrete anchor [P1]: the stores' different rollout dates, which are already in the paragraph.

1. [P1] Machinery before motive. The model, controls, and coefficient arrive before the reader learns the design that makes the comparison possible. Sentences 1 to 3 read as a specification list.
2. [P1] Definition debt. "Never-treated" and "not-yet-treated" are used without a plain statement of what separates the two kinds of control store, and the rollout is never named as staggered.
3. [P1] One topic per sentence. The 43-word final sentence carries the reason for the rollout, the choice of controls, and the second estimator.
4. [P1] Word sense. "Controls" means control stores in the last sentence and covariates in sentence 2.
5. [P1] Compressed inference. A reader new to staggered designs cannot tell why different treatment dates call for a second estimator next to two-way fixed effects. The manuscript does not say, so this goes to Author questions.
6. [P1] The "coefficient of interest" is not tied to any outcome or interpretation, and the two indicators are undefined for a staggered setting. The material is absent, so this goes to Author questions.

## Revised text

```
The loyalty program was rolled out to stores on different dates (a staggered rollout). We therefore use two kinds of control stores: never-treated stores, which never received the program, and not-yet-treated stores, which had not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

Added bridges: None.

## Change rationale

Word count: ~90 to ~110 (+20%).
The paragraph grew because it now labels the staggered rollout and glosses the two kinds of control store. Both additions answer the non-specialist request and use only the paragraph's own material.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped: precision-budget.md, because this is a methods paragraph, not an abstract, introduction, or contribution paragraph, and no hedge was added or removed. cold-read.md and consistency-checks.md belong to other dispatches. Altitude: the machinery already sits in its home section, so nothing was relocated.

- "Because the loyalty program was rolled out to stores on different dates" (end of sentence 4) → its own opening sentence, with "(a staggered rollout)" added. This puts the question before the machinery, brings the buried lede forward, and names the design at first use.
- "we use the never-treated and not-yet-treated stores as controls" → "We therefore use two kinds of control stores: never-treated stores, which never received the program, and not-yet-treated stores, which had not yet received it." This defines both terms at first use. "Therefore" keeps the author's "because" link, so the rollout dates hand the control group to the next sentence.
- "as controls" → "control stores". The word now has one sense, because "controls for foot traffic" keeps the covariate sense.
- "and we report the Callaway and Sant'Anna estimator ..." → a separate final sentence. Each sentence now has one topic, and the paragraph ends on "treatment timing", which echoes the opening rollout dates.
- "Because ... different dates" repeated before the final clause → not repeated. The reason is stated once, as the say-it-once rule requires.
- Sentences 2 and 3 are unchanged; the model, covariate, and coefficient sentences have no safe improvement available. Sentence 1 changed only in position.
- Nothing was deleted. No number, statistic, or citation was touched, and the order of the estimators' names is preserved.

## Author questions

- Is "staggered rollout" the term the paper uses elsewhere for this design, and is it defined earlier in the manuscript?
- Are my glosses right: "never received the program" for never-treated and "had not yet received it" for not-yet-treated? Is "not yet" measured against each treated store's treatment date, or against each week?
- Do both estimators (two-way fixed effects and Callaway and Sant'Anna) use the never-treated and not-yet-treated stores as controls? The original sentence left this open, and my reordering places the control sentence before both.
- Can you add one sentence on why different treatment dates call for a second estimator next to two-way fixed effects? A reader new to staggered designs cannot infer this, and I cannot supply it without asserting methodology the manuscript does not contain.
- Should the paragraph name the outcome (repeat purchase, per your core thesis) and say that the interaction coefficient is the estimated effect of the program on that outcome? Neither is in the paragraph now.
- Should the post-rollout indicator and the treatment indicator be defined in one clause each? Is the post-rollout indicator store-specific, taking the value 1 after that store's own rollout date?
- Is Callaway and Sant'Anna cited elsewhere in the paper? I added no citation.
- I changed "controls" to "control stores" in the second sentence so it does not collide with "controls for foot traffic". Do you want both uses to keep the single word "controls"?