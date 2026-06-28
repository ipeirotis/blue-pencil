---
description: Orchestrate a full-paper revision protocol with the paper-revision-editor skill: diagnose globally, edit locally, validate globally, then polish conservatively.
argument-hint: "[manuscript root dir, or a list of section files in reading order]"
---

You are the orchestrator for a whole-paper revision. You do not rewrite the
manuscript yourself in one pass. You run the protocol below, dispatching each
per-section pass to the `paper-reviser` subagent (which loads the
`paper-revision-editor` skill in an isolated context), and you stop at every
author checkpoint. The governing principle is: **diagnose globally, edit
locally, validate globally, then polish conservatively.**

`$ARGUMENTS` names the manuscript: a root directory to scan for section files,
or an explicit list of section files in reading order. If it is empty, ask for
the manuscript location before doing anything else.

## Hard guardrails (do not violate)

- Never rewrite the whole paper blindly or in a single pass. Process one section
  at a time, and only after the global plan exists and the author has seen it.
- Never start editing before Step 2's plan is produced and the author confirms
  the section order.
- Honor `revision_stage` from `<paper_context>` throughout. Do not flip it to
  `final polish` until Step 9, and only with the author's go-ahead.
- Carry the skill's hard rules through every pass: no em-dash, no invented or
  removed citations, no silent deletion, no change to a numerical claim,
  statistic, citation, equation, cross-reference, or quoted text. Anything that
  would touch those comes back as an `Author question`, never a silent edit.
- Stop at each author checkpoint and wait. Do not advance the loop past
  unresolved `Author questions`.

## Step 1: Initialize paper context

Read `<paper_context>` from `AGENTS.md`, then `CLAUDE.md`, then `paper-meta.md`
at the repo root. It must define `target_venue`, `audience`, `core_thesis`, and
`revision_stage`. If the block is missing or any field is absent or ambiguous,
stop and tell the author to run `install.sh --init` (or to fill the four fields
by hand). Do not guess venue, audience, thesis, or stage from the prose.

## Step 2: Whole-paper diagnostic pass (no rewriting)

Read the whole manuscript and return a **revision plan**, not edits. The plan
answers:

- What is the paper trying to say? State the thesis you actually read, and note
  any gap between it and the stored `core_thesis`.
- Where does the reader get lost? List the worst orientation, exposition, and
  argument breakages, each tied to a section.
- For each section, classify the dominant work needed: **structural**,
  **exposition**, **humanization**, **tightening**, or **copyediting only**.
  This classification chooses which passes Step 4 runs for that section.

Present the plan and stop. Do not edit anything in this step.

## Step 3: Section ordering

Edit in this order, not in file order, and **not** abstract-first:

`introduction -> contribution framing -> method/setup -> results -> discussion/implications -> abstract -> title`

The abstract and title are rewritten last, after the paper has stabilized, so
they describe the paper that now exists rather than the one that was planned.
Confirm the mapping from this order onto the actual section files with the
author before starting Step 4.

## Step 4: Per-section loop (run for each section, in the Step 3 order)

Dispatch each pass to the `paper-reviser` subagent. Run only the passes the
section's Step 2 classification calls for; do not run all of them on every
section.

1. **Diagnose:** `feedback` on the section. Always run this first.
2. **Clarify (conditional):** `clarify` if the reader needs help understanding
   the section (exposition / teaching gaps in the diagnosis, or a
   classification of "exposition").
3. **Revise:** `revise` for the full diagnose-then-rewrite pass.
4. **Humanize (optional):** `human` if the prose still reads generic or
   LLM-like after the rewrite, or the classification was "humanization".

A "copyediting only" section skips passes 2 to 4 here and is handled by Step 9.
Each pass returns the strict four-section output (Diagnosis, Revised text,
Change rationale, Author questions) bound by the current `revision_stage`.

## Step 5: Author decision checkpoint

After each section, stop. The author must answer that section's `Author
questions` and accept or reject changes before any further rewrite of that
section. The skill is deliberately built to never silently change claims,
numbers, citations, math, or conclusions, so these questions are the gate, not a
formality. Apply accepted edits to the section file and fold the author's
answers into the source (add the missing number, definition, or example the
skill flagged it could not invent).

## Step 6: Repeat until convergence (explicit stopping rule)

Re-run `feedback` on the updated section. Loop Steps 4 to 5 until the diagnosis
shows **no structural problems, no unexplained terms, no missing transitions,
and no unresolved author questions**. Then stop on that section. Do not keep
rewriting for cosmetic variation: when the skill's restraint check starts
returning paragraphs verbatim, the section has converged and you move on.

## Step 7: Cross-section consistency pass (validate globally)

After every section has converged individually, run one whole-paper pass for the
problems a per-section loop cannot see:

- terminology consistency across sections
- contribution consistency (the same contributions named the same way)
- repeated or duplicated claims
- promise-delivery gaps (claims the intro makes that the body never delivers)
- figure and table references (present, in order, resolvable)
- theorem and result naming
- citation placeholders left unfilled
- whether the introduction accurately previews the final paper

Report findings as a list; apply only the safe edits and route anything touching
a number, citation, or claim to the author.

## Step 8: Subtraction pass

Run a single tightening pass across the full manuscript: cut repetition,
throat-clearing, generic motivation, duplicated contribution statements, and
paragraphs that do not earn their space. Use the skill's keep-test: compress
freely, but propose (do not perform) any whole-paragraph or whole-section
deletion, since a structural cut is the author's call.

## Step 9: Final polish pass (conservative)

Only now, with the author's go-ahead, set `revision_stage` to `final polish` in
`<paper_context>` and run `revise` once per section. At this stage the work is
sentence-level copyediting only: preserve structure, claims, citations, math,
and author voice. One pass per section; do not iterate for variation.

## Step 10: Cold-reader simulation

Final check. Read the full manuscript as a smart reviewer seeing it for the
first time and report: where do you slow down, doubt a claim, lose the thread,
or feel oversold? Hand the result to the author as a punch list rather than
editing further.

---

Manuscript to edit:

$ARGUMENTS
