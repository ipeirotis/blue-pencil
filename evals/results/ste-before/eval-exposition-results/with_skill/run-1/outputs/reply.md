## 1. Diagnosis

**Assumed context:** none. Venue, audience, stage and thesis all come from `AGENTS.md`.

**Voice tics I preserved:** plain declaratives with no first-person subject, the template "The coefficient on X is N (SE = n) in column k", parenthetical SEs, column-by-column reporting, and "R-squared" spelled out.

**Reader map:** the reader is a trained empirical IS researcher who knows fixed-effects regressions but not your specification. They should leave knowing that the identity-disclosed coefficient is positive, survives product fixed effects and varies with reviewer tenure. They should also see that the star-rating coefficient is stable.

**Jargon:** none needs unpacking for this audience.

**Buried lede:** the identity coefficient holds up (0.18 to 0.15) once product fixed effects are added. In your draft it sat in sentences two and three, behind a table announcement.

**Concrete anchor:** none beyond the estimates. The outcome variable is never named (see questions).

1. The paragraph opens with "Table 3 reports the estimates", which announces the table instead of making a claim.
2. The statistics are a flat list of equal weight. The turn the numbers already contain, that the identity coefficient stays large after product fixed effects, is buried.
3. The star-rating sentence has no contrast signal. Readers can't tell it is the comparator, and your thesis (identity matters alongside rating) depends on that contrast.
4. The paragraph ends on significance levels, a procedural detail. The R-squared gain should sit in the closing position.
5. The outcome variable is not named, so the reader can't say what the coefficients measure. This goes to the questions, not into the text.
6. Altitude is right. The machinery belongs in Results, so nothing moves.
7. The 1% versus 5% significance split looks inconsistent with the coefficient-to-SE ratios (see questions). This is a question, not an edit.

## 2. Revised text

```
In Table 3, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2 and remains 0.15 (SE = 0.05) in column 3, after adding product fixed effects. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. By comparison, the coefficient on star rating is 0.42 (SE = 0.02) across all specifications. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level. R-squared rises from 0.31 to 0.47 across the columns.
```

## 3. Change rationale

**Word count:** about 100 to about 100 (0%).

**References loaded:** principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. precision-budget.md was read only to confirm its gate. The unit is a results paragraph with no hedge in the high-cost zone, so that pass was skipped and no hedge census was run. cold-read.md and consistency-checks.md are not part of the per-section sweep.

- **Opening:** "Table 3 reports the estimates. The coefficient…" became "In Table 3, the coefficient…". The paragraph now opens on the finding. The Table 3 callout stays, and only the throat-clearing sentence is gone.
- **Joined sentences:** columns 2 and 3 now share one sentence, with "remains 0.15… after adding product fixed effects". The identity coefficient and its survival sit together in the stress position. "Remains" adds no claim beyond your own "after adding".
- **Contrast:** "By comparison" now opens the star-rating sentence, so it reads as the comparator.
- **Order:** identity and tenure results are grouped, the significance sentence follows the coefficients it describes, and the paragraph ends on the fit gain.
- **Kept verbatim:** the significance and R-squared sentences, and all terminology (identity-disclosed, reviewer tenure, R-squared, SE).
- **Declined:** "falls only to", "survives", "adds" and any causal verb. They would assert interpretation your text doesn't state, and the outcome is unnamed.
- **Numbers:** every figure (0.18, 0.04, 0.15, 0.05, 0.09, 0.03, 0.42, 0.02, 0.31, 0.47, 1%, 5%), the column numbers and the Table 3 reference are unchanged. They were moved between sentences, not edited.

## 4. Author questions

- Do the moves keep each callout and significance statement attached to the right estimate? The significance sentence now follows the interaction, and "Table 3" moved into the first sentence.
- Which outcome do these estimates describe? Your thesis is about how much a review moves sales, but the paragraph never says. Should the first sentence name it?
- The interaction (0.09, SE = 0.03) is reported at the 5% level, but the column 3 identity coefficient (0.15, SE = 0.05) is reported at 1%. Both have a coefficient-to-SE ratio of 3.0. Is the 5% level correct, or is a different test or clustering involved?
- Is "the interaction with reviewer tenure" the identity-disclosed indicator interacted with tenure? If so, should the text say so, and is the tenure main effect reported in column 4?
- Is the star-rating coefficient identical in every column, including column 1, which this paragraph doesn't discuss?
- Which columns bound the R-squared range (0.31 to 0.47), and is the rise monotonic?
- "Remains" and "By comparison" are the only interpretive signals I added. Do they match what you intend to claim?
- Do you want a closing sentence tying the identity result to your thesis, or does that belong in the Discussion? I can't write it from the Results text alone.