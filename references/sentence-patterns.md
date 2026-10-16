# Sentence patterns

A catalog of recurring sentence-level patterns and their fixes, plus the within-paragraph cohesion mechanics that make prose flow. Load this when the sentence-level cohesion lens in SKILL.md names a flow or pattern problem and a concrete diagnosis is useful for the change rationale.

The theory behind the cohesion moves (Williams's old-new flow, Gopen and Swan's reader-expectation positions) lives in `references/principles.md`; this file is the operational version. Several patterns (the dropped connector, stacked verb phrases, two-way -ing forms, the vague "with", one topic per sentence, complex series, and idioms and phrasal verbs) adapt rules from ASD-STE100, Simplified Technical English; `references/principles.md` maps each rule to its academic version and lists the STE rules this skill does not adopt. The AI-tell list and banned-transition policy live in `references/ai-tells-to-avoid.md`, not here.

## Cohesion within the paragraph

The patterns below fix single sentences; these three moves fix how consecutive sentences hold together. (`references/principles.md` gives the underlying theory.)

**The given-new chain.** Place what the reader already knows at the start of a sentence and the new information at the end; the new information of one sentence becomes the given information of the next, pulling the reader forward. The common failure is front-loading a sentence with a new technical term before the reader has an anchor.

| Before | After |
|---|---|
| Heteroskedasticity-robust standard errors were computed. The HC3 variant was used for its small-sample properties. | We computed standard errors robust to heteroskedasticity. Among the variants, HC3 performs best in small samples, so we used it. |

Diagnostic: for each sentence, ask whether it opens on something the previous sentence established. Build transitions from this chain (end a sentence on the term the next will pick up) rather than from a transition word bolted on top.

**Topic strings.** Within a paragraph, the subjects of consecutive sentences should form a coherent set. If the subjects jump around (the data, the model, the result, the field), the reader reorients every sentence; if they stay related (the model, its parameters, its predictions, its limits), the reader stays oriented. Diagnostic: name the subject of every sentence in the paragraph. If you cannot do it in one breath, the topic string is broken.

**Sentence-length variety.** A run of uniform-length sentences reads mechanically, and uniform length is itself an AI tell. Vary the rhythm: land a point with a short sentence after a long one, build out a complex idea with a long sentence after several short ones. This is not mechanical alternation; it means writing for the ear and reading the result aloud.

**Paragraph-shape variety.** The paragraph-scale version of the same tell, and the stronger one. When every paragraph runs the same mold (a topic claim, three evenly weighted supporting sentences, then a "Taken together" or "In summary" restatement of the opener), the section reads mechanically even with every banned word gone, because the shape repeats. Vary it: let some paragraphs be two sentences, let the load-bearing one build across several, and cut the closing restatement when the paragraph already landed its point (a recap that only re-states the opener is the say-it-once echo, `references/subtraction.md`). This is the structural sibling of the sentence-length tell above and of "List rhythm" in `references/reader-pleasure.md`.

## Nominalizations

A nominalization is a noun made from a verb or adjective. Nominalizations are not bad in themselves; they are useful when the action is the topic. They become a problem when they bury the action of a sentence behind a weak verb.

**Pattern:** Subject + form of "to be" or "conduct" or "perform" or "make" or "have" + nominalization.

| Before | After |
|---|---|
| We performed an analysis of the data. | We analyzed the data. |
| There is a need for further investigation. | We need to investigate further. |
| A comparison was made between A and B. | We compared A and B. |
| The contribution of this paper is the development of a new method. | This paper develops a new method. |
| Our hope is that future work will provide a resolution to this issue. | We hope future work resolves this. |

Diagnostic: scan for words ending in *-tion, -ment, -ance, -ence, -ity, -ness* paired with weak verbs. If the noun names an action and the verb is doing no work, fold the action into the verb.

Exception: when the nominalization names the topic and the action is genuinely secondary, leave it. "Our analysis of the corpus revealed three patterns" is fine; "analysis" is the topic.

## Throat-clearing openings

Throat-clearing is the academic habit of starting sentences with phrases that announce what is about to happen rather than saying it.

