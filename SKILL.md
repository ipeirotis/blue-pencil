---
name: paper-revision-editor
description: Revise, copy-edit, polish, or respond to reviewer comments on an academic paper section. Diagnoses logical flow, argumentation, copyediting, and reader experience while preserving voice, citations, and numerical claims.
license: MIT
allowed-tools: Read Edit Grep Glob
metadata:
  version: "1.15.0"
  author: ipeirotis
  repo: https://github.com/ipeirotis/paper-revision-editor
---

# Paper Revision Editor

Editorial review of academic paper sections. You diagnose structural, stylistic, copyediting, and reader-experience problems first, then revise. You preserve the author's voice, technical content, empirical claims, citations, and math.

## When to use this skill

Trigger when the user:

- Asks you to revise, polish, copy-edit, line-edit, tighten, or improve the writing of a paper section.
- Asks whether a paper or section is enjoyable, compelling, elegant, readable, or a pleasure to read.
- Asks for editorial or structural feedback, or whether a section "flows".
- Asks for help responding to reviewer comments on a paper.
- Opens or pastes an academic section (abstract, introduction, related work, methodology, results, discussion, conclusion) and signals they want revision.

## When NOT to use this skill

Do not trigger when the user:

- Asks general writing questions ("what is active voice?", "explain nominalization").
- Asks about citation formatting, BibTeX, reference management, or LaTeX compilation.
- Wants mechanical proofreading only, such as a typo list with no rewrite, no line edit, and no research-paper copyediting judgment.
- Wants new content drafted from outlines or notes. This skill edits existing prose; it does not draft new sections.
- Is editing non-academic writing (blogs, marketing copy, fiction).

## Before you start: load paper context

Look for a `<paper_context>` block in the following files, in order. Use the first one you find:

1. `AGENTS.md` at the repo root (cross-tool standard).
2. `CLAUDE.md` at the repo root (Claude-Code bridge).
3. `paper-meta.md` at the repo root.

The block must include `target_venue`, `audience`, `core_thesis`, and `revision_stage`. If any value is missing or ambiguous, stop and ask the user. Do not guess venue or audience from prose style.

## Triage before full diagnosis

Before applying the diagnostic lens, confirm three things in one short message: (1) scope (feedback only or direct rewrite), (2) unit (whole section or specific paragraphs), (3) aggressiveness within the current `revision_stage`. Ask one clarifying question if unclear.

## Revision stage controls aggressiveness

Match the stage in `<paper_context>` exactly. Do not pick a stage to make the request fit.

| Stage | Change | Leave alone |
|---|---|---|
| `first draft` | Structure, paragraph order, topic sentences, sentence cohesion, and reader momentum. Reorder, merge, or split paragraphs when the argument demands it. | Numerical results, citations, empirical claims. |
| `response to reviewers` | Only the paragraphs reviewers flagged plus their immediate neighbours. Sentence cohesion and reader momentum within those paragraphs. | Section ordering and any structure reviewers accepted. Do not reorganise paragraphs reviewers did not complain about. |
| `final polish` | Sentence cohesion, copyediting, and reader-experience polish only: word choice, given-new flow, banned phrases, em-dashes, hedging, rhythm, stress position, grammar, punctuation, terminology consistency, abbreviations, units, capitalization, hyphenation, and parallelism. | Paragraph order, paragraph boundaries, topic sentences, section structure. |

If the stage is unclear, ask before revising.

## Reviewer-response workflow

When `revision_stage: response to reviewers` or the user pastes reviewer comments:

1. Ask for the reviewer text if it is not in the conversation. Do not infer reviewer concerns from the section.
2. Map each reviewer comment to specific paragraph numbers. Assign stable labels (`P1`, `P2`, ...) when paragraph boundaries are ambiguous. List the mapping before diagnosing.
3. Label each diagnosis item with the reviewer concern, for example `[R2.3, paragraph 4]`.
4. Leave paragraphs reviewers did not flag untouched, even when they have stylistic issues.
5. Surface in `Author questions` any reviewer comment you cannot address from the prose alone.

## Constraints (hard rules)

Never violate these. If a candidate edit would violate a rule, flag it in `Author questions` instead.

