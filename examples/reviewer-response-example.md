# Reviewer-response example

The response-to-reviewers stage has its own rules, and they are the easy ones to
break: touch only the paragraphs reviewers flagged plus their immediate
neighbours, leave everything else alone even when it has stylistic problems, and
never invent the substance a reviewer asks for. This example shows all three.
One reviewer comment is fixable by surfacing an argument already buried in the
prose; the other asks for a number the section does not contain, so it becomes an
`Author questions` item instead of a fabricated sentence. Three unflagged
paragraphs with real stylistic issues are returned verbatim. The output follows
the strict four-section format in `SKILL.md`; for the rebuttal-letter genre
itself, see the rebuttal section of `references/structural-patterns.md`.

## Scenario

```
<paper_context>
target_venue: Management Science
audience: empirical economists and IS researchers
core_thesis: Earning a platform badge causes a measurable increase in seller revenue, identified from the staggered rollout of the badge program across categories.
revision_stage: response to reviewers
</paper_context>
```

The request:

> Reviewer 2 had two comments on our empirical section. Can you help me revise
> the section to address them?
>
> R2.1: The identification strategy is unclear. It is not obvious why the
> instrument satisfies the exclusion restriction.
>
> R2.2: The authors report a 12% effect but never say whether this is
> economically meaningful relative to the baseline.

The section (paragraph labels added by the skill):

```
[P1] The purpose of this section is to describe our empirical strategy. It is
important to note that estimating the causal effect of platform badges on seller
revenue is complicated by selection: sellers who earn a badge may differ from
those who do not in ways that also affect revenue.

[P2] We instrument badge receipt with the rollout date of the badge program in a
seller's primary category. Categories received the program on a staggered
schedule set by the platform's engineering capacity. The exclusion restriction
requires that rollout timing affects revenue only through badge receipt.
Engineering capacity was allocated by team availability, which is plausibly
unrelated to category-level revenue trends.

[P3] We estimate a two-stage least squares model with seller and quarter fixed
effects, clustering standard errors at the category level.

[P4] Badge receipt raises seller revenue by 12% (Table 4). The effect is
statistically significant at the 1% level and is robust to the inclusion of
seller-specific time trends.

[P5] Furthermore, the results hold across several robustness checks, which are
reported in Appendix C. Moreover, we find no evidence of pre-trends.
```

## Triage and comment mapping

> Scope: direct rewrite, limited to the paragraphs R2 flagged plus any
> immediate neighbour a fix needs. Unit: the empirical section, but at `response
> to reviewers` I touch only those paragraphs and leave the rest untouched; here
> both fixes fit inside the flagged paragraphs, so no neighbour needs editing.
> Here is the mapping I will work from before diagnosing:
>
> - **R2.1** (exclusion restriction unclear) -> **P2**.
> - **R2.2** (is the 12% economically meaningful) -> **P4**.
>
> P1, P3, and P5 were not flagged, so I will return them verbatim even where I
> see stylistic issues. Proceeding on that basis.

## Skill output

The strict four-section return. The stage is `response to reviewers`, not a
first-draft or whole-section pass, so the Diagnosis opens straight into the
numbered list with no `Voice tics:` or `Reader map:` line, and every item
carries a reviewer label.

### 1. Diagnosis

1. [R2.1, P2] The exclusion-restriction argument is present but buried: the
   paragraph names the instrument first and states what identification requires
   only in its third sentence, with the supporting reason last. Reordering so
   the requirement leads and the reason follows answers R2.1 from material
   already in the paragraph.
2. [R2.2, P4] The 12% effect is reported with statistical significance but no
   baseline revenue level, so the reader cannot judge economic magnitude as R2
   asks. The section does not state the baseline, and supplying one is new
   substance, not an edit, so this is flagged rather than written.

(Only two items, both reviewer-labelled. P1 and P5 have stylistic issues
reviewers did not raise; under this stage they stay out of the Diagnosis block
and are noted in `Change rationale` as returned verbatim, not added here as
non-reviewer diagnoses.)

### 2. Revised text

```
The purpose of this section is to describe our empirical strategy. It is
important to note that estimating the causal effect of platform badges on seller
revenue is complicated by selection: sellers who earn a badge may differ from
those who do not in ways that also affect revenue.

Identification requires that the timing of the badge rollout move seller
revenue only through badge receipt. We instrument badge receipt with the rollout
date of the badge program in a seller's primary category. The platform rolled
out that program on a staggered schedule. That schedule was set by the
platform's engineering capacity, allocated by team availability, which is
plausibly unrelated to category-level revenue trends. Rollout timing is
therefore plausibly unrelated to those trends, which is what the exclusion
restriction needs.

We estimate a two-stage least squares model with seller and quarter fixed
effects, clustering standard errors at the category level.

Badge receipt raises seller revenue by 12% (Table 4). The effect is
statistically significant at the 1% level and is robust to the inclusion of
seller-specific time trends.

Furthermore, the results hold across several robustness checks, which are
reported in Appendix C. Moreover, we find no evidence of pre-trends.
```

