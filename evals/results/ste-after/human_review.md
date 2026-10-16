# Human review sheet (blinded)

For each pair, read the original and both versions, then write your verdict (1, 2, or tie) on the blank line. Judge how well each reads, and note any meaning change you spot. Do not open `human_review_key.json` until you are done.

## exposition-introduction/run-1

**Original**

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identification in this literature. We exploit
platform-level heterogeneity in content moderation as a source of exogenous
variation. Specifically, we leverage the fact that platforms differentially apply
moderation policies across review cohorts, which generates quasi-random assignment
conditional on observed covariates. Using a dataset of 3.4 million reviews, we
estimate the effect and find it to be positive and significant. Our identification
strategy improves upon prior approaches that rely on instrumental variables of
questionable validity.
```

**Version 1**

```
In research on the effect of review valence on sales, the endogeneity of valence with respect to unobserved product quality is a well-known obstacle to identification. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms differentially apply moderation policies across review cohorts, and this variation generates quasi-random assignment conditional on observed covariates. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and significant.
```

**Version 2**

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identifying the causal effect of reviews on sales: a
product that receives favorable reviews may also simply be a better product. We
exploit platform-level heterogeneity in content moderation as a source of
exogenous variation. Specifically, platforms moderate reviews unequally, and we
leverage the fact that they differentially apply moderation policies across
review cohorts. This generates quasi-random assignment of review valence
conditional on observed covariates, so that otherwise comparable products are
exposed to different sets of reviews for reasons unrelated to their quality.
Using a dataset of 3.4 million reviews, we estimate the effect of valence on
sales and find it to be positive and significant. Our identification strategy
improves upon prior approaches that rely on instrumental variables of
questionable validity.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## exposition-introduction/run-2

**Original**

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identification in this literature. We exploit
platform-level heterogeneity in content moderation as a source of exogenous
variation. Specifically, we leverage the fact that platforms differentially apply
moderation policies across review cohorts, which generates quasi-random assignment
conditional on observed covariates. Using a dataset of 3.4 million reviews, we
estimate the effect and find it to be positive and significant. Our identification
strategy improves upon prior approaches that rely on instrumental variables of
questionable validity.
```

**Version 1**

```
A central question in this literature is how a review's valence, meaning
whether it is positive or negative, affects a product's sales. The
endogeneity of review valence with respect to unobserved product quality
is a well-known obstacle to identification: quality shapes both the
reviews a product receives and its sales, so the two may be correlated
without one causing the other. We exploit platform-level heterogeneity in
content moderation as a source of exogenous variation. Specifically, we
leverage the fact that platforms differentially apply moderation policies
across review cohorts, which generates quasi-random assignment conditional
on observed covariates. Using a dataset of 3.4 million reviews, we
estimate the effect of review valence on sales and find it to be positive
and significant. Our identification strategy improves upon prior
approaches that rely on instrumental variables of questionable validity.
```

**Version 2**

```
Estimating the causal effect of a review's valence on sales is difficult because valence is endogenous to unobserved product quality, a well-known obstacle to identification in this literature. Prior approaches rely on instrumental variables of questionable validity. Our identification strategy improves upon these approaches by exploiting platform-level heterogeneity in content moderation as a source of exogenous variation. Specifically, platforms apply moderation policies differently to different review cohorts, and, conditional on observed covariates, this difference generates quasi-random assignment. Using a dataset of 3.4 million reviews, we estimate this effect and find it positive and significant.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## exposition-introduction/run-3

**Original**

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identification in this literature. We exploit
platform-level heterogeneity in content moderation as a source of exogenous
variation. Specifically, we leverage the fact that platforms differentially apply
moderation policies across review cohorts, which generates quasi-random assignment
conditional on observed covariates. Using a dataset of 3.4 million reviews, we
estimate the effect and find it to be positive and significant. Our identification
strategy improves upon prior approaches that rely on instrumental variables of
questionable validity.
```

**Version 1**

```
A well-known obstacle to identifying the causal effect of review valence on sales is endogeneity: valence is correlated with unobserved product quality, which itself affects sales. We exploit differences across platforms in how they moderate content as a source of exogenous variation. Specifically, we leverage the fact that platforms differentially apply moderation policies across review cohorts, which generates quasi-random assignment of moderation conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of valence on sales and find it to be positive and significant. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity.
```

