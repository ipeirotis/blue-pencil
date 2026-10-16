It assumes too much for a general Management Science reader. Four things stand out:

- **The outcome is never named.** "The effect" is never defined, so a reader can't tell what is being estimated until later. I named it as the effect of review valence on sales, taken from your paper context.
- **"This literature" has no referent.** I replaced it with a plain statement of the question.
- **The endogeneity point is compressed.** "Endogeneity with respect to unobserved product quality" is clear to economists but not to everyone. I added a short gloss on why it biases the estimate.
- **The moderation mechanism is stated as jargon.** "Exogenous variation" and "quasi-random assignment" are left unexplained, so the link between unequal moderation and identification is easy to miss. I made that link explicit without changing the claim.

I did not add a magnitude or any new numbers. A reader will probably want the effect size next to "positive and significant" if you can supply it.

```
Do more positive reviews cause higher sales? The question is hard to answer
because the endogeneity of review valence with respect to unobserved product
quality is a well-known obstacle to identification in this literature: a
high-quality product tends to receive better reviews and to sell more, so a
simple correlation between the two does not reveal the effect of the reviews
themselves. We exploit platform-level heterogeneity in content moderation as a
source of exogenous variation, that is, variation unrelated to product quality.
Specifically, we leverage the fact that platforms differentially apply
moderation policies across review cohorts, which generates quasi-random
assignment conditional on observed covariates. Using a dataset of 3.4 million
reviews, we estimate the effect of review valence on sales and find it to be
positive and significant. Our identification strategy improves upon prior
approaches that rely on instrumental variables of questionable validity.
```