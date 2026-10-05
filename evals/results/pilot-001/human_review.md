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
Review valence is endogenous to unobserved product quality, a well-known obstacle to identifying its effect on sales. Prior approaches rely on instrumental variables of questionable validity. Our identification strategy improves upon these approaches: we exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply moderation policies differently across review cohorts, which generates quasi-random assignment conditional on observed covariates. In a dataset of 3.4 million reviews, we estimate the effect of valence on sales and find it positive and significant.
```

**Version 2**

```
The endogeneity of review valence (whether reviews are favorable or unfavorable)
with respect to unobserved product quality is a well-known obstacle to
identification in this literature: products of higher quality tend to attract
more favorable reviews and higher sales, so the two are correlated even absent
any causal effect of reviews. We exploit platform-level heterogeneity in content
moderation as a source of exogenous variation. Specifically, we leverage the fact
that platforms differentially apply moderation policies across review cohorts,
which generates quasi-random assignment conditional on observed covariates. That
is, otherwise comparable cohorts are exposed to different moderation, and hence
differ in the valence of the reviews consumers see, for reasons unrelated to
product quality. Using a dataset of 3.4 million reviews, we estimate the effect
of review valence on sales and find it to be positive and significant. Our
identification strategy improves upon prior approaches that rely on instrumental
variables of questionable validity.
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
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identification in this literature: because quality affects
both the reviews a product receives and its sales, a naive comparison conflates the
effect of valence with the effect of quality. We exploit platform-level
heterogeneity in content moderation as a source of exogenous variation in valence.
Specifically, we leverage the fact that platforms differentially apply moderation
policies across review cohorts, which generates quasi-random assignment of
valence conditional on observed covariates. Using a dataset of 3.4 million
reviews, we estimate the effect of review valence on sales and find it to be
positive and significant. Our identification strategy improves upon prior
approaches that rely on instrumental variables of questionable validity.
```

**Version 2**

```
Review valence moves with unobserved product quality, so a raw comparison of reviews cannot isolate the effect of valence itself. This endogeneity is a well-known obstacle to identification in this literature, and prior approaches rely on instrumental variables of questionable validity. Our identification strategy improves upon them by exploiting platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply moderation policies differently across review cohorts, which generates quasi-random assignment conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and significant.
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

**Version 2**

```
Review valence is endogenous to unobserved product quality, a well-known obstacle to identification in this literature. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms differentially apply moderation policies across review cohorts, which generates quasi-random assignment conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and significant.
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
We estimate the effect of the loyalty program with a two-way fixed effects model that includes store and week fixed effects, and we cluster standard errors at the store level. The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks that affect all stores in the same week. The specification also controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator; it captures how much repeat purchase changes in a store after it receives the program, relative to stores that have not received it. Because the loyalty program was rolled out to stores on different dates, stores do not share a single "before" and "after" period, and a standard two-way fixed effects estimate can be distorted when treatment timing varies. We therefore use the never-treated and not-yet-treated stores as controls, so that each treated store is compared only with stores that have not yet received the program. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates, a staggered rollout. We estimate a two-way fixed effects model with store and week fixed effects and standard errors clustered at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. Its coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. Because the rollout dates differ, we use never-treated stores (those that never receive the program) and not-yet-treated stores (those that have not received it yet) as control stores. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing across stores.
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
The loyalty program was rolled out to stores on different dates, so treatment timing is staggered. We therefore use as control stores the never-treated stores, which never receive the program, and the not-yet-treated stores, which have not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

**Version 2**

```
We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. Store fixed effects absorb stable differences across stores, and week fixed effects absorb shocks common to all stores in a given week. The specification also controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures how repeat purchase changes in a store once the loyalty program reaches it, relative to stores where it has not.

The loyalty program was rolled out to stores on different dates, so stores enter treatment at different times. We therefore build the comparison group from two kinds of stores: those never treated and those not yet treated at a given point in time. Because treatment timing varies, the effect of the program may differ depending on when a store adopts it. To address this heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
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
We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks that affect all stores in a given week. The specification also includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures how outcomes change at a store once it receives the loyalty program, relative to stores that have not received it.

