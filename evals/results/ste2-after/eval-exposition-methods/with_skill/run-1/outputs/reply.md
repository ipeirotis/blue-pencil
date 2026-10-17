## 1. Diagnosis

Assumed context: none. Audience, revision stage, target venue and core thesis all come from `AGENTS.md`. The core thesis does not appear in this paragraph, and I did not add it.

Voice tics: first-person plural "we" with plain declarative sentences; terms of art kept in full and never abbreviated; short parallel lists of three (the controls); estimators named but not cited; "alongside" and "to address" as the author's connectives.

Reader map: starts with fixed-effects regression and standard difference-in-differences vocabulary, and does not assume the staggered-adoption literature; must learn that stores got the program on different dates, so the comparison stores are never-treated and not-yet-treated ones, and a second estimator is reported next to the first; should leave with the design in view before the specification.

Jargon to unpack [P1]: "never-treated" and "not-yet-treated" (glossed from their own wording); "heterogeneity in treatment timing" (cannot be glossed from the manuscript without risking a change of meaning, so it goes to Author questions).
Buried lede [P1]: the staggered rollout. It is the reason for the design, and it arrives only in the last sentence.
Concrete anchor [P1]: stores received the program on different dates, which is already on the page.

1. [P1, S1 to S4] Machinery before motive. The paragraph opens on the two-way fixed effects specification and reveals the staggered rollout last, so the reader meets the model before the design problem it answers.
2. [P1, S4] Definition debt. "Never-treated" and "not-yet-treated" are used with no gloss, and these are the terms a reader outside the staggered-design literature will not know.
3. [P1, S4] One topic per sentence. The 44-word final sentence does two jobs: it names the control group and it adds a second estimator. Splitting them gives each a visible role.
4. [P1, S4] Compressed inference. Nothing on the page says why "heterogeneity in treatment timing" calls for the Callaway and Sant'Anna estimator. The bridge needs substance the manuscript lacks, so it is routed to Author questions, not written.
5. [P1, S3] The post-rollout and treatment indicators are used with no definition. With different rollout dates it is unclear whether "post" is store-specific. This is a question, not an edit.
6. [P1, S4] Vague verb. "Address" does not say whether the estimator reduces, bounds or removes the problem. This is a question.
7. [P1] The paragraph is a flat list of specification facts, and the tension that motivates the second estimator is not on the page. I surfaced the staggered rollout in the opening and left the tension itself as a question.

## 2. Revised text

```
The loyalty program was rolled out to stores on different dates. We therefore use two kinds of stores as controls: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

Added bridges: None.

## 3. Change rationale

Word count: ~100 to ~110 (+10%). The growth is the two plain-language glosses of the control groups and one sentence split. No claim was added.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Gated off: precision-budget.md (it runs only for an abstract, introduction or contribution paragraph, or when a hedge is added or removed in that zone; this is a methods paragraph and no hedge was touched). Altitude ran and found no relocation, because the machinery already sits in its home section.

- "Because the loyalty program was rolled out to stores on different dates, we use the never-treated and not-yet-treated stores as controls" (end of the paragraph) -> "The loyalty program was rolled out to stores on different dates. We therefore use two kinds of stores as controls:" (opening), because it moves the design ahead of the machinery and puts the question before the specification. The author's own "because" logic is kept as "therefore".
- "the never-treated and not-yet-treated stores" -> "never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it", because each term is defined at first serious use from its own wording. This is a gloss of the author's terms, with no new claim.
- One 44-word sentence -> two sentences (the control group, then the second estimator), because it gives each sentence one topic and makes the estimator sentence short enough to read as the paragraph's close.
- "Because the loyalty program was rolled out ..., ... to address heterogeneity in treatment timing" -> the second "because" clause is dropped, because the opening sentence now states the rollout and repeating it in the last sentence would be an echo (say it once). "Heterogeneity in treatment timing" stays verbatim, because its technical sense is not settled (see Author questions).
- Sentences 1 to 3 of the original (the fixed-effects model, the controls, the coefficient of interest) are unchanged. Each already puts the topic first and parses in one pass, so no safe improvement was available.
- No cuts, no em-dashes, no banned phrases, and no numbers, citations or statistics were changed.

## 4. Author questions

- The control-group sentence now sits at the design level, before the model. Does the never-treated and not-yet-treated control set apply to both the two-way fixed effects model and the Callaway and Sant'Anna estimator, or only to the latter?
- Does "heterogeneity in treatment timing" mean that stores were treated at different dates, or that treatment effects differ across rollout cohorts? I kept the phrase verbatim because the two readings make different claims.
- What does the Callaway and Sant'Anna estimator do about that heterogeneity: reduce it, bound it, or remove it? Is there a sentence, drawn from your Methods or from the paper's motivation, on why the two-way fixed effects estimate alone could mislead under staggered timing? A reader new to staggered designs will want that bridge, and I cannot supply it.
- How are the post-rollout indicator and the treatment indicator defined when stores start on different dates? In particular, is "post" store-specific?
- The paragraph never names the outcome. Should it say that the outcome is repeat purchase, as the core thesis does?
- The Callaway and Sant'Anna estimator appears without a citation in this paragraph. Do you want one here, or is it cited elsewhere?
- The gloss "have not yet received it" assumes the not-yet-treated stores are treated later within the sample window. Is that right for every such store?