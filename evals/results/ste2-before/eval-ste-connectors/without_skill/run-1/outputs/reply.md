```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change. Accuracy on rare questions rose from 41.2% to 57.8% (Table 3), and median latency increased by 210 ms per query. Retrieval cost also rises as the index grows: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Changes I made:
- Split the long second sentence into two, so each sentence has one main point.
- Changed "Since" to "Because", since "since" can also mean "after a point in time", which may confuse some readers.
- Replaced "with median latency increasing" with "and median latency increased", which is a plainer verb form.
- Added "that" after "find", "observe", "assumes", and "shows" to make clause boundaries clear.
- Added "also" to link the retrieval-cost sentence to the previous point.

All numbers, the table reference, and the citation are unchanged.