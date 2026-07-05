# Whole-paper cold read

Load this for any whole-paper cold read: when the user asks you to read the
paper the way its intended reader would, asks whether the whole paper works, is
good, or is a pleasure to read end to end, when a `/paper:read` dispatch names
it, or at the diagnose-globally step of a whole-paper revision loop. This pass
diagnoses; it never rewrites. It needs no tools beyond reading the manuscript,
so it runs in every environment the skill runs in. It lives here rather than in
a command file so every agent that reads the skill gets it, not only Claude
Code.

## The posture

Read the full manuscript front to back, once, cold, as the `<paper_context>`
audience: a venue-competent reader who is not expert in this exact topic (the
reader model in `references/exposition.md`). The unit of diagnosis is the
reading experience, not the section: per-section feedback stitched together
never measures whether the paper carries a reader from the title to the
conclusion, and that is exactly what this pass measures. Do not edit anything,
and do not stop to fix what you find; record where the experience breaks and
keep reading, because what a reader does after a break point (reread, skim,
give up) is itself a finding.

Apply the layered-audience meta-rule from `references/edit-checks.md` during
the one read: would a curious non-expert read past the introduction, would a
generalist reviewer believe the question matters by page two, and would a
technical expert find the core defensible? Report each failure at the layer
where it occurs.

## The four deliverables

Produce all four inside the Diagnosis block, in this order.

### 1. Reading log

At each section boundary, record three things:

- the question the reader is carrying into the next section
- whether the section just finished answered the question the reader brought
  into it
- the first sentence at which the venue-competent non-specialist stops
  following (cannot connect the sentence to what they know) or stops caring
  (can connect it but no longer sees why it matters), quoted, or `none`

This is the pleasure test from `references/reader-pleasure.md` (orientation,
momentum, payoff, texture, relief) applied at paper scale instead of paragraph
scale: sections must open, narrow, or resolve a question some earlier section
planted, and a section boundary is where momentum is won or lost.

### 2. Colleague test

State, blind, the one-sentence summary the reader would give a colleague who
asked what the paper shows. Write that sentence before re-reading
`core_thesis`, then compare the two. A mismatch is the paper's most important
defect and outranks every sentence-level finding in the report: it means the
paper argues one thesis and delivers another, or buries the real one. When
`core_thesis` is unknown (the context fallback), still state the blind summary,
skip the comparison, and say so.

### 3. Delight audit

Where the paper rewards the reader and where it taxes them, each with a
location. Rewards: a genuine surprise, a figure that carries the argument, a
sentence the reader will repeat to explain the paper, a payoff that lands.
Taxes: a stretch with no payoff in sight, machinery before motive, a defensive
caveat wall, list rhythm across paragraphs or sections. "A pleasure to read" is
measured here, not asserted; an empty rewards column is itself a finding.

### 4. Venue compliance

Whole-paper checks that belong to a front-to-back read, driven by
`target_venue` when it is known:

- length against the venue limit when one is known (report the gap, do not cut;
  "cut to fit" routes to the Subtraction rules with the target as context)
- required structure the venue expects that the manuscript lacks, or ordering
  the venue forbids
- anonymization leaks when the venue reviews double-blind: self-identifying
  citations in the first person, acknowledgments, repository or grant
  identifiers

Skip any check whose input (`target_venue`, the limit, the review model) is
unknown, and say which checks were skipped and why.

## The dispatch list

Close the Diagnosis with a prioritized dispatch list: for each finding, which
section needs which pass (`/paper:revise`, `/paper:clarify`, `/paper:human`,
`/paper:consistency`, or author work for gaps that need new substance), ordered
by reader impact with the colleague-test mismatch first when there is one. The
dispatch list feeds the whole-paper loop's pass order; it is a plan, not a
license, and every recommendation must respect the stored `revision_stage`
(never recommend restructuring at `final polish`).

## Two stop rules compose

The cold read is the loop's exit criterion: the whole-paper revision is done
when a fresh cold read comes back clean (no reading-log break points, the
colleague test matches `core_thesis`, no must-fix delight or compliance
findings) and its dispatch list asks for nothing beyond a final polish. The
editor's own stop rule is untouched by this: inside any single dispatched pass,
stop when the remaining edits would be merely different rather than better.
The cold read decides whether another pass is dispatched; the editor rule
decides when a dispatched pass stops. Chasing delight never justifies churn
edits.

## Reporting conventions

- Diagnosis only. `Revised text` reads `No rewrite requested.`, and `Change
  rationale` carries brief rationale bullets for the prioritization instead of
  change lines. Route every question the read raises that only the author can
  settle (a missing motivation, a claim the evidence may not support, which of
  two theses is the paper's) to `Author questions`.
- Every finding names its location: a section for log and dispatch entries, a
  quoted sentence for break points.
- The seven-item Diagnosis cap does not apply: this is a whole-paper
  diagnosis-only pass, and exhaustiveness is its value. Group findings under
  the four deliverable headings above.
