## 1. Diagnosis

Assumed context: none assumed. The audience, revision stage (first draft), venue and thesis all come from the paper context in `AGENTS.md`.

- **Order of steps.** Each of the three sentences stacks two or three operations with commas and "and". The text only supports two orderings: coded categories are merged into the demographic file, and weights are applied to the merged file before estimation. A reader can't tell where screening falls relative to coding.
- **Weights clause.** "Would have been expected to have been applied" stacks three modals, so the reader can't tell whether the weights were applied. I kept the wording and raised it as a question rather than guess.
- **Sample size clause.** "N = 2,184 after exclusions" was joined to the weighting sentence with "and". That made it read as a result of weighting rather than of exclusions.
- **"Screened and recoded."** Only the exclusion rule is described. "Recoded" has no content in the paragraph.
- **Coding sentence.** "Disagreements being resolved by discussion" is a free-floating absolute attached to the coding step. The same sentence also carries the merge, so two separate steps share one sentence.
- **Replicator needs.** The paragraph doesn't separate steps you performed from steps that came with the panel. The manuscript doesn't say which is which, so prose can't fix this.

## 2. Revised text

```
Responses were screened and recoded after the field period closed. Respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Open-ended answers were coded by two research assistants using the codebook in Appendix B, and disagreements were resolved by discussion. The coded categories were then merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region. The analytic sample is N = 2,184 after exclusions.
```

## 3. Change rationale

The text grew from about 105 to about 110 words (+5%). Two clauses became sentences and one subject was restated ("Respondents were excluded"). No content was added.

- **Exclusion rule:** it is now its own sentence instead of a trailing absolute. A replicator can find it and repeat it.
- **Disagreements:** "disagreements being resolved by discussion" became "and disagreements were resolved by discussion". This fixes the free-floating absolute and matches the paragraph's passive voice.
- **Merge:** it is now its own sentence, "The coded categories were then merged…". "Then" appears only here because the text itself places the merge after coding.
- **Sample size:** "N = 2,184 after exclusions" is now the final sentence. The figure and the phrase are unchanged, and the paragraph ends on the analytic sample.
- **Weights clause:** kept verbatim, because any recasting would decide whether the weights were applied.
- **"Screened and recoded":** kept as written, because "recoded" can't be unpacked from the manuscript.
- **Sequence markers:** I added no "First/Second", since the text doesn't establish whether screening came before coding.
- **Numbers and citations:** nothing changed.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped: precision-budget.md (not an abstract, introduction or contribution paragraph) and reader-pleasure.md (no readability or pleasure request).

## 4. Author questions

- Were the raking weights actually applied before estimation? "Would have been expected to have been applied" can read as a plan that wasn't carried out or as a completed step. Which was it, so the sentence can say so plainly?
- Is "4.1 minutes" the median completion time or the resulting cutoff (one third of the median)? As written it reads as the median. A replicator will apply the rule differently depending on the answer.
- What does "recoded" in the first sentence refer to? Is it separate from coding the open-ended answers? If so, which variables were recoded and by what rule?
- In what order did screening and coding happen? Were excluded respondents' open-ended answers coded? Were the weights raked on the sample before or after exclusions?
- Which steps would a replicator need to repeat, and which came from the panel provider (the demographic file, the Census margin targets, any existing weights)? Could you add a sentence or a pointer, such as to Appendix B or a replication repository?
- "N = 2,184 after exclusions" moved into its own sentence. Please check it.
- Do "both attention checks" refer to checks described elsewhere in the paper? If so, should this paragraph point to that description?