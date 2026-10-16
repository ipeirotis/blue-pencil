## Diagnosis

Assumed context: none. The dispatch and `AGENTS.md` supply all four fields (audience: quantitative marketing researchers; revision_stage: first draft; target_venue: Journal of Marketing Research; core_thesis: staggered rollout of a loyalty program identifies the effect on repeat purchase without a clean control group). The thesis-dependent check is limited to this paragraph's local job, because the unit is one Methods paragraph.

Voice tics: first-person plural "we" with active verbs; short declarative sentences; "alongside" and "to address" as the author's own connectives; terms of art kept in full ("two-way fixed effects", "Callaway and Sant'Anna estimator"); no hedging.

Reader map: starts as a trained marketing-methods reader who knows fixed effects but not staggered-adoption estimators. The reader must learn that rollout on different dates is why this design uses particular control stores and a second estimator. They should leave understanding that the two-way fixed effects estimate is reported next to the Callaway and Sant'Anna estimate because treatment timing varies.

Jargon to unpack [P1]: "never-treated" and "not-yet-treated" stores (glossed from the author's own terms). "Heterogeneity in treatment timing" cannot be unpacked from the manuscript, so it goes to Author questions.

Buried lede [P1]: the staggered rollout. It appears in the fourth sentence, after the model, controls, and coefficient.

Concrete anchor [P1]: the loyalty-program rollout to stores on different dates, already in the paragraph. It becomes the opening and carries the control-group definitions.

1. [P1] Machinery before motive. The reader meets the fixed-effects specification, the covariates, and the coefficient before learning that rollout dates differ. Fix: open with the rollout, using only the author's own fact.
2. [P1] Definition debt. "Never-treated" and "not-yet-treated" are used as controls with no statement of who they are. Fix: gloss each from the author's own terms.
3. [P1] One word, two senses. "Controls" means control stores in sentence 4 and covariates in sentence 2. Fix: "control stores" for the stores; "controls for" stays for covariates.
4. [P1] Compressed inference. The paragraph never says why staggered timing creates a problem for the two-way fixed effects estimate, or what the Callaway and Sant'Anna estimator does differently. That bridge is not on the page, so I did not write it (see Author questions).
5. [P1] The "coefficient of interest" is named without saying what it measures or which outcome it is for. The outcome is not stated in the paragraph, so this goes to Author questions.
6. [P1] One topic per sentence. The final sentence packs the rollout reason, the control-group choice, the second estimator, and its purpose. Fix: split these across sentences.
7. [P1] Payoff. The paragraph ends mid-procedure. Fix: end on the author's own purpose clause, with the Callaway and Sant'Anna sentence last.

## Revised text

```
The loyalty program was rolled out to stores on different dates. At a given date, some stores had not yet received the program, and others never did; we use both groups as control stores. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate, to address heterogeneity in treatment timing.
```

Added bridges: None.

## Change rationale

Word count: ~90 to ~100 (+11%). The growth comes from two short glosses on the control groups and the split of the old final sentence. Each addition restates the author's own terms and adds no new claim.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped: precision-budget.md (not an abstract, introduction, or contribution paragraph, and no hedge was added or removed in the high-cost zone). cold-read.md and consistency-checks.md drive whole-paper passes and are not part of this per-section sweep.

- The "Because the loyalty program was rolled out to stores on different dates" clause moved to the opening as its own sentence. This puts the buried lede first.
- "we use the never-treated and not-yet-treated stores as controls" became "At a given date, some stores had not yet received the program, and others never did; we use both groups as control stores." This defines the two terms from the author's wording and gives "controls" a single sense (stores).
- The model, covariates, and coefficient sentences are kept verbatim and in order. They were fine, so the original wording stays.
- The old four-part final sentence is now separate sentences for the control stores and for the Callaway and Sant'Anna estimator.
- The causal "because" link from rollout dates to the choice of control stores is now carried by adjacency. This is a logged loss, and Author questions asks whether the "because" should return.
- The Callaway and Sant'Anna sentence keeps its original words and now closes the paragraph, so it ends on its purpose and not on procedure.
- No numbers, statistics, or citations appear in the passage, and none were changed. Terms of art and the estimator name are unchanged.

## Author questions

- Your paragraph never says why staggered rollout is a problem for the two-way fixed effects estimate. Do you want one sentence stating that problem, in your own words, so a reader new to staggered designs sees why the second estimator is needed?
- The paragraph does not say what the Callaway and Sant'Anna estimator does differently, and it carries no citation. Should a one-line description and the reference go here, or do they live elsewhere in the manuscript?
- Does the coefficient on the interaction measure the loyalty program's effect on repeat purchase? The outcome variable is not named in this paragraph. Would you like it stated at "The coefficient of interest"?
- How are the "post-rollout indicator" and the "treatment indicator" defined under staggered timing (for example, is the post indicator store-specific, and does the treatment indicator mark ever-treated stores)? A reader outside staggered designs will need this, and I could not supply it from the text.
- Does my gloss match your definitions: "not-yet-treated" as stores that had not yet received the program at a given date, and "never-treated" as stores that never receive it?
- Is the never-treated and not-yet-treated control group used for both estimators, or only for the Callaway and Sant'Anna estimator? Your original sentence could be read either way, and the revision keeps that ambiguity.
- Should the causal "Because ... different dates" link between the rollout and the choice of control stores return as an explicit connective? I replaced it with sentence adjacency.
- Is "control stores" (for the comparison stores) acceptable next to "controls" for the covariates elsewhere in the manuscript, or do you prefer another term for the stores?