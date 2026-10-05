Mostly clear, but it assumes a few things a general Management Science reader won't supply. The edits below are minimal and keep your claims and voice.

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identifying the causal effect of online reviews on sales.
We exploit platform-level heterogeneity in content moderation as a source of
exogenous variation. Specifically, we leverage the fact that platforms
differentially apply moderation policies across review cohorts, which generates
quasi-random assignment of review cohorts to moderation conditional on observed
covariates. Using a dataset of 3.4 million reviews, we estimate the effect of
review valence on sales and find it to be positive and significant. Our
identification strategy improves upon prior approaches that rely on instrumental
variables of questionable validity.
```

What I changed and why:

- **Outcome and treatment named up front.** "This literature" and "the effect" never said what the effect was on. The first sentence now states valence and sales, and the later "the effect" is specified as the effect of review valence on sales.
- **"Quasi-random assignment" now says what is assigned.** In your draft it is unclear whether valence, moderation, or something else is quasi-randomly assigned. I wrote "review cohorts to moderation," which is my reading of your design. Please check it matches your meaning.

Gaps I did not fill, because filling them would add claims you haven't made:

- **The mechanism.** A general reader will ask why differential moderation is exogenous to product quality, and why it moves valence. Your thesis is that this is what identifies the effect, so one sentence stating the link would strengthen the opening.
- **Magnitude.** "Positive and significant" is weak for a lead result. A point estimate or effect size would help, but I can't supply one.
- **The prior IV critique.** "Questionable validity" is vague. Naming the typical concern, or citing the prior work, would make the contrast concrete.