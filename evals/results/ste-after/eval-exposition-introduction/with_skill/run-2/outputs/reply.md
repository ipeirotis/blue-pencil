### 1. Diagnosis

**Your question:** The opening is clear for your stated audience (empirical economists and IS researchers). It assumes too much for a general Management Science reader. Three things carry most of that.

- **Undefined objects.** The passage never names the outcome (sales). It also never defines valence, content moderation or review cohorts.
- **The central step is asserted, not shown.** The reader is told that unequal moderation gives "quasi-random assignment". Nothing says why moderation would be unrelated to unobserved quality, and the whole paper rests on that.
- **Identification shorthand.** "Exogenous variation" and "quasi-random assignment conditional on observed covariates" are used without explanation, and they sit in mild tension with each other.

I fixed what the text supports: the missing outcome, the order of the argument, and sentence-level problems. The rest is in Author questions, because I can't supply it without drafting new content.

Other findings:
- **Out-of-order spine.** The tension (instrumental variables of questionable validity) came last, after the finding, so it read as an afterthought. I moved it before your solution.
- **Opening sentence.** It was a nominalization that never stated the research question.
- **Sentence-level problems.** "Leverage" is a banned verb. "We leverage the fact that" repeated "We exploit" from the sentence before. "Which generates" had no clear antecedent.
- **Unsupported assertions.** "Well-known" and "questionable validity" carry no citation or specific instance in this passage.

### 2. Revised text

```
Estimating the causal effect of a review's valence on sales is difficult because valence is endogenous to unobserved product quality, a well-known obstacle to identification in this literature. Prior approaches rely on instrumental variables of questionable validity. Our identification strategy improves upon these approaches by exploiting platform-level heterogeneity in content moderation as a source of exogenous variation. Specifically, platforms apply moderation policies differently to different review cohorts, and, conditional on observed covariates, this difference generates quasi-random assignment. Using a dataset of 3.4 million reviews, we estimate this effect and find it positive and significant.
```

### 3. Change rationale

Word count: about 90 before and after.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. All were kept and none was skipped.

- **Sentence 1:** The nominalization became a predicate adjective, and the question now comes before the machinery. "Sales" and "causal" come from your `core_thesis`, so please confirm them.
- **Reorder:** The instrumental-variable contrast moved ahead of your strategy, which gives the paragraph a "but, therefore" spine. The improvement claim is kept, and you can revert the order if you prefer the original emphasis.
- **"We exploit" sentence:** It is now joined to the contrast it answers, with its wording unchanged.
- **"Specifically" sentence:**
  - "We leverage the fact that" is cut.
  - "Which" became "this difference".
  - "Differentially ... across" became "differently to different".
  - The claim that platforms apply policies unequally is kept as a plain assertion.
- **Last sentence:** "This effect" now has a referent, and "to be" is dropped. "Significant" is left as written.
- **Protected material:** No number, statistic or citation was changed. "3.4 million" is untouched, and the section contained no citations.

### 4. Author questions

- Are the outcome "sales" and the framing "causal effect of a review's valence" correct? Your section names neither, so I added both from `core_thesis`.
- Is "valence" the star rating, text sentiment, or something else? Should one clause define it?
- What does "content moderation" consist of (removal, delay, flagging, something else)? What is a "review cohort" (time window, product category, platform)?
- Why does unequal moderation make assignment quasi-random? What makes moderation unrelated to unobserved product quality? One sentence on this is what a general reader most needs.
- Is the claim exogeneity or conditional independence? What is assigned, and to what?
- Are "platform-level heterogeneity" and moderation "across review cohorts" the same construct, or is one variation between platforms and the other within a platform?
- What makes the prior instruments "of questionable validity"? Should they be named or cited? Is "well-known obstacle" supported by a citation elsewhere in the introduction?
- Does "significant" mean statistical significance? Should a magnitude appear here?
- Does the Methods section state the full identification argument? It was outside my scope, so I couldn't check it. Without it, the introduction's claims are unsupported.
- Are you comfortable with the reorder?