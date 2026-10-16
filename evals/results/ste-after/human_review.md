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
Estimating the effect of review valence on sales faces a well-known obstacle to identification in this literature: valence is endogenous with respect to unobserved product quality. How positive or negative a product's reviews are reflects that quality, which also shapes sales. Prior approaches rely on instrumental variables of questionable validity. We instead exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply their moderation policies unequally across review cohorts, and conditional on observed covariates, this unequal application generates quasi-random assignment. Our identification strategy improves upon these prior approaches. Using a dataset of 3.4 million reviews, we estimate the effect and find it to be positive and significant.
```

**Version 2**

```
A well-known obstacle to identifying the effect of a review's valence on sales is
endogeneity: valence is correlated with unobserved product quality, which itself
drives sales. We exploit differences across platforms in how reviews are moderated
as a source of exogenous variation. Specifically, we leverage the fact that
platforms apply their moderation policies unequally across review cohorts, which
generates quasi-random assignment of moderation conditional on observed covariates.
Using a dataset of 3.4 million reviews, we estimate the effect of valence on sales
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
Estimating the effect of a review's valence (how positive or negative it is) on
sales is difficult because valence is endogenous: unobserved product quality
shapes both the reviews a product receives and how well it sells. This is a
well-known obstacle to identification in this literature. We exploit
platform-level heterogeneity in content moderation as a source of exogenous
variation. Specifically, we leverage the fact that platforms differentially apply
moderation policies across review cohorts, which generates quasi-random assignment
conditional on observed covariates. Using a dataset of 3.4 million reviews, we
estimate the effect of valence on sales and find it to be positive and
significant. Our identification strategy improves upon prior approaches that rely
on instrumental variables of questionable validity.
```

**Version 2**

```
Review valence is endogenous with respect to unobserved product quality, a well-known obstacle to identification in the literature on the effect of review valence on sales. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply moderation policies differentially across review cohorts, and this variation generates quasi-random assignment conditional on observed covariates. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate the effect and find it to be positive and significant.
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
well-known obstacle to identification in this literature: because quality affects
both the reviews a product receives and its sales, a raw correlation between
valence and sales cannot be read as the causal effect of valence. We exploit
platform-level heterogeneity in content moderation as a source of exogenous
variation. Specifically, we leverage the fact that platforms moderate reviews
unequally, applying moderation policies differentially across review cohorts, so
that the valence consumers encounter varies with platform moderation rather than
with product quality. This generates quasi-random assignment conditional on
observed covariates. Using a dataset of 3.4 million reviews, we estimate the
effect of review valence on sales and find it to be positive and significant. Our
identification strategy improves upon prior approaches that rely on instrumental
variables of questionable validity.
```

**Version 2**

```
Identifying the causal effect of review valence on sales is difficult because valence is endogenous with respect to unobserved product quality, a well-known obstacle in this literature. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply moderation policies differently across review cohorts, and conditional on observed covariates this generates quasi-random assignment. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate a positive and significant effect of review valence on sales.
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
We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator.

Because the loyalty program was rolled out to stores on different dates (a staggered rollout), stores enter the treated group at different times. We therefore use two kinds of stores as controls: never-treated stores, which do not receive the program during our data, and not-yet-treated stores, which have not yet received it at the point of comparison. Because treatment timing varies across stores, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates (a staggered rollout). We therefore use two kinds of control stores: never-treated stores, which never received the program, and not-yet-treated stores, which had not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
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
The loyalty program was rolled out to stores on different dates, so we use the never-treated stores (stores that never received the program) and the not-yet-treated stores (stores that had not yet received it) as controls. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The coefficient of interest is the interaction between the post-rollout indicator (weeks after rollout) and the treatment indicator (stores that received the program). The specification also adjusts for foot traffic, local unemployment, and promotional intensity. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing, meaning that stores entered treatment on different dates.
```

**Version 2**

```
We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. The loyalty program was rolled out to stores on different dates (a staggered rollout), so stores move from untreated to treated at different times. Because of this, we use two groups of stores as controls: never-treated stores, which do not receive the program during our data window, and not-yet-treated stores, which have not yet received it at a given point in time. To address heterogeneity in treatment timing, that is, the possibility that the program's effect differs across stores that adopted it on different dates, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
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
We estimate a two-way fixed effects model with store and week fixed effects, which absorb stable differences across stores and shocks that affect all stores in a given week. We cluster standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures the change in outcomes after the program arrives in a treated store, relative to stores that did not receive it at that time.

