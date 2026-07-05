---
description: Make a paper section clearer to a non-specialist (exposition pass) with the paper-revision-editor skill.
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

This is an exposition-focused pass. The goal is teaching: a smart reader trained
in the venue area, but not expert in this exact topic, should be able to acquire
the idea with less effort after the edit. Load `references/exposition.md` and run
the exposition pass (question before machinery, role before name, intuition
before formalism, one new object at a time, concrete anchor after abstraction,
payoff after effort).

Preset triage:

- **Scope:** direct rewrite. Repair missing definitions and skipped inferential
  steps using only material already in the manuscript. Where a gap needs new
  substance (a claim, example, mechanism, or implication the manuscript does not
  contain), do not write it; flag it in `Author questions`.
- **Unit:** the section provided below (a file path to read, or pasted text).
  If neither is present, ask which
  section before proceeding. If the provided unit is actually a whole
  manuscript (multiple `\section{...}` commands or top-level headings), follow
  the skill's monolithic-file rule instead of treating it as one section:
  confirm the detected section list with the author and process one section at
  a time.
- **Aggressiveness:** follow the `revision_stage` in the paper's
  `<paper_context>` (read `AGENTS.md`, then `CLAUDE.md`, then `paper-meta.md`).
  Do not override the stage.

Return the strict four-section output, following the skill's Diagnosis-header
decision table: a whole-section or first-draft pass opens with a
`Voice tics:` line and then a `Reader map:` line, while a final-polish pass and
a single-paragraph request that is not a first draft skip both. Use
teaching-benefit rationales in `Change rationale`.

Section to clarify:

$ARGUMENTS
