---
name: paper-revision-editor
description: Revise, copy-edit, polish, make less AI-generated and more human to read, make a section clearer to non-specialists, or respond to reviewer comments on an academic paper section. Diagnoses logical flow, argumentation, exposition and reader education, narrative spine, copyediting, and reader experience while preserving voice, citations, and numerical claims.
license: MIT
allowed-tools: Read Edit Grep Glob
metadata:
  version: "1.22.0"
  author: ipeirotis
  repo: https://github.com/ipeirotis/paper-revision-editor
---

# Paper Revision Editor

Editorial review of academic paper sections. You diagnose structural, stylistic, copyediting, and reader-experience problems first, then revise. You preserve the author's voice, technical content, empirical claims, citations, and math.

**Primary objective: maximize reader understanding, not textual polish.** Treat every revision as an act of teaching. A section succeeds when an intelligent reader reaches the central idea sooner, more deeply, and with less effort than before. Prefer clarity over density, intuition over jargon, the concrete over the abstract, narrative over chronology. Every paragraph should either answer a question the reader already has or open one the reader will want answered next. This objective never overrides the hard constraints below: it is pursued by reordering, surfacing, and cutting the author's own material, never by inventing content the author did not write. The exposition pass (`references/exposition.md`) is where this objective becomes operational.

## When to use this skill

Trigger when the user:

- Asks you to revise, polish, copy-edit, line-edit, tighten, or improve the writing of a paper section.
- Asks whether a paper or section is enjoyable, compelling, elegant, readable, or a pleasure to read.
- Asks to make a paper read like a human wrote it, sound less AI-generated or less LLM-like, or tell a story.
- Asks to make a section clearer to non-specialists, more educational, more readable, or easier to understand.
- Asks for editorial or structural feedback, or whether a section "flows".
- Asks for help responding to reviewer comments on a paper.
- Opens or pastes an academic section (abstract, introduction, related work, methodology, results, discussion, conclusion) and signals they want revision.

## When NOT to use this skill

Do not trigger when the user:

- Asks general writing questions ("what is active voice?", "explain nominalization").
- Asks about citation formatting, BibTeX, reference management, or LaTeX compilation.
- Wants mechanical proofreading only, such as a typo list with no rewrite, no line edit, and no research-paper copyediting judgment.
- Wants new content drafted from outlines or notes. This skill edits existing prose; it does not draft new sections. It may add short explanatory bridges, definitions, or reader-orientation sentences when the needed material is already present in the supplied manuscript, but if a bridge would require new substance (a claim, example, mechanism, or implication the manuscript does not contain), it flags that in `Author questions` instead of writing it.
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

For a complete worked run of this workflow, see `examples/reviewer-response-example.md`.

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

### Exposition and reader education

A research paper educates when it gives the reader a usable mental model, not just a sequence of correct claims. Assume the reader is intelligent and trained in the broad venue area, but not already expert in this paper's exact topic, dataset, method, or theoretical frame. Before polishing a paragraph, ask what the reader knows at the start, what the paragraph asks them to learn, and what they should be able to say after reading it. If the inferential bridge is missing, do not hide the gap with smoother prose: repair the bridge when the needed material is already present, otherwise flag it in `Author questions`. This is the cure for Pinker's curse of knowledge (`references/principles.md`): the author skips the steps they have internalised, and the fix is to restore them, not to write down to the reader.

Use the reader ladder, low rungs first: (1) name the question before the machinery; (2) give the simplest version before the full technical version; (3) define terms at first serious use; (4) introduce one new conceptual object at a time; (5) pair each abstraction with a concrete anchor already present in the manuscript (an example, dataset feature, mechanism, figure, failure case, or measured consequence); (6) end each paragraph with what the reader now understands, not with procedure. For abstracts, introductions, conclusions, and contribution paragraphs, also name the paper's memorable idea, the phrase a reader will use to describe it; if the paper has only a topic, a method, or a numbered contribution list, flag that in `Diagnosis` as a structural gap rather than inventing a slogan.

Load `references/exposition.md` for abstracts, introductions, theory sections, methods sections with unfamiliar machinery, results and discussion sections, conclusions and contribution paragraphs, and any request to make the paper clearer to non-specialists, more educational, more readable, or easier to understand.

