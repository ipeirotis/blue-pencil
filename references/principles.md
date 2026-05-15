# Principles

Load this when SKILL.md invokes a move (such as "old information first, new information last") and the deeper exposition is useful. Each section gives the source, the underlying claim, and when the move does not apply.

## Joseph Williams: character-action sentences and old-new flow

English prose feels clear when grammatical subjects name the *characters* of the story the sentence tells, and grammatical verbs name their *actions*. When subjects and verbs do other things, prose feels muddy even when it is grammatically correct.

**The nominalization problem.** A nominalization is a noun made from a verb or adjective ("analyze" becomes "analysis"). When a sentence buries its action inside a nominalization, the verb slot has to be filled with something weak ("was", "had", "conducted", "performed"), and the subject slot gets filled with an abstraction.

Before: "An investigation of the relationship between X and Y was conducted."
After: "We investigated how X relates to Y."

The second version is shorter, more specific, more honest about agency, and easier to read. The action is in the verb. The character (we) is in the subject.

Exception: when the nominalization names the topic of the sentence and the action is genuinely secondary, leave it. "Our analysis of the corpus revealed three patterns" is fine; "analysis" is the topic.

**The old-before-new principle.** Readers process sentences by anchoring new information to something they already know. Sentences that start with new material force the reader to hold it in working memory until the anchor arrives. Sentences that start with old material let the reader build forward.

Before: "Annotator disagreement on the labels for the most ambiguous items is what the Krippendorff's alpha statistic captures."
After: "Krippendorff's alpha captures annotator disagreement, especially on the most ambiguous items."

The reader has seen "Krippendorff's alpha" in the previous sentence (presumably), so it should be the topic, not the new revelation.

**The stress position.** The end of an English sentence is where emphasis falls naturally. Williams calls this the stress position. Whatever the writer wants the reader to remember should land there.

Weak: "Performance dropped by 40% in the ablation, which surprised us."
Strong: "The ablation dropped performance by 40%, a result that surprised us."

The choice depends on what the next sentence is about. End the current sentence with whatever the next sentence will pick up.

## Gopen and Swan: reader-expectation theory

Gopen and Swan's 1990 American Scientist article extended Williams's insights into a systematic theory. Their claim: readers do not just read sentences; they read them looking for specific information in specific syntactic positions.

The key positions:

- **Topic position (start of sentence):** the reader expects to find what the sentence is about. Use it for old information that connects to context.
- **Stress position (end of sentence):** the reader expects to find what is new and important. Use it for the payload.
- **Subject-verb proximity:** the reader expects the verb to follow the subject quickly. Long noun phrases or interruptions between subject and verb cause friction.
- **Topic continuity across sentences:** the reader expects consecutive sentences in a paragraph to have related topics. Sudden topic shifts feel jarring; the writer must either restructure or signal the shift explicitly.

The diagnostic move: when a passage feels muddy, identify the topic and stress positions in each sentence. If important new information is buried mid-sentence while throat-clearing fills the stress position, the sentence is structurally backwards regardless of whether each word is well chosen.

## Steven Pinker: the curse of knowledge and classic style

Pinker's central diagnostic, lifted from research on theory of mind, is the **curse of knowledge**: once we know something, we cannot easily imagine not knowing it. The author has spent months or years internalizing concepts, terms, mental models, and inferential chains. When they write, they unconsciously assume the reader has the same internal state, and they skip over the moves that would have helped the reader catch up.

The classic symptoms:

- Acronyms used before being defined, or defined once and assumed remembered forever.
- Definite articles ("the result", "the framework", "the issue") pointing at referents the reader has not been introduced to.
- Inferential chains compressed to one or two steps when the reader needs four or five.
- Terms of art used without contextual hints, leaving the uninitiated reader to either know the term or stop reading.
- Examples omitted on the assumption that the abstract statement is self-evident (it almost never is).

The fix is not to write down to the reader. It is to give the reader the context the writer has already internalized.

