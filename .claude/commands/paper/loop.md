---
description: "Drive the whole-paper revision loop with the paper-revision-editor skill: emit a staged edit plan first, then process sections one at a time with author checkpoints. Diagnose globally, edit locally, validate globally, polish conservatively."
argument-hint: "[manuscript root dir, or a list of section files in reading order]"
---

You drive a whole-paper revision. You are not the editor: the
`paper-revision-editor` skill is the source of truth for every individual edit,
and you dispatch each per-section pass to the `paper-reviser` subagent (which
loads the skill in an isolated context). Your job is to teach the author how to
drive the skill across a whole paper, then walk it with them. You always emit
the staged plan first, and you stop at every author checkpoint. The governing
principle is **diagnose globally, edit locally, validate globally, then polish
conservatively.**

The value provided below names the manuscript: a root directory to scan for
section files, an explicit list of section files, or a root or wrapper TeX file
(for example `paper.tex` or `main.tex`). For a TeX root, the test is where the
manuscript prose lives, not whether the file has includes. When it is a thin
wrapper whose `\input{...}` and `\include{...}` graph carries the sections,
follow that graph recursively to find the actual section files rather than
treating the wrapper as one section; that graph is the paper. When manuscript
prose lives inline in the file itself (its `\section{...}` commands or Markdown
headings carry prose, even when ancillary includes pull in a preamble, macro
definitions, a bibliography helper, or appendix metadata), the section list is
the inline headings plus any included file that carries manuscript prose: a
hybrid root (some sections inline, others behind `\input{...}`) contributes
both kinds of unit, and ancillary includes are not the paper. Confirm that
detected list with the author in Step A and process one unit at a time, exactly
as the loop would process section files. If it is empty, ask for the manuscript
location before doing anything else.

## Hard guardrails (do not violate)

- Emit the staged plan (the next section) before any editing, and do not start
  rewriting until the author has seen it and confirmed the section order.
- Never rewrite the whole paper in one pass. Process one section at a time.
- Honor `revision_stage` from `<paper_context>` throughout. Do not flip it to
  `final polish` until the final-polish step, and only with the author's
  go-ahead.
- Carry the skill's hard rules through every pass: no change to the meaning of
  any technical claim, no em-dash (unless an explicit `style_overrides:` line
  in `<paper_context>` sets that house rule aside), no invented or removed
  citations, no silent deletion, no change to a numerical claim, statistic,
  citation, equation, cross-reference, or quoted text, and no substance added
  that the manuscript does not contain. Anything that would touch those comes
  back as an `Author question`, never a silent edit.
- Stop at each author checkpoint and wait. Do not advance past unresolved
  `Author questions`.
- Every dispatched pass runs isolated and sees only what the dispatch carries,
  not this conversation. Pass everything the subagent needs in each dispatch:
  the section text or path, the reviewer text when relevant, the author's
  answers to any clarifying question a prior pass raised, and, on a repeat
  pass over a section, the decision record: the edits the author declined,
  reworded, or reverted since the last pass, so the across-rounds preservation
  rule can hold inside an isolated dispatch.
- Do not repeat a pass merely to get a different rewrite. Unchanged prose is a
  valid successful result, and a rewrite that touches every paragraph is
  suspect.

## Step A: Emit the staged plan first (no editing)

Read `<paper_context>` from `AGENTS.md`, then `CLAUDE.md`, then `paper-meta.md`,
scan the manuscript for sections (following `\input`/`\include` from a wrapper
file as described above), and return a plan with exactly these parts:

1. **Paper context:** found or missing. If missing or any of `target_venue`,
   `audience`, `core_thesis`, `revision_stage` is absent or ambiguous, stop here
   and tell the author to run `install.sh --init` or fill the four fields by
   hand. Do not guess.
2. **Current revision stage**, and one line on what it permits (first draft:
   restructuring allowed; response to reviewers: only flagged paragraphs and
   their neighbours; final polish: sentence-level only). If the stage is
   `response to reviewers`, do not run this whole-paper loop: it would diagnose
   and rewrite sections the reviewers accepted, which that stage gate forbids.
   Stop here and route the author to the response suite: `/paper:triage` on the
   decision letter first (severity-ranked comment table, section mapping, order
   of work), then `/paper:rebut` per section (which edits only reviewer-flagged
   paragraphs and their neighbours); or ask them to move the stage to
   `first draft` or `final polish` first. Do not change the stage yourself.
3. **Detected sections**, mapped to files. The author may name detected
   sections to leave out (for example appendices, or low-priority sections
   under a deadline); record that author-approved skip list in the plan and
   treat the skipped sections as out of scope for every later step: the
   Step B pass order, the Step D consistency check, the Step E rerun and
   re-validation, the Step F polish, and the Step G stop condition. A
   whole-paper cold read still reads the skipped sections, since a reader
   cannot skip them, but its dispatch-list entries for skipped sections are
   recorded in the plan, never dispatched.
4. **Recommended pass order** for the whole paper.
5. **First command to run.**
6. **Stop and repeat criteria** (the convergence rule in the last step).