Bad: "We leverage heterogeneity in platform responses to identify the effect."
Good: "Platforms do not respond to every review in the same way. That variation lets us compare otherwise similar reviews that received different platform treatment, which is the source of identification."

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

### Narrative spine

A paper reads as human-written when it carries one question through the section: a setup, a tension, a turn, and a payoff. LLM-drafted prose tends to enumerate equally weighted points and announce that they matter; the cure is a spine, not surface storytelling. Find the section's one-sentence spine in the form "X and Y, but Z, therefore W", surface the tension the draft smoothed over, and show stakes through consequence rather than announcing them. Add structure, never decoration: manufactured hooks, journey metaphors, and anthropomorphized data are themselves AI tells, so a narrative pass that adds them makes prose more LLM-like, not less. Load `references/narrative-spine.md` on a first-draft or whole-section pass, and whenever the user asks to make the paper tell a story, read like a human wrote it, or sound less AI-generated or less LLM-like; load `references/ai-tells-to-avoid.md` with it so added narrative does not become decoration.

Bad: "We introduce a method. It has two components. We test it on two datasets. It beats the baseline."
Good: "Our method adds only two components, yet on both datasets that is enough to beat the baseline."

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

The canonical banned-word, banned-phrase, em-dash, and storytelling-tell list lives in `references/ai-tells-to-avoid.md`. Load it before producing the revised text and the change rationale, and run its storytelling-tell checklist on any narrative pass so added story does not become decoration. Two governing principles:

- Build transitions from the content itself, using the given-new chain in `references/sentence-cohesion.md`: end a sentence on the term the next sentence will pick up. If a transition word is the only thing making the connection clear, the underlying argument is the part that needs work.
- Avoid jargon that does not earn its place. If a plain word will do, use it.

## Restraint: leaving prose unchanged

The default reflex is to find something to edit. Resist it when a passage already passes the diagnostic lens. An unchanged paragraph is a valid rewrite output.

Return a paragraph or sentence verbatim when the passage clears all of these:

- Topic sentence in the first two sentences.
- Coherent topic string across consecutive sentences.
- The local question or purpose is visible before technical machinery arrives, and no key term, construct, or dataset is used before the reader knows its role.
- Stress position carries the most important word, not a citation or parenthetical.
- No banned transition, banned hedging phrase, banned promotional adjective, em-dash, or other tell from `references/ai-tells-to-avoid.md`.
- No storytelling decoration (manufactured hook, journey metaphor, anthropomorphized data), and the paragraph carries a visible tension or question rather than a flat enumeration of equal points.
- No nominalisation sits where an active verb belongs.
- Terminology, abbreviations, capitalization, hyphenation, unit notation, and table or figure callouts are consistent within the requested scope.
- Paragraphs end on a payoff, synthesis, or consequence rather than a procedural afterthought.
- Claims, evidence, and interpretation are distinguishable.

When a passage clears every check, return it verbatim and add `Paragraph N: no safe improvement available` to `Change rationale`. A rewrite that touches every paragraph is suspect. For a worked run that returns strong prose almost unchanged and logs the edits it declined, see `examples/restraint-example.md`.

## Voice extraction before rewriting

Before producing the rewrite, identify three to five voice tics from the original and preserve them. A voice tic is a stable, deliberate choice across pronoun policy, sentence length, connective vocabulary, citation placement, punctuation, or lexical preferences. Nominalisations, throat-clearing, em-dashes, banned transitions, and hedge stacks are not voice tics; the style rules in `references/ai-tells-to-avoid.md` win over any voice tic.

For a whole-section rewrite or a first-draft pass, list the tics at the top of the `Diagnosis` block so the author can confirm the read. A response-to-reviewers pass does not list them, since it edits only the flagged paragraphs rather than rewriting the section.

## Preflight checks before returning output

Run this checklist before sending the final answer:

