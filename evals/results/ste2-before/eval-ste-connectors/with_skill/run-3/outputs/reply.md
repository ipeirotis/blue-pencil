## Diagnosis

Assumed context: none. `audience`, `revision_stage` (first draft), `target_venue` and `core_thesis` all come from `AGENTS.md`. The audience is ACL readers, many of whom read English as a second language.

Voice tics:
- First-person "we find" and "we observe" mark empirical findings.
- Claim-then-evidence order, with numbers close to the claim.
- A plain, unhedged register with few connectives.
- The table callout sits right after the numbers it supports.

Reader map: readers already know what retrieval augmentation is. They must learn that the gain sits in rare questions, that it costs latency and index time, and that the retriever often returns passages without the answer. They should leave with the idea that retrieval helps on rare questions but is limited by the relevance of what it returns.

Issues found:
1. [S2] One sentence carries three claims: the frozen retriever, the accuracy contrast, and the latency cost. "Since" can be read as time or as cause, and "while" can be read as time or as contrast.
2. [S2] The latency clause is attached to the rare-question gain. It is unclear whether 210 ms applies to all queries or only to rare ones, and whether Table 3 supports it.
3. [S2] "Since the retriever was frozen" presents the frozen retriever as the reason frequent-question accuracy did not change. The manuscript does not say why that follows.
4. [S3] The claim and its evidence share one sentence behind a colon. A subordinate clause leads and delays the subject, and the clause boundary after "observe" is unmarked.
5. [S1, S2] "Long-tail", "rare" and "frequent" probably name one contrast. I kept all three and flagged it.
6. [S4] The paragraph turns abruptly from cost to relevance. The 23% result bears on the thesis, but the paragraph does not say so. Writing that link would add a claim, so it goes to the author questions.
7. [S1, S4] "find", "assumes" and "shows" take clauses with no "that", so second-language readers must infer where each clause starts.

The altitude and precision-budget passes were skipped because this is a results paragraph with no stacked interval, preemptive caveat or added hedge.

## Revised text

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. With the retriever frozen, accuracy on frequent questions did not change, whereas accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency also increased by 210 ms per query. Retrieval cost rises as the index grows: we observe that median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

## Change rationale

Word count rose from about 90 to about 95 (+5%). The growth is the extra "that" markers and one added subject-verb pair from the sentence split.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Gated off: altitude.md and precision-budget.md.

- "We find the gain" became "We find that the gain", which marks the clause boundary.
- "Since the retriever was frozen," became "With the retriever frozen,", which removes the time-or-cause ambiguity without asserting or dropping a causal link.
- "while" became "whereas", so it has only a contrastive meaning.
- The latency clause became its own sentence, so each sentence carries one claim. "Per query" is kept.
- "As the index grows, retrieval cost rises: we observe the median..." became "Retrieval cost rises as the index grows: we observe that median...", which puts the claim first. "Roughly" and "we observe" are kept.
- "that" was added after "assumes" and "shows" as a clause marker.
- Unchanged: all numbers, "Table 3", `[@lewis2020]` and its position, the three question terms, the 1M and 10M index sizes and the paragraph order. Nothing was cut.

## Author questions

- Does Table 3 also support the 210 ms latency figure and the 1M and 10M retrieval-time result? Now that the latency has its own sentence, a reader may take the callout to cover only the accuracy numbers.
- Does the 210 ms increase apply to all queries or only to rare ones? The original attached it to the rare-question clause. The new sentence is neutral.
- Did you intend "Since the retriever was frozen" to explain why frequent-question accuracy did not change? If so, what is the reasoning? "With the retriever frozen" leaves the link open, but second-language readers may want it stated.
- Do "long-tail", "rare" and "frequent" name the same contrast? If so, would you prefer one term throughout, and can you define the long-tail cutoff in one sentence?
- Is the 23% meant to show that the retriever's relevance limits the gain? If so, should the paragraph say so in your own words? I cannot add that claim.
- Is "Prior work" one study ([@lewis2020]) or several? If one, should it name the study, for example "Lewis et al. assume"?
- Is the median retrieval time end-to-end or index lookup only? Should "1M and 10M" be spelled out as "1 million and 10 million" for second-language readers?