Because the loyalty program was rolled out to stores on different dates (a staggered rollout), we use two kinds of control stores: never-treated stores and not-yet-treated stores, meaning stores that have not yet received the program in a given week. Differences in treatment timing can distort two-way fixed effects estimates when the program's effect varies across stores or over time. To address this heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates, and this staggered timing shapes how we estimate its effect. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. Because of this timing, we use never-treated stores (stores that never receive the program) and not-yet-treated stores (stores that receive it later than the week in question) as control stores. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
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
Table 3 reports the estimates. Identity disclosure carries its own weight: the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2, and it remains at 0.15 (SE = 0.05) in column 3 after we add product fixed effects. Disclosure also matters more for some reviewers than others. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4, so the effect of disclosure grows with tenure. Throughout, star rating stays a strong predictor, with a coefficient of 0.42 (SE = 0.02) across all specifications, so identity effects appear alongside the rating effect rather than in place of it. Model fit improves as the specifications build, with R-squared rising from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
In Table 3, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2 and falls to 0.15 (SE = 0.05) in column 3 once product fixed effects are added. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across all specifications. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level. R-squared rises from 0.31 to 0.47 across the columns.
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
In Table 3, the coefficient on the identity-disclosed indicator is positive: 0.18 (SE = 0.04) in column 2 and, after adding product fixed effects, 0.15 (SE = 0.05) in column 3. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across all specifications. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates, and they point to a clear role for reviewer identity. In column 2, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04). Adding product fixed effects in column 3 leaves the effect largely intact, at 0.15 (SE = 0.05). The identity effect also grows with reviewer credibility: the interaction with reviewer tenure in column 4 is 0.09 (SE = 0.03). Star rating remains a strong predictor, with a coefficient of 0.42 (SE = 0.02) across all specifications, yet it does not displace identity. Explanatory power rises from an R-squared of 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
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
Table 3 reports the estimates, and they point to a consistent role for reviewer identity. In column 2, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04). It remains sizable after we add product fixed effects in column 3, at 0.15 (SE = 0.05). Identity also conditions on who is speaking: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. Star rating matters throughout, with a coefficient of 0.42 (SE = 0.02) across all specifications, yet identity adds to it rather than merely echoing it. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates. Star rating has a coefficient of 0.42 (SE = 0.02) across all specifications. The identity-disclosed indicator has its own: 0.18 (SE = 0.04) in column 2, and 0.15 (SE = 0.05) in column 3, which adds product fixed effects. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
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
Online platforms have fundamentally transformed how consumers make purchasing
decisions. Several researchers have investigated the relationship between
online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008;
Dellarocas 2003), and these studies found that reviews matter: a one-star
increase leads to a 5-9% increase in revenue. Crucially, however, whether the
identity of reviewers affects this relationship remains, to the best of our
knowledge, somewhat underexplored.

To investigate this question, we leverage a novel dataset comprising 1.2
million reviews. Our analysis demonstrates that reviewer identity has a
significant effect. This finding has important implications for platform
design: managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has transformed how consumers make
purchasing decisions. Several studies have examined the relationship between
online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008;
Dellarocas 2003). These studies found that reviews matter: a one-star increase
leads to a 5-9% increase in revenue. However, to the best of our knowledge,
whether reviewer identity affects this relationship remains underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. Reviewer
identity has a significant effect on the relationship between reviews and
sales. This finding has implications for platform design: managers should
consider highlighting reviewer credentials.
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
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). They found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, whether reviewer identity affects this relationship remains underexplored in the literature, to the best of our knowledge.

To investigate this question, we use a dataset of 1.2 million reviews. In our analysis, reviewer identity has a significant effect. For platform design, this finding implies that managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how
consumers make purchasing decisions. Several researchers have investigated the
relationship between online reviews and sales (Chevalier and Mayzlin 2006;
Forman et al. 2008; Dellarocas 2003), and these studies found that reviews
matter: a one-star increase leads to a 5-9% increase in revenue. Crucially,
however, whether the identity of reviewers affects this relationship remains,
to the best of our knowledge, somewhat underexplored.

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
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several studies have examined the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. Yet to our knowledge, the question of whether reviewer identity affects this relationship remains somewhat underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. In these data, reviewer identity significantly affects the relationship between reviews and sales. Platform managers should therefore consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003), and found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. Crucially, however, whether reviewer identity affects this relationship remains, to the best of our knowledge, somewhat underexplored.

To investigate this question, we leverage a novel dataset comprising 1.2 million reviews. Our analysis demonstrates that reviewer identity has a significant effect. This finding has important implications for platform design: managers should consider highlighting reviewer credentials.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

