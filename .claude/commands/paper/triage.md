---
description: "Triage a decision letter with the paper-revision-editor skill: severity-ranked comment table, section mapping, and a suggested order of work (diagnosis only, no rewrite)."
argument-hint: "[paste the full decision letter, or give file paths; optionally add the manuscript root]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`paper-revision-editor` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
the user's answers to any prior clarifying question.

This is decision-letter triage: the first step of a major revision, before any
section edit. The text provided below holds the decision letter (the editor or
AE summary plus the per-reviewer comments), directly or as file paths to read;
it may also name the manuscript root. If no decision letter is present, ask for
it before doing anything else. Do not diagnose or rewrite prose: this pass plans
the revision, it does not perform it. Reviewer comments with no manuscript are
enough to triage: classify what each comment asks for, map sections by the
letter's own references, and say the mapping is unverified until the manuscript
is available.

Run the triage:

1. Parse the letter into individual comments with stable labels (`AE.1`,
   `R1.1`, `R1.2`, `R2.1`, ...), quoting or tightly paraphrasing each.
2. Cluster comments that ask for the same underlying change, and name each
   cluster.
3. Rank by severity for the decision (must-fix, important, optional), judged by
   the letter's own weight and the editor's framing, not by what is easy.
4. Classify each comment: prose-fixable (answerable by editing existing text),
   needs new substance (an analysis, number, or evidence only the author can
   supply), rebut-only (answered in the response letter, no manuscript change),
   or unclear.
5. Map each comment to the manuscript section(s) it touches.
6. Recommend an order of work mapped onto the other commands: `/paper:rebut`
   per section or cluster for the prose-fixable comments, author work for the
   new-substance items, `/paper:consistency` over the touched sections once the
   edits land, and `/paper:letter` to close the round.
7. Where two comments demand incompatible changes, name the conflict and route
   the choice to `Author questions`, per the skill's reviewer-workflow conflict
   rule; do not pick a side in the ranking.
8. Where a comment invites a claim stronger than the manuscript's stated
   evidence, mark it: the plan notes the strongest version the evidence
   licenses, and the gap goes to `Author questions`, per the reviewer
   workflow's overclaim rule.

Preset triage:

- **Scope:** feedback only, no rewrite. The `Revised text` block must read
  `No rewrite requested.`, and `Change rationale` carries brief rationale
  bullets for the ranking and ordering decisions instead of change lines.
- **Unit:** the whole decision letter provided below, plus the manuscript when
  it is named.
- **Aggressiveness:** diagnosis only; this pass never edits the manuscript or
  drafts reply text. If the stored `revision_stage` in `<paper_context>` is not
  `response to reviewers`, note the mismatch (a decision letter usually means
  the stage should move there) rather than silently overriding it; do not
  change the stage yourself.

Return the strict four-section output, with `No rewrite requested.` as the
revised text. The Diagnosis carries the severity-ranked comment table (one row
per comment: label, the comment in brief, severity, type, section(s), cluster),
then the recommended order of work; every comment in the letter appears in
exactly one row. The skill's seven-item Diagnosis cap does not apply to this
whole-letter diagnosis-only pass: cover every comment. Each `Author question`
ends with a question mark.

Decision letter (and optional manuscript):

$ARGUMENTS
