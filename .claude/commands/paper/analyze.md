---
description: "Run a new analysis the author names against the repository's own data with the paper-revision-editor skill's analyst lane: pin the specification before running, author a new script, report the whole result whichever way it points, and present it as a proposal (proposal only, no edits, no forking paths)."
argument-hint: "[the analysis to run, named by the author or a reviewer, plus the manuscript root or section files and the data or pipeline entry point]"
---

Dispatch the request below to the `paper-analyst` subagent, which loads the
`paper-revision-editor` skill's analyst lane
(`references/analysis-integrity.md`) and applies it in an isolated context.
If that subagent is unavailable, locate the installed skill yourself (check
`.claude/skills/paper-revision-editor/`,
`~/.claude/skills/paper-revision-editor/`, and
`~/.agents/skills/paper-revision-editor/`; the reference file lives inside
the skill, not next to this command), load its
`references/analysis-integrity.md`, and run its new-analysis capability
yourself, honoring its gate condition against your own tool surface: with no
shell tool, no write tool, or no data and analysis code in the repository,
return the degraded report the reference file specifies (say which half is
missing, assert nothing about the result, route the question to `Author
questions`) instead of improvising a computation.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
the exact analysis the author (or a reviewer through the author) named, which
files hold the manuscript, the data or pipeline entry point, and the user's
answers to any prior clarifying question (which outcome definition, which
subsample, which covariates are canonical).

This is the analyst lane's most powerful and most dangerous capability: it
computes something the author's pipeline never ran. It carries the
no-forking-paths rule as its load-bearing constraint. The specification is
pinned before the run, and the whole result is reported whichever way it
points; the analyst never scans specifications, subgroups, or outcome
definitions for a favorable result, never invents the question itself, and
never runs an analysis to "strengthen the results" on its own initiative. If
the author has not actually named an analysis, ask for it rather than
proposing one. Nothing the author tracks gets edited: the manuscript, the
analysis code, and the data all stay untouched; the new script is authored as
a new file in a proposal location, and the result enters `Revised text` as a
clearly marked candidate for the author to decide on, never woven into an
existing claim. Choose the manuscript file set as `/paper:read` does: follow
a provided root's include graph and never sweep in files it does not include.

Preset triage:

- **Scope:** one new analysis, proposal only, no rewrite and no edit of any
  kind. The `Revised text` block carries the new result as a clearly marked
  candidate addition with its full provenance (the script authored, the
  command, the data version); `Change rationale` carries the run log instead
  of change lines.
- **Unit:** the single analysis the author named. Pin its specification (the
  outcome, the sample or subgroup, the model or test, and what result counts
  as which answer) before running; if the author named a grid, run and report
  the whole grid.
- **Aggressiveness:** none as an editor. This pass computes only the pinned
  specification, authors only new files, never overwrites the author's code
  or data, and reports a result that weakens a claim as plainly as one that
  supports it, per the reference file's integrity norms.

Return the strict four-section output. The Diagnosis names the pinned
specification and the full result (the whole grid when the author named one),
labeling anything exploratory as exploratory. Each `Author question` ends
with a question mark and includes the belongs-in-the-paper decision (does this
new result belong in the paper?). When the author adopts a new result,
recommend `/paper:consistency` over the whole paper, since a new number may
change what the abstract, introduction, and discussion should say.

Analysis to run (named by the author), the manuscript, and the data entry point:

$ARGUMENTS