### 3. Change rationale

Word count: 177 to 198 (+12%). Longer because the one substantive edit (P2)
surfaces an argument the draft had compressed into trailing clauses; addressing
R2.1 legitimately adds words to the flagged paragraph while the rest of the
section is unchanged.

The five paragraphs appear in their original order. Per the output contract, the
`[P1]`-style labels from the mapping stay outside the `Revised text` block: they
mark the input and the rationale lines below, and the block carries only
manuscript text the author can paste back whole.

"We instrument badge receipt with the rollout date ... The exclusion restriction
requires that rollout timing affects revenue only through badge receipt." ->
"Identification requires that the timing of the badge rollout move seller revenue
only through badge receipt. We instrument badge receipt with the rollout date
...", moved the exclusion requirement to the front so the reader knows what must
hold before meeting the instrument; addresses R2.1 by making the identification
logic visible. Reordered from material already in the paragraph; no new
justification invented.

"set by the platform's engineering capacity ... Engineering capacity was
allocated by team availability, which is plausibly unrelated to category-level
revenue trends." -> "That schedule was set by the platform's engineering
capacity, allocated by team availability, which is plausibly unrelated to
category-level revenue trends. Rollout timing is therefore plausibly unrelated
to those trends, which is what the exclusion restriction needs.", drew the
exclusion conclusion the draft's own sentences imply, carrying the original
claims (engineering capacity, team availability, plausibly unrelated to
category-level revenue trends) over verbatim. No new premise was added: the
draft never says timing was set "rather than by category revenue", so neither
does the rewrite.

Paragraphs P1, P3, P5: returned verbatim. P1 and P5 carry stylistic issues
(throat-clearing, banned transitions), but reviewers did not flag them and the
stage forbids editing unflagged paragraphs.

Paragraph P4: returned verbatim. It is flagged by R2.2, but the fix requires a
baseline revenue level the section does not contain; see Author questions. The
12% and the 1% significance level are carried over unchanged.

### 4. Author questions

- R2.2 asks whether the 12% effect is economically meaningful relative to the
  baseline, but the section never states baseline seller revenue, and I did not
  invent one: what is the baseline level (or rate), and how would you like the
  comparison phrased?
- R2.1 now rests P2's exclusion argument on engineering team availability being
  unrelated to category revenue trends. Do you have evidence you can cite for
  that (for example, a balance check showing no differential pre-rollout revenue
  trends across categories), or should the rebuttal present it as a maintained
  assumption?
- Should P4 report a confidence interval alongside the 12% point estimate, so
  the rebuttal can point R2 to a specific magnitude rather than a single number?

## What this demonstrates

- **Scope is bound to the reviewer.** Edits stay within the flagged paragraphs
  and any immediate neighbour a fix requires. Here both fixes fit inside the
  flagged paragraphs, so P1, P3, and P5 are returned verbatim despite genuine
  stylistic flaws. The stage leaves untouched what reviewers accepted, but an
  immediate neighbour stays eligible when a fix belongs in its transition or
  setup sentence.
- **Comment mapping comes first.** Each reviewer comment is tied to a paragraph
  before any diagnosis, and every diagnosis item carries its reviewer label, so
  the author can check coverage at a glance.
- **The block stays clean.** The `[P#]` labels live in the mapping, the
  Diagnosis, and the rationale, never inside the `Revised text` block: the
  output contract forbids inline tags and editor labels there, so the block is
  safe to paste back whole.
- **One comment is fixed, one is flagged.** R2.1 is answered by surfacing an
  argument already in the prose; R2.2 needs a number the manuscript lacks, so it
  becomes a question instead of a fabricated claim. Not every reviewer comment
  yields an edit.
- **No invented substance.** The exclusion argument is reordered, not
  manufactured, and the missing baseline is requested rather than guessed.
- **Numbers and citations preserved.** The 12% effect, the 1% significance
  level, and the Table 4 and Appendix C callouts are all carried over unchanged.
- **The letter is a separate deliverable.** This pass revises the section; on
  request, the skill can also draft the per-comment rebuttal phrasing using the
  rebuttal conventions in `references/structural-patterns.md`.
