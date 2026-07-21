---
description: Run a whole-paper cross-section consistency check with the blue-pencil skill (diagnosis only, no rewrite).
argument-hint: "[paper root file, or a list of section files covering the whole paper]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`blue-pencil` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
the user's answers to any prior clarifying question and, on a repeat pass
over the same text, the edits the author declined, reworded, or reverted
since the last pass, so the across-rounds preservation rule can hold inside
the isolated dispatch.

This is a paper-level consistency pass, not a section edit. Read every section
named in the manuscript reference provided below. Treat paths as files to read.
Choose the file set by what the provided value is:

- **A root or wrapper file** (for example `paper.tex` or `main.tex`): the test
  is where the manuscript prose lives. When it is a thin wrapper whose
  `\input{...}` and `\include{...}` graph carries the sections, follow that
  graph recursively and check exactly the files it reaches; that graph is the
  paper. When the manuscript prose lives inline in the root file itself (its
  `\section{...}` headings carry the paper, with ancillary includes pulling in
  only a preamble, macro definitions, or a bibliography helper), check the root
  file's inline sections as the units, plus any included file that carries
  manuscript prose; ancillary includes are not the paper. In neither case sweep
  in sibling files the root does not include: a repo often holds
  `sections/old_results.tex`, abandoned drafts, or supplementary fragments, and
  checking those produces false claim-drift and stale-summary findings.
- **A directory**: scan it for the section files; here a broad scan is what the
  author asked for.
- **A wrapper with no resolvable includes** (or includes you cannot locate): say
  so, then ask the author which files are in scope rather than guessing from a
  broad sibling scan.

If no manuscript is present, ask for it before proceeding.

Do not rewrite. Load the skill's `references/consistency-checks.md` and check
every item on its checklist: terminology drift, claim drift and result
overstatement, inconsistent contribution framing, promise-delivery gaps,
unpaid precision debt, callout and forward-reference problems, unfilled
citation placeholders, and stale summaries. That file owns the checklist and
its reporting conventions; do not improvise a different list.

Preset triage:

- **Scope:** feedback only, no rewrite. The `Revised text` block must read
  `No rewrite requested.`, and `Change rationale` carries brief rationale
  bullets for the top diagnosis items instead of change lines.
- **Unit:** the whole paper provided below.
- **Aggressiveness:** bound by the `revision_stage` in `<paper_context>`. Since
  this pass only diagnoses, it never edits protected content; route every
  cross-section conflict that needs an author decision (which wording is
  correct, which result is the true one) to `Author questions`.

Return the strict four-section output, with `No rewrite requested.` as the
revised text. Each diagnosis item must name the sections in conflict (for
example `[abstract vs. results]`). The skill's seven-item Diagnosis cap does
not apply to this whole-paper diagnosis-only pass: report every finding, and
group findings by type with counts when the list grows long. Each
`Author question` ends with a question mark.

Manuscript to check:

$ARGUMENTS
