**Diagnosis**

Assumed context: none. `audience`, `revision_stage` (first draft), `target_venue` and `core_thesis` are all present in `AGENTS.md`. I read "someone who does not already work with staggered designs" as a quantitative marketing researcher who knows regression and fixed effects but not staggered-adoption estimators.

Voice tics to preserve:
- First-person plural, active verbs ("we estimate", "we use", "we report").
- Plain declarative sentences with no hedging.
- Specification-list order: model, controls, coefficient, control group, robustness estimator.
- Hyphenated compounds ("never-treated", "not-yet-treated", "post-rollout").
- No citation years or parentheticals.

Findings:
1. **Machinery before motive (S4).** The paragraph opens with the two-way fixed effects specification. The reason it needs care, the staggered rollout, appears only in sentence 4.
2. **Definition debt (S4).** "Never-treated" and "not-yet-treated" are used as terms of art. "Staggered" is never named, though it describes the design.
3. **Two topics in one sentence (S4).** The control-group choice and the second estimator share a roughly 40-word sentence behind a "Because" preamble.
4. **Compressed inference (S4).** The paragraph doesn't say why different dates call for these controls. It also doesn't say what "heterogeneity in treatment timing" does to the two-way estimate. The manuscript doesn't contain this, so it goes to the author questions.
5. **Terminology risk (S3).** "Post-rollout indicator" is ambiguous when rollout dates differ by store. I left it unchanged and flagged it.
6. **Restraint (S1–S3).** The model, controls, and coefficient sentences parse in one pass and were kept verbatim.

**Revised text**

```
The loyalty program was rolled out to stores on different dates, so treatment timing is staggered. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. Because of the staggered timing, we use the never-treated and not-yet-treated stores as controls: stores that never received the program and stores that had not yet received it on a given date. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

**Change rationale**

Word count: about 90 to about 120 (+33%). The growth comes from two additions built from your own words: an opening sentence naming the staggered rollout, and a gloss of the two control groups.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped: precision-budget.md, because it applies to abstracts, introductions and contribution paragraphs, and this is a Methods paragraph with no hedge edits.

Changes:
- **Added an opening sentence** ("The loyalty program was rolled out to stores on different dates, so treatment timing is staggered."). The buried fact now comes first, and "staggered" is defined at first use.
- **Shortened the "Because" clause** to "Because of the staggered timing, we use…". It no longer repeats the rollout clause.
- **Added a gloss after the colon** for both control groups, reading your compound terms literally.
- **Split the long sentence 4** so the "report the Callaway and Sant'Anna estimator" clause stands as its own sentence.
- **Left sentences 1–3 unchanged** (model, controls, coefficient).
- **Cut nothing.**

Protected content: no number, statistic or citation was changed. "Callaway and Sant'Anna" keeps its position and form.

**Author questions**

- Do the glosses "stores that never received the program" and "stores that had not yet received it on a given date" match how your data define never-treated and not-yet-treated stores?
- Does "post-rollout indicator" mean after each store's own rollout date, or after the first rollout date? Is "treatment indicator" an ever-treated flag? With staggered dates a non-specialist can't tell, so I left the wording alone.
- Can you add one sentence on why staggered timing makes a two-way fixed effects estimate hard to read, and what the Callaway and Sant'Anna estimator changes? The manuscript doesn't say, and a reader new to staggered designs needs it to see why both estimates are reported.
- In "heterogeneity in treatment timing", do you mean that effects differ by adoption date, or only that adoption dates differ across stores? These are different claims, so I kept your wording.
- Should the paragraph tie the control-group choice to your core thesis, that the rollout lets you estimate the effect on repeat purchase without a clean control group? It currently ends on procedure.
- Should "Callaway and Sant'Anna" carry a citation here? I added none.