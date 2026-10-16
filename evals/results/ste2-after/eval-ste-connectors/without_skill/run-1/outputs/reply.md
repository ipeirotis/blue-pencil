```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. The retriever was frozen, so accuracy on frequent questions did not change. Accuracy on rare questions rose from 41.2% to 57.8% (Table 3), and median latency increased by 210 ms per query. As the index grows, retrieval cost rises: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Changes:
- I split the long second sentence into two shorter ones and turned "Since the retriever was frozen" into "The retriever was frozen, so...". "Since" can read as either "because" or "after", which is hard for second-language readers.
- I added "that" after "find", "observe", "assumes" and "shows" to make the clause boundaries clear.
- Numbers, the table reference, and the citation are unchanged.