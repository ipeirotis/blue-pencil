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
Estimating the effect of review valence on sales runs into a well-known obstacle to identification in this literature: valence is endogenous with respect to unobserved product quality. Prior approaches rely on instrumental variables of questionable validity. We improve on these approaches by exploiting platform-level heterogeneity in content moderation as a source of exogenous variation. Specifically, platforms apply their moderation policies differently across review cohorts, and this difference generates quasi-random assignment conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of valence on sales and find it positive and significant.
```

**Version 2**

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
Estimating the causal effect of a review's valence on product sales is difficult
because valence is endogenous: it is correlated with unobserved product quality,
which also drives sales. This endogeneity is a well-known obstacle to
identification in this literature. We exploit platform-level heterogeneity in
content moderation as a source of exogenous variation. Specifically, we leverage
the fact that platforms differentially apply moderation policies across review
cohorts, which generates quasi-random assignment of reviews to moderation
treatment conditional on observed covariates. Using a dataset of 3.4 million
reviews, we estimate the effect of review valence on sales and find it to be
positive and significant. Our identification strategy improves upon prior
approaches that rely on instrumental variables of questionable validity.
```

**Version 2**

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identification in this literature. We address this obstacle
by exploiting platform-level heterogeneity in content moderation as a source of
exogenous variation. Platforms apply their moderation policies unequally across
review cohorts, and this generates quasi-random assignment conditional on observed
covariates. Using a dataset of 3.4 million reviews, we estimate a positive and
statistically significant effect of review valence on sales. Our identification
strategy improves upon prior approaches that rely on instrumental variables of
questionable validity.
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
Do more favorable online reviews cause higher sales? The endogeneity of review
valence with respect to unobserved product quality is a well-known obstacle to
identification in this literature: the same unobserved quality that leads
consumers to leave favorable reviews also leads them to buy the product. We
exploit platform-level heterogeneity in content moderation as a source of
exogenous variation. Specifically, we leverage the fact that platforms
differentially apply moderation policies across review cohorts, which generates
quasi-random assignment conditional on observed covariates. Using a dataset of
3.4 million reviews, we estimate the effect of review valence on sales and find
it to be positive and significant. Our identification strategy improves upon
prior approaches that rely on instrumental variables of questionable validity.
```

**Version 2**

```
Review valence is endogenous to unobserved product quality, a well-known obstacle to identification in this literature. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity: it exploits platform-level heterogeneity in content moderation as a source of exogenous variation. The variation arises because platforms apply moderation policies unequally across review cohorts; conditional on observed covariates, this generates quasi-random assignment. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it positive and statistically significant.
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
We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks that affect all stores in a given week. The specification also includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures the change in outcomes at a store after it receives the loyalty program, relative to stores that have not yet received it.

Because the loyalty program was rolled out to stores on different dates (a staggered design), there is no single date that separates "before" from "after" for all stores. In this setting, stores that were treated earlier can end up serving as implicit comparisons for stores treated later, which can distort the two-way fixed effects estimate when the effect differs across stores or over time. To address this, we use the never-treated and not-yet-treated stores as controls, and we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

**Version 2**

```
Because the loyalty program was rolled out to stores on different dates, we use two kinds of control stores: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it at the date in question. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing, that is, the different dates on which stores received the program.
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
The loyalty program was rolled out to stores on different dates. We therefore use two groups of stores as controls: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

**Version 2**

```
We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator; it captures the change in repeat purchase at a store after the loyalty program arrives, relative to the change at comparison stores over the same weeks.

