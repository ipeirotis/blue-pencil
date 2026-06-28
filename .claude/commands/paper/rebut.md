---
description: Revise a paper section to address specific reviewer comments (response-to-reviewers workflow).
argument-hint: [paste reviewer comments and the section, or give file paths]
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`paper-revision-editor` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

This invokes the skill's reviewer-response workflow. Do not infer reviewer
concerns from the section: if the reviewer text is not in `$ARGUMENTS` or the
conversation, ask for it before doing anything else.

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

Preset triage:

- **Scope:** direct rewrite of the flagged paragraphs only.
- **Unit:** the section in `$ARGUMENTS` (file path or pasted text), with the
  reviewer comments alongside it.
- **Aggressiveness:** response-to-reviewers semantics regardless of the stored
  stage; do not reorganize structure reviewers accepted.

Return the strict four-section output. For the rebuttal letter itself, the skill
can draft per-comment phrasing on request using the rebuttal conventions in
`references/structural-patterns.md`.

Reviewer comments and section:

$ARGUMENTS
