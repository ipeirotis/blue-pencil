# Exposition example: results

A results paragraph that reports numbers but never says what the reader learns from
them. The estimates are all there and every figure reference is correct, but the
paragraph reads as a table narrated aloud: it never leads with the claim or closes
on the consequence. The exposition pass reorders each result into claim, then
evidence, then what it teaches, without touching a single number. The output follows
the strict four-section format in `SKILL.md`.

## Scenario

```
<paper_context>
target_venue: Information Systems Research
audience: empirical IS researchers
core_thesis: A reviewer's identity, not just the rating, shapes how much an online review moves sales.
revision_stage: first draft
</paper_context>
```

The request:

> My results paragraph is accurate but feels flat. Can you make it land?

## Input

```
Table 3 reports the estimates. The coefficient on the identity-disclosed indicator
is 0.18 (SE = 0.04) in column 2. In column 3, after adding product fixed effects,
the coefficient is 0.15 (SE = 0.05). The interaction with reviewer tenure is 0.09
(SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across
all specifications. R-squared rises from 0.31 to 0.47 across the columns. All
coefficients are significant at the 1% level except the interaction, which is
significant at the 5% level.
```

## Triage

> Scope: direct rewrite. Unit: the one results paragraph you pasted. Aggressiveness:
> stage is `first draft`, so I will reorder each result to lead with the claim and
> close on what it shows, while carrying every number over verbatim. Proceeding on
> that basis.

## Skill output

### 1. Diagnosis

Voice tics: estimates reported with standard errors in parentheses; results keyed to
specific table columns; star rating used as the reference effect.

Reader map: starts with knowing the regression was run; must learn that disclosed
reviewer identity moves sales on its own and survives controls, and that it adds to
the rating rather than just proxying for it; should leave with identity as a second
lever on sales alongside the rating, not just metadata.

Jargon to unpack: "product fixed effects", reported as a column change before the
reader is told what they absorb (stable differences between products), with the
specific confound they are meant to address left to Author questions rather than
asserted in the Diagnosis.

Buried lede: disclosed reviewer identity moves sales on its own (0.18), survives
product controls, and sits alongside the star-rating effect (0.42) as a second lever
on sales, not a proxy for the rating. Both coefficients are carried over verbatim; the
rewrite places them side by side without computing a ratio the manuscript does not
state.

Concrete anchor: the star-rating coefficient (0.42) already in the table, which the
rewrite places next to the 0.18 identity coefficient as a reference point, leaving
whether the two are on comparable scales (and so whether their sizes can be compared)
to Author questions.

1. [P1] Payoff inversion: every sentence leads with the table location or the
   coefficient and never with the claim the number supports. The reader assembles
   the finding instead of being handed it.
2. [P1] No reader takeaway: the paragraph ends on R-squared and a significance
   footnote, the two facts that teach the reader least, rather than on what the
   identity effect means relative to the rating.
3. [P1] Compressed inference: the move from column 2 to column 3 (adding product
   fixed effects) is reported as two numbers with no statement that the effect
   barely changes, which is the point of running the second specification.
4. [P1] Missing contrast carried by an existing number: the star-rating coefficient
   (0.42) sits in the list as one more estimate, when it is the natural yardstick
   that tells the reader how big the 0.18 identity effect is.

### 2. Revised text

```
Disclosing who wrote a review moves sales on its own, not just through the rating it
carries. In Table 3, the coefficient on disclosed identity is 0.18 (SE = 0.04, column
2). The effect is not an artefact of stable differences between products: adding
product fixed effects in column 3 barely moves it, to 0.15 (SE = 0.05). It
also grows with the reviewer: the interaction with reviewer tenure is 0.09 (SE =
0.03, column 4), so a disclosed identity counts for more when the reviewer has a
longer track record. For comparison, the star rating carries a coefficient of 0.42
(SE = 0.02) across all specifications, a benchmark for these estimates once the scales
are comparable. All coefficients are significant at the 1% level except the tenure
interaction, which is significant at the 5% level, and R-squared rises from 0.31 to
0.47 across the columns. Identity is a second lever on sales alongside the rating, not
just metadata.
```

Added bridges: "The effect is not an artefact of stable differences between products:
adding product fixed effects in column 3 barely moves it, to 0.15 (SE = 0.05)." Names
what the draft's own move from column 2 to column 3 implies; confirmed in Author
questions (the product-fixed-effects item).

### 3. Change rationale

