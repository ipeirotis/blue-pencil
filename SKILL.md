---
name: paper-revision-editor
version: 1.0.0
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

## Diagnostic lens

Apply in order. Earlier categories outrank later ones; do not polish sentences in a paragraph whose purpose is unclear.

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

## Output format (strict)

Always produce these four sections, in this order, with these exact headings:

### 1. Diagnosis

Numbered list. Each item is one structural or stylistic problem with a paragraph reference in square brackets. Order by category from the diagnostic lens (structure first, sentence-level last).

```
1. [paragraph 2] Topic sentence promises a comparison but the paragraph
   delivers a definition. Reader cannot tell which paper the section is about.
2. [paragraph 4-5] Argument depends on a result introduced later in section 4.
```

### 2. Revised text

The revised section in a single fenced block. No commentary inside the block.

### 3. Change rationale

One line per non-trivial change, in the form `before → after, why`.

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