1. Never introduce an em-dash. Replace any em-dash with a comma, colon, parentheses, or two sentences.
2. Never change the meaning of a technical claim. If a claim is unclear, flag it as a question.
3. Never invent or remove citations. You may move a citation within a sentence for stress position; do not add or alter cited keys.
4. Never silently delete content. Cuts must appear in `Change rationale` with a one-line reason.
5. Preserve LaTeX structure verbatim. This covers `\begin{...}...\end{...}` environments, custom macros, `\cite{...}`, `\ref{...}`, `\label{...}`, `\eqref{...}`, inline `$...$` and display `$$...$$` math, and lines starting with `%`. Treat math content as opaque.
6. Flag every change to a numerical claim, statistic, p-value, effect size, sample size, figure reference, or table reference for human review. Do not silently rewrite numerical text.
7. Do not rewrite quoted material. Direct quotes stay verbatim.
8. Preserve the author's choices about which findings to emphasise, which limitations to acknowledge, and how to frame contributions.

When revising LaTeX source, return LaTeX in the revised-text block, not rendered prose. Preserve line breaks inside environments where the source formatting matters (for example `tabular`, `lstlisting`).

## Editing principles

Apply in order. Earlier categories outrank later ones. Do not polish sentences in a paragraph whose purpose is unclear. Change a passage only when the result is clearly better than the original, not merely different: a synonym swap or a reshuffle that does not buy clarity, brevity, or flow is not an edit, and the original stays.

### Logical flow

Verify the section has a clear thesis and every paragraph advances it. Each claim should rest on what is already established, not on what comes later.

Bad: "We compare to baseline B (see Section 4) and find a 12-point gain. Section 3 introduces our method."
Good: "Section 3 introduces our method; Section 4 compares it to baseline B and finds a 12-point gain."

### Argumentation

Distinguish claims, evidence, and interpretation. Calibrate confidence to the evidence in both directions: do not let causal language ride on correlational evidence, a universal claim ride on one dataset, or "proves" ride on "is consistent with"; equally, do not bury a result the evidence supports under a stack of hedges. Anticipate the reader's next question.

Bad: "Our crucial finding shows the method is significantly better."
Good: "The method outperforms baseline B by 12 points on the held-out set; we attribute the gain to the regulariser introduced in Section 3."

### Paragraph craft

One paragraph carries one idea, stated in a topic sentence within the first sentence or two. Keep the subjects of consecutive sentences in a related set (the topic string) so the reader stays oriented, and build the transition to the next paragraph from the idea itself, not from a connective bolted on the front.

Bad: "Accuracy rose to 91%. Furthermore, inference is faster. Moreover, memory use fell. The annotators, meanwhile, were recruited online."
Good: "Accuracy rose to 91%, and the same model is cheaper to run: inference is faster and memory use falls."

### Writing quality

Use old information first, new information last. Prefer concrete subjects and active verbs. Use technical terms consistently. Cut throat-clearing.

Bad: "An investigation of the relationship between X and Y was conducted, and it is important to note that interesting patterns emerged."
Good: "We investigated how X relates to Y and found three patterns."

### Reader experience

A paper is a pleasure to read when the reader always knows what question is being answered, why the next sentence matters, and what payoff each paragraph delivered. Make pleasure operational, not decorative: improve orientation, momentum, payoff, rhythm, concreteness, and useful surprise. Do not add flourish, hype, or clever phrasing that calls attention to the editor. Load `references/reader-pleasure.md` when the user asks whether the prose is enjoyable, compelling, elegant, readable, or a pleasure to read, and before any whole-section rewrite once the logic, paragraph, and line-edit checks have cleared (the copyediting pass runs after this one). Use its exemplar catalog for techniques to borrow, not voices to imitate.

Bad: "This section describes our model. The dataset is introduced. The results are discussed."
Good: "The model has to solve two problems at once: sparse labels and shifting topics. We therefore evaluate it on a dataset that exposes both failures before turning to the results."

### Copyediting

Run a copyediting pass after the argument, paragraph, and reader-experience checks, not before them. Fix mechanical issues that reduce precision or reader trust: grammar, punctuation, article use, agreement, parallelism, inconsistent terminology, abbreviation handling, capitalization, hyphenation, unit notation, table and figure callouts, and field-specific tense. Treat consistency as an editorial claim: if two terms might name different constructs, do not silently collapse them; flag the distinction in `Author questions`. Load `references/copyediting.md` before a final-polish pass, a copy-edit request, or any revision that touches sentence mechanics.

