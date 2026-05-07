# Sentence-Level Cohesion

Deep treatment of the sentence-level mechanics that make academic prose readable. Load this when diagnosing flow problems within paragraphs.

## The given-new contract

Every sentence has two information slots: what the reader already knows (given) and what the writer is introducing (new). Place given information at the start of the sentence and new information at the end. The new information of one sentence becomes the given information of the next, creating a chain that pulls the reader forward.

A common failure mode in technical writing is front-loading sentences with new technical terms before the reader has any anchor. The fix is to start with what the reader knows from the previous sentence, then bridge to the new concept.

**Broken:** "Heteroskedasticity-robust standard errors were computed. The HC3 variant was used because of its small-sample properties. Bootstrapping with 10,000 replications was applied for confidence intervals."

**Fixed:** "We computed standard errors that are robust to heteroskedasticity. Among the available variants, HC3 performs best in small samples, so we used it. To construct confidence intervals around these estimates, we bootstrapped with 10,000 replications."

The fix shows the chain: standard errors → variants → estimates → confidence intervals. Each sentence's subject connects to the previous sentence's predicate.

## Topic strings

Within a paragraph, the subjects of consecutive sentences should form a coherent string. If subjects jump around (the data, the model, the result, the implication, the field), the reader has to reorient with every sentence. If subjects stay in a related set (the model, its parameters, its predictions, its limitations), the reader stays oriented.

Diagnostic question: "What are the subjects of every sentence in this paragraph?" If you cannot answer in one breath, the topic string is broken.

## Stress position

The end of a sentence carries the most weight. Put the information you want emphasized at the end. If a sentence ends with a citation or a parenthetical, the emphasis is wasted on metadata.

**Weak:** "The treatment effect was statistically significant (p < 0.001, two-tailed test, n = 1,243)."

**Strong:** "Across 1,243 participants, the treatment produced a statistically significant effect (p < 0.001, two-tailed)."

## Cutting throat-clearing

Phrases that contribute nothing:

- "It is important to note that..."
- "It is worth mentioning that..."
- "In this section, we will..."
- "As mentioned previously..."
- "Needless to say..."
- "It goes without saying..."

Delete them. The sentence that follows almost always stands without the preamble.

## Active voice with concrete subjects

Academic prose has a reflex toward passive voice and abstract subjects. Both create distance from the action.

**Distant:** "An evaluation of the proposed approach was conducted using three benchmark datasets."

**Direct:** "We evaluated the approach on three benchmark datasets."

Passive voice has its uses (when the agent is unknown, irrelevant, or when the recipient of the action is the topic), but those should be deliberate choices, not defaults.

## Nominalization

Nominalizations are verbs and adjectives turned into nouns: analyze → analysis, decide → decision, intense → intensity. They sound formal but bury the action.

**Buried:** "The performance of an analysis of the relationship between income and education was the focus of this study."

**Active:** "We analyzed how income relates to education."

Diagnostic: scan for words ending in -tion, -ment, -ance, -ence, -ity. If most carry the meaning of the sentence, unbury the verbs.

## Sentence length variety

A paragraph of uniform-length sentences feels mechanical. Vary the rhythm. Use a short sentence after a long one to land a point. Use a long sentence after several short ones to build out a complex idea.

This does not mean alternating mechanically. It means writing for the ear and reading the result aloud.