Present this and stop. Do not edit anything yet. The example diagnoses the
whole paper before any rewrite, so global problems (thesis, terminology,
reader momentum) surface before a single edit is baked in:

```
Detected revision_stage: first draft.
Recommended loop:
  Phase 1, diagnose globally (one whole-paper cold read, no rewriting):
    /paper:read paper.tex
    If the repo holds your data and analysis code:
      /paper:verify-numbers paper.tex   (verification only, no edits)
    If the environment grants literature retrieval:
      /paper:scholar paper.tex          (citation and novelty checks, no edits)
    Then resolve the Author questions these passes raise and confirm the
    read's prioritized dispatch list; that list feeds the Phase 2 pass order.
  Phase 2, rewrite section by section in the Step B order:
    /paper:revise sections/abstract.tex
    If exposition gaps remain: /paper:clarify sections/abstract.tex
    If list rhythm or AI-flatness remains: /paper:human sections/abstract.tex
    Resolve any new Author questions, re-run feedback, then move on.
    ... (repeat per section)
  Phase 3, validate and polish:
    /paper:consistency paper.tex
    Rerun the abstract and introduction, re-check consistency,
    then /paper:read paper.tex to confirm the exit criterion,
    then /paper:polish each section.
```

## Step B: Recommended pass order

Diagnose globally first: one whole-paper cold read (`/paper:read`, whose
protocol lives in the skill's `references/cold-read.md`), not a per-section
feedback sweep, so the diagnosis measures the front-to-back reading experience
the per-section passes never see. When the repo also holds the author's data
and analysis code, run `/paper:verify-numbers` once after the cold read and
before any rewrite, so a stale number is caught before the prose passes repeat
it; the command is gated (it needs that pipeline and a shell) and reports what
is missing instead of checking anything when the gate fails, and its
recomputed values are proposals the author applies to the source, never edits
the loop performs. Likewise, when the environment grants literature retrieval,
run `/paper:scholar` in the same phase to check the citations and novelty
claims the cold read flagged, so an unsupported citation or an overstated
contribution is caught before the prose passes polish it; it is gated the same
way (it needs retrieval) and reports what is missing instead of citing from
memory when the gate fails, and its citation changes and recalibrated claims
are proposals the author applies to the source, never edits the loop performs.
Resolve the `Author questions` these global passes raise,
then rewrite in this order, using the cold read's prioritized dispatch list to
decide which sections need which targeted passes:

`abstract -> introduction -> results -> methods -> related work -> discussion -> conclusion`

This order is a template for the canonical sections. Insert every other section
Step A detected (for example Background, Experiments, Limitations, an Appendix)
at its reading-order position, so the loop rewrites each detected file. The stop
condition in Step G is not satisfied while any detected section is still
unprocessed; do not skip a detected section just because it is not one of the
seven labels above. The only sections the loop may skip are the ones on the
author-approved skip list recorded in Step A.

The abstract and introduction are edited twice across the loop, but each pass
appears exactly once in the steps so the driver never double-runs them. This
first pass (here, at the front of the order) sets the spine and contribution
frame the body must serve. The second pass is Step E, after the body is stable
and the Step D consistency check has run, so it reflects the final paper; Step E
then re-validates with `/paper:consistency` so any drift that second pass
introduces is caught before the sentence-only final polish, which cannot repair
it. Do not add a second abstract or introduction pass to this order; that is
Step E's job. Confirm the mapping onto the actual files with the author before
editing.

## Step C: Per-section loop (run for each section, in the Step B order)

`/paper:revise` is the default and does most of the work. The targeted passes
are second passes, run only when the diagnosis points to their specific problem,
not on every section.

The author checkpoint is recurring, not a single gate. Every pass below
(`feedback`, `revise`, `clarify`, and `human`) can surface new `Author
questions`, so after any pass that returns them, stop and resolve them before the
next pass on this section or the move to the next section. The edits depend on
the answers, so unresolved questions must not flow into a later pass.

Author edits between passes are part of the decision record: a passage the
author hand-tuned, reworded, or reverted since the last pass is deliberate, so
a later pass never re-proposes the rejected edit and notes an apparent
reversion in `Author questions` once, not on every pass. Track those declined
and reverted edits as the loop runs, and carry the list in every repeat
dispatch for the section (per the dispatch guardrail above): the subagent
cannot see this conversation, so a rejection you do not carry is a rejection
it cannot honor.

1. **Diagnose:** `feedback` on the section. Always first. Carry the cold
   read's findings for this section in the dispatch, per the dispatch
   guardrail above, and collect the pass's `Author questions`.
2. **Author checkpoint:** the author answers the `Author questions` and folds
   the answers into the source (the missing number, definition, example, or
   mechanism the skill is not allowed to invent). Do not proceed until they are
   resolved or explicitly deferred.
3. **Rewrite:** `revise` for the full diagnose-then-rewrite pass. Then stop at
   the checkpoint and resolve any new `Author questions` it raised.

   Between passes, ask the author whether to apply the accepted revision to the
   section file. Convergence (item 6) is checked against the file, so an
   unapplied revision means the next `feedback` pass re-reports the same items
   by design.
4. **Clarify (only if needed):** `clarify` when the reader lacks definitions,
   intuition, motive, inferential bridges, concrete anchors, or paragraph
   payoff. Repeat only until the reader can state the question, the motive, each
   object's role, the evidence, and the payoff, or until the remaining issues
   are all `Author questions` needing new substance. Do not repeat it just to
   make prose smoother. Resolve any new `Author questions` before continuing.
5. **Humanize (only if needed):** `human` when the section is flat, list-like,
   or LLM-sounding. Repeat only if the section still has no findable turn; stop
   once it has a visible setup, tension, therefore-response spine. Add structure,
   not decoration. Resolve any new `Author questions` before continuing.
6. **Converge:** re-run `feedback`, and move to the next section when no
   structural item remains and every `Author question` is either resolved or
   explicitly deferred. Record each deferral in the manuscript (for example as a
   short `% TODO` comment at the relevant spot) and treat it as cleared for
   progression, so a later `feedback` re-reporting the same open question does not
   trap the loop on this section. Convergence requires the structural items to be
   gone, not the deferred questions.

Reviewer-driven work uses `rebut` instead of this loop, edited only on the
reviewer-flagged paragraphs and their immediate neighbours.

## Step D: Cross-section consistency (validate globally)

Once every section has converged individually, run `/paper:consistency` over the
whole paper. It does not rewrite; it flags terminology drift, claim drift,
inconsistent contribution framing, result overstatement, missing forward
references, stale summaries, and figure or table callout problems, and asks
whether the abstract, introduction, methods, results, discussion, and conclusion
describe the same paper. When Step A recorded a skip list, hand this check only
the in-scope section files, so a skipped section cannot generate findings or
`Author questions` that block the loop. Resolve its `Author questions` and fold
fixes back into the relevant sections.

## Step E: Re-run abstract and introduction, then re-validate

With the body stable, re-run `revise` on the abstract and the introduction so
they reflect the final argument, emphasis, results, and contribution frame; if
either is on the Step A skip list, leave it alone like any other skipped
section. Where a section lacks a memorable idea, the skill flags that as a
structural gap rather than inventing a slogan; surface it to the author.

This rerun can change contribution wording or result summaries after the Step D
consistency check, so run `/paper:consistency` once more over the abstract and
introduction against the body before polishing. Hand this re-validation only
in-scope files, like Step D: a front-matter section on the Step A skip list
stays out, and when both front-matter sections are skipped there was no rerun,
so skip this re-validation too. The final polish in Step F is sentence-level
only and cannot repair fresh cross-section drift, so any drift this rerun
introduced must be caught and resolved here.

With the re-validation clean, run one more whole-paper cold read
(`/paper:read`). It reads the full detected section set, including any Step A
skipped sections, since a reader cannot skip them and a read narrowed to the
in-scope files would report a clean front-to-back experience without checking
the actual paper; per the Step A rule, its findings and dispatch-list entries
confined to skipped sections are recorded in the plan, never dispatched. It is
the loop's exit criterion (Step G), and it runs before the final polish
because polish is sentence-level only and cannot repair what the read finds.
When its dispatch list asks for more than a polish on in-scope sections, feed
the flagged sections back into the Step B order and return here afterwards.

## Step F: Final polish (conservative)

Only now, with the author's go-ahead, run `/paper:polish` section by section (or
set `revision_stage` to `final polish` and run `revise`). Sentence-level
copyediting only: no paragraph reordering, no new explanatory content, no
structural cuts. One pass per section, skipping the sections on the Step A
skip list.

