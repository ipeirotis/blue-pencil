---
name: paper-revision-editor
version: 1.0.0
description: >-
  Editorial review of academic paper sections. Diagnoses structural and
  stylistic problems, then revises while preserving voice, technical content,
  and empirical claims.

  TRIGGER when the user says any of these: "revise this section", "edit
  my paper", "polish the introduction", "improve the writing", "review my
  draft", "fix the structure", "tighten this up", "give me editorial
  feedback", "is this argument clear", "address reviewer comments",
  "respond to reviewers", "copy-edit this", "make this academic",
  "rewrite this paragraph", "is this paragraph confusing", "does this
  flow", "what's wrong with this section". Also trigger when the user
  opens or pastes an academic paper section (abstract, introduction,
  related work, methodology, results, discussion, conclusion) AND
  indicates they want feedback or revisions on writing quality, structure,
  or argument flow.

  DO NOT TRIGGER for general writing questions ("what's active voice?",
  "explain the passive"), citation formatting, BibTeX or reference
  management, LaTeX compilation issues, pure proofreading without
  structural feedback (just typos), generating new paper content from
  scratch (this skill edits existing prose, it does not draft from
  outlines), or non-academic writing such as blog posts, marketing copy,
  or fiction.
---

# Paper Revision Editor

## Overview

This skill performs editorial review of academic paper sections for top-tier venues. It diagnoses problems first, then revises. The revision preserves the author's voice, technical content, and empirical claims. Numerical results, citations, and analytical conclusions are never altered.

## Before you start

Read paper context from one of the following, in order:

1. A `<paper_context>` block in `CLAUDE.md` at the repo root.
2. `paper-meta.md` at the repo root.
3. The manuscript's main file (look for the abstract and venue mentions).

The context should include: target venue, primary audience, core thesis, and revision stage. If any are missing or ambiguous, ask the user before proceeding.

## Diagnostic lens

Apply these in order. The earlier categories are more important than the later ones; do not waste time polishing sentences in a paragraph whose purpose is unclear.

### Structural integrity

- Verify the paper has a clear thesis and that every section advances it.
- Check that arguments build sequentially: each claim should rest on what has already been established, never on what comes later.
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

See `references/sentence-cohesion.md` for the full treatment.

- Old information first, new information last. Each sentence should link to the previous one through shared subjects or repeated concepts.
- Cut throat-clearing and filler. Every sentence must earn its place.
- Prefer concrete subjects and active verbs. Avoid nominalizations ("performed an analysis" becomes "analyzed").
- Use technical terms consistently: same concept, same word. Define terms on first use.

### Claims and evidence

- Distinguish claims, evidence, and interpretation. The reader should always know which they are reading.
- Calibrate confidence to the evidence. Do not overclaim, but do not hedge so heavily that nothing is asserted.
- Verify that every empirical claim is supported and every cited result is accurately characterized.

## Section-specific lens

Identify the section type from the file name or section heading and adapt:

- **Introduction**: motivation, positioning against prior work, explicit contribution claims, roadmap.
- **Related Work**: organized by theme or argument, not by paper. Each cited work should serve the thesis.
- **Methodology**: replicability, clear inferential logic, justified design choices.
- **Results**: clean separation of finding from interpretation. Tables and figures should be referenced in the order presented.
- **Discussion**: honest acknowledgment of limitations, scope of generalization, links back to the thesis.
- **Conclusion**: synthesis, not summary. State what the reader should take away.

## Style constraints

See `references/ai-tells-to-avoid.md` for the full list of patterns to flag.

- Do not use em-dashes. Use commas, parentheses, colons, or two sentences instead.
- Avoid these transition words: Furthermore, Moreover, Crucially, Importantly, Notably, Ultimately, Delving. Avoid the phrases "It's worth noting" and "That said." Build transitions from the content itself.
- Avoid jargon that does not earn its place. If a plain word will do, use it.

## Output format

For the section provided:

1. **Diagnosis.** List structural and stylistic problems with paragraph references.
2. **Revised text.** Provide the revised section.
3. **Change rationale.** Briefly note what changed and why.
4. **Author questions.** Flag any unverifiable claims, missing evidence, or logical gaps as questions for the author rather than guessing.

## Examples

**User:** "Can you take a look at the introduction and see if it flows?"

**Skill behavior:** Reads `CLAUDE.md` for paper context, opens the introduction file, applies the full diagnostic lens, returns diagnosis + revised text + rationale + author questions.

**User:** "Just fix the typos in section 3."

**Skill behavior:** Does NOT trigger. This is proofreading, not editorial revision. Defer to the user's regular tools.

**User:** "Reviewer 2 says my methodology is unclear. Help me fix it."

**Skill behavior:** Triggers. Reads `CLAUDE.md`, sets revision stage to "response to reviewers", applies methodology-section lens with extra emphasis on replicability and inferential logic. Preserves the analytical decisions; rewrites the prose around them.

**User:** "Write me a discussion section based on these results."

**Skill behavior:** Does NOT trigger. This skill edits existing prose; it does not draft new sections from scratch.
