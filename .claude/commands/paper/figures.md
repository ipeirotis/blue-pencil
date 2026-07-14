---
description: "Regenerate a named figure with better visual design from the same data and scripts with the paper-revision-editor skill's analyst lane: re-render the plot the author's own pipeline produces, changing how the data is shown and never which data, and propose it side by side with the original (proposal only, no edits)."
argument-hint: "[which figure to regenerate, plus the manuscript root or section files; optionally the plotting script or data path]"
---

Dispatch the request below to the `paper-analyst` subagent, which loads the
`paper-revision-editor` skill's analyst lane
(`references/analysis-integrity.md`) and applies it in an isolated context.
If that subagent is unavailable, locate the installed skill yourself (check
`.claude/skills/paper-revision-editor/`,
`~/.claude/skills/paper-revision-editor/`, and
`~/.agents/skills/paper-revision-editor/`; the reference file lives inside
the skill, not next to this command), load its
`references/analysis-integrity.md`, and run its figure-regeneration
capability yourself, honoring its gate condition against your own tool
surface: with no shell tool, no write tool, or no data and plotting code in
the repository, return the degraded report the reference file specifies (say
which half is missing, assert nothing about the figure, route the question
to `Author questions`) instead of improvising a re-render.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
which figure to regenerate, which files hold the manuscript, the plotting
script or data path when the user has named one, and the user's answers to
any prior clarifying question (which script produces the figure, which data
snapshot is current).

This regenerates one figure's presentation, it is not a prose pass and not a
new analysis. Nothing the author tracks gets edited: the manuscript, the
analysis code, the data, and the original figure all stay untouched, and the
re-render is authored as a new file in a proposal location and offered
alongside the original for the author to choose. A re-render that changes a
value, an axis range that hides points, a series that was not there, or a
smoothing the original did not apply is a new analysis, not a regeneration,
and it belongs to `/paper:analyze` under its rules. Choose the manuscript
file set as `/paper:read` does: when a root or wrapper file is provided,
follow its include graph and never sweep in sibling files it does not
include. If no figure is named, or no manuscript is present, ask before
proceeding; never sweep the paper re-rendering every plot uninvited.

Preset triage:

- **Scope:** figure regeneration only, no rewrite and no edit of any kind.
  The `Revised text` block carries the proposed re-render (the new figure
  with the exact script and command that produced it) alongside the original;
  `Change rationale` carries the run log (script authored, command run, data
  version) instead of change lines.
- **Unit:** the named figure only. Find its own producing script and data,
  re-render from the same values, and confirm the values did not change.
- **Aggressiveness:** none. This pass never edits anything the author tracks
  and never overwrites the author's figure or figure script; it changes only
  the presentation (color, scale labeling, ordering, gridlines), never the
  plotted values, per the reference file's integrity norms.

Return the strict four-section output. The Diagnosis names what changed in
presentation and confirms the values did not, with the producing script and
data version. Each `Author question` ends with a question mark and includes
the adopt-or-keep decision (adopt the re-render, or keep the original?). When
the author adopts a figure that carries a different emphasis, recommend
`/paper:consistency` over the whole paper, since the surrounding text may
describe the old figure.

Figure to regenerate (and the manuscript, optional plotting script or data):

$ARGUMENTS