Because the loyalty program was rolled out to stores on different dates, there is no single before-and-after date shared by all treated stores. We therefore use two groups of stores as controls: never-treated stores, which never receive the program, and not-yet-treated stores, which have not received it as of the period being compared. To address heterogeneity in treatment timing, meaning differences across stores in when the program begins, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates. We therefore use two kinds of stores as the control group: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
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
Table 3 reports the estimates, and identity matters. In column 2, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04). It holds up in column 3, where adding product fixed effects leaves it at 0.15 (SE = 0.05). The interaction with reviewer tenure, 0.09 (SE = 0.03) in column 4, shows that the effect of disclosure grows with tenure. Star rating remains a strong driver of sales, with a coefficient of 0.42 (SE = 0.02) across all specifications, yet identity adds to it. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates. Star rating has a coefficient of 0.42 (SE = 0.02) across all specifications. Alongside it, the identity-disclosed indicator is positive: 0.18 (SE = 0.04) in column 2. After adding product fixed effects in column 3, the coefficient stays positive at 0.15 (SE = 0.05). The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level. R-squared rises from 0.31 to 0.47 across the columns.
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
Table 3 reports the estimates. The coefficient on star rating is 0.42 (SE = 0.02) across all specifications. The identity-disclosed indicator carries a separate coefficient: 0.18 (SE = 0.04) in column 2 and 0.15 (SE = 0.05) in column 3, after adding product fixed effects. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level. R-squared rises from 0.31 to 0.47 across the columns.
```

**Version 2**

```
Table 3 reports the estimates. Identity disclosure carries a coefficient of 0.18 (SE = 0.04) in column 2, and it holds at 0.15 (SE = 0.05) in column 3 once we add product fixed effects. Column 4 adds the interaction with reviewer tenure, which comes in at 0.09 (SE = 0.03). Star rating remains a strong predictor throughout, at 0.42 (SE = 0.02) in every specification. Across the columns, R-squared rises from 0.31 to 0.47. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
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
Table 3 reports the estimates. Identity matters over and above the rating itself. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2, and it holds at 0.15 (SE = 0.05) in column 3 once product fixed effects are added. Who the reviewer is also conditions the effect: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. Star rating, by comparison, carries a coefficient of 0.42 (SE = 0.02) across all specifications. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates. The coefficient on star rating is 0.42 (SE = 0.02) across all specifications. The identity-disclosed indicator carries its own positive coefficient: 0.18 (SE = 0.04) in column 2, and 0.15 (SE = 0.05) in column 3 after adding product fixed effects. In column 4, the interaction with reviewer tenure is 0.09 (SE = 0.03). R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
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
Forman et al. 2008; Dellarocas 2003), and these studies find that reviews
matter: a one-star increase leads to a 5-9% increase in revenue. Crucially,
however, whether the identity of reviewers affects this relationship remains,
to the best of our knowledge, somewhat underexplored.

To investigate this question, we leverage a novel dataset of 1.2 million
reviews. Our analysis demonstrates that reviewer identity has a significant
effect. This finding has important implications for platform design: managers
should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several studies have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. Our analysis finds that reviewer identity has a significant effect on this relationship. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
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
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several researchers have studied how online reviews relate to sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. To the best of our knowledge, however, whether reviewer identity affects this relationship remains somewhat underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. In our data, reviewer identity has a significant effect on the relationship between reviews and sales. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how
consumers make purchasing decisions. Several researchers have investigated the
relationship between online reviews and sales (Chevalier and Mayzlin 2006;
Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter:
a one-star increase leads to a 5-9% increase in revenue. Crucially, however,
whether the identity of reviewers affects this relationship remains, to the best
of our knowledge, somewhat underexplored.

To investigate this question, we leverage a novel dataset comprising 1.2 million
reviews. Our analysis demonstrates that reviewer identity has a significant
effect. This finding has important implications for platform design: managers
should consider highlighting reviewer credentials.
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
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several researchers have studied how online reviews relate to sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. Yet, to the best of our knowledge, whether reviewer identity affects this relationship remains somewhat underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. In our analysis, reviewer identity has a significant effect on this relationship. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003), and these studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. Crucially, however, whether the identity of reviewers affects this relationship remains, to the best of our knowledge, somewhat underexplored in the existing literature.

To investigate this question, we leverage a novel dataset comprising 1.2 million reviews. Our analysis demonstrates that reviewer identity has a significant effect. This finding has important implications for platform design: managers should consider highlighting reviewer credentials.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