Because the loyalty program was rolled out to stores on different dates, a standard two-way fixed effects model can be misleading: it may use stores that were already treated as controls for stores treated later, which can distort the estimate when the program's effect changes over time or differs across stores. To avoid this, we compare each treated store only with stores that have not yet received the program at that time, namely the never-treated and not-yet-treated stores. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address this heterogeneity in treatment timing.
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
Because the loyalty program was rolled out to stores on different dates, at any given week some stores have the program and others do not. We estimate a two-way fixed effects model with store and week fixed effects. Store fixed effects absorb stable differences across stores, and week fixed effects absorb shocks common to all stores in a given week. We cluster standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures how outcomes change at a store after it receives the program, relative to stores that have not received it. Because treatment timing differs across stores, we use the never-treated stores (those that never receive the program) and the not-yet-treated stores (those that will receive it later) as controls. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing, that is, the possibility that the program's effect differs depending on when a store was treated.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates, so no single date separates before from after. We therefore use as control stores those that have not yet received the program (not-yet-treated) and those that never receive it (never-treated). We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The model also controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing across stores, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
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
Table 3 reports the estimates, and they show that who writes a review matters, not just what it says. In column 2, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04). It remains 0.15 (SE = 0.05) in column 3 after adding product fixed effects, so the identity effect is not an artifact of unobserved product differences. Reviewer tenure strengthens it: the interaction in column 4 is 0.09 (SE = 0.03). Star rating, by comparison, carries a coefficient of 0.42 (SE = 0.02) across all specifications. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
In Table 3, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2 and remains 0.15 (SE = 0.05) in column 3, after adding product fixed effects. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. By comparison, the coefficient on star rating is 0.42 (SE = 0.02) across all specifications. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level. R-squared rises from 0.31 to 0.47 across the columns.
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
Table 3 reports a positive coefficient on the identity-disclosed indicator that persists after product fixed effects are added: 0.18 (SE = 0.04) in column 2 and 0.15 (SE = 0.05) in column 3. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across all specifications, and R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates, and identity matters. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2, and it remains substantial at 0.15 (SE = 0.05) in column 3 after we add product fixed effects. Reviewer tenure amplifies the effect: the interaction is 0.09 (SE = 0.03) in column 4. Star rating remains a strong predictor, with a coefficient of 0.42 (SE = 0.02) across all specifications, but it does not tell the whole story. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
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
Table 3 reports the estimates, and they show that who writes a review matters alongside what it says. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2, and it remains substantial at 0.15 (SE = 0.05) in column 3 after we add product fixed effects. Identity also works in combination with experience: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. Star rating, by comparison, carries a coefficient of 0.42 (SE = 0.02) across all specifications. Explanatory power rises accordingly, with R-squared increasing from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates. The coefficient on the identity-disclosed indicator
is 0.18 (SE = 0.04) in column 2 and 0.15 (SE = 0.05) in column 3, after adding
product fixed effects. In column 4, the interaction with reviewer tenure is 0.09
(SE = 0.03). The coefficient on star rating is 0.42 (SE = 0.02) across all
specifications. R-squared rises from 0.31 to 0.47 across the columns. All
coefficients are significant at the 1% level except the interaction, which is
significant at the 5% level.
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
The proliferation of online platforms has fundamentally transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003), and these studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. Crucially, however, whether the identity of reviewers affects this relationship remains, to the best of our knowledge, somewhat underexplored in the existing literature.

To investigate this question, we leverage a novel dataset comprising 1.2 million reviews. Our analysis demonstrates that reviewer identity has a significant effect. This finding has important implications for platform design: managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how consumers make purchasing decisions. Several researchers have studied the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. In this dataset, reviewer identity has a significant effect. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
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
The proliferation of online platforms has transformed how consumers make
purchasing decisions. Several studies have examined how online reviews relate
to sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003).
These studies found that reviews matter: a one-star increase leads to a 5-9%
increase in revenue. Yet, to the best of our knowledge, whether reviewer
identity affects this relationship remains underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. We find
that reviewer identity has a significant effect on this relationship. Platform
managers should therefore consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how
consumers make purchasing decisions. Several researchers have examined the
relationship between online reviews and sales (Chevalier and Mayzlin 2006;
Forman et al. 2008; Dellarocas 2003), finding that reviews matter: a one-star
increase leads to a 5-9% increase in revenue. Crucially, however, whether the
identity of reviewers affects this relationship remains, to the best of our
knowledge, somewhat underexplored.

To investigate this question, we leverage a novel dataset comprising 1.2
million reviews. Our analysis demonstrates that reviewer identity has a
significant effect. This finding has important implications for platform
design: managers should consider highlighting reviewer credentials.
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
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several studies have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, to the best of our knowledge, the question of whether reviewer identity affects this relationship remains underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. Our analysis demonstrates that reviewer identity has a significant effect on this relationship. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how
consumers make purchasing decisions. Several researchers have investigated the
relationship between online reviews and sales (Chevalier and Mayzlin 2006;
Forman et al. 2008; Dellarocas 2003), and found that reviews matter: a one-star
increase leads to a 5-9% increase in revenue. Crucially, however, whether the
identity of reviewers affects this relationship remains, to the best of our
knowledge, somewhat underexplored in the existing literature.

To investigate this question, we leverage a novel dataset comprising 1.2
million reviews. Our analysis demonstrates that reviewer identity has a
significant effect. This finding has important implications for platform
design: managers should consider highlighting reviewer credentials.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

