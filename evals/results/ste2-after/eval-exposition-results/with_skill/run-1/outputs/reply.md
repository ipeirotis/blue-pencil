## Diagnosis

Assumed context: none. `audience`, `revision_stage` (first draft), `target_venue`, and `core_thesis` all come from the paper context in `AGENTS.md`.

**Voice tics:**
1. The "coefficient is X (SE = Y) in column N" template.
2. Short declarative sentences.
3. "R-squared" spelled out.
4. The significance summary written as "except the interaction".
5. No hedging.

**Reader map:** The reader arrives expecting a table of coefficients and the thesis that identity matters beyond the rating. They need to learn that the identity effect survives product fixed effects and varies with tenure. They should leave with "identity adds to the rating's effect, and the result is stable".

**Buried lede:** The identity-disclosed indicator is positive and significant with the star rating in the model. The paragraph opens with "Table 3 reports the estimates" and never says this.

**Concrete anchor:** The 0.18 to 0.15 move after product fixed effects, set against the stable 0.42 for star rating.

1. **Figure-driven opener.** "Table 3 reports the estimates" announces the table instead of the finding, so the reader has no question to hold while reading the numbers.
2. **Flat list.** Five coefficients and R-squared all carry equal weight. The "but" your numbers support is that the identity coefficient moves when product fixed effects enter (0.18 to 0.15) and stays significant. The draft reports the two values in separate sentences, which hides that.
3. **Topic string.** The sentences run identity, identity, tenure interaction, star rating, R-squared, significance, so the reader reorients each time. Sentences 2 and 3 repeat the same template, which gives uniform rhythm.
4. **Stress position.** The paragraph ends on significance bookkeeping, not a payoff.
5. **Referent.** "The interaction with reviewer tenure" doesn't say which variable interacts with tenure. The identity-disclosed indicator is implied only by adjacency.
6. **Missing outcome.** The dependent variable is never named, so the coefficients read as unanchored numbers.
7. **Altitude and precision.** SEs and significance levels belong in Results, so nothing was relocated. There are no hedges, so none were added or removed.

## Revised text

```
With the star rating in the model, the identity-disclosed indicator is positive and significant (Table 3). The coefficient on the indicator is 0.18 (SE = 0.04) in column 2 and holds at 0.15 (SE = 0.05) in column 3 after product fixed effects are added. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across all specifications. All coefficients are significant at the 1% level except this interaction, which is significant at the 5% level. R-squared rises from 0.31 to 0.47 across the columns.
```

## Change rationale

Word count: about 100 to about 105 (+5%). The growth is the new opening sentence.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped: precision-budget.md, because its gate (abstract, introduction, contribution paragraph, or a hedge edit in the high-cost zone) isn't met. Altitude pass: no change.

- **Opener.** "Table 3 reports the estimates." became "With the star rating in the model, the identity-disclosed indicator is positive and significant (Table 3)." This puts the lede first, replaces an announced table with a claim, and keeps the table callout.
- **Merged identity sentences.** The two identity-coefficient sentences are now one, so the "but" (the value moves, the result survives) is visible. "Holds" rests on your own 1% statement for all coefficients except the interaction.
- **Reordering.** The interaction sentence now follows the identity sentence, and the star-rating sentence follows it as the stable benchmark. This puts the interaction next to its implied referent.
- **"This interaction".** "Except the interaction" became "except this interaction", to fix the referent after the reordering.
- **Ending.** The paragraph still ends on the short R-squared sentence, so it closes on model fit instead of significance bookkeeping. The significance sentence is kept in full.
- **Fixed-effects clause.** "After adding product fixed effects" became "after product fixed effects are added", which keeps the clause attached to column 3.
- **Unchanged.** Every number, SE, column label, and significance level is unchanged. Only the sentence order, the placement of "Table 3" (now a parenthetical), and the sentence form changed.

## Author questions

- **Numbers and columns:** Because the sentences moved, please confirm each value still sits next to its correct column. These are 0.18 in column 2, 0.15 in column 3, 0.09 in column 4, 0.42 across all specifications, and R-squared 0.31 to 0.47.
- **Outcome variable:** Is it sales, as the core thesis suggests, or something else? One clause naming it would anchor every number.
- **Interaction:** Is it the identity-disclosed indicator interacted with tenure? If so, what does the positive 0.09 imply, for example that the identity effect is larger for longer-tenured reviewers? That interpretation is yours to state.
- **New opener:** "With the star rating in the model" assumes star rating is in every column that reports the indicator. Your "across all specifications" supports this, but I added the characterization, so please confirm it.
- **"Holds at 0.15":** Is this acceptable for the move from 0.18 to 0.15, or would you rather say explicitly that the coefficient stays significant at 1%?
- **Significance of the interaction:** A coefficient of 0.09 with an SE of 0.03 has a ratio of about 3, which ordinarily corresponds to the 1% level. Is "significant at the 5% level" correct, or does rounding of the reported values explain it?
- **R-squared range:** Does 0.31 to 0.47 span columns 1 to 4? Column 1 isn't described elsewhere in this paragraph.
- **Closing sentence:** Should the paragraph end with one sentence on what the pattern means for your thesis (identity matters beyond the rating)? I didn't add one, because that interpretation goes beyond the Results text you wrote.