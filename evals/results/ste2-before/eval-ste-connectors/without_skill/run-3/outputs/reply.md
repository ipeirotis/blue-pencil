```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change. In contrast, accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. As the index grows, retrieval cost rises: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Changes made:
- Split the long second sentence into three shorter ones, so each sentence carries one idea.
- Changed "Since" to "Because", since "since" can be read as a time word. Changed "while" to "In contrast" for the same reason.
- Added "that" after "find", "observe", "assumes" and "shows", which makes clause boundaries clearer.

All numbers, the table reference and the citation are unchanged.