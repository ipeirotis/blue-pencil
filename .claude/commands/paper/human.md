---
description: Make a paper section read like a human wrote it (narrative spine, fewer AI tells) with the paper-revision-editor skill.
argument-hint: "[section file path, or paste the section text]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`paper-revision-editor` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

This is a narrative-and-de-AI pass. Load `references/narrative-spine.md` and
`references/ai-tells-to-avoid.md` together. Give the section one carried
question (a setup, a tension, a turn, a payoff) and strip the sentence-level
and storytelling AI tells. Critically: add structure, not decoration.
Manufactured hooks, journey metaphors, and anthropomorphized data are themselves
AI tells, so a narrative pass that adds them makes the prose more LLM-like, not
less. Run the storytelling-tell checklist against the rewrite before returning.

Preset triage:

- **Scope:** direct rewrite. Surface the spine the draft already implies; do not
  invent events, stakes, or characters the manuscript does not contain.
- **Unit:** the section in `$ARGUMENTS` (a file path to read, or pasted text).
  If neither is present, ask which section before proceeding.
- **Aggressiveness:** follow the `revision_stage` in the paper's
  `<paper_context>` (read `AGENTS.md`, then `CLAUDE.md`, then `paper-meta.md`).
  Do not override the stage; at `final polish`, do not restructure.

Return the strict four-section output, confirming in the preflight that no
decorative storytelling tell was introduced.

Section to revise:

$ARGUMENTS