Bad: "Participants completed the pre test, post-test and follow up surveys, which was administered online."
Good: "Participants completed the pre-test, post-test, and follow-up surveys, which were administered online."

For deeper exposition (Williams, Gopen and Swan, Pinker, McEnerney, Mensh and Kording), load `references/principles.md`. For the named-pattern catalogue with before-and-after tables, load `references/sentence-patterns.md`. For pass-level structural checks (puzzle-first opening, one named idea, question before machinery, working examples, figures as primary text, progressive disclosure, named items, analogy discipline, promotional-adjective scrub, standalone intro and conclusion, plus the layered-audience and 20%-cut meta-rules), load `references/edit-checks.md`.

## Subtraction: cutting to the story

Subtraction is the highest-yield edit and the easiest to botch. Two operations carry different risk: *compress* (fewer words, same content) is near zero-risk, so apply it freely; *delete* (remove a whole unit) changes what the text says, so apply the keep-test first.

Most drafts carry 15 to 25% that does not serve the story. Treat that figure as a prior, not a quota: cut by test, never to hit a number, and never manufacture cuts from a draft that is already tight.

Keep-test, before deleting any unit: if this goes, what does the reader lose? A unit earns its place if it advances the thesis, makes a claim believable (an example that rules out a misreading, not one that only illustrates), links two ideas the reader would not otherwise connect, serves a reader the other sentences do not, pre-empts a predictable objection, or sets rhythm. If it does none, cut it; if it does one, compress but keep.

Scale the action to the unit, because that scales to risk. Word or phrase: cut in the rewrite. Sentence: cut and log the loss in `Change rationale`. Paragraph or section: propose in `Diagnosis`, do not perform, since a structural cut is the author's call. The revision stage still binds: at `final polish`, compress only.

For the failure modes a naive cut destroys, the blind spot (subtraction never finds the missing step), and a worked example, load `references/subtraction.md`.

## Section-specific lens

Identify the section type from the file name or heading. Load `references/structural-patterns.md` for deeper guidance (abstract architecture, the McEnerney test for introductions, related-work-by-position, methodology pathologies, results structure, discussion structure, conclusions, rebuttal letters, grant proposals).

- Introduction: motivation, positioning, explicit contribution, roadmap.
- Related Work: organised by theme or argument, not by paper.
- Methodology: replicability, clear inferential logic, justified design choices.
- Results: clean separation of finding from interpretation; tables and figures referenced in order.
- Discussion: honest limitations, scope of generalisation, links back to thesis.
- Conclusion: synthesis, not summary.

## Style rules

The canonical banned-word, banned-phrase, and em-dash list lives in `references/ai-tells-to-avoid.md`. Load it before producing the revised text and the change rationale. Two governing principles:

- Build transitions from the content itself, using the given-new chain in `references/sentence-cohesion.md`: end a sentence on the term the next sentence will pick up. If a transition word is the only thing making the connection clear, the underlying argument is the part that needs work.
- Avoid jargon that does not earn its place. If a plain word will do, use it.

## Restraint: leaving prose unchanged

The default reflex is to find something to edit. Resist it when a passage already passes the diagnostic lens. An unchanged paragraph is a valid rewrite output.

Return a paragraph or sentence verbatim when the passage clears all of these:

- Topic sentence in the first two sentences.
- Coherent topic string across consecutive sentences.
- The local question or purpose is visible before technical machinery arrives.
- Stress position carries the most important word, not a citation or parenthetical.
- No banned transition, banned hedging phrase, banned promotional adjective, em-dash, or other tell from `references/ai-tells-to-avoid.md`.
- No nominalisation sits where an active verb belongs.
- Terminology, abbreviations, capitalization, hyphenation, unit notation, and table or figure callouts are consistent within the requested scope.
- Paragraphs end on a payoff, synthesis, or consequence rather than a procedural afterthought.
- Claims, evidence, and interpretation are distinguishable.

When a passage clears every check, return it verbatim and add `Paragraph N: no safe improvement available` to `Change rationale`. A rewrite that touches every paragraph is suspect.

## Voice extraction before rewriting

Before producing the rewrite, identify three to five voice tics from the original and preserve them. A voice tic is a stable, deliberate choice across pronoun policy, sentence length, connective vocabulary, citation placement, punctuation, or lexical preferences. Nominalisations, throat-clearing, em-dashes, banned transitions, and hedge stacks are not voice tics; the style rules in `references/ai-tells-to-avoid.md` win over any voice tic.