| Throat-clearing | Direct |
|---|---|
| It is important to note that the effect is small. | The effect is small. |
| It should be emphasized that participants varied widely. | Participants varied widely. |
| One thing to keep in mind is that the data are skewed. | The data are skewed. |
| What we want to argue here is that X causes Y. | X causes Y. |
| It is worth pointing out that prior work has neglected this. | Prior work has neglected this. |

Diagnostic: if you can delete the opening clause and the sentence still says what it means, delete it. The opening clause was telling the reader what was about to happen rather than telling them what is so.

## Existential and expletive constructions

"There is", "there are", "it is", "it was" used as dummy subjects. They are not wrong, but they put the topic in the wrong place.

| Before | After |
|---|---|
| There are several reasons that motivate this work. | Several reasons motivate this work. |
| It is the case that the model overfits on small datasets. | The model overfits on small datasets. |
| There exists a tradeoff between recall and precision. | Recall and precision trade off against each other. |
| It is clear that further work is needed. | (Delete; if it is clear, you do not need to say so.) |

Diagnostic: find "there is", "there are", "there exists", "it is", "it was". For each, ask whether the real topic is being introduced after the dummy subject. If so, restructure.

Exception: "there" constructions are useful when the existence itself is the point ("There are exactly three solutions to this equation"). Use them deliberately.

## The emphatic cleft habit

An it-cleft ("It is X that Y") or a wh-cleft ("What Y does is X") splits a plain clause to spotlight one element. Used once for a genuine contrast it earns its place; LLMs reach for it by default, and it pushes the real subject rightward, delaying the verb the way "Misplaced stress" and "The interrupted clause" do. Unlike the expletive "it is" above, the fix is not deletion: the cleft encodes contrastive focus, so recast to a plain subject-verb only when that focus is not real.

| Before | After |
|---|---|
| It is the interaction between prompt length and model size that drives the effect. | The interaction between prompt length and model size drives the effect. |
| What the ablation shows is that the gain comes from the reranker. | The ablation shows that the gain comes from the reranker. |

Diagnostic: for each "It is/was X that/who ..." and "What ... is/does ...", ask whether the sentence is correcting a specific wrong alternative the reader would otherwise credit. If it is, keep the cleft; the focus is doing work. If it is emphasis by default, unfold it to subject-verb.

## Noun pile-ups

A noun pile-up is three or more nouns adjacent, where the reader has to guess which modifies which.

| Before | After |
|---|---|
| User behavior analysis framework design | Design of a framework for analyzing user behavior |
| Survey response quality measurement instrument | Instrument for measuring the quality of survey responses |
| Algorithm performance evaluation methodology | Methodology for evaluating algorithm performance |

Diagnostic: count adjacent nouns. Two is usually fine. Three is suspicious. Four is almost always wrong. (STE sets its limit at three, rule 2.1.) Fix by breaking the pile with prepositions ("of", "for", "in", "with"). Watch the mirror-image failure: too many such prepositional phrases in a row hold the verb off, which is the prepositional-chain variant under `The interrupted clause` below.

## Two-way -ing forms

An "-ing" word in front of a noun can be a verb acting on that noun or an adjective describing it, and the reader cannot always tell which. STE allows the "-ing" form only as a noun or a noun modifier for this reason (rule 3.5). In academic prose the form is common and usually clear; the failure is the case where both readings make sense in context.

| Before | After |
|---|---|
| Testing conditions differed across sites. | The test conditions differed across sites. (Or, if the act of testing is meant: The way the conditions were tested differed across sites.) |
| Labeling errors reduced recall. | Errors in the labels reduced recall. (Or: Errors made during labeling reduced recall.) |
| Using a larger sample, the effect disappeared. | In the larger sample, the effect disappeared. |

Diagnostic: for each "-ing" word before a noun, read it once as a verb ("testing the conditions") and once as a modifier ("conditions for testing"). If both readings fit the context, recast with a noun, a preposition, or a clause that names the agent. When the two readings make different claims and the context does not decide between them, ask the author which one is meant; do not pick. The third row is the dangling "-ing" opener: its implied subject (whoever used the sample) is not the sentence's subject ("the effect"). Repair it without naming an agent the text does not name, as the third row does; write "when we used" only when the passage already says the authors did it, and otherwise ask. A term of art that ends in "-ing" ("matching estimator", "boosting", "training set") is a name, not an ambiguity; leave it.

