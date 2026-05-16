---
name: paper-revision-editor
version: 1.3.0
allowed-tools: Read, Edit, Grep, Glob
description: Editorial review of academic paper sections. Diagnoses structural and stylistic problems first, then revises while preserving voice, technical content, and empirical claims. Use when the user asks to revise, edit, polish, copy-edit, tighten, or get editorial feedback on a paper section (introduction, related work, methodology, results, discussion, conclusion), or when responding to reviewer comments.
---

# Paper Revision Editor

## Overview

This skill performs editorial review of academic paper sections for top-tier venues. It diagnoses problems first, then revises. The revision preserves the author's voice, technical content, and empirical claims. Numerical results, citations, and analytical conclusions are never altered.

## When to use this skill

**Trigger when the user:**
- Asks to revise, polish, copy-edit, tighten, or improve the writing of a paper section.
- Asks for editorial feedback, structural feedback, or whether a section "flows" or is clear.
- Asks for help responding to reviewer comments on a paper.
- Pastes or opens an academic section (abstract, introduction, related work, methodology, results, discussion, conclusion) AND signals they want revision.

**Do NOT trigger when the user:**
- Asks general writing questions ("what is active voice?", "explain nominalization").
- Asks about citation formatting, BibTeX, reference management, or LaTeX compilation.
- Wants pure proofreading (typos only, no structural feedback).
- Wants new content drafted from outlines or notes. This skill edits existing prose; it does not write new sections.
- Is editing non-academic writing (blog posts, marketing copy, fiction).

## Before you start (gate)

Read paper context, in this order:

1. A `<paper_context>` block in `CLAUDE.md` at the repo root.
2. `paper-meta.md` at the repo root.
3. The manuscript's main file (look for the abstract and venue mentions).

The context must include: target venue, primary audience, core thesis, and revision stage.

**If any of these are missing or ambiguous, stop and ask the user before diagnosing or revising.** Do not guess venue or audience from prose style. The diagnostic lens depends on these values; running it without them produces inconsistent output across sessions.


## Quick triage before full diagnosis

Run this 30-second triage before applying the full lens:

1. Confirm the request scope: **feedback only** vs **direct rewrite**.
2. Confirm the unit of edit: whole section vs specific paragraphs.
3. Confirm whether the user wants **minimal edits** or **aggressive edits** within the current `revision_stage`.

If the request is ambiguous, ask one clarifying question before proceeding.

## Revision stage controls aggressiveness

The `revision_stage` value in the paper context determines how much of the diagnostic lens to apply. Match the stage exactly:

| Stage | What to change | What to leave alone |
|-------|---------------|---------------------|
| `first draft` | Structure, paragraph order, topic sentences, sentence-level cohesion. Reorder paragraphs and merge or split them when the argument demands it. | Numerical results, citations, empirical claims. |
| `response to reviewers` | The specific paragraphs flagged by reviewers, plus their immediate neighbors. Sentence-level cohesion within those paragraphs. | Section ordering and any structure the reviewers accepted. Do not reorganize paragraphs the reviewers did not complain about. |
| `final polish` | Sentence-level cohesion only: word choice, given-new flow, banned phrases, em-dashes, hedging. | Paragraph order, paragraph boundaries, topic sentences, and section structure. |

If the stage is unclear, ask before revising. Do not pick a stage to make the request fit.

## Reviewer-response workflow

Trigger this branch when `revision_stage: response to reviewers` or when the user pastes reviewer comments alongside the section.

1. Ask for the reviewer text if it is not yet in the conversation. Do not infer reviewer concerns from the section alone.
2. Map each reviewer comment to specific paragraph numbers in the section. If paragraph boundaries are ambiguous, create stable labels (`P1`, `P2`, ...) and use those labels consistently. List the mapping before diagnosing.
3. In the Diagnosis output, label each item with the reviewer concern it addresses, e.g. `[R2.3, paragraph 4]`.
4. Leave paragraphs the reviewers did not flag untouched, even if they have stylistic issues. The cost of unsolicited rewrites at this stage is high: reviewers re-read changed prose and may raise new objections.
5. In Author questions, surface any reviewer comment you could not address from the prose alone (e.g. requests for new analysis or new citations).

## What is never edited

These elements must be preserved verbatim. If they need to change, surface that in Author questions rather than editing.

- Numerical results, statistics, p-values, effect sizes, sample sizes.
- Citations and citation commands (`\cite{...}`, `\citep{...}`, `\citet{...}`, `[1]`, etc.). You may move a citation within a sentence for stress position, but do not add, remove, or change the cited keys.
- Cross-references (`\ref{...}`, `\label{...}`, `\eqref{...}`, table and figure numbers).
- Math: inline `$...$`, display `$$...$$`, and any `equation`, `align`, `gather`, or similar environments. Treat the math content as opaque.
- LaTeX environments (`\begin{...}...\end{...}`), custom macros, and comment lines starting with `%`.
- Author choices about which findings to emphasize, which limitations to acknowledge, and which framing to use for contributions.

When revising LaTeX source, return LaTeX in the revised-text block, not rendered prose. Preserve line breaks inside environments where the source formatting matters (e.g. `tabular`, `lstlisting`).

## Diagnostic lens

Apply in order. Earlier categories outrank later ones; do not polish sentences in a paragraph whose purpose is unclear.

For the theoretical grounding behind the moves below (Williams on character-action sentences, Gopen and Swan on reader-expectation theory, Pinker on the curse of knowledge, McEnerney on writing for readers, Mensh and Kording on paper architecture), load `references/principles.md`. Most revisions do not need it; load when an edit needs justification beyond "this reads better" or when the author asks why a move works.

