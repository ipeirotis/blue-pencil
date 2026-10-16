### 1. Diagnosis

**Assumed context:** None. `AGENTS.md` supplies the venue (Management Science), the audience (empirical economists and IS researchers), your core thesis, and the stage (first draft). I read "general Management Science reader" as a trained economist or IS reader who isn't an expert in this exact topic.

**Your question:** The opening assumes too much in three ways.
- It never names the effect or its outcome.
- It skips the step from uneven moderation to exogeneity.
- It leaves "prior approaches" unspecified.

**Findings**
1. **The question is never stated.** Sentence 1 speaks of "identification" and sentence 5 of "the effect", but the passage never says the effect of what on what. "This literature" has no referent in an opening sentence. The rewrite names the effect using your thesis wording (valence, sales).
2. **The key inference is compressed.** The passage says unequal moderation yields "quasi-random assignment". It doesn't say what is assigned, or why moderation differences make valence exogenous. That bridge is the paper's core claim, and the text doesn't supply it. I did not write it (see the questions below).
3. **Two topics and a restatement.** Sentence 2 states the strategy in abstract nouns. Sentence 3 re-announces it ("Specifically, we leverage the fact that") before giving the mechanism. "Leverage" is a banned verb, and the "which" in sentence 3 has no clear antecedent.
4. **Expert-only contrast and misplaced payoff.** "Prior approaches … of questionable validity" names no approach. The contrast with your strategy is separated from it by the result, and the finding doesn't land in the closing position.
5. **Terminology.** "Platform-level heterogeneity", "differentially apply … across review cohorts" and your thesis's "unequal moderation" may name one construct or two. I did not collapse them.
6. **Precision.** The passage has no hedges to cut. Two items remain open:
   - "Exogenous variation" is stronger than "quasi-random conditional on observed covariates".
   - The result gives direction and significance but no magnitude.
7. **Memorable idea.** The passage has a method and a result but no phrase for readers to carry away. "Unequal moderation" could be that phrase, but the text doesn't use it. I didn't invent a slogan.

### 2. Revised text

```
In research on the effect of review valence on sales, the endogeneity of valence with respect to unobserved product quality is a well-known obstacle to identification. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms differentially apply moderation policies across review cohorts, and this variation generates quasi-random assignment conditional on observed covariates. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and significant.
```

### 3. Change rationale

**Length:** about 90 words became about 100 (+8%). The growth comes from naming the effect and its outcome, which the original never did.

**References loaded:** principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. All were kept for an introduction at first draft. `cold-read.md` and `consistency-checks.md` belong to whole-paper passes and were not loaded.

- **Opening sentence:** it now names the question (effect of review valence on sales) before the machinery. It also replaces "this literature", which had no antecedent.
- **Sentence 3:** I dropped "leverage" and the connective "Specifically", and separated strategy from mechanism. "Which" became "this variation".
- **Prior-approaches sentence:** moved ahead of the result, wording verbatim. The contrast now sits next to your strategy, and the finding closes the passage.
- **"The effect":** now reads "the effect of review valence on sales".
- **Kept verbatim:** "platform-level heterogeneity in content moderation as a source of exogenous variation", "3.4 million reviews", "positive and significant", and "instrumental variables of questionable validity". No number, statistic, or citation was changed. The passage contains no citations.
- **Declined edits:** glossing "review valence", replacing "heterogeneity" with "unequal", and adding "statistically" before "significant". Each would assert something the manuscript hasn't settled.

### 4. Author questions

- I took "valence" and "sales" from your core thesis. Is "the effect of review valence on sales" what you want, and should it say "causal effect"?
- What exactly is quasi-randomly assigned, and to what? Does moderation change which reviews appear, their valence, or both? A general reader needs this one-sentence bridge.
- Is "platform-level heterogeneity" (differences between platforms) the same variation as "platforms differentially apply moderation policies across review cohorts" (differences across cohorts)? Is either the same as "unequal moderation" in your thesis? Which single term should the paper use?
- Is "unequal moderation" the phrase you want readers to carry away? If so, should it appear in this opening?
- Does exogeneity hold only after conditioning on covariates? Does the Methods section state that condition in full? I couldn't check, because that section wasn't provided.
- Which prior approaches use instrumental variables of questionable validity, and where is that criticism supported? I added no citations. Does "improves upon" mean more credible exogeneity, or something else?
- Is "significant" statistical or substantive? Can the opening report the estimated magnitude rather than direction alone?
- Which platforms and period make up the 3.4 million reviews, and does the general reader need that here?
- Should "review valence" be glossed (for example, star rating or the tone of the text)? The manuscript doesn't say which measure you use.