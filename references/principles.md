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

## Cowan and Daneman & Merikle: working memory as the budget

The positional rules above are memory-management strategies, and the memory they manage is small. Cowan's review puts focal working-memory capacity at roughly four chunks, though the figure is highly task-dependent; Daneman and Merikle's meta-analysis (6,179 participants across 77 studies) found that spans measuring processing and storage *together* predict reading comprehension better than storage-only spans. The claim that matters for editing is the conjunction: comprehension is bounded by capacity *under load*, and reading is exactly the loaded case, because the reader must hold earlier material in mind while integrating new material. Every caveat, interrupting constituent, delayed core, and undischarged forward pointer spends part of that four-chunk budget on bookkeeping instead of understanding.

This is the shared account beneath moves scattered through the skill: old-before-new and the stress position (above); the interrupted clause and the left-branching preamble (`references/sentence-patterns.md`); one-new-object-at-a-time and concrete anchoring (the reader ladder in `SKILL.md`); grouped caveats and the precision gradient (`references/precision-budget.md`); and load variation (`references/reader-pleasure.md`). Each is a way of spending fewer chunks per sentence. The costliest violation is flat emphasis: when every claim arrives at equal weight (the accumulation and concessive-see-saw tells), nothing is marked disposable, so the reader must keep all of it open at once; `references/precision-budget.md` traces why a defensive draft produces exactly that.

When the move does not apply: the budget is not fixed, because the unit is the *chunk*, and expertise is what packs more into each one. A term of art an expert reads as a single chunk costs a novice several, so the same sentence can sit inside an expert's budget and overrun a novice's. That is the empirical reason the skill calibrates to audience (the reader ladder in `SKILL.md`): write to the reader's chunking, not to an abstract capacity.

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

## ASD-STE100: Simplified Technical English as a reader-in-a-second-language test

ASD-STE100 (Simplified Technical English, Issue 9, 2025) is a controlled language written for aerospace maintenance manuals: a set of writing rules plus a dictionary of approved words, each with one approved meaning. Its reader is a technician who may read English as a second language, may read through a machine translation, and cannot ask the author what a sentence meant. Most readers of an international journal fit that description: they read in English, many not in their first language, and some through a translation tool, and none can query the author.

The underlying claim is that most misreadings come from a small set of causes: a word that carries two senses, a word the writer dropped to save space, a verb phrase built from stacked auxiliaries, an "-ing" form that parses two ways, and a sentence that carries more than one topic. Each cause costs a native reader a moment and can cost a second-language reader or a translation tool the whole sentence. STE removes the causes by rule. This skill takes the causes as diagnostics and leaves the rules as rules for manuals.

### What transfers, and where it lives

| STE rule (Issue 9 numbering) | Academic version | Home in this skill |
|---|---|---|
| 1.3, 9.2: use each word only in its approved meaning | One word, one sense: no occurrence of "since", "as", "while", "once", "may", or "should" can be read in two senses; clear uses of two senses in one passage ("as a control", "as specified") both stay | `references/copyediting.md`, item 11 |
| 1.11, 9.4: do not use different technical nouns for the same thing | One construct, one term, already the terminology-consistency rule; no synonyms for variety | `references/copyediting.md`, items 4 and 11 |
| 1.10, 1.9: no slang, regional, or jargon words as technical nouns; prefer short, clear ones | Jargon earns its place; a term of art stays, an idiom does not | `SKILL.md` Style rules; `references/sentence-patterns.md`, "Idioms and phrasal verbs" |
| 2.1: multi-word nouns of not more than three nouns | The noun pile-up threshold (three suspicious, four almost always wrong) | `references/sentence-patterns.md`, "Noun pile-ups" |
| 3.4: do not use auxiliary verbs to make complex verb constructions | Stacked verb phrases ("would have been expected to have") | `references/sentence-patterns.md`, "Stacked verb phrases" |
| 3.5: use the "-ing" form only as a noun or a noun modifier | Flag an "-ing" form that parses two ways, and the dangling "-ing" opener | `references/sentence-patterns.md`, "Two-way -ing forms" |
| 3.6, 3.7: active voice; an action in a verb, not a noun | Already the character-action rule above and the nominalization pattern; the passive stays legal where the receiver is the topic | `references/sentence-patterns.md`, "Nominalizations" and "Voice issues" |
| 4.1 and Section 6: short, clear sentences, one topic each; key topic first | One topic per sentence, with about 25 words as the point to check, not a cap | `references/sentence-patterns.md`, "One topic per sentence" |
| 4.2 and GR-1: do not omit words to make a sentence shorter; keep the conjunction "that" | The dropped connector: a missing "that", article, or verb that sends the reader down the wrong parse | `references/sentence-patterns.md`, "The dropped connector" |
| 4.3: use a vertical list for complex text | Label a long or comma-heavy inline series; a vertical list only where the venue and stage allow | `references/sentence-patterns.md`, "Complex series" |
| 4.4: connect related sentences with connecting words | Name the relation (because, so, but), already "Accumulation instead of argument" | `references/sentence-patterns.md` |
| 4.5 and GR-4: use an article or a demonstrative before a noun; "this" needs a noun | The "this + noun" rule | `references/sentence-patterns.md`, "Dangling references" |
| GR-2: the preposition "with" | The vague "with" that attaches a clause and hides its relation | `references/sentence-patterns.md`, "The vague with" |
| GR-5, GR-6: false friends, Latin abbreviations | Flag false friends; check "i.e." against "e.g." | `references/copyediting.md`, items 12 and 13 |
| 5.2, 5.4: one instruction per sentence; a condition before its command | Procedural passages in Methods: one step per sentence in order of performance, the condition before the action | `references/structural-patterns.md`, "Methodology" |
| 7.3: give an explanation to show the risk or possible result | A limitation names its consequence for the reading of the result | `references/structural-patterns.md`, "Discussion" |
| 5.2 (applied to letters) | One claimed change per sentence, each with its location | `references/structural-patterns.md`, "Rebuttal letters" |
| 9.3: do not make phrasal verbs | Replace an idiomatic phrasal verb with a single verb of equal precision | `references/sentence-patterns.md`, "Idioms and phrasal verbs" |

### What does not transfer

- **The dictionary.** Academic prose needs the full vocabulary of its field. The transferable part of the dictionary is its principle (one word, one sense), not its word list.
- **Hard word caps.** STE caps descriptive sentences at 25 words and procedural ones at 20. A cap would flatten rhythm, and uniform sentence length is itself a tell (`references/sentence-patterns.md`). Here 25 words is the point at which a sentence is checked for a second topic, never a limit it must meet.
- **The semicolon ban (8.1).** Academic style uses the semicolon to join two closely related clauses and to separate series items that contain commas. Keep it; check only that the relation between the joined clauses is one the reader can see.
- **The imperative mood and the strict passive rule (3.6, 5.3).** Papers report what was done and what was found. The past-tense passive is legitimate where the receiver of the action is the topic (`references/sentence-patterns.md`, "Voice issues").
- **American spelling (1.14).** Spelling follows the venue, and `references/copyediting.md` forbids silent normalization.
- **The six-sentence paragraph.** One topic per paragraph transfers (it is already the paragraph-craft rule); the count does not.

STE is a floor for comprehension, not a model of good prose. An edit made under one of these diagnostics must still clear the Restraint rule in `SKILL.md`: a sentence that already parses in one pass for a second-language reader stays as it is.

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