Word count: ~87 to ~159 (+83%). This is a large expansion, at the high end of what the
length budget tolerates, and is flagged for the author: the input is a bare list of
estimates, and each one gains a leading claim and a closing consequence. No number,
standard error, table or column reference, or significance level was added, removed,
or altered; every numerical claim is carried over verbatim per constraint 4.

"Table 3 reports the estimates. The coefficient on the identity-disclosed indicator
is 0.18 (SE = 0.04) in column 2." -> "Disclosing who wrote a review moves sales on
its own, not just through the rating it carries. In Table 3, the coefficient on
disclosed identity is 0.18 (SE = 0.04, column 2).", led with the claim, then the
evidence; the Table 3 reference, the coefficient, and the standard error are kept,
and the estimate stays a coefficient rather than being restated as a rise in sales,
since the outcome scale is not given.

"In column 3, after adding product fixed effects, the coefficient is 0.15 (SE =
0.05)." -> "The effect is not an artefact of stable differences between products:
adding product fixed effects in column 3 barely moves it, to 0.15 (SE = 0.05).",
named what product fixed effects absorb (stable between-product differences) and that
the effect survives them, without claiming they rule out every selection story, which
the bare two-number report left for the reader to infer.

"The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4." -> "It also
grows with the reviewer: the interaction with reviewer tenure is 0.09 (SE = 0.03,
column 4), so a disclosed identity counts for more when the reviewer has a longer
track record.", added the reader takeaway the interaction encodes.

"The coefficient on star rating is 0.42 (SE = 0.02) across all specifications." ->
"For comparison, the star rating carries a coefficient of 0.42 (SE = 0.02) across all
specifications, a benchmark for these estimates once the scales are comparable.",
offered the rating coefficient as a benchmark for the identity estimates rather than
asserting that identity is smaller, since the two regressors may be on different
scales (raised in Author questions); the "across all specifications" scope is kept
verbatim.

"R-squared rises from 0.31 to 0.47 across the columns. All coefficients are
significant at the 1% level except the interaction, which is significant at the 5%
level." -> "All coefficients are significant at the 1% level except the tenure
interaction, which is significant at the 5% level, and R-squared rises from 0.31 to
0.47 across the columns.", merged the two sentences in reversed order and placed them
after every coefficient they cover (including the star rating) but before the closing
line, so the fit and significance statistics leave the stress position and the
paragraph ends on the takeaway ("identity is a second lever on sales"). "The
interaction" is renamed "the tenure interaction" so the exception stays unambiguous
now that the sentence sits three results away from the tenure estimate; every number,
significance level, and the R-squared range is unchanged, and the renaming edits the
prose around the statistic, not the statistic itself.

### 4. Author questions

- I report 0.18 as a coefficient, not as a rise in sales, because the outcome scale
  is not given. In what units is the dependent variable (log sales, units, a
  standardised measure), so the prose can say what the coefficient means?
- I described the star-rating coefficient as a yardstick for the identity effect.
  Are identity disclosure and star rating on comparable scales, so that 0.18 versus
  0.42 is a fair size comparison, or would that mislead the reader?
- Is "disclosed identity counts for more when the reviewer has a longer track
  record" the reading you want for the tenure interaction, or do you interpret it
  differently?
- Column 3's product fixed effects absorb stable differences between products; is
  that the confound you mean to address, and should the text flag that within-product
  selection of identified reviewers is not ruled out?

## What this demonstrates

- **Claim, then evidence, then teaching.** Each result now opens on the claim the
  number supports and closes on what it shows, the structure a results paragraph
  owes the reader.
- **Numbers untouched.** Every coefficient, standard error, table and column
  reference, and significance level is carried over verbatim; the exposition pass
  reorders the prose around the numbers, never the numbers, and reports each estimate
  as a coefficient rather than restating it as a sales change the outcome scale would
  not support.
- **Existing numbers made to teach.** The star-rating coefficient already in the
  draft becomes a benchmark for reading the identity estimates against, with the
  scale caveat flagged rather than glossed, so no size ranking is asserted that the
  raw coefficients may not support.
- **Payoff after effort.** The paragraph now ends on the takeaway (identity as a
  second lever), with the significance and fit statistics compressed and moved out of
  the stress position, so it stops landing on the facts that teach the reader least.
- **Interpretations flagged.** The size comparison and the tenure reading are raised
  for the author, because an exposition edit may foreground a number already present
  but must not assert an interpretation the author has not endorsed.
