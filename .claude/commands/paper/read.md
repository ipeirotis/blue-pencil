---
description: "Read the whole paper front to back, cold, as its intended reader, with the blue-pencil skill: reading log, colleague test, delight audit, venue compliance, and a prioritized dispatch list (diagnosis only, no rewrite)."
argument-hint: "[paper root file, or a list of section files in reading order]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`blue-pencil` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
the user's answers to any prior clarifying question and, on a repeat read of
the same paper, the edits the author declined, reworded, or reverted since
the last pass, so the across-rounds preservation rule can hold inside the
isolated dispatch.

This is a whole-paper cold read, not a section edit and not a per-section
feedback sweep. Read every section named in the manuscript reference provided
below, front to back, once, in reading order. Treat paths as files to read.
Choose the file set by what the provided value is:

- **A root or wrapper file** (for example `paper.tex` or `main.tex`): the test
  is where the manuscript prose lives. When it is a thin wrapper whose
  `\input{...}` and `\include{...}` graph carries the sections, follow that
  graph recursively and read exactly the files it reaches, in the order the
  root includes them; that graph is the paper. When the manuscript prose lives
  inline in the root file itself (its `\section{...}` headings carry the
  paper, with ancillary includes pulling in only a preamble, macro
  definitions, or a bibliography helper), read the root file's inline sections
  as the units, plus any included file that carries manuscript prose;
  ancillary includes are not the paper. In neither case sweep in sibling files
  the root does not include: a repo often holds `sections/old_results.tex`,
  abandoned drafts, or supplementary fragments, and reading those corrupts the
  reading experience being measured.
- **A directory**: scan it for the section files and confirm the reading order
  with the author before reading.
- **A wrapper with no resolvable includes** (or includes you cannot locate):
  say so, then ask the author which files are in scope rather than guessing
  from a broad sibling scan.

If no manuscript is present, ask for it before proceeding.

Do not rewrite. Load the skill's `references/cold-read.md` and run its
protocol: the reading log at each section boundary, the quote-grounded
colleague test compared against `core_thesis`, the delight audit, the
venue-compliance checks
`target_venue` supports, and the closing prioritized dispatch list. That file
owns the protocol and its reporting conventions; do not improvise a different
report.

Preset triage:

- **Scope:** feedback only, no rewrite. The `Revised text` block must read
  `No rewrite requested.`, and `Change rationale` carries brief rationale
  bullets for the prioritization instead of change lines.
- **Unit:** the whole paper provided below, read front to back in reading
  order.
- **Aggressiveness:** diagnosis only; this pass never edits the manuscript.
  The dispatch list must respect the stored `revision_stage` in
  `<paper_context>`: never recommend restructuring passes at `final polish`,
  and at `response to reviewers` route the author to `/paper:triage` and
  `/paper:rebut` instead of the whole-paper loop.

Return the strict four-section output, with `No rewrite requested.` as the
revised text. The Diagnosis carries the reading log, the colleague test, the
delight audit, and the venue-compliance findings, grouped under those
headings, and closes with the prioritized dispatch list. The skill's
seven-item Diagnosis cap does not apply to this whole-paper diagnosis-only
pass: report every finding. Each `Author question` ends with a question mark.

Manuscript to read:

$ARGUMENTS
