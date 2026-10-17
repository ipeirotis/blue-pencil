The `paper-reviser` subagent has finished. Its output is below. I changed nothing except the arrow characters.

## Diagnosis

Assumed context: none. `audience`, `revision_stage` (first draft), `target_venue` and `core_thesis` all came from `AGENTS.md`. Triage was preset: direct rewrite of this one results paragraph, at first-draft aggressiveness.

Voice tics: first-person "we" with reporting verbs ("we find", "we observe"); a colon that expands a claim ("retrieval cost rises: ..."); numbers with a table pointer in parentheses; a mid-sentence pandoc citation; "roughly" as a plain approximation marker.

Reader map: the reader knows retrieval augmentation and the long-tail idea. They must learn three things: the gain sits in rare questions, it comes with a latency cost, and it is capped by passages that often miss the answer. They should leave with "retrieval helps rare questions, but only when the retriever returns passages that contain the answer".

Jargon to unpack: none.
Buried lede: none. The 23% finding already sits in the stress position of the last sentence.
Concrete anchor: 41.2% to 57.8% (Table 3) and the 23% annotation figure, both already present.

1. **[P1, whole paragraph]** The paragraph runs claim, then latency cost, then index-size cost, then retriever relevance, with no sentence connecting these. The tension in the core thesis (the gain is real, but capped by relevance) is never joined to the 23% figure. The two cost sentences sit between the claim and its limit. The subagent did not reorder, because the paragraph ends on the relevance finding. It did not add a bridge, because that would need a claim the manuscript does not state. Both go to Author questions.
2. **[S2]** This is one 36-word sentence with three topics: a cause ("Since the retriever was frozen"), a contrast (frequent unchanged vs. rare up), and a cost (latency). "Since" can be read as time or cause. "while" can be read as time or contrast. "with median latency increasing" attaches a clause without saying how it relates to the rest.
3. **[S3]** "As the index grows" can be read as time or cause. "the 1M and 10M document indexes" is a noun pile-up in which "1M" could read as a bare number. The text uses three terms for what may be one or several quantities: "latency", "retrieval cost", and "retrieval time".
4. **[S1, S3, S4]** "that" is dropped after "find", "observe", "assumes", and "shows". The next noun phrase can be misparsed as the verb's object.
5. **[S4]** The "but" treats "do not contain the answer" as the failure of "relevant". These are two different properties, and the paragraph does not say so.
6. **[P1]** The text names the same two groups "long-tail", "rare", and "frequent". These may be the same construct or different ones. The subagent did not unify them.

## Revised text

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change. In contrast, accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. Retrieval cost rises with index size: we observe that the median retrieval time roughly doubles between the 1M-document and 10M-document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Added bridges: None.

## Change rationale

Word count: ~90 to ~90 (0%). The added words ("that" three times, "In contrast") are offset by the removed "while", "with", and "As the index grows".

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Altitude was consulted and its gate is not met (no stacked interval, machinery, or preemptive caveat), so it produced no change. Precision-budget was skipped: its gate covers abstracts, introductions, and contribution paragraphs, and this is a results paragraph.

- "Since the retriever was frozen, ..., while ..., with ..." → three sentences, one topic each. This removes the three ambiguous connectives and the stacked clauses.
- "Since" → "Because". The only plausible reading is causal, and "because" gives the cause sense a single meaning. It does not add a claim (see Author questions).
- "while" → "In contrast," opening its own sentence. It restores the frequent-versus-rare contrast as a single-sense connector and puts the improved rare-question result in the sentence's stress position.
- "with median latency increasing by 210 ms per query" → "Median latency increased by 210 ms per query." The vague "with" becomes a plain statement in the same past tense as "rose". The relation to the gain is left unstated because the text does not state it.
- "As the index grows, retrieval cost rises" → "Retrieval cost rises with index size". It removes the two-sense "as" without changing the claim.
- "we observe the median retrieval time" → "we observe that the median retrieval time". This restores the dropped connector so the noun phrase is not read as the object of "observe". The same fix applies to "We find that", "assumes that", and "shows that".
- "the 1M and 10M document indexes" → "the 1M-document and 10M-document indexes". Parallel hyphenated compounds make it clear that each number counts documents.
- S4 is otherwise unchanged. The citation stays where you placed it, and the sentence ends on the answer-containment finding.
- Paragraph order, "we find/observe/our annotation", "roughly", and the colon are kept as your voice. There is no cut and no reordering.

## Author questions

- **Flag for review:** "Since" became "Because" in S2. Did you mean the retriever's being frozen as the cause of the unchanged accuracy on frequent questions, and not "since" in the time sense?
- **Numerical and table flag:** the 210 ms latency figure and "(Table 3)" now sit in separate sentences. Does Table 3 also report the latency figure, or does it support only the accuracy numbers?
- **Numerical flag:** "1M and 10M document indexes" was reformatted to "1M-document and 10M-document indexes". Please confirm that both figures and the "roughly doubles" claim are unchanged in your data.
- Is the 210 ms median latency increase measured over all queries, or only over rare questions?
- Are "latency", "retrieval cost", and "retrieval time" three names for one quantity or different quantities (for example, whether total latency includes generation)? All three were kept.
- Are "long-tail", "rare", and "frequent" the same two groups throughout, or does "long-tail" name a broader class than "rare"?
- Should the two cost sentences (latency and index size) stay in this paragraph? They separate the gain from its limit, and a separate cost paragraph would let this one move from the gain to the relevance finding. This is a paragraph-level structural call.
- The text shows that 23% of top-ranked passages lack the answer but does not link that figure to the size of the gain. Do you want a sentence stating how the 23% limits the gain? Is "does not contain the answer" the same property as the "relevant" in the prior-work sentence?