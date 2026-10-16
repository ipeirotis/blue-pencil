## 1. Diagnosis

Assumed context: none. The venue, audience, revision stage (first draft) and thesis were all supplied. This is a direct rewrite of the pasted paragraph at first-draft aggressiveness.

**Voice tics**
- First-person finding frame ("We find...").
- Claim first, then numbers inline, with the table callout in parentheses.
- A colon to expand a claim ("retrieval cost rises: ...").
- A closing "but" that contrasts with prior work, with a citation key mid-sentence.
- Plain, unadorned vocabulary.

**Reader map:** The reader knows retrieval-augmented QA and accuracy and latency reporting. They must learn three things:
- The gain sits in long-tail questions.
- It comes with latency and index-size costs.
- It is limited by passages that often lack the answer.

**Jargon:** None to unpack. "Long-tail" and "frozen" are standard terms at this venue.
**Buried lede:** None. The relevance finding already closes the paragraph, so the order stays.
**Concrete anchor:** None needed. The 41.2% to 57.8% result and the 23% figure are already on the page.

1. [S2] "Since the retriever was frozen" can be read as temporal or causal. The manuscript never says why a frozen retriever would leave frequent-question accuracy unchanged, so a second-language reader has to guess.
2. [S2] "with median latency increasing by 210 ms per query" is a trailing phrase attached to the accuracy clause, though latency is a separate result. It also has no stated comparison point.
3. [S2] "while" can mean "during" or "whereas". The sentence also packs three results into one long line.
4. [S3] "As the index grows" can be read as time or cause. The sentence mixes a general statement with an observed result. "Cost" and then "time" are used without saying whether they are the same quantity.
5. [S1, S2] "long-tail", "rare" and "frequent" appear without a stated mapping.
6. [S4] "Top-ranked" has no cutoff, and the annotation is not described. These are gaps in the manuscript, so they go to Author questions.
7. [S1, S4] The word "that" is missing after "We find" and "shows". Adding it makes the clause boundary explicit.

## 2. Revised text

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. With the retriever frozen, accuracy on frequent questions did not change, but accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency rose by 210 ms per query. Retrieval cost also grows with index size: median retrieval time roughly doubled between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Added bridges: None.

## 3. Change rationale

**Word count:** about 100 to about 105 (+5%). The growth comes from two added "that" words and one sentence split.

**References loaded:** principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. The altitude and precision-budget passes ran as checks and found no change. The paragraph has no stacked intervals or inferential machinery, so the hedge census did not apply.

**Changes**
- "We find the gain" became "We find that the gain". This makes the clause boundary explicit.
- "Since the retriever was frozen" became "With the retriever frozen". This removes the temporal/causal ambiguity without asserting a cause the manuscript does not state.
- "while" became "but". This restores the contrast, since "while" can mean "during" or "whereas".
- "with median latency increasing by 210 ms per query" became its own sentence, "Median latency rose by 210 ms per query." Latency is a separate result and now has its own subject. The short sentence also varies the rhythm after the long one. "Increasing" became "rose" to match the tense of the previous sentence.
- "As the index grows, retrieval cost rises: we observe the median retrieval time roughly doubles ..." became "Retrieval cost also grows with index size: median retrieval time roughly doubled ...". This removes the ambiguous "As" and puts the subject first. "We observe" is cut because the past tense already marks an observed result. "Also" marks this as a second cost after latency. The order of claims is unchanged.
- "shows 23%" became "shows that 23%", and "assumes the retrieved" became "assumes that the retrieved". These make the clause boundaries explicit.
- Kept as is: the sentence order, the closing "Prior work ... but our annotation ..." contrast, and the citation position. The turn already sits at the end of the paragraph.
- All numbers, "Table 3" and "[@lewis2020]" are unchanged and in their original order.

## 4. Author questions

- **Latency figure:** The 210 ms figure now sits in its own sentence, and "increasing" became "rose". Is the figure and its meaning exactly as you intended?
- **Tense change:** "roughly doubles" became "roughly doubled" and "we observe" was cut. Does the 1M to 10M doubling describe measured results only, or do you also intend a general claim about larger indexes?
- **Table 3:** "(Table 3)" now follows a restructured sentence. Does Table 3 report only the 41.2% and 57.8% figures, or also the frequent-question result and the latency?
- **Frozen retriever:** Is a frozen retriever the reason accuracy on frequent questions did not change? If so, what is the mechanism? If it only describes the setup, should it be its own sentence?
- **Latency baseline:** What is the 210 ms measured against, for example the same model without retrieval?
- **Question groups:** Do "long-tail", "rare" and "frequent" name the same question groups? Is there a stated frequency cutoff?
- **Cost versus time:** Are "retrieval cost" and "retrieval time" the same quantity, or does cost include something beyond time?
- **Annotation:** What cutoff defines "top-ranked" (top-1, top-5, ...), and how was the annotation done? Readers need this to interpret the 23%.
- **Link to the thesis:** Should a sentence connect the 23% finding to the gain on rare questions, for example how irrelevant passages limit that gain? The paragraph does not state the link, so I did not write it.
- **Prior work:** Only one reference is cited. Does "Prior work assumes" describe that one paper, or a wider group of papers?