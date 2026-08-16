---
description: "Quickly improve an academic passage with Blue Pencil: a conservative rewrite, up to three change bullets, and author questions."
argument-hint: "[short passage or section file path]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`blue-pencil` skill in an isolated context. If that subagent is unavailable,
load the skill's `SKILL.md` directly.

Preset triage, so do not ask for confirmation when a passage is present:

- **Scope:** direct rewrite using the compact quick-pass contract.
- **Unit:** the short passage or single section provided below. If it is a
  whole manuscript, stop and recommend `/paper:loop`.
- **Aggressiveness:** conservative sentence-level editing only, regardless of
  whether the stored stage permits more. Preserve paragraph order and
  boundaries, claims, citations, numbers, math, and quoted text.

Use available paper context. If `audience` or `revision_stage` is missing, ask
once before editing. Only if the author declines or answers partially, use the
skill's conservative defaults; put `Assumed context: ...` as the first line
under `Top changes` so the compact output does not need a Diagnosis section.
Drive the revision sweep at its quick-pass narrowing (the "The revision sweep"
section of `SKILL.md`): the same deterministic pass set as `final polish`,
whatever the stored stage, with structural findings routed to `Author
questions` rather than fixed. Return exactly `Revised text`, `Top changes` (at
most three bullets plus `References loaded:`), and `Author questions`.

Passage to edit:

$ARGUMENTS
