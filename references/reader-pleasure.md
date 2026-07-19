# Reader-pleasure pass

Use this file when the user asks whether the paper is enjoyable, compelling, elegant, a pleasure to read, or when a full-section revision has already passed the logic, paragraph, and line-edit checks. The copyediting pass runs after this one, so this is not a prerequisite. This pass is about reader experience, not decoration. It must never outrank the hard constraints in `SKILL.md`.

A research paper is a pleasure to read when the reader always knows why the next sentence is worth reading. The goal is not charm, flourish, or a magazine voice. The goal is earned momentum: each sentence reduces effort, creates a question the next sentence answers, or delivers a payoff the section has prepared.

A research paper is delightful when the reader feels their understanding growing sentence by sentence. That is the link to the exposition pass (`references/exposition.md`): pleasure and teaching are the same property felt from two sides. A delightful paragraph usually does at least one of these:

- resolves a question the previous paragraph opened
- gives a name to something the reader had only sensed
- turns an abstract claim into a concrete mechanism
- shows why a familiar assumption fails
- lets a result change the reader's view of the problem
- gives the reader a sentence they can repeat to explain the paper to someone else

The last test matters most: if no sentence in the introduction is repeatable, the paper is hard to remember. Do not manufacture a quotable line; surface the one the paper already earns.

## Pleasure test

Read the revised text cold and ask five questions.

1. **Orientation.** Can the reader state the local question by the end of the first sentence or two?
2. **Momentum.** Does each sentence make the reader want the next one because it opens, narrows, or resolves a concrete question?
3. **Payoff.** Do paragraphs end on the point the reader should remember, not on a citation, caveat, or procedural detail?
4. **Texture.** Does the prose mix explanation, evidence, and interpretation, or does it flatten into a list of claims?
5. **Relief.** After dense technical material, does the text give the reader a short synthesis sentence, example, or signpost before increasing complexity again?

If the answer to any question is no, fix the highest-leverage sentence or flag the problem in `Diagnosis`. Do not perform a decorative rewrite.

### The tired-reviewer read

The five questions above are a cold read for what works. Run one adversarial variant to find what fails: read the text as a tired reviewer at 11pm and mark every sentence where your attention drops, quoting each one. A model is far better at diagnosing dead prose than at avoiding it while generating, so this diagnostic pass catches airless sentences that the drafting pass wrote past. Each marked sentence is a `Diagnosis` item, routed to the load-variation and stress-position moves below; do not rewrite from the mark alone. At paper scale this pass is the delight audit in `references/cold-read.md`; run it there for a whole-paper read and here for a single section.

## Load variation: not every sentence should work equally hard

Dense prose has a specific cause. When each sentence is written to convey maximum information, every sentence works equally hard, and prose that never varies its load exhausts the reader even when every sentence is true. Human writing that flows varies the load: some sentences carry the argument, others orient the reader, restate a point so it lands, or exist only to move from one idea to the next. A sentence that does nothing but transition is not filler; it is the relief that lets the next high-load sentence register.

This is why the argument and the flow are separate concerns, addressed in order (`SKILL.md`, Editing principles). Once the argument and structure are settled, the reader-experience pass adds no new information (constraint 1 forbids it), and that restriction is the point: with nothing to add, the effort goes into rhythm and load instead of into packing more in. Editing for flow is not editing for density.

Concrete moves, all within the author's existing material:

- **Let low-load sentences exist.** After a dense technical sentence, a short sentence that only names the consequence or orients the reader earns its place by setting rhythm (the keep-test's "sets rhythm" clause, `references/subtraction.md`). Do not compress it away as redundant.
- **Vary sentence length deliberately.** Land a point with a short sentence after a long one; build a complex idea across a long sentence after several short ones. Uniform length is itself an AI tell (`references/sentence-patterns.md`, "Sentence-length variety").
- **Open each section with a sentence a non-specialist could follow**, before the machinery arrives (the reader ladder, `references/exposition.md`).

## The running example

For delight specifically, a single example threaded through the whole paper does more than any sentence-level move. One example the reader meets in the introduction and follows through method, results, and discussion gives them a fixed handhold as the abstraction rises, and it is the most reliable source of the repeatable sentence the pleasure test asks for. Diagnose it: does the paper reuse one concrete case, or introduce a fresh disposable example in each section?

This move is bounded by constraint 1. The editor may surface an example the author already wrote and thread it more consistently across sections the author already connects, and may point out where a scattered set of examples could become one. The editor may not invent a running example, extend one into a section where the author did not use it, or manufacture the connective claims that would carry it. When the paper would benefit from a running example it does not have, that is an `Author questions` item, not an edit.

## Edit moves that create pleasure without hype

- **Make the question visible.** Replace generic openings with the specific puzzle, contrast, or uncertainty the paragraph resolves.
- **Put the payoff in stress position.** End sentences and paragraphs on the idea that should stay with the reader.
- **Use concrete anchors.** After an abstract claim, give the reader a method step, dataset feature, example, failure mode, or measured outcome already present in the text.
- **Vary sentence weight.** Follow a long technical sentence with a short sentence that names the consequence.
- **Let transitions carry thought.** Use cause, contrast, sequence, or scope from the content itself rather than a stock transition word.
- **Preserve useful surprise.** If the section contains a counterintuitive result or tension, do not smooth it away. Frame it so the reader sees why it matters.
- **Prefer memorable exactness to decorative adjectives.** A precise noun or verb beats a praise word.

## Exemplars and transferable techniques

Use exemplars as technique sources, not as voices to imitate. The editor should borrow the move, not the mannerism.

| Exemplar | Transferable technique | What to check in a mundane paper |
|---|---|---|
| Coase and Akerlof | Open with a puzzle or market failure the reader can feel before the literature review begins. | Does the first paragraph make the reader want an answer, or does it only announce a topic? |
| Schelling and Hirschman | Use a concrete case or analogy to carry abstract structure, then mark where the analogy stops. | Does an example rule out a mistaken interpretation, or is it merely decorative? |
| Kleinberg and Roth | Put the question before the model, theorem, algorithm, or design machinery. | Can a reader say why the machinery matters before seeing the machinery? |
| Lampson and Brooks | Give memorable names to ideas the reader must carry across the paper. | Are contribution lists and design principles named, or only numbered? |
| Chetty | Make figures and captions carry the spine of the empirical argument. | Could a skimmer understand the main empirical result from figures and captions alone? |
| Varian and Angrist-Pischke | Teach the intuition before the complication, then use examples to discipline interpretation. | Does the prose build the simple version before caveats and robustness details arrive? |
| Dijkstra and McCloskey | Let exact claims do the work instead of promotional language. | Can importance-signaling adjectives and verbs be replaced by mechanisms or results? |

The common pattern is not literary flourish. These writers make ordinary material pleasurable by reducing reader effort at the right moments and increasing reader curiosity at the right moments. They orient before they formalize, name what must be remembered, make examples do argumentative work, let figures carry evidence, and place payoffs where the reader naturally pauses.

An author may supply their own exemplar. "Match the sentence-length variation and paragraph pacing of this" is a usable instruction; "write engagingly" is not, because it names no target. When the author pastes a passage from a writer they admire as a pacing target, treat it as a rhythm model only: match its sentence-length variation and paragraph pacing, and nothing else. Do not borrow its diction, its mannerisms, its metaphors, or its voice, and do not import any of its content. The rule that exemplars are technique sources, not voices to imitate, holds for the author's own exemplar as much as for the catalog above; a supplied passage widens what "technique" covers to include cadence, not what may be copied.

## Anti-patterns

These make a paper less pleasurable even when every sentence is grammatical.

- **Correct but airless prose.** Every sentence is accurate, but none tells the reader what is at stake.
- **List rhythm.** Paragraphs become a sequence of similarly weighted claims, often joined by banned transitions.
- **Delayed purpose.** The paragraph explains machinery before naming the question the machinery answers.
- **Payoff leakage.** The strongest idea is followed by a citation tail, a caveat that belongs earlier, or a procedural afterthought.
- **Over-smoothed tension.** An interesting contrast, limitation, or surprise is edited into a bland generality.
- **Performative elegance.** Figurative language, alliteration, triads, or dramatic phrasing call attention to the editor rather than the paper.

## Safe boundaries

Pleasure edits are allowed only when they preserve the author's claims, evidence, technical terms, and emphasis. If making a paragraph pleasurable would require adding a new example, explaining a missing mechanism, changing the contribution frame, or elevating a result the author did not emphasize, ask the author instead.

At `final polish`, pleasure edits are sentence-level only: stress position, rhythm, referents, punctuation, and exact word choice. Do not move paragraphs or add new argumentative material. At `response to reviewers`, apply this pass only inside flagged paragraphs and their immediate neighbours.

## Rationale language

In `Change rationale`, name the reader-experience benefit precisely. Good reasons include: visible question, improved payoff, corrected stress position, reduced processing load, restored contrast, varied rhythm, varied sentence load, a low-load sentence kept for relief, a running example threaded across sections, concrete anchor, or clearer consequence. Bad reasons include: more engaging, more elegant, better flow, stronger voice, or pleasure to read with no named mechanism.