## Hedge stacking

Hedges (modal verbs and adverbs that qualify a claim) are useful for honesty. Stacked, they become evasive.

| Before | After |
|---|---|
| This may possibly suggest that perhaps X causes Y. | This suggests X may cause Y. |
| It could be argued that one might consider the possibility that... | One possibility: ... |
| The results seem to potentially indicate a tendency toward... | The results suggest a tendency toward... |

Rule: one hedge per claim, maximum; a claim too uncertain to make with a single hedge should not be made, and a claim solid enough to make takes one hedge or none. Exception: a hedge that marks genuine calibration or scope ("on the held-out set", "correlational", a qualifier that bounds the claim to what the evidence bears) is content, not filler; keep it, and count it as the claim's one hedge rather than stripping it (see the qualifier-is-content rule in SKILL.md and `references/subtraction.md`).

## Stacked verb phrases

Auxiliaries and modals stack into verb phrases the reader has to unpack before reaching the action: "would have been expected to have increased", "has been being used", "could be seen to be suggesting". STE forbids auxiliary chains outright (rule 3.4); here the target is the chain that does no work, the verb-phrase sibling of the hedge stack above.

| Before | After |
|---|---|
| The estimates can be seen to have been affected by the outliers. | The outliers appear to have affected the estimates. |
| These features have been being used as proxies for income. | These features continue to be used as proxies for income. |
| The results could be seen to be suggesting a ceiling. | The results suggest a ceiling. |

Diagnostic: count the auxiliaries and modals between the subject and the main verb. Two is ordinary ("has been shown"); three or more is a stack. Keep the tense and aspect (the second row keeps the ongoing use that the progressive "being used" expressed; "have been used" could describe use that has ended) and one marker that carries the claim's calibration: in the first row "appear to" keeps the uncertainty that "can be seen to" expressed, and in the third row "suggest" already carries it, so "could be seen to" goes. When you cannot tell whether a stacked modal marks real uncertainty or only verbosity, keep a marker and ask; dropping the last one turns a qualified claim into a categorical one. Some stacks hide an agent or a time: "the effect would have been expected to be larger" may mean "we predicted" or "theory predicts", and that difference is content, so when the rewrite would have to choose an agent or a time the original left open, ask the author rather than choosing. A modal that carries calibration counts toward the claim's one hedge (see "Hedge stacking" above).

## Overclaiming

The opposite failure: language stronger than the evidence supports. Where hedge-stacking dilutes a sound claim, overclaiming inflates a weak one. Both are miscalibration; the editor flags the change rather than rewriting the claim, because only the author knows what the evidence will bear.

| Before | After (flag for the author) |
|---|---|
| X causes Y. | X is associated with Y. (Is the design causal, or correlational?) |
| Our method proves that ... | Our results are consistent with ... (Does the evidence prove, or support?) |
| This holds in all settings. | This holds on the three datasets we tested. (Was it tested beyond these?) |
| The model is robust. | The model's accuracy stays within 2 points under perturbation P. (Robust to what?) |

Diagnostic: for each strong verb ("causes", "proves", "demonstrates", "establishes", "guarantees") and each universal ("all", "always", "any", "every"), check that the evidence in the section reaches that far. If it does not, surface the gap as an Author question rather than silently weakening the claim.

## Misplaced stress

The end of an English sentence carries emphasis. When the important word lands mid-sentence and trivia lands at the end, the sentence reads backwards.

| Before | After |
|---|---|
| Performance dropped by 40% in the ablation experiment, as we found. | The ablation dropped performance by 40%. |
| The framework, which we describe in detail in Section 3, achieves state-of-the-art results on three benchmarks. | The framework achieves state-of-the-art results on three benchmarks; we describe it in Section 3. |
| Annotators agreed on 86% of items, after deliberation, which is high. | After deliberation, annotators agreed on 86% of items, a high rate. |

Diagnostic: for each sentence, identify the most important word. Check whether it is in the stress position. If not, restructure.

## The buried thesis

