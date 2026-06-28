---
description: Diagnose then rewrite an academic paper section with the paper-revision-editor skill (full four-section output).
argument-hint: "[section file path, or paste the section text]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`paper-revision-editor` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

Preset triage, so the skill does not need to ask:

- **Scope:** direct rewrite.
- **Unit:** the section in `$ARGUMENTS` (treat it as a file path to read if it
  looks like one, otherwise as pasted text). If neither is present, ask which
  section before proceeding.
- **Aggressiveness:** follow the `revision_stage` in the paper's
  `<paper_context>` (read `AGENTS.md`, then `CLAUDE.md`, then `paper-meta.md`).
  Do not override the stage to fit the request; if the context block is missing,
  stop and surface that gap.

Apply the full diagnostic lens and return the strict four-section output
(`Diagnosis`, `Revised text`, `Change rationale`, `Author questions`) and
nothing else.

Section to revise:

$ARGUMENTS
