---
description: Drive the whole-paper revision loop with the paper-revision-editor skill: emit a staged edit plan first, then process sections one at a time with author checkpoints. Diagnose globally, edit locally, validate globally, polish conservatively.
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

`$ARGUMENTS` names the manuscript: a root directory to scan for section files,
or an explicit list of section files. If it is empty, ask for the manuscript
location before doing anything else.

## Hard guardrails (do not violate)

- Emit the staged plan (the next section) before any editing, and do not start
  rewriting until the author has seen it and confirmed the section order.
- Never rewrite the whole paper in one pass. Process one section at a time.
- Honor `revision_stage` from `<paper_context>` throughout. Do not flip it to
  `final polish` until the final-polish step, and only with the author's
  go-ahead.
- Carry the skill's hard rules through every pass: no em-dash, no invented or
  removed citations, no silent deletion, no change to a numerical claim,
  statistic, citation, equation, cross-reference, or quoted text. Anything that
  would touch those comes back as an `Author question`, never a silent edit.
- Stop at each author checkpoint and wait. Do not advance past unresolved
  `Author questions`.
- Do not repeat a pass merely to get a different rewrite. Unchanged prose is a
  valid successful result, and a rewrite that touches every paragraph is
  suspect.

## Step A: Emit the staged plan first (no editing)

Read `<paper_context>` from `AGENTS.md`, then `CLAUDE.md`, then `paper-meta.md`,
scan the manuscript for sections, and return a plan with exactly these parts:

1. **Paper context:** found or missing. If missing or any of `target_venue`,
   `audience`, `core_thesis`, `revision_stage` is absent or ambiguous, stop here
   and tell the author to run `install.sh --init` or fill the four fields by
   hand. Do not guess.
2. **Current revision stage**, and one line on what it permits (first draft:
   restructuring allowed; response to reviewers: only flagged paragraphs and
   their neighbours; final polish: sentence-level only).
3. **Detected sections**, mapped to files.
4. **Recommended pass order** for the whole paper.
5. **First command to run.**
6. **Stop and repeat criteria** (the convergence rule in the last step).

Present this and stop. Do not edit anything yet. Example shape:

```
Detected revision_stage: first draft.
Recommended loop:
  1. /paper:feedback sections/intro.tex
  2. Resolve Author questions
  3. /paper:revise sections/intro.tex
  4. If exposition gaps remain: /paper:clarify sections/intro.tex
  5. If list rhythm or AI-flatness remains: /paper:human sections/intro.tex
  6. Move to the next section
  ...
  Final step: rerun the abstract and introduction, then a final polish.
```

## Step B: Recommended pass order

Diagnose every section first (feedback only), then rewrite in this order, since
the abstract and introduction are compressed versions of the whole paper and go
stale once the body changes:

`abstract -> introduction -> results -> methods -> related work -> discussion -> conclusion -> abstract again -> introduction again`

Confirm the mapping onto the actual files with the author before editing.

## Step C: Per-section loop (run for each section, in the Step B order)

`/paper:revise` is the default and does most of the work. The targeted passes
are second passes, run only when the diagnosis points to their specific problem,
not on every section.

1. **Diagnose:** `feedback` on the section. Always first. Collect its `Author
   questions`.
2. **Author checkpoint:** the author answers the `Author questions` and folds
   the answers into the source (the missing number, definition, example, or
   mechanism the skill is not allowed to invent). Do not proceed until they are
   resolved or explicitly deferred.
3. **Rewrite:** `revise` for the full diagnose-then-rewrite pass.
4. **Clarify (only if needed):** `clarify` when the reader lacks definitions,
   intuition, motive, inferential bridges, concrete anchors, or paragraph
   payoff. Repeat only until the reader can state the question, the motive, each
   object's role, the evidence, and the payoff, or until the remaining issues
   are all `Author questions` needing new substance. Do not repeat it just to
   make prose smoother.
5. **Humanize (only if needed):** `human` when the section is flat, list-like,
   or LLM-sounding. Repeat only if the section still has no findable turn; stop
   once it has a visible setup, tension, therefore-response spine. Add structure,
   not decoration.

Reviewer-driven work uses `rebut` instead of this loop, edited only on the
reviewer-flagged paragraphs and their immediate neighbours.

## Step D: Cross-section consistency (validate globally)

Once every section has converged individually, run `/paper:consistency` over the
whole paper. It does not rewrite; it flags terminology drift, claim drift,
inconsistent contribution framing, result overstatement, missing forward
references, stale summaries, and figure or table callout problems, and asks
whether the abstract, introduction, methods, results, discussion, and conclusion
describe the same paper. Resolve its `Author questions` and fold fixes back into
the relevant sections.

## Step E: Re-run abstract and introduction

With the body stable, re-run `revise` on the abstract and the introduction so
they reflect the final argument, emphasis, results, and contribution frame.
Where a section lacks a memorable idea, the skill flags that as a structural gap
rather than inventing a slogan; surface it to the author.

## Step F: Final polish (conservative)

Only now, with the author's go-ahead, run `/paper:polish` section by section (or
set `revision_stage` to `final polish` and run `revise`). Sentence-level
copyediting only: no paragraph reordering, no new explanatory content, no
structural cuts. One pass per section.

## Step G: Stop condition

Stop the loop when all of these hold:

- Every section has had at least one `feedback` or `revise` pass.
- All `Author questions` are answered in the manuscript or explicitly deferred.
- No section-level diagnosis remains that requires moving paragraphs, changing
  claims, adding evidence, defining terms, or supplying examples.
- The final polish changes only sentence-level issues, and the `Change
  rationale` is mostly copyediting, referent repair, terminology consistency,
  stress position, rhythm, or safe compression.
- The read-cold pass finds no unclear referents, AI tells, inconsistent terms,
  abbreviation drift, tense drift, unit-format drift, or missing paragraph
  payoff.

The correct stopping point is not "nothing more can be rewritten." It is "the
remaining edits would be merely different rather than better."

---

Manuscript to edit:

$ARGUMENTS
