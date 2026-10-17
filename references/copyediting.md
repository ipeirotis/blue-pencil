# Research-paper copyediting pass

Use this file when the request asks for copyediting, line editing, final polish, or sentence-mechanics work. This pass happens after the argument, paragraph, reader-experience, and claim-calibration checks in `SKILL.md`; it is the final mechanical pass before output. Do not let mechanical polish hide an unresolved logic problem.

## What copyediting means here

Copyediting is not just typo correction. For a research paper, it protects the precision and credibility of the argument at sentence level. It should make the prose easier to parse without changing what the authors claim, what the evidence supports, or which terms of art they use.

Perform these edits when they are safe:

1. **Grammar and agreement.** Fix subject-verb agreement, pronoun agreement, article use, pluralization, dangling modifiers, and faulty comparisons.
2. **Punctuation for parsing.** Add or remove commas, colons, semicolons, and parentheses when they clarify sentence structure. Do not introduce em-dashes.
3. **Parallelism.** Make coordinate items grammatically parallel, especially in contribution lists, method steps, hypotheses, and result summaries.
4. **Terminology consistency.** Keep one term for one construct. If two terms might be intentional variants, preserve both and ask the author.
5. **Abbreviations.** Define an abbreviation at first use within the requested scope, then use either the abbreviation or the full term consistently. Do not invent abbreviations unless the author has already introduced them elsewhere in the provided text.
6. **Capitalization and hyphenation.** Normalize only within the requested scope. Keep proper names, model names, dataset names, and field-standard capitalization intact.
7. **Units and symbols.** Preserve numerical values. Normalize spacing and wording only when it does not alter the claim, such as using the same unit style across nearby sentences. Flag any uncertain unit conversion or symbol change.
8. **Tense and aspect.** Match disciplinary convention and section function. Prior work is usually past tense when describing a specific study, present tense when describing an established result or what a paper argues. Methods are often past tense for completed studies. Results often use past tense for observed outcomes and present tense for tables, figures, and persistent interpretations.
9. **Table and figure callouts.** Keep references in logical order and ensure each callout has a clear reason. Do not renumber or invent references.
10. **Citation punctuation.** Move punctuation around citation commands only when required by the local sentence grammar. Do not alter citation keys or citation commands.
11. **One word, one sense.** Each occurrence of a multi-sense word should be readable in only one of its senses; where an occurrence could be read in two, prefer the word that has only the sense you mean. The check is per occurrence: "as a control" (role) and "as specified" (manner) in the same section are both clear and both stay. What fails is a single occurrence the reader can take two ways. The principle comes from ASD-STE100, whose dictionary gives each approved word one meaning (`references/principles.md`). The frequent academic cases:
    - "since" (time or cause): use "because" for cause, keep "since" for time.
    - "as" (cause, time, manner, or role): use "because" for cause, "while" or "when" for time; keep "as" for manner and role ("as a control").
    - "while" (time or contrast): use "although" or "whereas" for contrast (`references/sentence-patterns.md`, "Misused connectives").
    - "once" (after, or one time): use "after" or "when" for the time sense if "one time" could also fit.
    - "may" (possibility or permission) and "can" (ability or possibility): in a methods passage, "participants may skip items" can mean either "were allowed to" or "possibly did"; write the one meant.
    - "should" (prediction or obligation): "the effect should be larger in rural areas" can be a prediction or a recommendation. These are different claims, so when the context does not decide, ask; do not pick.
    - "significant": statistical or substantive (`references/ai-tells-to-avoid.md`).
    The reverse rule is item 4: one construct, one term, never a synonym for variety. A swap is a safe fix only when the context fixes the sense; when the sense changes the claim and the context does not fix it, it is a consistency risk.
12. **False friends.** Authors who write in a second language sometimes use an English word in the sense of a similar word in their first language: "actual" for "current", "eventually" for "possibly", "sensible" for "sensitive", "control" for "check", "argument" for "topic". STE lists false friends as a grammar rule for the same reason. When the context shows the intended sense, flag it; do not silently swap the word, because "eventually" and "possibly" make different claims.
13. **Latin abbreviations.** "i.e." restates ("that is"), "e.g." gives examples ("for example"). Swapping one for the other changes the claim (a complete list versus a sample), so a mismatch is an `Author question`, never a silent fix. Drop "etc." after an "e.g." list, which already says the list is partial. Spell out "cf.", "viz.", and "et seq." in running text only when the venue style asks for it.

## Copyediting triage

Before editing, classify each issue as one of three types.

- **Safe fix.** The edit repairs grammar, punctuation, or consistency without changing the claim. Make the edit.
- **Consistency risk.** The edit might collapse two constructs, change a term of art, alter a measurement, shift emphasis, or fix the sense of a word whose sense the context leaves open. Preserve the original and ask the author.
- **Evidence risk.** The edit would require adding a fact, citation, result, limitation, or interpretation. Do not make the edit. Ask the author.

## Consistency inventory

For any section longer than one paragraph, build a quick inventory before rewriting:

- Key technical terms and their variants.
- Abbreviations and first-use definitions.
- Dataset, model, treatment, condition, and measure names.
- Unit and symbol formats.
- Table, figure, equation, appendix, and section references.
- Repeated list structures that should be parallel.

Use the inventory to prevent drift. Do not report the full inventory unless it reveals a question the author must answer.

## Common high-value fixes

| Pattern | Safer edit | Why |
|---|---|---|
| "the model are" | "the model is" | Repairs agreement without changing the claim. |
| "pre test, post-test and follow up" | "pre-test, post-test, and follow-up" | Normalizes parallel compound modifiers. |
| "accuracy, latency, and how much memory it uses" | "accuracy, latency, and memory use" | Makes a list grammatically parallel. |
| "which" with an unclear antecedent | Repeat the noun | Fixes the referent for read-cold comprehension. |
| "Table 2 shows the results" | "Table 2 reports the model's accuracy and latency" | Gives the callout a reason without changing the result. |
| "Previous work finds" for one cited study | "Previous work found" | Uses past tense for a specific prior result. |

## Do not normalize these silently

- Competing technical terms that may mark different constructs, such as "fairness", "equity", and "bias".
- Field-standard capitalization, such as named datasets, model families, surveys, corpora, or instruments.
- Spelling variants when the target venue or author style is unknown, such as American versus British spelling.
- Unit systems, unit conversions, symbols, or thresholds.
- Statistical language, including "significant", confidence intervals, p-values, robustness, and effect sizes.
- The sense of a multi-sense word ("should", "may", "since") or a possible false friend, when the context does not fix it.
- "i.e." against "e.g.", since one claims a complete list and the other a sample.
- Citation style beyond sentence-level punctuation.

Put these in `Author questions` when they block a safe edit.

## Final copyediting checklist

Before returning the rewrite, verify:

- Every abbreviation used in the requested scope is defined or intentionally inherited from surrounding context.
- Each key term is used consistently, unless variation is flagged as a possible distinction.
- Lists are parallel.
- Pronouns and demonstratives have visible antecedents.
- Punctuation clarifies syntax without adding em-dashes.
- Units, symbols, and numerical values match the original.
- Table, figure, equation, section, and appendix references were not renumbered or invented.
- Tense choices match section function and disciplinary convention.
- No occurrence of a multi-sense word ("since", "as", "while", "once", "may", "should") can be read in two senses.
- No reporting verb ("found", "show", "assume") drops a "that" where the next noun could be misread as its object (`references/sentence-patterns.md`, "The dropped connector").
