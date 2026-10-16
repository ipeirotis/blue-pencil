## Diagnosis

Assumed context: none. Audience, revision stage, venue and thesis all came from `AGENTS.md`. Stage is `first draft`, but this is a one-paragraph results section whose order already works. The edits are therefore sentence-level, and the paragraph keeps its order and boundaries.

Voice tics: first-person "we find / we observe"; a colon that introduces the evidence for a claim; the citation placed right after the claim it supports; compact numeric reporting; a "prior work assumes X, but our annotation shows Y" contrast.

Reader map: starts with knowing what retrieval augmentation is and what "long-tail" means in QA; must learn that the gain sits on rare questions, that it costs latency and grows with index size, and that the retriever's top results often lack the answer; should leave with the thesis that retrieval helps mainly on rare questions and is capped by what the retriever returns.

Jargon to unpack: none. Buried lede: none (the claim is already sentence 1). Concrete anchor: none needed (41.2% to 57.8%, 210 ms, and 23% are already on the page).

1. [P1, whole paragraph] The spine is "the gain is concentrated in long-tail questions, but it costs latency and index-size growth, and the retriever's top results often lack the answer". The paragraph never says that the 23% figure limits the gain, which is the second half of the thesis. Supplying that link would add a claim, so it is routed to `Author questions`.
2. [S1, S2] "long-tail" (S1) and "rare" (S2) may name the same set of questions, and "frequent" appears as their opposite. I did not unify them, because collapsing terms is the author's call.
3. [S2] "Since the retriever was frozen" can be read as time ("from when") or cause ("because"). The causal reading is a technical claim, so I did not choose a sense and asked instead.
4. [S2] "while" can mean "during" or "although". The sentence contrasts two accuracies, so "whereas" carries only the contrast.
5. [S2] The vague "with": "with median latency increasing by 210 ms per query" attaches a fact without naming its relation to the accuracy result. I made it its own sentence and asked which relation is meant.
6. [S1, S4, S5] The dropped connector "that" after "find", "observe", "assumes", and "shows". The next noun phrase can be misread as the verb's object, which costs second-language readers and translation tools a re-parse.
7. [S4] "the 1M and 10M document indexes" can be misread as "10M document indexes" (ten million indexes). Naming the documents as what the numbers count removes that parse.

## Revised text

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Since the retriever was frozen, accuracy on frequent questions did not change, whereas accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. As the index grows, retrieval cost rises: we observe that the median retrieval time roughly doubles between the indexes of 1M and 10M documents. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

## Change rationale

Word count: ~110 to ~120 (+9%). The growth is restored "that" connectors (4 words) and the clearer index phrasing (about 4 words); no content was added.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Altitude was gate-checked: this is a Results paragraph with no stacked interval, machinery, or preemptive caveat above its home, so it needed no change. precision-budget.md is skipped: the gate (abstract, introduction, or contribution paragraph, or a hedge added or removed in the high-cost zone) is not met.

- "We find the gain" → "We find that the gain": restored connector so the clause parses once for second-language readers.
- "while accuracy on rare questions rose" → "whereas accuracy on rare questions rose": a single-sense word that states only the contrast.
- "(Table 3), with median latency increasing by 210 ms per query." → "(Table 3). Median latency increased by 210 ms per query.": one topic per sentence. This removes the vague "with" and gives a short sentence after a long one to vary rhythm.
- "we observe the median retrieval time" → "we observe that the median retrieval time": restored connector.
- "between the 1M and 10M document indexes" → "between the indexes of 1M and 10M documents": removes the noun pile-up and the "ten million indexes" parse. The numbers are unchanged.
- "Prior work assumes the retrieved" → "Prior work assumes that the retrieved": restored connector.
- "our annotation shows 23%" → "our annotation shows that 23%": restored connector.
- "Since", the S1 and S2 term choice ("long-tail" / "rare"), "retrieval cost / retrieval time / median latency", and the citation placement are kept as written. Each is either an unresolved sense or the author's choice (see Author questions).
- Sentences 1, 4 (colon structure) and 5 (order, stress position on the 23% finding, and `[@lewis2020]` position): no safe improvement beyond the connectors.
- No numbers, citation keys, or table references were altered. The sentence boundary and the position of "(Table 3)" and of the counts moved only as described above.

## Author questions

- Does "Since the retriever was frozen" mean "because" (freezing the retriever is why frequent-question accuracy did not change) or "from the time that"? If it is causal, would "Because" be right? I left "Since" unchanged.
- Do "long-tail" (sentence 1) and "rare" (sentence 2) name the same set of questions, and is "frequent" its complement? If so, should one term be used throughout?
- What is the relation between "Median latency increased by 210 ms per query" and the accuracy gain: is it the cost of the gain, or measured independently? Should the text say so?
- Are "median latency" (end-to-end, 210 ms), "retrieval cost", and "median retrieval time" three different quantities, or one? If different, which one does the doubling between the 1M and 10M indexes refer to?
- Please confirm the rephrased index sizes ("the indexes of 1M and 10M documents") and the split sentence around "(Table 3)", since both touch numerical text. All figures (41.2%, 57.8%, 210 ms, 1M, 10M, 23%) and the Table 3 reference are unchanged.
- Should the paragraph state that the 23% of top-ranked passages without the answer limits the benefit of retrieval, as your core thesis says? The text now reports the figure but does not draw that link, and I did not add it.
- What does "top-ranked" mean here (top-1 or top-k), and which index or dataset was annotated? The reader cannot interpret the 23% without this.
- Should the single citation [@lewis2020] be read as "Prior work" in general, or is a second source intended? I left the citation and its position untouched.