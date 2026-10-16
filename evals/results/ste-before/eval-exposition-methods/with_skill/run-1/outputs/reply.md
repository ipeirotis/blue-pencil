## Diagnosis

Assumed context: none. The `<paper_context>` block in `AGENTS.md` supplies the audience, the revision stage (`first draft`), the venue and the core thesis.

**Reader.** A trained marketing researcher who knows two-way fixed effects but not staggered-adoption designs. They need to learn that stores got the program on different dates, so the comparison stores and the second estimator are chosen to fit that.

1. **Sentences 1–4: machinery before motive.** The model, controls and coefficient come before the reader learns that rollout dates differ across stores, and that fact motivates the design. The revision leads with it.
2. **Sentence 5: undefined terms.** "Never-treated" and "not-yet-treated" are named but not defined.
3. **Sentence 5: too much in one sentence.** The rollout fact, the control choice, the second estimator and "heterogeneity in treatment timing" arrive together. The revision separates the control-store sentence from the estimator sentence.
4. **Sentence 5: "heterogeneity in treatment timing" is unglossed.** The revision ties it to the different rollout dates you already state.
5. **Sentences 2 and 5: "controls" means two things.** It names covariates in sentence 2 and comparison stores in sentence 5. The revision uses "control stores" for the latter.
6. **Sentence 5: a gap I couldn't fix.** The paragraph never says why the two-way fixed effects estimate alone isn't enough under staggered timing, or what the Callaway and Sant'Anna estimator does differently. That content isn't in your text, so it is in the questions below.

## Revised text

```
Because the loyalty program was rolled out to stores on different dates, we use two kinds of control stores: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it at the date in question. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing, that is, the different dates on which stores received the program.
```

## Change rationale

The paragraph grew from about 120 to about 140 words (+17%). Both additions restate meaning already in your wording, and no new claim is made. The original has no numbers, statistics or citations, and none were added or changed.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped: precision-budget.md, because this is a methods paragraph and no hedge was added or removed.

- **Rollout fact moved to the opening.** The reader learns why the design looks as it does before meeting the model.
- **Control-store terms defined.** Each is defined from its own meaning, at first use.
- **"Controls" became "control stores"** for the comparison stores, to avoid colliding with the covariate "controls". Flagged below.
- **Estimator sentence made standalone.** I split the original final sentence, added "We also", and kept your "alongside".
- **"Heterogeneity in treatment timing" kept**, with a gloss tying it to the different rollout dates.
- **Model, controls and coefficient sentences** are unchanged apart from position.

## Author questions

- Are my definitions right? Never-treated stores never receive the program during your sample, and not-yet-treated stores are untreated at a given date but treated later.
- Is "control stores" acceptable for the comparison stores, distinct from the covariate "controls"?
- Can you supply one sentence on why the two-way fixed effects estimate alone is insufficient when stores are treated on different dates? A reader new to staggered designs will ask this.
- Can you supply one sentence on what the Callaway and Sant'Anna estimator does differently, for example how it forms its comparisons? I added none, because the manuscript doesn't contain it.
- Does "heterogeneity in treatment timing" mean only the different rollout dates, as I glossed it? Or does it also mean the program's effect differs by when a store was treated?
- How are the post-rollout and treatment indicators defined for never-treated stores? Is the post-rollout indicator store-specific, given the differing dates?
- Do the control stores feed the two-way fixed effects estimate, the Callaway and Sant'Anna estimate, or both?