The sentence that carries a passage's main point should be the easiest to read, not the hardest. The failure is the reverse: the takeaway arrives as the most clause-laden sentence in the paragraph, so the reader decodes syntax exactly where they most need the point to land clean. Fix by putting a character in the subject, the claim in an active verb, and any qualification in a following sentence rather than a nested clause.

| Before | After |
|---|---|
| On this evidence the interface relocates the visible work of querying rather than demonstrably removing work: for our SQL-literate participants a verification burden survives the switch to natural language, and an NLIDB that hides the generated SQL would remove the very step these users relied on to trust the answer. | The interface moves the visible work of querying rather than demonstrably removing it. Our SQL-literate participants still had to verify the generated SQL, and an NLIDB that hid it would remove the very step they relied on to trust the answer. |
| The observation that performance degrades under distribution shift, which prior work had attributed to representation collapse, is shown by our ablations to instead follow from optimizer state. | Our ablations trace the performance drop under distribution shift to optimizer state, not the representation collapse prior work blamed. |

Diagnostic: find the sentence stating the paragraph's main claim. If it is the longest or most deeply nested sentence in the paragraph, split it: lead with the claim in plain subject-verb-object order, and demote the qualifications to following sentences. Plainness is a change in syntax, not in strength: carry the evidential qualifiers and hedges through unchanged (here "visible" and "demonstrably", which bound the claim to what the study shows), or the plainer sentence asserts more than the original. This is the sentence-level form of "The load-bearing sentence is the plainest" in `references/altitude.md`.

## The interrupted clause

A clause keeps the reader in suspense until its core resolves: a subject needs its verb, a linking verb needs its complement, a verb needs its object, an object needs its complement, and so on for any element and the word that completes it. When an interrupting constituent opens up in one of those gaps, the reader has to hold an unfinished clause in working memory (the four-chunk budget in `references/principles.md`) until the sentence finally closes. The interrupter can be any kind of syntactic unit set into the gap: an appositive ("that question, calibration, open"), a parenthetical, a non-restrictive relative clause ("The interface, which relocates the visible work of querying, produced ..."), or an interposed adverbial, often stacked with a connective ("The results, however, when compared against the baseline, suggest ..."). What matters is the interrupter's position, in a gap the core has not yet closed, not its grammatical type; the type only tells you where the fix's trailing material should reattach. A sentence can trip this way while passing every other check: correct terminology, a topic sentence up front, no banned tell, a payoff at the end. The fix closes the gap so the core resolves without interruption: bring the stranded completing word up to the element it completes, or move the interrupting material to a trailing clause or its own sentence, always carrying that material through unchanged.

| Before | After | Gap closed |
|---|---|---|
| Our data leave that question, calibration, open. | Our data leave open the question of calibration. | object and complement (`leave ... open`) |
| Those conditions, team literacy, schema design, and task framing, are the axes most likely to vary. | Those conditions are the axes most likely to vary: team literacy, schema design, and task framing. | subject and verb (`conditions ... are`) |
| One conjecture, untestable across studies that differ in task, interface, and population, is that the models have matured. | One conjecture is that the models have matured. That conjecture is untestable across studies that differ in task, interface, and population. | subject and verb (`conjecture ... is`) |
| The interface, which relocates rather than removes the visible work of querying, produced no reduction in task time. | The interface produced no reduction in task time. It relocates the visible work of querying rather than removing it. | subject and verb (`interface ... produced`); non-restrictive relative clause |
| The results, however, when compared against the baseline reported in prior work, suggest a smaller effect. | Compared against the baseline reported in prior work, however, the results suggest a smaller effect. | subject and verb (`results ... suggest`); interposed adverbial |

Note how each rewrite keeps the interrupting words verbatim ("calibration"; "untestable across studies that differ in task, interface, and population"; "which relocates rather than removes the visible work of querying") and only changes where they sit, never what they claim. The gap can close either way: the first brings the stranded complement "open" up to the verb and leaves "calibration" where it was, while the others move the interrupting material to the end or the front. When a trailing phrase would dangle (in the third, "untestable ..." at the end would read as modifying "the models have matured" rather than "conjecture"), give it its own sentence with an explicit referent instead. The last two rows show the widening: a non-restrictive relative clause and an interposed adverbial are neither appositive nor parenthetical, but they open in the same subject-verb gap and take the same fix.

