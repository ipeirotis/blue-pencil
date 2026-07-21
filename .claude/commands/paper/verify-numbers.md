---
description: "Verify the manuscript's reported numbers against the repo's own data and analysis pipeline with the blue-pencil skill's analyst lane: rerun the author's pipeline, diff its outputs against every number in scope, and report match, mismatch, or unverifiable with provenance (verification only, no edits)."
argument-hint: "[manuscript root or section files; optionally the pipeline entry point, e.g. make results]"
---

Dispatch the request below to the `paper-analyst` subagent, which loads the
`blue-pencil` skill's analyst lane
(`references/analysis-integrity.md`) and applies it in an isolated context.
If that subagent is unavailable, locate the installed skill yourself (check
`.claude/skills/blue-pencil/`,
`~/.claude/skills/blue-pencil/`, and
`~/.agents/skills/blue-pencil/`; the reference file lives inside
the skill, not next to this command), load its
`references/analysis-integrity.md`, and run the protocol yourself, honoring
its gate condition against your own tool surface: with no shell tool, or no data and analysis code in
the repository, return the degraded report the reference file specifies
(say which half is missing, assert nothing about the numbers, route the
question to `Author questions`) instead of improvising a check.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
which files hold the manuscript, the pipeline entry point when the user has
named one, and the user's answers to any prior clarifying question (which
producing command is canonical, which data snapshot is current).

This is number verification, not a prose pass. Nothing gets edited:
manuscript, analysis code, and data all stay untouched, and a mismatch is a
finding for the author, never a fix. Choose the manuscript file set as
`/paper:read` does: when a root or wrapper file is provided, follow its
include graph and never sweep in sibling files it does not include; when the
includes cannot be resolved, ask which files are in scope rather than
guessing. If no manuscript is present, ask for it before proceeding.

Preset triage:

- **Scope:** verification only, no rewrite and no edit of any kind. The
  `Revised text` block must read `No rewrite requested.`, and `Change
  rationale` carries the run log (commands executed, data version, run
  outcome) instead of change lines.
- **Unit:** every number in the manuscript scope provided below; default to
  the whole manuscript, abstract and tables included.
- **Aggressiveness:** none. This pass never edits anything, and it runs
  only the author's own pipeline: no new analysis code, no specification
  search, per the reference file's integrity norms.

Return the strict four-section output, with `No rewrite requested.` as the
revised text. The Diagnosis carries the verification table (match, then
mismatch, then unverifiable; every row names its manuscript location, and
every recomputed value carries the producing command and data version). The
skill's seven-item Diagnosis cap does not apply to this whole-paper
diagnosis-only pass: cover every number in scope. Each `Author question`
ends with a question mark. When mismatches are found, recommend
`/paper:consistency` over the whole paper after the author's corrections
land, since the same stale value may sit in the abstract, introduction, and
discussion.

Manuscript (and optional pipeline entry point):

$ARGUMENTS
