---
description: "Final-polish a paper section with the paper-revision-editor skill: sentence-level copyediting only, no restructuring."
argument-hint: "[section file path, or paste the section text]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`paper-revision-editor` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
the user's answers to any prior clarifying question and, on a repeat pass
over the same text, the edits the author declined, reworded, or reverted
since the last pass, so the across-rounds preservation rule can hold inside
the isolated dispatch.

This is a conservative final-polish pass. Run it only when the section's
structure, claims, and evidence are stable. Load `references/copyediting.md`,
`references/ai-tells-to-avoid.md`, and `references/sentence-cohesion.md`. The
copyediting pass runs after the argument, paragraph, reader-experience, and
claim-calibration checks, so it repairs mechanics, not structure.

Preset triage:

- **Scope:** direct rewrite, limited to sentence-level repairs: word choice,
  given-new flow, referents, stress position, terminology consistency,
  abbreviations, capitalization, hyphenation, units, table and figure callouts,
  punctuation, tense, parallelism, rhythm, and the AI tells permitted to fix
  under final-polish constraints. No paragraph reordering, no merging or
  splitting paragraphs, no new explanatory content, no structural cuts (compress
  only).
- **Unit:** the section provided below (a file path to read, or pasted text).
  If neither is present, ask which
  section before proceeding. If the provided unit is actually a whole
  manuscript (multiple `\section{...}` commands or top-level headings), follow
  the skill's monolithic-file rule instead of treating it as one section:
  confirm the detected section list with the author and process one section at
  a time.
- **Aggressiveness:** apply `final polish` constraints, never looser ones.
  Read the stored `revision_stage` in `<paper_context>` (`AGENTS.md`, then
  `CLAUDE.md`, then `paper-meta.md`) and branch on it:
  - `final polish`: proceed.
  - `first draft`: proceed. Final-polish constraints are strictly narrower than
    what this stage permits, so applying them bypasses no gate; note that you are
    polishing a draft still marked `first draft`.
  - `response to reviewers`: do not proceed with a whole-section polish. That
    stage gate limits edits to reviewer-flagged paragraphs and their neighbours,
    and a section-wide copyedit would touch accepted paragraphs the stage
    protects. Stop and ask the author to either confirm the reviewer round is
    closed and update `revision_stage` to `final polish`, or to keep
    reviewer-response scope and use `/paper:rebut` instead. Do not override the
    stage on your own.
  Surface any deeper structural or exposition gap in `Author questions` instead
  of fixing it here.

Return the strict four-section output. Per the skill's Diagnosis-header decision
table, a final-polish pass skips the `Voice tics:` and `Reader map:`
lines and the three exposition extraction lines. If the section already clears
the restraint checks, return it verbatim and say so in `Change rationale`.

Section to polish:

$ARGUMENTS
