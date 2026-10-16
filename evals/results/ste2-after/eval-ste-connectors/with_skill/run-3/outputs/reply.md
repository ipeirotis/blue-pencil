### Diagnosis

Context came from `AGENTS.md`, so no context was assumed. The paragraph states the first half of your thesis (gain concentrated on long-tail questions). It covers the second half (relevance limits the benefit) only through the 23% finding.

- **Order:** The order is gain, then cost, then the relevance limit. It works, and the last sentence lands the turn, so I kept it.
- **Ambiguous connectors:** "Since", "while" and "As" can each be read as time or as cause or contrast. The trailing "with median latency increasing" also interrupts the accuracy result.
- **Dropped "that":** "that" is missing after "find", "observe", "assumes" and "shows". A second-language reader or a translation tool may take the next noun as the verb's object.
- **Terminology:** "long-tail", "rare" and "frequent" may or may not name the same question groups. "Latency", "retrieval cost" and "retrieval time" may or may not name different quantities. I left all of them as written.
- **Relevance versus answer:** The prior work "assumes the passages are relevant", while your finding is that they "do not contain the answer". These may be different constructs, and the contrast depends on them being the same.

### Revised text

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change, whereas accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. Retrieval cost rises with index size: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

### Change rationale

The text grew from about 94 to about 100 words (+6%). Most of that is four restored "that" connectors, each of which removes a wrong parse for second-language readers. Nothing was cut or reordered. The citation key and its position are unchanged.

- **"We find that the gain":** the added "that" keeps "the gain" from being read as the object of "find".
- **"Because the retriever was frozen":** "Because" has only a causal sense.
- **"whereas accuracy on rare questions":** "whereas" cannot be read as time.
- **Sentence split after "(Table 3)":** this removes the vague "with" and lets the accuracy result end its sentence. The latency figure now has its own sentence.
- **"Retrieval cost rises with index size":** this replaces "As the index grows", which could be read as time. It also fits a comparison between two fixed index sizes.
- **Added "that" after "observe", "assumes" and "shows":** these follow the same logic as the first one.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Two other passes were loaded and then skipped: altitude.md and precision-budget.md. They apply to abstracts, introductions and contribution paragraphs, and this paragraph has none of the stacked intervals, statistical machinery or preemptive caveats that precision-budget.md targets.

### Author questions

- **Numbers:** I moved "median latency increasing by 210 ms per query" into its own sentence. The number, unit and "per query" are unchanged, but please confirm the split. Please also confirm "41.2% to 57.8% (Table 3)", which is untouched but now ends its sentence.
- **Index comparison:** "roughly doubles between the 1M and 10M document indexes" is unchanged. The opening now reads "rises with index size" instead of "As the index grows". Does it still describe a comparison between two separate indexes, not growth of one index over time?
- **Frozen retriever:** Does "Because the retriever was frozen" give the reason frequent-question accuracy did not change? If you meant something narrower, such as "so the gain cannot come from retriever training", which relation do you intend?
- **"Did not change":** Does this mean no difference at all, or no detectable difference? A reader may ask for a test or an interval, and if one exists, which section carries it?
- **Latency baseline:** The 210 ms increase is relative to which condition, presumably the same model without retrieval? The standalone sentence leaves that implicit.
- **Question groups:** Do "long-tail", "rare" and "frequent" name the same groups throughout? If so, where are they defined (for example, by a frequency threshold), and would one term be enough?
- **Cost terms:** Are "retrieval cost", "median retrieval time" and "median latency" the same quantity or different ones?
- **Relevant versus answer:** Does "relevant" mean the same as "contain the answer"? If not, the contrast with prior work needs one line saying how they relate.
- **"Top-ranked":** Does this mean top 1 or top k, and where is the cutoff stated?
- **Thesis link:** Do you want the paragraph to say that the 23% of passages without the answer is what limits the gain? That is your stated thesis. I did not add it, because the paragraph does not claim it.
- **Paragraph split:** Would you prefer to split before "Retrieval cost rises with index size", so the cost findings and the relevance finding each get their own paragraph? I left it as one.