## Diagnosis

Assumed context: none. `AGENTS.md` supplies the audience (empirical economists and IS researchers), the stage (first draft), the venue (Management Science) and the core thesis. I took "sales" as the outcome from the core thesis, because the passage never names it.

**Your question.** For economists and IS researchers the paragraph is mostly clear. A general Management Science reader would be missing four things:
- The outcome of "the effect" is never named.
- "Valence" and "quasi-random assignment" are not glossed.
- The step from unequal moderation to as-good-as-random variation is skipped.
- The charge against prior instruments is asserted without support.

I fixed the first from material you supplied. The other three need your input and are in the questions below.

**Other findings:**
- **Order of claims.** The paragraph was a flat run of five claims. The tension, that prior instruments are questionable, came last and read as a tail. I reordered it to problem, failed fix, your fix, mechanism, result.
- **Opening.** "The endogeneity of … is a well-known obstacle" never says what is being estimated.
- **Redundancy.** "We leverage the fact that" repeats "We exploit". "Leverage" is also a weak verb, and "which generates" had an unclear referent.
- **Terms.** "Platform-level heterogeneity" (across platforms) and "across review cohorts" (possibly within a platform) may name different sources of variation. "Exogenous variation" and "quasi-random assignment" may also be distinct. I kept all four terms and flagged them.
- **Missing magnitude.** The result gives direction and significance but no magnitude. That is acceptable in an introduction, but Results must supply it. I could not verify that from this unit.

## Revised text

```
Estimating the effect of review valence on sales runs into a well-known obstacle to identification in this literature: valence is endogenous with respect to unobserved product quality. Prior approaches rely on instrumental variables of questionable validity. We improve on these approaches by exploiting platform-level heterogeneity in content moderation as a source of exogenous variation. Specifically, platforms apply their moderation policies differently across review cohorts, and this difference generates quasi-random assignment conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of valence on sales and find it positive and significant.
```

## Change rationale

Word count rose from about 90 to about 100 (+8%). The growth comes from naming the estimand ("on sales", twice) and adding the referent "these approaches". Neither adds a claim.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. No pass was skipped.

- **Opening.** The nominalized opener now states the question first and names the estimand. "In this literature" is kept as a scope qualifier.
- **Prior instruments.** This sentence moved up so the tension comes before your solution. Its wording is unchanged apart from the sentence frame.
- **Improvement claim.** "Our identification strategy improves upon prior approaches" became "We improve on these approaches by exploiting…", merged with your second sentence so the claim and its mechanism sit together.
- **Mechanism.** "We leverage the fact that … which generates" became "platforms apply … differently …, and this difference generates". That drops "leverage", cuts the repeated "exploit" frame and fixes the referent. "Specifically," and the conditional-on-covariates claim are unchanged.
- **Result.** "On sales" restores the antecedent of "the effect". The result now ends the paragraph. "Significant" stays because it is used in the statistical sense.
- **Cuts.** Only "we leverage the fact that" and the repeated "identification strategy" label.
- **Unchanged.** No number, qualifier or citation was touched, and "3.4 million" is as you wrote it.
- **Not drafted.** I did not write the bridge explaining why unequal moderation yields quasi-random assignment. That would assert substance your manuscript doesn't contain here.

## Author questions

- Is sales the outcome here? I wrote it from your core thesis.
- Do you want a one-clause definition of "valence" on first use (star rating or text sentiment)?
- Why does unequal moderation produce quasi-random assignment? Can you give the mechanism in one or two sentences, placed right after the "Specifically," sentence?
- Does "platform-level heterogeneity" (across platforms) mean the same source of variation as differences "across review cohorts" (possibly within a platform)? If not, which one identifies the effect?
- Are "exogenous variation" and "quasi-random assignment" the same construct?
- What is a "review cohort" (a time window, a product category, a rating band), and which observed covariates are conditioned on? Is that detail for Methods, with a pointer from here?
- Is there a concrete example in the paper of a moderated and an unmoderated review that could anchor the idea?
- "Instrumental variables of questionable validity" has no citation or stated reason. Should this sentence name the prior work (keeping citation order) and the specific flaw, or point to the section that does?
- Does Results carry the magnitude and confidence interval? Should the introduction carry the point estimate?
- Do you want one consistent handle for the paper's idea, such as "unequal moderation", across sections?