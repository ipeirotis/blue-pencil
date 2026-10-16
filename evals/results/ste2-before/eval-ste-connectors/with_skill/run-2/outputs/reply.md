## Diagnosis

Assumed context: none. I took `audience`, `revision_stage` (first draft), `target_venue` and `core_thesis` from `AGENTS.md`. Because many readers use English as a second language, sentence boundaries and connectives got extra weight.

- **Voice to keep:** first-person "we" and "our", the colon linking a claim to its detail, "roughly", and the plain results-section register.
- **Jargon:** "long-tail" in sentence 1 becomes "rare" in sentence 2. "Frozen retriever" is not explained. I can't define either from the manuscript, so both are in the questions below.
- **Concrete anchor:** the 41.2% to 57.8% contrast (Table 3). I kept it as the paragraph's anchor.
- **Structure:** sentence 2 carried three findings at once (frequent unchanged, rare up, latency up). The two cost findings (latency, index-size retrieval time) sat apart. I split sentence 2 and grouped the costs, so the order is gain, then costs, then the relevance turn.
- **Logic:** "Since the retriever was frozen" reads as causal, but the paragraph never says why a frozen retriever would leave frequent-question accuracy unchanged. "Since" can also read as temporal, which can trip second-language readers. I changed the wording but did not choose a meaning for you.
- **Spine:** the paragraph never says how the 23% of passages without the answer limits the gain. That link is the second half of your thesis. It isn't on the page, so I did not add it.
- **Copyediting:** I added "that" to mark the start of two embedded clauses. "While" is ambiguous between "during" and "whereas", so I used "whereas". I cut "we observe" as filler.

## Revised text

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. With the retriever frozen, accuracy on frequent questions did not change, whereas accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. Retrieval cost also rises as the index grows: the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

## Change rationale

Word count is about the same (about 100 before and after).

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md (gate not met, no change), precision-budget.md (gate not met, no change), narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md

- **"Since the retriever was frozen" became "With the retriever frozen":** this removes the ambiguous causal/temporal "since" and keeps either relation you may intend.
- **"while" became "whereas":** the contrast is now unambiguous.
- **Latency clause split off:** the accuracy sentence now ends on its anchor (Table 3). The 210 ms figure and "per query" are unchanged.
- **Sentence order:** latency now sits directly before the index-size cost, so the two costs form one block. The paragraph still ends on the retriever-relevance turn.
- **Cost sentence:** the claim leads, "also" shows it adds to the previous cost, and "roughly" and "1M and 10M document indexes" are kept word for word.
- **"that" added** after "We find" and "our annotation shows".
- **Unchanged:** `[@lewis2020]` and its position, Table 3, 41.2%, 57.8%, 210 ms, 1M, 10M and 23%. The "Prior work … but our annotation" contrast stays as one sentence because the "but" is the paragraph's turn.
- **Declined edits:** I did not unify long-tail/rare, cost/time/latency, or "relevant"/"contain the answer". Each pair might name a different construct.

## Author questions

- I moved the 210 ms latency clause into its own sentence. Does "median latency increased by 210 ms per query" still read as you intend?
- Is the 210 ms measured against a no-retrieval baseline? Does it apply to all questions or only to rare ones? The original attached it to the rare-question sentence.
- Does "Since the retriever was frozen" mean freezing explains why frequent-question accuracy did not change, or only that the retriever was held fixed across conditions? "With the retriever frozen" keeps either reading. Should the sentence state which one?
- Are "long-tail questions" and "rare questions" the same thing? If so, which term should the paragraph use throughout?
- Are "retrieval cost", "retrieval time" and "latency" the same quantity? Is cost measured only as time?
- Is "relevant" (what prior work assumes) the same as "contains the answer" (what your annotation measures)? If so, can the paragraph say so once?
- Your thesis says the benefit is limited by what the retriever returns, but this paragraph doesn't link the 23% of passages without the answer to the size of the gain. Do you want to add that link, using a result already in the paper?