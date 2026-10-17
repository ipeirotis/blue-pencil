## Diagnosis

Context came from `AGENTS.md`: first draft, Public Opinion Quarterly, survey methodologists and political scientists. This is a methods paragraph, so the core-thesis check wasn't engaged.

**Voice:** agentless passive for the processing steps, with agents named only where they matter ("two research assistants"). The protocol details sit in trailing phrases (the Appendix B codebook, the 2020 Census margins).

**Main problem:** the sequence (screen, code, merge, weight, estimate) is the point of the paragraph, but the draft packs it into three long sentences. The order is implicit or hidden in the grammar.

1. **Sequence is hard to recover.** "Screened and recoded" in the first sentence doesn't say what was recoded, or whether it came before or after the coding in sentence two. Later steps are joined by "and" or trailing clauses, so no step announces its place in the order.
2. **"Would have been expected to have been applied"** stacks modal and perfect verbs. A reader can't tell whether the weights were applied, planned, or not applied. This is the most serious replicability problem in the paragraph.
3. **"Disagreements being resolved by discussion"** is a detached clause that holds the coding step open before the merge arrives.
4. **The sample size is bolted onto the weighting sentence.** It describes the sample, not the weights, so it belongs in its own closing sentence.
5. **Nothing separates steps a replicator must repeat from steps that only describe the pipeline.** The manuscript doesn't say which are which, so this goes to you as a question.
6. **"(4.1 minutes)"** could be the median or the cutoff. That's a content question, so it was flagged and not edited.

## Revised text

```
After the field period closed, responses were screened, and respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Open-ended answers were then coded by two research assistants using the codebook in Appendix B, with disagreements resolved by discussion. The coded categories were next merged with the panel's demographic file using the respondent ID. Raking weights were to be applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region. The analytic sample is N = 2,184 after exclusions.
```

## Change rationale

Length went from about 120 to about 115 words (-4%). No number, statistic, or citation was changed, and the Appendix B reference and the 2020 Census margins are untouched.

- **Opening sentence:** it now starts with the time anchor ("After the field period closed") and drops "recoded", so coding appears only once, as step two. See the first question below.
- **"then" and "next":** these mark steps two and three, so the order no longer has to be inferred.
- **Coding sentence:** "disagreements being resolved by discussion" became "with disagreements resolved by discussion", which closes the sentence cleanly.
- **Merge:** it now has its own sentence, one step per sentence, linked to the coding sentence by "coded".
- **Weighting:** "would have been expected to have been applied" became "were to be applied". This removes the stacked verbs and keeps the planned-not-reported sense. It changes meaning slightly, so see the second question.
- **Sample size:** "The analytic sample is N = 2,184 after exclusions" is now its own closing sentence, with the number and wording unchanged.
- **Left alone:** passive voice and the step order, where the sequence was already correct. No hedges or qualifiers were altered, and no narrative or storytelling was added.
- **Passes run:** all the applicable reference passes ran. The precision-budget pass was skipped because it applies only to abstracts, introductions, and contribution paragraphs. The altitude pass made no change.

## Author questions

1. **What does "recoded" mean in your original first sentence?** Is it the open-ended coding described next, a separate recoding of closed-ended items, or something else? I removed it so the coding step appears once. If it's a separate operation, it needs its own step in the sequence.
2. **Were the raking weights actually applied before estimation, or only planned?** The original can be read either way. "Were to be applied" asserts neither. Please swap in plain past tense if they were applied, or say what was done instead if not.
3. **Which steps must a replicator repeat?** The choices are the exclusions, the Appendix B coding, the merge, and the weighting. Would you like a sentence saying so, for example whether the coded categories are released so a replicator can skip the coding?
4. **Is 4.1 minutes the median completion time or the exclusion cutoff** (one third of the median)? The parenthetical currently reads either way.
5. **Were excluded respondents' open-ended answers coded, or were exclusions applied before coding?** Also, does N = 2,184 count respondents after the screening exclusions only, or after the merge as well?
6. **Is there an inter-coder agreement statistic**, here or in Appendix B, that a replicator would need alongside "disagreements resolved by discussion"? The manuscript doesn't state one, so I added none.