### Machine-generated variants

These three are the specifically LLM-generated forms of the interrupted clause. Each composes with a rule stated elsewhere, and each carries content that must move rather than die.

**The first-mention gloss.** The model glosses a term at first mention by setting the definition into the subject-verb gap; this is the strongest LLM instance of the shape. "Retrieval-augmented generation, an architecture that retrieves passages before generating, underperformed the fine-tuned baseline." The gloss is real content, so it moves rather than dies: "Retrieval-augmented generation underperformed the fine-tuned baseline. The architecture retrieves passages before generating." This composes with the first-mention-versus-full-statement rule in `references/precision-budget.md`: the claim runs clean at first mention, and the definition lands once, in its own sentence or wherever the term is established.

**The prepositional chain that holds off the verb.** No set-off constituent at all, but a chain of prepositional phrases stretches the subject and its verb apart. "The effect of the intervention on retention among first-year students in the treatment arm was small." The subject core ("The effect") and its verb ("was") sit eight words apart. Front the qualifying phrases: "Among first-year students in the treatment arm, the intervention had a small effect on retention." This is the mirror image of a noun pile-up (`Noun pile-ups` above): there, stacked nouns collapse the modifiers together; here, the prepositions that would break such a pile-up instead stretch the subject-verb gap. The diagnostic below catches both, because both leave the verb waiting.

**The split correlative.** An embedded clause holds a correlative pair ("not only ... but also", "either ... or", "both ... and") open across the interruption. "The system not only reduces grading time, which was the original motivation, but also improves consistency." Close the correlative so its two halves sit together and demote the interrupter: "The system not only reduces grading time but also improves consistency. Reducing grading time was the original motivation." This ties to the "not only ... but also more than once in a section" tell in `references/ai-tells-to-avoid.md`: if closing the correlative leaves a second one nearby, recast rather than repeat.

Diagnostic: for each sentence, trace the core of every clause it contains, embedded clauses included, and check that no interrupting constituent sits in a gap the core has not yet closed, whatever its grammatical type, and that no chain of modifiers holds a verb out of reach. Length is not the test: a single interrupting word counts when it holds the completing word out of reach (above, the lone "calibration" delays "open"), while a brief parenthetical the reader resolves without losing the core can stay. Carry the interrupting material through unchanged, since a scope or calibration qualifier is content (the qualifier-is-content rule in `references/subtraction.md`). "The buried thesis" above is this pattern applied to a paragraph's main-claim sentence; both share the plainness principle of "The load-bearing sentence is the plainest" in `references/altitude.md`.

## The left-branching preamble

A sibling of the interrupted clause, with the same working-memory cost (`references/principles.md`) but a different fix. Here the material sits before the core opens, not inside it: a stack of subordinate clauses runs ahead of the main subject and verb, so the reader carries the preamble unresolved until the core finally arrives. "Because the annotators disagreed on the hard cases, and given that the training set over-represents them, the model fails to generalize." The gap-closing fix does not apply, because no gap has opened yet; the core has not started. Instead, front the core and demote the preamble to a trailing clause or a following sentence: "The model fails to generalize: the annotators disagreed on the hard cases, and the training set over-represents them." As with the interrupted clause, the demoted material carries through unchanged; only its position moves. A short single preamble ("Because X, the model fails") is fine, the way a brief parenthetical is; the tell is the stack, two or more subordinate clauses held open before the core.

Diagnostic: for each sentence, find where the main subject and verb begin. If two or more subordinate or participial clauses precede them, front the core and trail the rest. One leading clause is rhythm; a stack is a preamble. This shares the stress principle of "Misplaced stress" above (the core belongs where the reader can act on it) and the plainness of "The buried thesis".

## One topic per sentence

A sentence carries one topic: one claim, one step, or one relation between two things (STE rules 4.1 and Section 6). A sentence that carries two topics makes the reader decide where the first ends, and a second-language reader or a translation tool often decides wrong. Length is the symptom, not the defect, so use it only to find candidates: a sentence past about 25 words (counting a citation command, a math span, or a parenthetical as one word, as STE counts a parenthesis) is checked for a second topic.