**Classic style.** Pinker also borrows Thomas and Turner's notion of "classic style": prose that pretends to be a conversation in which the writer has seen something interesting and is pointing the reader toward it. Classic style avoids the metadiscourse of "this paper argues that...", the academic hedging of "it could be argued that...", and the bureaucratic abstraction of "a framework is presented for the analysis of...". It says, in effect: look at this thing in the world. See what I see.

Classic style does not work everywhere (methods sections need other registers), but it is a useful default for introductions, abstracts, and prose passages that need to engage the reader.

## Larry McEnerney: writing for readers, not for self

McEnerney's central diagnostic: the failure of academic writers is that they write to demonstrate what they know rather than to change what readers think. They write writer-centered prose: "I worked hard. I read everything. I am thinking carefully. Here is my thinking." The reader does not care. The reader cares about whether this work is *valuable* and *problematic* and *costly to ignore* in the reader's community.

Diagnostic questions to ask of a draft:

- **Whose problem is this?** A piece of writing has to identify a community and a problem in that community. If you cannot name the readers and what they care about, you cannot write effectively to them.
- **What is at stake?** If nothing is at stake for the reader, why should they read further? Stakes can be intellectual (this changes how we should think about X), practical (this changes what we should do about Y), or methodological (this changes how we should study Z).
- **Why is this hard?** If the problem were easy, someone would have solved it. The writer needs to make the difficulty visible so the contribution registers.
- **Is the writing valuable, or just correct?** Most academic prose is correct. Very little is valuable. Correctness is necessary, not sufficient.

The single most common move that improves academic prose is reframing it from a demonstration of thinking to an argument that changes the reader's mind. This usually involves rewriting the introduction so the reader sees, in the first page, why they should care.

## Mensh and Kording: paper architecture

Mensh and Kording's "Ten simple rules for structuring papers" (PLOS Computational Biology, 2017) is the most useful brief guide to the architecture of a scientific paper. The central insight is that the paper has a structure determined by the reader's needs, not the writer's chronology.

Their rules in compressed form:

1. **Focus on a central contribution.** Pick one. Communicate it in the title.
2. **Write for those who do not know your work.** Most readers are not specialists in your subfield.
3. **Stick to the context-content-conclusion (CCC) scheme** at every level (paper, section, paragraph). Open with context, deliver content, close with conclusion.
4. **Optimize logical flow** by minimizing dependencies. Each paragraph should depend only on what came immediately before.
5. **Tell a complete story in the abstract.** Context, gap, contribution, evidence, implications.
6. **Get to the point in the introduction.** Funnel from broad context to specific gap to specific contribution. The contribution paragraph should come early enough that an abstract-skimming reader finds it.
7. **Communicate results as a sequence of statements supported by figures.** Each result paragraph: claim, then evidence.
8. **Discuss how the gap was filled, the limitations, and the relevance.**
9. **Allocate time wisely.** Title, abstract, figures, first paragraphs. These are what most readers read.
10. **Get feedback early and often.**

For section-by-section application of these rules, load `references/structural-patterns.md`.

## On Strunk and White

"Omit needless words" remains one of the most useful pieces of writing advice ever given. Most of the rest of *The Elements of Style* is either too general to be actionable, prescriptively wrong (the passive voice rule, in particular, has been demonstrated to be partly based on misidentification of passive constructions by Geoffrey Pullum and others), or oriented toward a register of writing that is no longer current.

Treat Strunk and White as a source of one durable piece of advice. Williams supersedes it almost entirely. Gopen and Swan supply what it lacks (structural theory). Pinker supplies the modern linguistic grounding.

## Why these and not others

Other useful sources that this reference does not draw on directly but that converge on similar conclusions:

- Helen Sword, *Stylish Academic Writing*. Empirically grounded analysis of what academics actually do vs. what works.
- Booth, Colomb, Williams, *The Craft of Research*. Excellent on the research process and argument structure.
- William Zinsser, *On Writing Well*. Excellent on nonfiction prose, less specifically academic.
- Simon Peyton Jones, "How to write a great research paper." Short, sharp, CS-oriented, free online.

If the author asks for sources beyond what this skill cites, recommend these.