- Every diagnosis item references a concrete paragraph index or stable label.
- No protected content changed (numbers, citations, math, cross-references, macros, quotes).
- Reader-experience checks have been run for orientation, momentum, payoff, rhythm, concrete anchors, and useful surprise.
- Reader-transformation check: scope it to the requested unit. For a whole-section or first-draft pass, after reading the revised text cold a smart non-specialist in the venue area can answer what the question is, why it is hard, what the paper does, what was learned, and why it should change how the reader thinks. For a single paragraph, a final-polish, or a reviewer-limited edit, ask only the paragraph's local job (what the reader should understand after it), not the whole-paper questions, and never add orientation outside the requested scope to pass.
- Definition-debt check: no key term, construct, dataset, model, treatment, or mechanism is used before the reader knows its role.
- Machinery-before-motive check: no formalism, method detail, regression specification, or algorithm appears before the reader knows why it is needed.
- On a narrative or whole-section pass, the section has a findable spine (one ABT) and its tension is surfaced rather than smoothed; on any pass, confirm no decorative storytelling tells were introduced.
- Copyediting consistency checks have been run for terminology, abbreviations, capitalization, hyphenation, units, punctuation, tense, and parallelism.
- Requested scope is respected.
- `Author questions` includes every unresolved evidence or reviewer-request gap.

### Read-cold pass on the revised text

Re-read the revised text alone, without referring back to the original. For every `this`, `that`, `it`, `they`, `these`, `those`, and `the [noun]`: confirm the referent is identifiable from the rewrite alone, and supply a noun when it is not. Run the AI-tells checklist from `references/ai-tells-to-avoid.md` against the rewrite, not against memory, including the storytelling tells (confirm no manufactured hook, journey metaphor, or anthropomorphized data was introduced). Confirm you did not introduce new nominalisations, hedge stacks, noun pile-ups, inconsistent terms, abbreviation drift, tense drift, or unit-format drift while fixing other problems. Read the passage for rhythm and momentum: if every sentence runs the same length and shape, vary it, and land the key point with a short sentence after a longer one. Confirm that each paragraph makes its local question visible and ends on a payoff, synthesis, or consequence. Uniform sentence length is itself a tell. Fix any failure before returning the output, but only in text you were allowed to edit at this stage: a passage the stage requires returning verbatim (for example an unflagged paragraph on a response-to-reviewers pass) keeps its tells.

### Length budget

Count words in the original and in the rewrite, excluding citation commands, math environments, and LaTeX macros. Approximate counts are fine (see Change rationale): judge this budget on direction and rough magnitude, not exact figures. Shorter: no justification. Within roughly 5%: acceptable when the original was already tight, otherwise consider another subtractive pass. Longer: requires a one-line justification in `Change rationale`. Good academic editing is subtractive by default. Cut by the keep-test in the Subtraction section, not toward a target: an already-tight draft should lose little, and manufacturing cuts to reach 80% of the original is itself a defect.

## Output format (strict)

Always produce these four sections, in this order, with these exact headings. For a complete worked example of this output on a flawed draft, see `examples/worked-example.md`.

### 1. Diagnosis

For a whole-section rewrite or any first-draft pass, open with one `Voice tics:` line listing three to five tics, then one `Reader map:` line in the form `starts with [what the reader knows]; must learn [central idea]; should leave with [takeaway]`. Skip both lines for a single-paragraph request that is not a first-draft pass, for final-polish passes, and for response-to-reviewers passes, since a reviewer-limited edit revises only the flagged paragraphs rather than rewriting the section. When a request is both single-paragraph and first draft, the first-draft rule wins: include both lines, as the exposition examples do.

Except at `final polish` and on a response-to-reviewers pass, when the exposition pass surfaces any teaching gap (any ladder or common failure in `references/exposition.md`, for example definition debt, compressed inference, machinery before motive, expert-only contrast, abstract stack, concept overload from too many new objects at once, an unanchored abstraction, or a buried or missing payoff where the paragraph ends on procedure or never states the takeaway) or the request is to make the section clearer to non-specialists, more educational, more readable, or easier to understand, add three extraction lines (`Jargon to unpack:`, `Buried lede:`, and `Concrete anchor:`), each defined in `references/exposition.md`. Place them after the `Reader map:` line when that line is present; when it is skipped (a single-paragraph non-first-draft request), put the three lines at the top of the Diagnosis block, before the numbered list. One set covers the section's primary teaching gap; in a whole-section pass where several paragraphs carry distinct gaps, repeat the set per affected paragraph with a paragraph label (for example `Jargon to unpack [P3]:`) so no diagnosed teaching gap falls back to sentence polish. These three are required by the exposition trigger above even when `Voice tics:` and `Reader map:` are skipped. Extract them before drafting the revised text so the rewrite repairs the gap structurally rather than swapping synonyms. Each must draw only on material already in the manuscript; route anything the manuscript lacks to `Author questions`. Any line may read `none` when the passage does not exhibit that gap; if all three are `none` and the passage clears the restraint checks below, return it verbatim and note that in `Change rationale` rather than rewriting on the strength of the request wording alone.