| Before | After |
|---|---|
| We recruited 412 participants through the panel provider, and the participants completed the survey in about 14 minutes on average, and we excluded those who failed both attention checks, which removed 38 respondents. | We recruited 412 participants through the panel provider. They completed the survey in about 14 minutes on average. We excluded the 38 who failed both attention checks. |

Diagnostic: for each sentence past the mark, list the independent claims or steps it makes: parts that each have their own subject and verb and could be true or false, or done or not done, without the others. One relation between two things is one topic even though naming it takes "and" ("the trade-off between accuracy and latency"), and a qualifier belongs to the claim it governs. If the sentence makes two or more independent claims or steps, split it between them, carrying every qualifier and number through unchanged. A split that moves or rephrases a numerical clause is a change to a numerical claim, so it needs both checks: the number and its referent survive exactly, and the change is flagged for human review under the numerical-claim constraint in `SKILL.md` (in the table, "which removed 38 respondents" becoming "the 38 who failed" is such a change). A long sentence that carries one topic with a clean core stays: the mark finds candidates and never sets a cap, because uniform short sentences are their own tell ("Sentence-length variety" above). The rewrite in the table keeps a long-short rhythm without the original's three topics.

## The dropped connector

Writers drop small words to save space: the conjunction "that", an article, a repeated verb. STE forbids it (rule 4.2, with a grammar rule on "that"). The common academic case is "that" after a verb of reporting or finding ("show", "find", "report", "observe", "assume", "note"). Without it, the reader parses the next noun as the object of the verb, then has to back up when a second verb arrives.

| Before | After |
|---|---|
| We found the effect of tutoring on attendance was small. | We found that the effect of tutoring on attendance was small. |
| Prior work assumes the labels reflect the construct. | Prior work assumes that the labels reflect the construct. |
| Model trained on the full corpus outperforms baseline. | The model trained on the full corpus outperforms the baseline. |

Diagnostic: after each reporting verb, check whether the noun phrase that follows could be its object ("found the effect"). If it could, and a verb follows that makes it the subject of a new clause instead, restore "that". Restore a dropped article in running prose, but the choice between "the" and "a" says which thing is meant, so take it from the context: the third row assumes the paper has already introduced one model and one baseline, and when the context does not settle which article is meant, ask in `Author questions` instead of choosing; captions, table headers, and figure labels may stay telegraphic when the venue's convention is telegraphic. Short objects that cannot mislead ("We found it was small") need no "that".

## Wordiness compounds

Common multi-word phrases that have shorter equivalents. Cutting them is the easiest revision pass.

| Before | After |
|---|---|
| in order to | to |
| due to the fact that | because |
| at this point in time | now |
| a large number of | many |
| a small number of | few |
| in spite of the fact that | although |
| with the exception of | except |
| in the event that | if |
| for the purpose of | for, to |
| in close proximity to | near |
| has the ability to | can |
| is able to | can |
| make use of | use |
| in the case of | for, with |
| it is often the case that | often |
| the majority of | most |
| in addition to the fact that | besides |
| the fact that | (recast: "due to the fact that" -> "because"; "aware of the fact that" -> "aware that") |
| in terms of | (name the dimension, or delete) |
| a number of | several, many |
| the way in which | how |
| serves to [verb] | [verb] ("serves to clarify" -> "clarifies") |

These are search-and-replace targets. Run them first; they almost always shorten without loss.

## Idioms and phrasal verbs

A phrasal verb whose meaning is not the sum of its words ("come up with", "end up", "turn out to be", "carry out", "point out") is clear to a native reader and opaque to many second-language readers and translation tools (STE rule 9.3). Where a single verb carries the same meaning with equal precision, use it.

| Before | After |
|---|---|
| We came up with a scoring rule. | We devised a scoring rule. |
| The gain turned out to be smaller in the second wave. | The gain was smaller in the second wave. |
| Most respondents ended up choosing the default. | Most respondents chose the default. |