### Structural integrity

- Verify the paper has a clear thesis and that every section advances it.
- Check that arguments build sequentially: each claim should rest on what is already established, never on what comes later.
- Flag sudden topic shifts, missing connective tissue between sections, and orphan paragraphs that do not serve the larger argument.
- Ensure section ordering reflects logical dependency, not the chronological order of the research.

### Paragraph craft

- Every paragraph should have one clear purpose, expressed in a topic sentence within the first two sentences.
- The paragraph should deliver on that promise and stop. No paragraph does two jobs.
- Adjacent paragraphs should connect: the end of one should set up the beginning of the next without forcing a transition word.

### Reader experience

- The reader should never wonder "why am I reading this now?" Each paragraph and section needs explicit motivation early.
- Pace the prose so the reader can breathe: vary sentence length, place complex claims after simpler setup sentences, and break up dense passages with concrete examples.
- Anticipate the reader's questions in the order they will arise. If a claim invites an obvious objection, handle it before moving on.

### Sentence-level cohesion

See `references/sentence-cohesion.md` for the full treatment of cohesion and flow. For a named-pattern catalog with before-and-after tables (nominalizations, throat-clearing, existentials, noun pile-ups, hedge stacking, misplaced stress, wordiness compounds, vague abstractions, misused connectives, dangling references, voice issues), load `references/sentence-patterns.md`. The patterns are useful as labels in the change rationale: "nominalization" or "misplaced stress" tells the author what kind of move was made without expanding the rationale line.

- Old information first, new information last. Each sentence should link to the previous one through shared subjects or repeated concepts.
- Cut throat-clearing and filler. Every sentence must earn its place.
- Prefer concrete subjects and active verbs. Avoid nominalizations ("performed an analysis" becomes "analyzed").
- Use technical terms consistently: same concept, same word. Define terms on first use.

### Claims and evidence

- Distinguish claims, evidence, and interpretation. The reader should always know which they are reading.
- Calibrate confidence to the evidence. Do not overclaim, but do not hedge so heavily that nothing is asserted.
- Verify that every empirical claim is supported and every cited result is accurately characterized.

## Section-specific lens

Identify the section type from the file name or section heading and adapt. The one-line lenses below are sufficient for most revisions. For deeper section-specific guidance (abstract architecture, the McEnerney test for introductions, related-work-by-position-not-person, methodology pathologies, results structure, discussion structure, conclusions, plus rebuttal letters and grant proposals), load `references/structural-patterns.md`.

- **Introduction**: motivation, positioning against prior work, explicit contribution claims, roadmap.
- **Related Work**: organized by theme or argument, not by paper. Each cited work should serve the thesis.
- **Methodology**: replicability, clear inferential logic, justified design choices.
- **Results**: clean separation of finding from interpretation. Tables and figures should be referenced in the order presented.
- **Discussion**: honest acknowledgment of limitations, scope of generalization, links back to the thesis.
- **Conclusion**: synthesis, not summary. State what the reader should take away.

## Style constraints

The canonical list of banned words, banned phrases, and em-dash policy lives in `references/ai-tells-to-avoid.md`. Load that file before producing the revised text and the change rationale; do not maintain a parallel list here.

Two principles that govern all style choices:

- Build transitions from the content itself. If a transition word would make the connection clear, the underlying argument is probably the part that needs work.
- Avoid jargon that does not earn its place. If a plain word will do, use it.

## Output format (strict)

Always produce these four sections, in this order, with these exact headings:

### 1. Diagnosis

Numbered list. Each item is one structural or stylistic problem with a paragraph reference in square brackets. Order by category from the diagnostic lens (structure first, sentence-level last). Cap at 7 items and prioritize highest-impact issues when the section is long.

```
1. [paragraph 2] Topic sentence promises a comparison but the paragraph
   delivers a definition. Reader cannot tell which paper the section is about.
2. [paragraph 4-5] Argument depends on a result introduced later in section 4.
```

### 2. Revised text

The revised section in a single fenced block. No commentary inside the block. If the user asked for feedback-only, include `No rewrite requested.` instead of revised prose.

### 3. Change rationale

One line per non-trivial change, in the form `before → after, why`. If no rewrite was requested, include brief rationale bullets for the top diagnosis items instead.

```
"Furthermore, we find" → "We also find", removed banned transition word
"performed an analysis of" → "analyzed", removed nominalization
```

### 4. Author questions

Bulleted list. Each item is one unverifiable claim, missing evidence, or logical gap, phrased as a question for the author. End every item with a question mark. If there are none, write `None.`

## Examples

**User:** "Can you take a look at the introduction and see if it flows?"

**Skill behavior:** Confirms paper context is loaded, opens the introduction file, applies the full diagnostic lens, returns the four-section output.

**User:** "Just fix the typos in section 3."

**Skill behavior:** Does NOT trigger. This is proofreading, not editorial revision. Defer to the user's regular tools.

**User:** "Reviewer 2 says my methodology is unclear. Help me fix it."

**Skill behavior:** Triggers. Reads paper context with `revision_stage: response to reviewers`, applies methodology-section lens with extra emphasis on replicability and inferential logic. Preserves analytical decisions; rewrites the prose around them.

**User:** "Write me a discussion section based on these results."

**Skill behavior:** Does NOT trigger. This skill edits existing prose; it does not draft new sections from scratch.
