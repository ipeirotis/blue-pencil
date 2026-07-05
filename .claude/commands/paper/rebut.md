---
description: Revise a paper section to address specific reviewer comments (response-to-reviewers workflow).
argument-hint: "[paste reviewer comments and the section, or give file paths]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`paper-revision-editor` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
the user's answers to any prior clarifying question.

This invokes the skill's reviewer-response workflow. The text provided below
may hold the reviewer text directly or file paths to read; if it names files,
read them first. Do not infer reviewer concerns from the section: only when no
reviewer text is present in the provided text or the named files, ask for it
before doing anything else.

Run the workflow exactly:

1. Map each reviewer comment to specific paragraph numbers (assign stable labels
   `P1`, `P2`, ... if boundaries are ambiguous). List the mapping before
   diagnosing.
2. Edit only the paragraphs reviewers flagged plus their immediate neighbours.
   Leave every other paragraph verbatim, even if it has stylistic issues.
3. Label each diagnosis item with the reviewer concern, e.g. `[R2.3, P4]`.
4. Where a comment needs substance the manuscript does not contain (a number, an
   analysis, a claim), do not write it; flag it in `Author questions` with what
   is needed.
5. Where a reviewer asks for a stronger, broader, or more causal claim, do not
   strengthen the text beyond what its stated evidence supports: write the
   strongest version the existing evidence licenses and put the gap in
   `Author questions`.
6. Where two reviewer comments demand incompatible edits to the same passage,
   make neither edit; present both readings and a proposed resolution in
   `Author questions`, since the trade-off is the author's call.
7. After the four-section output, append a comment-to-change table so the
   author can carry it into the response letter: one row per reviewer comment
   with columns Comment, Paragraph(s), Status (addressed in text / flagged in
   Author questions / needs new analysis / rebut-only, answered in the letter
   with no manuscript change), and Where (the paragraph label, question item,
   or the letter). Every reviewer comment appears in exactly one row.

Preset triage:

- **Scope:** direct rewrite of the flagged paragraphs and their immediate neighbours (per step 2 above). Touch a neighbour only when the fix for a reviewer comment belongs in its transition or setup sentence; leave every other paragraph verbatim.
- **Unit:** the section provided below (file path or pasted text), with the
  reviewer comments alongside it.
- **Aggressiveness:** apply response-to-reviewers scope, since pasting reviewer
  comments is itself a trigger for that workflow in the skill. If the stored
  `revision_stage` in `<paper_context>` is not `response to reviewers`, tell the
  user about the mismatch rather than silently overriding it. Do not reorganize
  structure reviewers accepted.

Return the strict four-section output. This command revises the manuscript section
only. The response letter itself is a separate deliverable with its own license: on
request, draft or edit per-comment reply text following the rebuttal conventions in
`references/structural-patterns.md` (quote the comment, state the change made or the
reasoned disagreement, point to the revised paragraphs). Reply text may restate and
cite what the revision did; it must never promise or assert analyses, results, or
claims the manuscript does not contain, and every such gap goes to `Author questions`.
`/paper:letter` runs that lane on the whole letter.

Reviewer comments and section:

$ARGUMENTS