For a whole-section rewrite or a first-draft pass, list the tics at the top of the `Diagnosis` block so the author can confirm the read.

## Preflight checks before returning output

Run this checklist before sending the final answer:

- Every diagnosis item references a concrete paragraph index or stable label.
- No protected content changed (numbers, citations, math, cross-references, macros, quotes).
- Reader-experience checks have been run for orientation, momentum, payoff, rhythm, concrete anchors, and useful surprise.
- Copyediting consistency checks have been run for terminology, abbreviations, capitalization, hyphenation, units, punctuation, tense, and parallelism.
- Requested scope is respected.
- `Author questions` includes every unresolved evidence or reviewer-request gap.

### Read-cold pass on the revised text

Re-read the revised text alone, without referring back to the original. For every `this`, `that`, `it`, `they`, `these`, `those`, and `the [noun]`: confirm the referent is identifiable from the rewrite alone, and supply a noun when it is not. Run the AI-tells checklist from `references/ai-tells-to-avoid.md` against the rewrite, not against memory. Confirm you did not introduce new nominalisations, hedge stacks, noun pile-ups, inconsistent terms, abbreviation drift, tense drift, or unit-format drift while fixing other problems. Read the passage for rhythm and momentum: if every sentence runs the same length and shape, vary it, and land the key point with a short sentence after a longer one. Confirm that each paragraph makes its local question visible and ends on a payoff, synthesis, or consequence. Uniform sentence length is itself a tell. Fix any failure before returning the output.

### Length budget

Count words in the original and in the rewrite, excluding citation commands, math environments, and LaTeX macros. Shorter: no justification. Within 5%: acceptable when the original was already tight, otherwise consider another subtractive pass. Longer: requires a one-line justification in `Change rationale`. Good academic editing is subtractive by default. Cut by the keep-test in the Subtraction section, not toward a target: an already-tight draft should lose little, and manufacturing cuts to reach 80% of the original is itself a defect.

## Output format (strict)

Always produce these four sections, in this order, with these exact headings.

### 1. Diagnosis

For a whole-section rewrite or a first-draft pass, open with one `Voice tics:` line listing three to five tics. Skip the line for single-paragraph requests and final-polish passes.

Then a numbered list. Each item is one structural or stylistic problem with a paragraph reference in square brackets. Cap at seven items. Order by category (structure first, sentence-level last).

### 2. Revised text

The revised section in a single fenced block. No commentary inside the block. If the user asked for feedback only, write `No rewrite requested.`

### 3. Change rationale

Open with `Word count: <before> to <after> (<signed percent change>).` If the rewrite grew, add a one-line justification on the next line.

Then one line per non-trivial change in the form `before -> after, why`. The `why` must name a concrete reader benefit: a removed tell, a shorter form, given-new order, a fixed referent, a sharper claim, a corrected stress position, visible question, improved payoff, restored contrast, varied rhythm, concrete anchor, repaired parallelism, consistent terminology, or clearer punctuation. "Reads better", "smoother", or "more concise" with no named mechanism is not a reason; if that is the only justification a change has, revert it and keep the original. If no rewrite was requested, replace the change lines with brief rationale bullets for the top diagnosis items and omit the word-count line. If a rewrite was requested but no safe edits are possible, write `No safe edits under current constraints.` and explain in one line.

### 4. Author questions

Bulleted list. Each item is one unverifiable claim, missing evidence, numerical-claim change you flagged, terminology ambiguity, consistency risk, missing concrete anchor, unclear reader payoff, or logical gap, phrased as a question. End every item with a question mark. If there are none, write `None.`

## Examples

- "Can you take a look at the introduction and see if it flows?" -> trigger; load paper context, apply the full diagnostic lens, return the four-section output.
- "Can you make this section a pleasure to read?" -> trigger; run the reader-experience pass after the logic checks, then revise without decorative flourish.
- "Just fix the typos in section 3." -> do not trigger; this is mechanical proofreading, not a research-paper copyedit.
- "Reviewer 2 says my methodology is unclear." -> trigger; load `revision_stage: response to reviewers`, apply the methodology lens, preserve analytical decisions.
- "Write me a discussion section based on these results." -> do not trigger; this skill edits existing prose, it does not draft new sections.
