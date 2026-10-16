## Diagnosis

Assumed context: none. `audience`, `revision_stage` (first draft), `target_venue` and `core_thesis` are all in AGENTS.md. The thesis check does not apply to a methods paragraph.

**Voice tics:**
- First-person plural, plain declaratives ("We estimate", "we use", "we report").
- Terms of art left unglossed (two-way fixed effects, clustering, Callaway and Sant'Anna).
- Hyphenated compounds ("never-treated", "not-yet-treated", "post-rollout").
- Short sentences, each stating one design choice, with no hedges.

**Reader map:** The reader is a quantitative marketing researcher who knows fixed effects but not staggered-adoption designs. They need to learn why staggered timing calls for a particular control group and a second estimator. They should leave knowing that stores treated at different dates are compared with stores not yet or never treated, and that the Callaway and Sant'Anna estimator is reported next to the two-way fixed effects estimate for that reason.

**Issues found:**
1. **Machinery before motive (sentences 1–4).** The specification comes first and the staggered rollout that motivates the design comes last. The fix is to lead with the rollout fact.
2. **Compressed inference (sentence 4).** The text skips from "different dates" to "no shared before-and-after period" to "need stores untreated at each date." The step is restored from your own premise and flagged as an added bridge.
3. **Definition debt (sentence 4).** "Never-treated" and "not-yet-treated" are named but not described.
4. **Overloaded sentence (sentence 4).** One sentence carries the rollout reason, the control rule, the second estimator and its purpose. It is split.
5. **Terminology.** "Controls" names covariates in sentence 2 and comparison stores in sentence 4.
6. **Interrupted clause.** A long "Because…" preamble comes before the core of the control-group sentence.
7. **Altitude.** The machinery is already in its home section. There are no hedges, em-dashes or promotional adjectives.

## Revised text

```
The loyalty program was rolled out to stores on different dates, so no single date separates before from after. We therefore use as control stores those that have not yet received the program (not-yet-treated) and those that never receive it (never-treated). We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The model also controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing across stores, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

Added bridge: "so no single date separates before from after."

## Change rationale

Word count: about 95 to about 110 (+15%). The growth comes from the opening bridge and the two glosses. Nothing in the original was cut.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped by gate: precision-budget.md (not an abstract, introduction or contribution paragraph, and no hedge added or removed), reader-pleasure.md (single methods paragraph, no enjoyment request).

- **Rollout sentence moved from sentence 4 to the opening.** The reader learns why the design is unusual before meeting the specification.
- **New first sentence.** It restores the inference from different dates to the need for a special control group, using only your premise.
- **Control-group clause is now its own sentence, with "(not-yet-treated)" and "(never-treated)" glossed at first use.** The core comes first instead of after a "Because" preamble.
- **"Control stores" versus "controls for foot traffic".** One word no longer names two constructs.
- **"The specification includes controls for" became "The model also controls for".** This is shorter and keeps the two meanings apart.
- **The final sentence now opens with the estimator's purpose.** "Across stores" ties it back to the opening rollout fact.
- **Specification sentences are unchanged.** They are clear and serve the expert part of the audience.
- **No change at the altitude level.** The machinery is already in its home section.

No number, statistic or citation was changed.

## Author questions

- Do the not-yet-treated and never-treated stores serve as controls for both the two-way fixed effects estimate and the Callaway and Sant'Anna estimate, or only for the latter? Your original leaves this open, and the reordered paragraph now reads as if they apply to both.
- Please confirm the added bridge, "so no single date separates before from after." Is it an accurate statement of your design?
- Does "heterogeneity in treatment timing" mean that stores were treated at different dates (as the rewrite reads it), or that the effect differs across groups treated at different times? The rewrite keeps your phrase unchanged.
- A reader new to staggered designs would benefit from one sentence on why the two-way fixed effects estimate alone is not enough when timing varies. The manuscript does not say, so can you supply it?
- What is the outcome variable (repeat purchase, per your thesis)? Should the specification sentence name it?
- Is the post-rollout indicator store-specific, switching on at each store's own start date? Should the final specification sentence say what the interaction coefficient measures, such as the program's effect? I added nothing for either.
- Does "never-treated" mean never treated within the sample window? "Never receive it" could be read more broadly.
- Should the Callaway and Sant'Anna estimator carry a citation here? None is in the text, so I added none.
- Is "week" the intended time unit for the fixed effects?