## Step G: Stop condition

Stop the loop when all of these hold:

- Every section not on the author-approved skip list from Step A has had at
  least one `feedback` or `revise` pass.
- All `Author questions` are answered in the manuscript or explicitly deferred.
- No section-level diagnosis remains that requires moving paragraphs, changing
  claims, adding evidence, defining terms, or supplying examples.
- The final polish changes only sentence-level issues, and the `Change
  rationale` is mostly copyediting, referent repair, terminology consistency,
  stress position, rhythm, or safe compression.
- The read-cold pass finds no unclear referents, AI tells, inconsistent terms,
  abbreviation drift, tense drift, unit-format drift, or missing paragraph
  payoff.
- The Step E closing cold read, run over the full section set, came back
  clean outside the author-approved skip list: no reading-log break points,
  the colleague test matches `core_thesis`, no must-fix delight or
  venue-compliance findings, and a dispatch list asking for nothing beyond the
  final polish. Findings confined to skipped sections are reported for the
  author's record but do not block the stop; leaving them unfixed was the
  author's Step A call.

Two stop rules compose here. The cold read decides whether the loop dispatches
another pass: the loop is done when a cold read of the whole paper comes back
clean outside the skip list and the colleague test matches `core_thesis`. Inside any
single dispatched pass, the editor's stop rule is unchanged: the correct
stopping point is not "nothing more can be rewritten" but "the remaining edits
would be merely different rather than better", so the cold read's pursuit of a
delighted reader never justifies churn edits.

---

Manuscript to edit:

$ARGUMENTS
