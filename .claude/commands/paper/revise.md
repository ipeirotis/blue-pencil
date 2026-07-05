---
description: Diagnose then rewrite an academic paper section with the paper-revision-editor skill (full four-section output).
argument-hint: "[section file path, or paste the section text]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`paper-revision-editor` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
the user's answers to any prior clarifying question.

Preset triage, so the skill does not need to ask:

- **Scope:** direct rewrite.
- **Unit:** the section provided below (treat it as a file path to read if it
  looks like one, otherwise as pasted text). If neither is present, ask which
  section before proceeding. If the provided unit is actually a whole
  manuscript (multiple `\section{...}` commands or top-level headings), follow
  the skill's monolithic-file rule instead of treating it as one section:
  confirm the detected section list with the author and process one section at
  a time.
- **Aggressiveness:** follow the `revision_stage` in the paper's
  `<paper_context>` (read `AGENTS.md`, then `CLAUDE.md`, then `paper-meta.md`).
  Do not override the stage to fit the request. If the context block is missing,
  follow the skill's context fallback: use any context answers this dispatch
  carries; if the request shows the user was already asked and declined or
  answered partially, proceed with the skill's conservative defaults and an
  `Assumed context:` line; only otherwise surface the single ask-once question.

Apply the full diagnostic lens and return the strict four-section output
(`Diagnosis`, `Revised text`, `Change rationale`, `Author questions`) and
nothing else.

Section to revise:

$ARGUMENTS