**Version 2**

```
The effect of review valence on sales is hard to identify because valence is endogenous to unobserved product quality, a well-known obstacle in this literature. We exploit differences in content moderation across platforms as a source of exogenous variation. Specifically, we use the fact that platforms apply moderation policies differently across review cohorts. This difference generates quasi-random assignment conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and significant. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## exposition-methods/run-1

**Original**

```
We estimate a two-way fixed effects model with store and week fixed effects,
clustering standard errors at the store level. The specification includes controls
for foot traffic, local unemployment, and promotional intensity. The coefficient of
interest is the interaction between the post-rollout indicator and the treatment
indicator. Because the loyalty program was rolled out to stores on different dates,
we use the never-treated and not-yet-treated stores as controls, and we report the
Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to
address heterogeneity in treatment timing.
```

**Version 1**

```
We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. In other words, the model compares each store's outcomes to its own baseline (store fixed effects) and removes shocks common to all stores in a given week (week fixed effects). The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator; it captures the change in repeat purchase at a store after it receives the loyalty program, relative to stores that have not yet received it or never do.

Because the loyalty program was rolled out to stores on different dates, a single before-and-after comparison is not available. We therefore use the never-treated and not-yet-treated stores as controls: at any given date, stores that have not yet received the program serve as the comparison group for stores that already have. A known concern with two-way fixed effects under staggered timing is that effects can differ across stores that are treated at different times, and the pooled estimate may then compare already-treated stores with later-treated ones in ways that distort the result. To address this heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates. At a given date, some stores had not yet received the program, and others never did; we use both groups as control stores. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate, to address heterogeneity in treatment timing.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## exposition-methods/run-2

**Original**

```
We estimate a two-way fixed effects model with store and week fixed effects,
clustering standard errors at the store level. The specification includes controls
for foot traffic, local unemployment, and promotional intensity. The coefficient of
interest is the interaction between the post-rollout indicator and the treatment
indicator. Because the loyalty program was rolled out to stores on different dates,
we use the never-treated and not-yet-treated stores as controls, and we report the
Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to
address heterogeneity in treatment timing.
```

**Version 1**

```
The loyalty program was rolled out to stores on different dates, so we use two kinds of control stores: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

**Version 2**

```
We estimate a two-way fixed effects model, which includes a separate intercept for each store and each week. The store effects absorb stable differences across stores, and the week effects absorb shocks common to all stores in a given week. We cluster standard errors at the store level and include controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures how outcomes change at a store once it receives the loyalty program, relative to stores that have not received it. Because the program was rolled out to stores on different dates (a staggered rollout), there is no single date at which treatment begins for all stores. We therefore use the never-treated stores (those that never receive the program) and the not-yet-treated stores (those that have not yet received it at a given point in time) as controls. Because two-way fixed effects estimates can be hard to interpret when treatment timing differs across stores, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## exposition-methods/run-3

**Original**

```
We estimate a two-way fixed effects model with store and week fixed effects,
clustering standard errors at the store level. The specification includes controls
for foot traffic, local unemployment, and promotional intensity. The coefficient of
interest is the interaction between the post-rollout indicator and the treatment
indicator. Because the loyalty program was rolled out to stores on different dates,
we use the never-treated and not-yet-treated stores as controls, and we report the
Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to
address heterogeneity in treatment timing.
```

**Version 1**

