# Evaluation rubric (draft v0.1)

This is the written definition of "good" that every grader in the pilot uses.
It has two parts that are scored **separately**, because a passage can read
better and still be a bad edit if it changed what the author said.

- **Part A, Preservation (a gate).** Did the edit keep the author's meaning,
  technical content, and voice? A revision that fails Part A fails, however
  smooth it reads.
- **Part B, Writing quality.** Among revisions that pass the gate, which reads
  better? Only scored for revisions that passed Part A.

Scope of this draft: `/paper:revise` at the `first draft` stage. At that stage
the editor is allowed to reorder, merge, and cut. Stricter stages
(`final polish`, `response to reviewers`) would need their own allowed-edit
rules, so the rubric is written to take the stage as an input rather than
assume one. Not covered yet: whole-paper edits, LaTeX-heavy sections.

## Part A. Preservation

Each item is judged by the grader as **pass**, **fail**, or **unsure**. "Unsure"
is a legitimate answer and is reported, not hidden.

| ID | Check | Fails when | Judged by |
|----|-------|-----------|-----------|
| A1 | Numbers and statistics | Any figure, sign, range, unit, p-value, or standard error is added, dropped, or altered | Code grader (exact), plus meaning grader |
| A2 | Citations | A citation is added, dropped, altered, or attached to a different claim | Code grader (tokens), plus meaning grader (attachment) |
| A3 | Equations, cross-references, quotes, markup | Math, `\ref`/table/figure callouts, quoted text, or LaTeX/Markdown markup differs | Code grader |
| A4 | Claim strength | Hedging or certainty shifts: "associated with" becomes "causes"; "may" becomes "does"; "suggestive" becomes "shows" | Meaning grader |
| A5 | Qualifications and scope | A caveat, condition, limitation, population, or time window is dropped, narrowed, or widened | Meaning grader |
| A6 | No new substance | The revision asserts something the original did not (a new claim, mechanism, motive, or fact) | Meaning grader |
| A7 | Nothing important lost | A finding, step, or definition the reader needs is silently removed | Meaning grader |
| A8 | Author voice | Distinctive wording, person ("we"), register, or stance is replaced by generic prose without reason | Meaning grader (flag only; see below) |

Notes on Part A:

- **A1 to A3 are mechanical.** A code grader extracts these tokens from the
  original and the revision and compares them. Any difference is a *flag* for a
  person to look at, not automatic proof of damage (a legitimate edit can move a
  citation).
- **A4 to A7 need judgment** about meaning, so a model grader reads both texts
  and must quote the exact original and revised wording for every problem it
  reports. A verdict without a quote does not count.
- **A8 (voice) is the hardest and the least settled.** The pilot records voice
  concerns as flags and does not let them fail a revision on their own. How to
  measure voice is an open question (see README).
- **Rewording is not a change.** Synonyms, reordering, and tighter phrasing that
  say the same thing at the same strength are fine and must not be penalized.
- **Preservation verdict:** `fail` if any A1 to A7 item fails with a quoted
  example; `unsure` if the grader cannot tell; otherwise `pass`.

## Part B. Writing quality (first-draft stage)

Judged pairwise (which of two versions is better), not on an absolute scale,
because relative judgments are easier to make reliably. Each dimension gets
`A`, `B`, or `tie`, then an overall choice.

| ID | Dimension | What better looks like |
|----|-----------|------------------------|
| B1 | Clarity and orientation | The point of the passage is easy to find early; a reader outside the subfield can follow it |
| B2 | Concision without loss | Fewer words for the same content; no padding, stacked hedges, or throat-clearing |
| B3 | Flow and cohesion | Sentences connect through content (what is already known, then what is new), not through bolted-on connectives |
| B4 | Precision and mechanics | Exact word choice, correct grammar, consistent terms, no ambiguous pronouns |
| B5 | Fit for audience | Register and detail suit the stated audience and venue |

Rules for the quality grader:

- Judge only how well the text reads. Meaning is checked elsewhere.
- Do not reward length: a shorter or longer version is not better for that
  reason alone. Brevity bought by dropping content is not concision.
- If versions are equally good, answer `tie`. Ties are allowed and expected.
- **Order is randomized, then swapped.** Every pair is judged twice, once in each
  order. A win counts only if the same version wins both times; otherwise the
  pair is recorded as a tie (this guards against the known tendency of model
  judges to favor whichever answer comes first).

## What counts as an improvement (the pilot's headline rule)

A revision "improves" the passage only if it **passes Part A** and **beats the
other version (or the original) on Part B**. Reported separately, never blended
into one score:

1. Preservation pass rate (code check, meaning check, and both together).
2. Quality win / tie / loss rate among passing revisions.
3. Head-to-head: Blue Pencil versus the same request without Blue Pencil.

## Sources and status

This rubric is **our draft**, not a published standard. It borrows the general
shape of scientific-writing quality rubrics (cohesion, conciseness, readability,
organization; compare the linguistic and stylistic rubrics in
[YESciEval](https://arxiv.org/pdf/2505.14279)) and the standard mitigations for
model-judge bias (swap the order and require agreement; instruct the judge to
ignore length). It was deliberately **not** copied from Blue Pencil's own
editing rules, because grading the skill by its own rules would favor it.
Before the results are used for any claim, the rubric should be checked against
an independent source (a journal copyediting guide or a validated rubric) and
refined with the professor.
