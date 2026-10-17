```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change. Accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. As the index grows, retrieval cost rises: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Changes I made:
- **Shorter sentences:** I split the long second sentence into three, so each one carries a single result.
- **"Since" became "Because":** "Since" can mean either time or cause, and you use it causally. "Because" is unambiguous.
- **Added "that":** I added it after "find", "observe", "assumes" and "shows". This makes clause boundaries easier to see.

All numbers, the table reference, and the citation are unchanged.