Exceptions: a phrasal verb that is a term of art or the plain verb of the field ("rule out", "set up" for an experiment, "drop out" for attrition) stays, and so does one whose single-verb replacement is longer, rarer, or less precise ("find out" is often clearer than "ascertain"). Some phrasal verbs carry meaning their single-verb replacement drops: "turned out to be" can mark a surprise, and "ended up" can mark an outcome reached after deliberation or against an expectation. The rows above assume the context shows no such meaning; when it does, or when you cannot tell, the meaning is content, so keep the phrasal verb or ask. This pattern never licenses swapping a plain word for a Latinate one: the "use, not utilize" rule in `references/ai-tells-to-avoid.md` still holds.

## Vague abstractions

Abstract nouns that hide the underlying concrete claim. Common offenders: "aspects", "factors", "issues", "considerations", "elements", "things", "approaches".

| Before | After |
|---|---|
| Several factors influence the result. | Three things influence the result: A, B, and C. |
| Various aspects of the problem need consideration. | (Name the aspects.) |
| There are issues with the methodology. | (Name the issues.) |
| Different approaches have been proposed. | (Name them, or summarize their shared logic.) |

Diagnostic: when you see one of these abstract nouns, ask what concrete content it stands for. If you cannot answer, the writer probably could not either. Flag as an author question.

**Vague verbs** are the verb form of the same problem: "address", "handle", "deal with", "tackle", "affect", "impact", "involve", "examine", "explore", "focus on", "look at". Each stands for a more specific action, and STE's demand for a specific word (the reason its dictionary gives each verb one meaning) applies here. The specific verb usually makes a different claim: "address the confound" can mean "measure", "control for", "bound", or "eliminate", and those are four different results.

| Before | Rewrite, unless the manuscript says elsewhere | Author question |
|---|---|---|
| We address selection bias with a reweighting step. | Unchanged. | Does the reweighting reduce, bound, or remove the bias? |
| Income affects turnout. | Unchanged. | Which direction, and is the design causal? |

Diagnostic: for each vague verb on a claim, ask what the author did or found. If the passage says so elsewhere, use that verb; if it does not, the choice is substance, so ask in `Author questions` rather than picking the strongest verb.

## Misused connectives

Common errors with logical connectives that obscure argument structure.

- **"However"** signals contrast. If the next sentence does not contrast with the prior one, do not use it.
- **"Thus", "therefore", "hence"** signal logical consequence. If the next sentence does not follow logically, do not use them.
- **"Indeed"** signals confirming evidence. It is overused as a generic intensifier.
- **"While"** is ambiguous between "during" and "although". Prefer "although" or "whereas" for the contrastive meaning, especially in academic prose. "Since", "as", and "once" carry the same two-sense risk; the full rule is "One word, one sense" in `references/copyediting.md`.

Note: the banned-transition list in `references/ai-tells-to-avoid.md` is the canonical source. The above are about misuse of allowed connectives, not bans.

## The vague "with"

"With" can attach a whole clause to a sentence without saying how the two relate: "Accuracy rose to 91%, with recall on rare classes falling to 40%." The reader cannot tell whether the second fact contrasts with the first, causes it, or only happened at the same time. STE limits "with" for this reason (its grammar rule on "with"). In academic prose the absolute "with X doing Y" construction is the usual case, and LLM drafts reach for it often.

| Before | After |
|---|---|
| Accuracy rose to 91%, with recall on rare classes falling to 40%. | Accuracy rose to 91%. Recall on rare classes fell to 40%. (Flag: are these a trade-off, or independent?) |
| Turnout fell in rural districts, with polling places closing in 30 counties. | Turnout fell in rural districts. Polling places closed in 30 counties. (Flag: are the closures in those districts, and do they explain the fall?) |

Diagnostic: for each "with" followed by a noun and an "-ing" or past-participle verb, name the relation (contrast, cause, place, time, manner) and use the word that states it. The license is the same as for "Accumulation instead of argument" below: make explicit only a relation the author's text supports. Two numbers moving in opposite directions do not by themselves make a contrast: in the first row "but" would present the recall drop as a trade-off against the accuracy gain, which is a claim about the result, so it needs the paper to say so. In the second row the text likewise supports no relation: "because" would add a causal claim and "where" a claim about location, since the 30 counties may lie partly outside the rural districts. When no relation is supported, keep the two facts as two sentences and ask the author in `Author questions` which relation they mean. When the "with" clause carries a number (both rows do), splitting it off rephrases a numerical claim, so it also gets the human-review flag the numerical-claim constraint in `SKILL.md` requires, beside the relation question; every number and its referent carry through exactly. "With" in its plain senses ("trained with dropout", "participants with a degree") is fine.

