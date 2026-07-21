# Edit-check pass

A pass-level checklist of structural and rhetorical moves drawn from writers whose papers are widely cited as a pleasure to read (Coase, Akerlof, Kleinberg, Schelling, Brooks, Lampson, Chetty, Varian, Roth, Hirschman, Dijkstra, McCloskey). Run as a checklist over the section's load-bearing paragraphs: the first paragraph of the section, the first paragraph of each subsection, and any paragraph that introduces a new claim.

Load this file when revising an introduction, abstract, or conclusion, or when the user asks for a holistic pass over the paper. The ten checks below sit at a higher level than the named-pattern catalog in `sentence-patterns.md`: those are sentence moves, these are paragraph- and section-level moves.

The checks are listed in roughly decreasing order of impact for an introduction. Most sections will not need all ten.

## 1. Puzzle-first opening

The first paragraph poses a question the reader did not know to ask. Not a literature review, not a contribution claim, not "X is a fundamental problem in field Y."

**Edit check.** Rewrite paragraph one as a single question. If the question is more interesting than the paragraph, replace the paragraph.

Coase, Akerlof, and Kleinberg open by making the reader feel a gap, not by surveying the field.

## 2. One named idea per paper

The central claim should fit a phrase the reader can carry away: "market for lemons", "no silver bullet", "tragedy of the commons".

**Edit check.** State what a colleague who has not read the paper will call it. If no phrase exists, the paper is not ready. The Diagnosis output should flag this as a structural issue, not a stylistic one.

Named ideas travel; numbered or descriptively-labeled contributions do not (Brooks, Krugman, Akerlof).

## 3. Question before machinery

The model, theorem, or regression specification appears only after the reader knows why they should care.

**Edit check.** Find the first equation or formal definition in the section. If the motivating question has not been stated three different ways before it, move the formalism back or restate the question.

Roth, Kleinberg, and Schelling all establish stakes before machinery. The opposite move (formalism first, motivation after) is the most common reason an introduction reads as writer-centered.

## 4. Examples that do work, not illustrate

A working example rules out an alternative, exposes a hidden assumption, or carries the intuition the formalism captures. An illustrative example just restates the claim concretely.

**Edit check.** For each example, ask what would change in the paper if it were cut. If nothing, cut it. If the change is "the reader would not believe the claim", the example is load-bearing and should keep its position.

Schelling and Varian use examples as argument. Angrist and Pischke use them to discipline the interpretation of a regression.

## 5. Figures as primary text

Captions let a reader who skims only the figures understand the paper's contribution.

**Edit check.** Cover everything but the figures and their captions and ask whether a colleague could describe the main result. If not, the captions are under-doing their job; promote claims from the body prose into the captions.

Chetty treats figures as the spine of the paper, not as decoration. This check is most relevant for empirical sections (Results, parts of Discussion).

## 6. Progressive disclosure

Simple version first, complications after. Do not front-load every caveat the reader might raise.

**Edit check.** Find every "however", "but", and "subject to" in the first three pages. Defer the ones that are not load-bearing for the next claim. Caveats that belong in a Limitations paragraph should not appear in the introduction.

The decision rule for which caveats defer is the refinement-vs-retraction test in `references/precision-budget.md`: a caveat whose later full statement preserves the claim's sign and rough magnitude defers with at most one forward pointer; one whose full statement would reverse or gut the claim stays inline.

Kleinberg-Tardos and Varian both build understanding before introducing exceptions. Front-loaded caveats read as defensive and slow the reader before the contribution lands.

## 7. Named items in remembered lists

When a list is meant to be remembered (design principles, methodological commitments, contribution bullets), give each item a name.

**Edit check.** Replace "First, ... Second, ... Third, ..." with named items wherever the list is meant to be remembered. Numbered items are forgotten; named ones get cited.

Lampson's "Hints for Computer System Design" is the canonical example: the hints survive because each has a name. This check does not apply to lists that are purely sequential ("first we did X, then Y").

## 8. Argue by analogy when the analogy holds

Analogies move abstract structure into working memory, but they must not leak.

**Edit check.** For each analogy in the section, identify what part of the source the analogy does not capture. If that mismatch undermines the point being made, replace the analogy with a direct argument.

Hirschman and Schelling argue heavily by analogy without letting the analogy outrun its scope. The failure mode is the analogy that does work the formalism cannot back up.

## 9. Cut promotional adjectives and the "we show that" frame

"Important", "novel", "interesting", "significant" (outside the statistical sense), "crucial", and the "we show that..." preface all perform certainty rather than earning it. Let the work demonstrate.

**Edit check.** Search for these terms. Strip the adjective or frame, not the sentence: reread without the word, and if the substance survives, the word was throat-clearing. If removing it would gut a load-bearing claim or result, keep the claim and apply the keep-test from the Subtraction section before cutting anything. For "we show that X" replace with X directly. See `references/ai-tells-to-avoid.md` for the canonical list.

McCloskey on economists and Dijkstra on computer scientists both argued that promotional language signals weak claims.

## 10. Standalone introduction and conclusion

A reader who reads only the introduction and the conclusion should be able to summarize the paper's contribution. They are compressed versions of the whole, not the opening and closing of an unfolding argument.

**Edit check.** Read the introduction and the conclusion aloud to someone who has not seen the paper and ask them to describe the contribution. The gap between their summary and the actual contribution is the gap to close.

Reviewers, editors, and downstream readers often read only these sections. The body of the paper convinces; the introduction and conclusion must already inform.

## Meta-rules for the overall pass

Two framing rules that organize the checks above. Apply both on a full-section pass.

### Layered audience passes

Make three passes over the section, each from a different reader's perspective:

1. **Curious non-expert.** Would they read past paragraph two?
2. **Generalist reviewer.** Would they think the question matters by page two?
3. **Technical expert.** Would they find the core defensible?

Most academic prose fails the first pass because it has been written only for the third. Fix each failure at the layer where it occurs; do not paper over an audience-one problem with audience-three machinery.

### Expect roughly a 20% cut, then test for it

Dijkstra, Solow, Akerlof, and Schelling all share concision. "The Market for Lemons" is 13 pages, "The Nature of the Firm" is 18, and Lampson's "Hints" is short relative to its influence. The published version of a paper usually says it in roughly 80% of the draft's space, and the cut almost always improves the argument.

Treat that 80% as a prior, not a quota. Apply the keep-test from the Subtraction section to each candidate cut, expect an already-tight section to lose little, and remember that manufacturing cuts to reach a target is itself a defect. Flag substantial cuts in the `Change rationale` block of the four-section output so the author can override them.
