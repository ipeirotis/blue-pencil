---
description: "Verify a paper's citations and scan its novelty claims against the actual literature with the blue-pencil skill's scholar lane: fetch and read the cited sources, report each cited claim as supported, unsupported, or unverifiable, and return novelty leads, proposing any citation change as a flagged candidate (retrieval only, no edits)."
argument-hint: "[manuscript root or section files, or a named contribution/claim to check; retrieval must be available]"
---

Dispatch the request below to the `paper-scholar` subagent, which loads the
`blue-pencil` skill's scholar lane
(`references/literature-checks.md`) and applies it in an isolated context.
If that subagent is unavailable, locate the installed skill yourself (check
`.claude/skills/blue-pencil/`,
`~/.claude/skills/blue-pencil/`, and
`~/.agents/skills/blue-pencil/`; the reference file lives inside
the skill, not next to this command), load its
`references/literature-checks.md`, and run the protocol yourself, honoring
its gate condition against your own tool surface: with no literature
retrieval (no web fetch or search, or equivalent), return the degraded report
the reference file specifies (say retrieval is unavailable, assert nothing
about what any source contains, route the question to `Author questions`)
instead of improvising a check from memory.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
which files hold the manuscript, the specific contribution or claim to check
when the user has named one, and the user's answers to any prior clarifying
question (which claims are in scope, which sources are canonical).

This is citation and novelty checking, not a prose pass. Nothing gets edited:
a citation change and a recalibrated novelty claim are flagged candidates for
the author, never edits this pass performs. Choose the manuscript file set as
`/paper:read` does: when a root or wrapper file is provided, follow its
include graph and never sweep in sibling files it does not include; when the
includes cannot be resolved, ask which files are in scope rather than
guessing. Then, because verifying a citation means mapping its key to a real
work, also read the bibliography the manuscript points at (the `.bib` files
named by `\bibliography{}` or `\addbibresource{}`, an inline `thebibliography`
block, or a non-LaTeX reference list) so `\cite{key}` resolves to a title,
venue, year, and DOI before any retrieval; if no bibliography is discoverable,
ask for it rather than searching by bare key. If neither a manuscript nor a
named claim is present, ask for the scope before proceeding.

Preset triage:

- **Scope:** retrieval only, no rewrite and no edit of any kind. The
  `Revised text` block reads `No rewrite requested.` (the skill's shared
  diagnosis-only sentinel) when nothing is proposed; when a citation addition
  or recalibrated claim is proposed, it carries the candidate marked as a
  proposal with its retrieved source attached. `Change rationale` carries the
  retrieval log (each source fetched, with title, venue, year, and the passage
  read) instead of change lines.
- **Unit:** every cited claim and every contribution or novelty claim in the
  scope provided below; default to the whole manuscript's citations and
  contribution statements.
- **Aggressiveness:** none. This pass never edits anything. It reports only
  what it fetched and read (retrieved, not remembered) and returns novelty
  candidates as leads for the author to judge, never verdicts on the paper's
  contribution, per the reference file's integrity norms.

Return the strict four-section output. The Diagnosis carries the findings
(citation verification first: supported, then unsupported, then unverifiable;
then novelty leads; every row names its manuscript location, unsupported rows
quote what the source actually says, and novelty rows name the candidate work
and what to read). The skill's seven-item Diagnosis cap does not apply to
this whole-scope diagnosis-primary pass: cover every claim in scope. Each
`Author question` ends with a question mark. When an unsupported citation or
an accepted novelty correction lands, recommend `/paper:consistency` over the
whole paper afterward, since the same claim may echo in the abstract,
introduction, and discussion.

Manuscript (or named contribution/claim to check):

$ARGUMENTS