## Accumulation instead of argument

Banning "Furthermore", "Moreover", and "Additionally" (`references/ai-tells-to-avoid.md`) removes the word, not the habit under it: claims strung together as coordinate equals when one actually causes, enables, or qualifies the next. Delete the connective and the flat list is still there.

| Before | After |
|---|---|
| The baseline fails on rare classes. Our method reweights them. Additionally, accuracy improves. | The baseline fails on rare classes, so our method reweights them; accuracy improves as a result. |
| Annotators disagreed on the hard cases. The training set over-represents them. Moreover, the model inherits the noise. | Because annotators disagreed on the hard cases that the training set over-represents, the model inherits the noise. |

Diagnostic: for a run of same-shaped declaratives joined by additive connectives or by nothing, ask what relation actually holds between them: does one cause, enable, qualify, or contrast with the next? Name that relation with the connective that fits (because, so, but, despite). The license comes from the author's own material: a juxtaposition that already implies the relation may be made explicit, but a relation the text does not support is new substance, so flag it in `Author questions` rather than inventing it. When the items are genuinely independent, an explicit list is more honest than additive glue. The test is whether reordering the sentences changes the meaning; if it does not, they are being accumulated, not argued. See "List rhythm" in `references/reader-pleasure.md`; for why a draft defaults to this equal-weight mold, see "Why the defensive draft reads flat" in `references/precision-budget.md`.

## Complex series

An inline series is hard to parse when its items are long, contain their own commas, or have internal structure of their own. STE's answer is a vertical list (rule 4.3). Academic prose has two lighter answers that keep the paragraph intact: label the items, or separate them with semicolons.

| Before | After |
|---|---|
| Participants were excluded if they failed the attention check, completed the survey in under three minutes, which we set as one third of the median time, or gave the same answer to every grid item. | Participants were excluded if they (i) failed the attention check, (ii) completed the survey in under three minutes, which we set as one third of the median time, or (iii) gave the same answer to every grid item. |

Diagnostic: a series of three or more items where any item contains a comma or its own clause takes labels "(i), (ii), (iii)" or semicolons between items. Labels and semicolons are sentence-level edits and run at any stage. Converting a series to a vertical list changes the paragraph's shape, so it is structural: propose it in `Diagnosis` at `first draft`, never perform it at `final polish`, and only where the venue style uses lists in running text. When the items are meant to be remembered rather than parsed, name them instead (`references/edit-checks.md`, check 7).

## Dangling references

Pronouns and definite articles that point at things the reader cannot identify.

| Before | After |
|---|---|
| This is a problem for downstream applications. | This ambiguity is a problem for downstream applications. |
| The result was unexpected. | The accuracy result was unexpected. |
| It suggests a different mechanism. | The 40% drop suggests a different mechanism. |

The "this + noun" rule: when "this" begins a sentence, almost always follow it with a noun summarizing what "this" refers to. "This finding suggests..." not "This suggests...".

Diagnostic: for each "this", "that", "it", "they", "the X", ask whether the reader, reading linearly, can identify the referent without backtracking. If not, supply a noun.

## Voice issues that matter (and ones that do not)

The blanket prohibition on the passive voice is wrong. The passive is useful when:

- The receiver of the action is the topic. ("The samples were stored at 4°C." The samples are the topic, not whoever stored them.)
- The agent is unknown or uninteresting.
- Old-new flow requires the receiver to come first.

The passive is harmful when:

- It hides agency the reader needs to see. ("It was decided that the protocol would be revised." By whom?)
- It produces weak verbs and nominalizations.

Diagnostic: when you see a passive, ask whether the agent matters and whether the receiver is the topic. If the agent matters and is hidden, fix it. If the receiver is the topic, leave it.

Similarly: "I" and "we" are not banned in modern academic prose. "We analyzed" is almost always better than "An analysis was performed".
