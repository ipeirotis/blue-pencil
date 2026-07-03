---
description: Run a whole-paper cross-section consistency check with the paper-revision-editor skill (diagnosis only, no rewrite).
argument-hint: "[paper root file, or a list of section files covering the whole paper]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`paper-revision-editor` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

This is a paper-level consistency pass, not a section edit. Read every section
named in the manuscript reference provided below. Treat paths as files to read.
Choose the file set by what the provided value is:

- **A root or wrapper file** (for example `paper.tex` or `main.tex`): follow its
  `\input{...}` and `\include{...}` graph recursively and check exactly the files
  that graph reaches. That graph is the paper. Do not also sweep in sibling files
  the wrapper does not include: a repo often holds `sections/old_results.tex`,
  abandoned drafts, or supplementary fragments, and checking those produces false
  claim-drift and stale-summary findings.
- **A directory**: scan it for the section files; here a broad scan is what the
  author asked for.
- **A wrapper with no resolvable includes** (or includes you cannot locate): say
  so, then ask the author which files are in scope rather than guessing from a
  broad sibling scan.

If no manuscript is present, ask for it before proceeding.

Do not rewrite. Check whether the abstract, introduction, contribution claims,
methods, results, discussion, and conclusion describe the same paper, and flag:

- terminology drift (the same construct named differently across sections, or
  one term naming two constructs)
- claim drift and result overstatement (a result reported one way in results and
  a stronger way in the abstract, intro, or discussion)
- inconsistent contribution framing (contributions named or counted differently
  across abstract, intro, and conclusion)
- promise-delivery gaps (claims the intro makes that the body never delivers)
- missing or out-of-order forward references, and figure, table, theorem, or
  result callouts that do not resolve
- citation placeholders left unfilled
- stale summaries (an abstract or intro that previews a paper the body no longer
  matches)

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
example `[abstract vs. results]`). Each `Author question` ends with a question
mark.

Manuscript to check:

$ARGUMENTS
