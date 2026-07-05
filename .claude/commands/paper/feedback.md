---
description: Get editorial diagnosis of a paper section without a rewrite (feedback only).
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

Preset triage, so the skill does not need to ask:

- **Scope:** feedback only, no rewrite. The `Revised text` block must read
  `No rewrite requested.`, and `Change rationale` carries brief rationale
  bullets for the top diagnosis items instead of change lines (per the skill's
  output contract).
- **Unit:** the section provided below (a file path to read, or pasted text).
  If neither is present, ask which
  section before proceeding. If the provided unit is actually a whole
  manuscript (multiple `\section{...}` commands or top-level headings), follow
  the skill's monolithic-file rule instead of treating it as one section:
  confirm the detected section list with the author and process one section at
  a time.
- **Aggressiveness:** diagnosis is bound by the `revision_stage` in the paper's
  `<paper_context>` (read `AGENTS.md`, then `CLAUDE.md`, then `paper-meta.md`).
  Do not propose changes outside what that stage permits.

Run the full diagnostic lens (logical flow, argumentation, exposition,
paragraph craft, reader experience, narrative spine, copyediting) and return the
strict four-section output, with `No rewrite requested.` as the revised text.

Section to diagnose:

$ARGUMENTS
