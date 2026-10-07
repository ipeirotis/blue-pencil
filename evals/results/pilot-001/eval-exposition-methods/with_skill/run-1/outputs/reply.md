## Diagnosis

Assumed context: none. The paper context supplies audience, revision stage (`first draft`), target venue and core thesis, so nothing is assumed.

Voice tics: first-person plural ("we") with plain declaratives; spelled-out "two-way fixed effects" used consistently; serial-comma lists; no inline citation commands; "Callaway and Sant'Anna estimator" named without a citation.

Reader map: starts with a trained quantitative marketing reader who knows fixed effects and difference-in-differences but not staggered-adoption estimators; must learn that rollout dates differ and that this shapes which stores serve as controls and why a second estimator is reported; should leave with the point that the two-way fixed effects estimate is complemented by an estimator built for staggered timing.

Jargon to unpack: "never-treated" and "not-yet-treated" stores, and "staggered" (the word is never introduced). "Heterogeneity in treatment timing" is left as the author's term, tied to the rollout dates.

Buried lede: the staggered rollout, the fact that drives every design choice in the paragraph, appears only in the fourth sentence, after the specification.

Concrete anchor: the author's own fact that the program "was rolled out to stores on different dates".

1. [P1] Machinery before motive. The paragraph gives the specification, controls and coefficient before saying why the design is unusual. The rollout fact that motivates the second estimator arrives last. Fix: lead with the rollout.
2. [P1] Definition debt. "Never-treated" and "not-yet-treated" are used with no gloss. A reader outside staggered designs cannot tell who the controls are. Fix: gloss each from the manuscript's own meaning.
3. [P1] Overloaded "controls". The word means control variables in sentence 2 and control stores in sentence 4. Fix: "control stores" for the second.
4. [P1] Overloaded final sentence. It carries a causal "because", a control-group choice, a second estimator and a purpose clause. Fix: split into two sentences, one for the controls and one for the second estimator.
5. [P1] Undefined indicators. "Post-rollout" and "treatment" indicators are named without saying how they work when stores start on different dates. The manuscript lacks the material, so this goes to `Author questions`.
6. [P1] Missing bridge. The paragraph never says why two-way fixed effects alone is a problem under staggered timing. That is new substance, so it goes to `Author questions`.
7. [P1] Sentence level. "Because the loyalty program was rolled out ... we use ..." is a subordinate-clause preamble before the core. Fix: front the core.

## Revised text

```
The loyalty program was rolled out to stores on different dates, a staggered rollout. We estimate a two-way fixed effects model with store and week fixed effects and standard errors clustered at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. Its coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. Because the rollout dates differ, we use never-treated stores (those that never receive the program) and not-yet-treated stores (those that have not received it yet) as control stores. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing across stores.
```

Added bridges: None.

## Change rationale

Word count: ~100 to ~125 (+25%). The growth comes from the opening rollout sentence and the two glosses, which restore the staggered-design context a non-specialist needs. The paragraph is not otherwise padded.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Two of these ran as checks only:
- precision-budget.md: this is a Methods paragraph, not the high-cost zone, and the hedge-lexicon census found no hits.
- altitude.md: the machinery is already in its home section, so nothing moved.

- (new opening sentence) -> "The loyalty program was rolled out to stores on different dates, a staggered rollout.", moves the author's own rollout fact to the front so the question precedes the machinery, and names "staggered" at first use.
- "clustering standard errors at the store level" -> "and standard errors clustered at the store level", parallel noun phrase that keeps the sentence core unbroken.
- "Because the loyalty program was rolled out to stores on different dates, we use ..." -> "Because the rollout dates differ, we use ...", the long causal clause is now shorter because the fact was already stated up front.
- "never-treated and not-yet-treated stores" -> "never-treated stores (those that never receive the program) and not-yet-treated stores (those that have not received it yet)", defines both terms at first serious use, using only the terms' own meaning.
- "as controls" -> "as control stores", separates control stores from the control variables in the previous sentences.
- "The coefficient of interest is the interaction ..." -> "Its coefficient of interest is the interaction ...", given-new link to the specification sentence before it, so the coefficient reads as belonging to the model just described.
- one overloaded final sentence -> two sentences, so the control-group choice and the second estimator each get their own sentence (one new object at a time).
- "heterogeneity in treatment timing" -> "heterogeneity in treatment timing across stores", ties the author's term back to the differing rollout dates and ends the paragraph on that point.
- Restraint: "The specification includes controls for foot traffic, local unemployment, and promotional intensity" is unchanged, as it already passes every check. The citation-free "Callaway and Sant'Anna estimator" is unchanged.
- No numbers, statistics or citations appear in the passage, so none were changed.

## Author questions

- The paragraph never names the outcome. Should it state that the outcome is repeat purchase, so the coefficient of interest has an object?
- How are the post-rollout and treatment indicators defined when stores start at different dates (for example, is "post" store-specific, and is "treatment" ever-treated or currently treated)? A one-clause definition would let a non-specialist follow the specification.
- Do the never-treated and not-yet-treated control stores feed the Callaway and Sant'Anna estimator, the two-way fixed effects model, or both? I kept your original attachment, which does not say.
- Does your sample contain never-treated stores at all? The core thesis refers to the absence of a clean control group.
- For readers new to staggered designs, should the paragraph say in one sentence why two-way fixed effects alone is a concern under staggered timing, and what the Callaway and Sant'Anna estimator does differently? That substance is not in the manuscript, so I did not write it.
- Does "heterogeneity in treatment timing" mean variation in the effect across rollout cohorts, or only variation in when stores are treated? I left your term as written.
- Should the Callaway and Sant'Anna estimator carry a citation here? None appears in the passage, and I added none.
- Do you confirm the two plain-language glosses of "never-treated" and "not-yet-treated" and the "a staggered rollout" label match your intended meaning?