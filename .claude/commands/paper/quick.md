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

Use available paper context. Ask once only if `audience` or `revision_stage` is
missing and materially changes a safe edit; otherwise use the skill's stated
conservative defaults and report them briefly. Run the applicable
sentence-level reference passes. Return exactly `Revised text`, `Top changes`
(at most three bullets plus `References loaded:`), and `Author questions`.

Passage to edit:

$ARGUMENTS