```
We estimate a two-way fixed effects model, which includes a separate intercept for each store and each week. The store effects absorb stable differences across stores, and the week effects absorb shocks that affect all stores in a given week. We cluster standard errors at the store level, which allows observations from the same store to be correlated over time. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures the change in outcomes for a store after the loyalty program arrives, relative to stores without it. Because the loyalty program was rolled out to stores on different dates, treated stores do not share a single before-and-after period. We therefore use the never-treated stores (those that do not receive the program) and the not-yet-treated stores (those that have not yet received it at the time of comparison) as controls. Because two-way fixed effects estimates can be sensitive to differences in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates (a staggered rollout). We therefore use two kinds of stores as the control group: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it at a given date. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing across stores, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## exposition-results/run-1

**Original**

```
Table 3 reports the estimates. The coefficient on the identity-disclosed indicator
is 0.18 (SE = 0.04) in column 2. In column 3, after adding product fixed effects,
the coefficient is 0.15 (SE = 0.05). The interaction with reviewer tenure is 0.09
(SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across
all specifications. R-squared rises from 0.31 to 0.47 across the columns. All
coefficients are significant at the 1% level except the interaction, which is
significant at the 5% level.
```

**Version 1**

```
Table 3 reports the estimates, and identity matters. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2, and it holds up when product fixed effects are added in column 3, where it is 0.15 (SE = 0.05). Reviewer tenure strengthens the effect: the interaction in column 4 is 0.09 (SE = 0.03). Star rating remains a powerful driver throughout, with a coefficient of 0.42 (SE = 0.02) across all specifications. Explanatory power rises accordingly, as R-squared climbs from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
In Table 3, the identity-disclosed indicator has a coefficient of 0.18 (SE = 0.04) in column 2, and 0.15 (SE = 0.05) in column 3 once product fixed effects are added. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. Star rating has a coefficient of 0.42 (SE = 0.02) across all specifications, and R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## exposition-results/run-2

**Original**

```
Table 3 reports the estimates. The coefficient on the identity-disclosed indicator
is 0.18 (SE = 0.04) in column 2. In column 3, after adding product fixed effects,
the coefficient is 0.15 (SE = 0.05). The interaction with reviewer tenure is 0.09
(SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across
all specifications. R-squared rises from 0.31 to 0.47 across the columns. All
coefficients are significant at the 1% level except the interaction, which is
significant at the 5% level.
```

**Version 1**

```
Table 3 reports the estimates. The coefficient on the identity-disclosed indicator
is 0.18 (SE = 0.04) in column 2 and 0.15 (SE = 0.05) in column 3, after product
fixed effects are added. The interaction with reviewer tenure is 0.09 (SE = 0.03)
in column 4. Across all specifications, the coefficient on star rating is 0.42
(SE = 0.02). R-squared rises from 0.31 to 0.47 across the columns. All
coefficients are significant at the 1% level except the interaction, which is
significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates, and they point to a clear role for reviewer identity. In column 2, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04). It remains substantial after we add product fixed effects in column 3, where it is 0.15 (SE = 0.05). Identity also conditions the effect of a review: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. Star rating matters throughout, with a coefficient of 0.42 (SE = 0.02) across all specifications, yet identity adds to it rather than being absorbed by it. Model fit improves accordingly, as R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## exposition-results/run-3

**Original**

```
Table 3 reports the estimates. The coefficient on the identity-disclosed indicator
is 0.18 (SE = 0.04) in column 2. In column 3, after adding product fixed effects,
the coefficient is 0.15 (SE = 0.05). The interaction with reviewer tenure is 0.09
(SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across
all specifications. R-squared rises from 0.31 to 0.47 across the columns. All
coefficients are significant at the 1% level except the interaction, which is
significant at the 5% level.
```

**Version 1**

```
Table 3 reports the estimates, and they point to a clear role for reviewer identity. Disclosing the reviewer's identity raises the outcome by 0.18 (SE = 0.04) in column 2, and the effect holds when we add product fixed effects in column 3, where the coefficient is 0.15 (SE = 0.05). Identity also conditions the weight a review carries: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. Star rating matters as well, with a coefficient of 0.42 (SE = 0.02) across all specifications, but it does not account for the identity effects, which persist alongside it. Model fit improves as identity measures enter, with R-squared rising from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates. Star rating has a coefficient of 0.42 (SE = 0.02) across all specifications. Alongside it, the identity-disclosed indicator has a coefficient of 0.18 (SE = 0.04) in column 2, and 0.15 (SE = 0.05) in column 3 after adding product fixed effects. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## worked-example/run-1

**Original**

```
It is important to note that the proliferation of online platforms has
fundamentally transformed the way in which consumers make purchasing
decisions. Furthermore, an investigation of the relationship between online
reviews and sales was conducted by several researchers (Chevalier and Mayzlin
2006; Forman et al. 2008; Dellarocas 2003). Moreover, these studies found that
reviews matter, a one-star increase leads to a 5-9% increase in revenue.
Crucially, however, the question of whether the identity of reviewers affects
this relationship remains, to the best of our knowledge, somewhat underexplored
in the existing literature.

In order to investigate this question, we leverage a novel dataset comprising
of 1.2 million reviews. The results of our analysis demonstrate that reviewer
identity has a significant effect. It should be noted that this finding has
important implications for platform design: managers should consider
highlighting reviewer credentials.
```

**Version 1**

```
The proliferation of online platforms has fundamentally transformed how
consumers make purchasing decisions. Several researchers have investigated the
relationship between online reviews and sales (Chevalier and Mayzlin 2006;
Forman et al. 2008; Dellarocas 2003), and they find that reviews matter: a
one-star increase leads to a 5-9% increase in revenue. Crucially, however,
whether the identity of reviewers affects this relationship remains, to the
best of our knowledge, somewhat underexplored.

To investigate this question, we leverage a novel dataset comprising 1.2
million reviews. Our analysis demonstrates that reviewer identity has a
significant effect. This finding has important implications for platform
design: managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several studies of the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003) found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. Yet to our knowledge, whether reviewer identity affects this relationship remains underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. Reviewer identity has a significant effect on the relationship between reviews and sales. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## worked-example/run-2

**Original**

```
It is important to note that the proliferation of online platforms has
fundamentally transformed the way in which consumers make purchasing
decisions. Furthermore, an investigation of the relationship between online
reviews and sales was conducted by several researchers (Chevalier and Mayzlin
2006; Forman et al. 2008; Dellarocas 2003). Moreover, these studies found that
reviews matter, a one-star increase leads to a 5-9% increase in revenue.
Crucially, however, the question of whether the identity of reviewers affects
this relationship remains, to the best of our knowledge, somewhat underexplored
in the existing literature.

In order to investigate this question, we leverage a novel dataset comprising
of 1.2 million reviews. The results of our analysis demonstrate that reviewer
identity has a significant effect. It should be noted that this finding has
important implications for platform design: managers should consider
highlighting reviewer credentials.
```

**Version 1**

```
Online platforms have transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, to the best of our knowledge, whether reviewer identity affects this relationship remains somewhat underexplored.

To investigate this question, we use a dataset comprising 1.2 million reviews. Our analysis shows that reviewer identity has a significant effect on this relationship. Platform managers should therefore consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003), and they find that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, whether reviewer identity affects this relationship remains, to the best of our knowledge, somewhat underexplored.

To investigate this question, we leverage a novel dataset comprising 1.2 million reviews. Our analysis demonstrates that reviewer identity has a significant effect. This finding has important implications for platform design: managers should consider highlighting reviewer credentials.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## worked-example/run-3

**Original**

```
It is important to note that the proliferation of online platforms has
fundamentally transformed the way in which consumers make purchasing
decisions. Furthermore, an investigation of the relationship between online
reviews and sales was conducted by several researchers (Chevalier and Mayzlin
2006; Forman et al. 2008; Dellarocas 2003). Moreover, these studies found that
reviews matter, a one-star increase leads to a 5-9% increase in revenue.
Crucially, however, the question of whether the identity of reviewers affects
this relationship remains, to the best of our knowledge, somewhat underexplored
in the existing literature.

In order to investigate this question, we leverage a novel dataset comprising
of 1.2 million reviews. The results of our analysis demonstrate that reviewer
identity has a significant effect. It should be noted that this finding has
important implications for platform design: managers should consider
highlighting reviewer credentials.
```

**Version 1**

```
The proliferation of online platforms has transformed how consumers make
purchasing decisions. Several researchers have studied the relationship
between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al.
2008; Dellarocas 2003). These studies found that reviews matter: a one-star
increase leads to a 5-9% increase in revenue. To the best of our knowledge,
however, the question of whether reviewer identity affects this relationship
remains somewhat underexplored in the literature.

To investigate this question, we use a dataset of 1.2 million reviews. Our
analysis shows that reviewer identity has a significant effect. This finding
has implications for platform design: managers should consider highlighting
reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003), and these studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, whether the identity of reviewers affects this relationship remains, to the best of our knowledge, underexplored.

To investigate this question, we leverage a novel dataset comprising 1.2 million reviews. Our analysis demonstrates that reviewer identity has a significant effect. This finding has important implications for platform design: managers should consider highlighting reviewer credentials.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

