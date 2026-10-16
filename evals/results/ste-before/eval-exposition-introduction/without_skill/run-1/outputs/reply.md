Your opening is clear to empirical economists but assumes too much in four places for a general Management Science reader:

1. **"Endogeneity of review valence"** is stated but not explained. A one-clause mechanism (unobserved quality drives both reviews and sales) fixes this.
2. **"The effect"** is never named. The reader only learns it is the effect of valence on sales from the paper context, not from the text.
3. **"Platform-level heterogeneity" and "across review cohorts"** read as two different sources of variation. I've kept your wording but tied them together so it is clear that unequal moderation is the source.
4. **"Quasi-random assignment conditional on observed covariates"** is jargon-dense. I added a short gloss on what it means here.

Two things I left alone because of your constraints. "Positive and significant" gives no magnitude, which many readers will want, but I can't add a number. The claim about "instrumental variables of questionable validity" also reads as unsupported without a citation, so you may want to add one yourself.

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identification in this literature: because product quality
affects both the reviews a product receives and its sales, a simple correlation
between the two cannot be read as the causal effect of valence on sales. We exploit
platform-level heterogeneity in content moderation as a source of exogenous
variation. Specifically, we leverage the fact that platforms differentially apply
moderation policies across review cohorts. Because this unequal moderation is
unrelated to a product's underlying quality, it generates quasi-random assignment
conditional on observed covariates; that is, comparable reviews are exposed to
different moderation regimes for reasons unrelated to the product itself. Using a
dataset of 3.4 million reviews, we estimate the effect of review valence on sales
and find it to be positive and significant. Our identification strategy improves
upon prior approaches that rely on instrumental variables of questionable validity.
```

One caution: the added sentence "Because this unequal moderation is unrelated to a product's underlying quality" states your identifying assumption as fact. That is the claim reviewers will probe hardest. It follows from your meaning, but you may want to soften it or point to the section where you defend it.