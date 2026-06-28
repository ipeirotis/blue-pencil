---
description: Final-polish a paper section with the paper-revision-editor skill: sentence-level copyediting only, no restructuring.
argument-hint: "[section file path, or paste the section text]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`paper-revision-editor` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

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
- **Unit:** the section in `$ARGUMENTS` (a file path to read, or pasted text).
  If neither is present, ask which section before proceeding.
- **Aggressiveness:** apply `final polish` constraints regardless of the request
  wording. If the stored `revision_stage` in `<paper_context>` (read
  `AGENTS.md`, then `CLAUDE.md`, then `paper-meta.md`) is not `final polish`,
  tell the user about the mismatch rather than silently overriding it, then
  proceed under final-polish constraints. Surface any deeper structural or
  exposition gap in `Author questions` instead of fixing it here.

Return the strict four-section output. Per the skill's conditional Diagnosis
header rules, a final-polish pass skips the `Voice tics:` and `Reader map:`
lines and the three exposition extraction lines. If the section already clears
the restraint checks, return it verbatim and say so in `Change rationale`.

Section to polish:

$ARGUMENTS
