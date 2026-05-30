# Sentence patterns

A catalog of recurring sentence-level patterns and their fixes. Load this when the sentence-level cohesion lens in SKILL.md (or in `references/sentence-cohesion.md`) names a problem and a concrete diagnosis with a named pattern is useful for the change rationale.

The AI-tell list and banned-transition policy live in `references/ai-tells-to-avoid.md`, not here.

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

## Noun pile-ups

A noun pile-up is three or more nouns adjacent, where the reader has to guess which modifies which.

| Before | After |
|---|---|
| User behavior analysis framework design | Design of a framework for analyzing user behavior |
| Survey response quality measurement instrument | Instrument for measuring the quality of survey responses |
| Algorithm performance evaluation methodology | Methodology for evaluating algorithm performance |

Diagnostic: count adjacent nouns. Two is usually fine. Three is suspicious. Four is almost always wrong. Fix by breaking the pile with prepositions ("of", "for", "in", "with").

## Hedge stacking

Hedges (modal verbs and adverbs that qualify a claim) are useful for honesty. Stacked, they become evasive.

| Before | After |
|---|---|
| This may possibly suggest that perhaps X causes Y. | This suggests X may cause Y. |
| It could be argued that one might consider the possibility that... | One possibility: ... |
| The results seem to potentially indicate a tendency toward... | The results suggest a tendency toward... |

Rule: one hedge per claim, maximum. If a claim is too uncertain to make with one hedge, do not make it. If a claim is solid enough to make, make it with one hedge or none.

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

## Vague abstractions

Abstract nouns that hide the underlying concrete claim. Common offenders: "aspects", "factors", "issues", "considerations", "elements", "things", "approaches".

| Before | After |
|---|---|
| Several factors influence the result. | Three things influence the result: A, B, and C. |
| Various aspects of the problem need consideration. | (Name the aspects.) |
| There are issues with the methodology. | (Name the issues.) |
| Different approaches have been proposed. | (Name them, or summarize their shared logic.) |

Diagnostic: when you see one of these abstract nouns, ask what concrete content it stands for. If you cannot answer, the writer probably could not either. Flag as an author question.

## Misused connectives

Common errors with logical connectives that obscure argument structure.

- **"However"** signals contrast. If the next sentence does not contrast with the prior one, do not use it.
- **"Thus", "therefore", "hence"** signal logical consequence. If the next sentence does not follow logically, do not use them.
- **"Indeed"** signals confirming evidence. It is overused as a generic intensifier.
- **"While"** is ambiguous between "during" and "although". Prefer "although" or "whereas" for the contrastive meaning, especially in academic prose.

Note: the banned-transition list in `references/ai-tells-to-avoid.md` is the canonical source. The above are about misuse of allowed connectives, not bans.

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