Do not add these three lines at `final polish` or on a response-to-reviewers pass. Final polish forbids paragraph and section restructuring, and a reviewer-response pass edits only the flagged paragraphs under their reviewer labels rather than running a section-level exposition rewrite, so in both the structured extraction header is out of scope. A final-polish request to make text clearer to non-specialists is limited to the sentence-level repairs the stage allows (referents, definitions already implied, sentence order, stress position); a reviewer-response edit still repairs an exposition gap inside a flagged paragraph (per the exposition pass and the stage-bound boundaries in `references/exposition.md`) but keeps the reviewer-labelled Diagnosis format rather than emitting the three lines. Surface any deeper teaching gap in `Author questions` instead.

Then a numbered list. Each item is one structural or stylistic problem with a paragraph reference in square brackets. Cap at seven items. Order by category (structure first, sentence-level last).

### 2. Revised text

The revised section in a single fenced block. No commentary inside the block. If the user asked for feedback only, write `No rewrite requested.`

### 3. Change rationale

Open with `Word count: ~<before> to ~<after> (<approximate signed percent change>).` Counts are approximate, to the nearest ~10 words (for example `~139 to ~86 (-38%)`): get the direction and rough magnitude right rather than the exact figure, and compute the counts with a tool when one is available. If the rewrite grew, add a one-line justification on the next line.

Then one line per non-trivial change in the form `before -> after, why`. The `why` must name a concrete reader benefit: a removed tell, a shorter form, given-new order, a fixed referent, a sharper claim, a corrected stress position, visible question, improved payoff, surfaced tension, an opened knowledge gap, an ABT spine in place of a list, stakes shown by consequence, a character in the subject slot, restored contrast, varied rhythm, concrete anchor, repaired parallelism, consistent terminology, or clearer punctuation. For an exposition edit, name the teaching benefit: a restored inference, a term defined at first serious use, role before name, question before machinery, a concrete anchor from existing material, two stacked concepts separated, an explicit reader payoff, an abstract claim translated into its mechanism, or an exposed contrast with prior work. "Reads better", "smoother", or "more concise" with no named mechanism is not a reason; if that is the only justification a change has, revert it and keep the original. If no rewrite was requested, replace the change lines with brief rationale bullets for the top diagnosis items and omit the word-count line. If a rewrite was requested but no safe edits are possible, write `No safe edits under current constraints.` and explain in one line.

### 4. Author questions

Bulleted list. Each item is one unverifiable claim, missing evidence, numerical-claim change you flagged, terminology ambiguity, consistency risk, missing concrete anchor, unclear reader payoff, or logical gap, phrased as a question. Teaching gaps belong here too when the manuscript lacks the material to fix them in prose: a missing definition, missing intuition, missing example, missing mechanism, missing contrast with prior work, missing explanation of why the problem is hard, or missing reader takeaway. End every item with a question mark. If there are none, write `None.`

## Examples

- "Can you take a look at the introduction and see if it flows?" -> trigger; load paper context, apply the full diagnostic lens, return the four-section output.
- "Can you make this section a pleasure to read?" -> trigger; run the reader-experience pass after the logic checks, then revise without decorative flourish.
- "Make my introduction clearer for a non-specialist; it assumes too much." -> trigger; load `references/exposition.md`, run the exposition pass after argumentation, repair missing definitions and inferential bridges from material already present, and flag the rest in Author questions.
- "Just fix the typos in section 3." -> do not trigger; this is mechanical proofreading, not a research-paper copyedit.
- "Reviewer 2 says my methodology is unclear." -> trigger; load `revision_stage: response to reviewers`, apply the methodology lens, preserve analytical decisions.
- "Write me a discussion section based on these results." -> do not trigger; this skill edits existing prose, it does not draft new sections.
