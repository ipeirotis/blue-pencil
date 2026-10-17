## Diagnosis

Assumed context: none. The paper context came from `AGENTS.md`. The core-thesis check doesn't apply to a data-processing paragraph, so it was skipped.

- **Main problem:** The order of steps is hidden. The only order the text fixes is coding, then merge, then weighting, then estimation. The original packs three steps into its second sentence and ties the final N to the weighting step.
- **Dangling phrase:** "Disagreements being resolved" has no stated relation to the coding.
- **Stacked verb:** "Would have been expected to have been applied" hides whether the weights were applied. A replicator most needs to know that, and the text can't settle it (see questions).
- **Undefined terms:** "Recoded" isn't defined. The paragraph uses both "responses" and "open-ended answers", which may be different objects, so I didn't merge them.
- **Replicator steps:** The paragraph doesn't say which steps a replicator must repeat. That isn't on the page, so I didn't invent it.
- **Ambiguous parenthetical:** "(4.1 minutes)" follows "median completion time", so it reads as the median. It could also be the one-third cutoff. I left it where it was.

## Revised text

```
After the field period closed, responses were screened and recoded. Respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Two research assistants coded the open-ended answers using the codebook in Appendix B, and disagreements were resolved by discussion. The coded categories were then merged with the panel's demographic file using the respondent ID. Raking weights were expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region. The analytic sample is N = 2,184 after exclusions.
```

## Change rationale

Word count: about 110 to 100 (-9%). References loaded: principles, edit-checks, structural-patterns, exposition, altitude, narrative-spine, reader-pleasure, sentence-patterns, subtraction, ai-tells-to-avoid, copyediting. The precision-budget pass was skipped because this isn't an abstract, introduction, or contribution paragraph, and no high-cost-zone hedge is added or removed.

- **Opening:** The field-period anchor now comes first, and the exclusion rule has its own sentence.
- **Coding and merge:** The sentence that held three steps is now two. Coding and dispute resolution come first, then the merge. "Disagreements being resolved" became a finite verb.
- **"Then":** I added "then" before the merge because the text already fixes coding before merging. I added none to the exclusion step, because the text doesn't say where it falls.
- **Weighting:** I cut the four auxiliaries to three and kept "expected", because the intended meaning can't be resolved from the text.
- **Final N:** It now closes the paragraph as its own sentence. The number and its qualifier are unchanged.
- **Left alone:** "Matching the 2020 Census margins…", "(4.1 minutes)", the position of the "if" clause, and the passive voice, since the text names no agent.

No number, statistic, or citation was changed. The only move is N = 2,184, which now sits in its own sentence.

## Author questions

- Were exclusions applied before or after the open-ended answers were coded and merged? Does N = 2,184 count respondents with coded answers? Does the paragraph's current order (exclusion first) match what happened?
- What does "recoded" refer to? Is it the open-ended coding described next, or a separate recoding of closed-ended variables? Are "responses" and "open-ended answers" different objects?
- Were the raking weights actually applied before estimation, or only planned? If applied, may the text say "were applied"? If not, what was done instead?
- Were the raking margins computed on the post-exclusion sample or the full sample?
- Is "4.1 minutes" the median completion time or the one-third cutoff?
- Which steps must a replicator repeat, and which can start from released files (the coded file or the merged file, for example)? Should the paragraph say so, and who performed the screening, merge, and weighting?
- Please confirm that N = 2,184 is the correct analytic sample, and not the weighted or full sample.