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
Review valence is endogenous to unobserved product quality, a well-known obstacle to identification in this literature. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms differentially apply moderation policies across review cohorts, and this differential application generates quasi-random assignment conditional on observed covariates. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate the effect of review valence. We find it positive and significant.
```

**Version 2**

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identifying the causal effect of valence on sales in this
literature: the same unobserved quality that leads consumers to rate a product
highly also leads them to buy it. We exploit platform-level heterogeneity in
content moderation as a source of exogenous variation. Specifically, we leverage
the fact that platforms differentially apply moderation policies across review
cohorts, so that comparable reviews are moderated differently. This generates
quasi-random assignment, conditional on observed covariates, of the moderation
regime a review faces. Using a dataset of 3.4 million reviews, we estimate the
effect of review valence on sales and find it to be positive and significant. Our
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
Estimating the causal effect of a review's valence on sales is difficult because
valence is endogenous: it is correlated with unobserved product quality, which
also drives sales. This is a well-known obstacle to identification in this
literature. We exploit platform-level heterogeneity in content moderation as a
source of exogenous variation. Specifically, we leverage the fact that platforms
differentially apply moderation policies across review cohorts, which generates
quasi-random assignment conditional on observed covariates; that is, among
otherwise comparable reviews, which ones are moderated is as good as random. Using
a dataset of 3.4 million reviews, we estimate the effect of valence on sales and
find it to be positive and significant. Our identification strategy improves upon
prior approaches that rely on instrumental variables of questionable validity.
```

**Version 2**

```
We study the effect of review valence on sales, where valence is how positive or negative a review is. Review valence is endogenous with respect to unobserved product quality, a well-known obstacle to identification in this literature. We exploit differences across platforms in content moderation as a source of exogenous variation. Specifically, we use the fact that platforms differentially apply moderation policies across review cohorts, which generates quasi-random assignment conditional on observed covariates. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate this effect and find it to be positive and significant.
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
well-known obstacle to identification in this literature: higher-quality products
tend to receive more favorable reviews and also to sell more, so the observed
relationship between valence and sales cannot be read as causal. We exploit
platform-level heterogeneity in content moderation as a source of exogenous
variation. Specifically, we leverage the fact that platforms differentially apply
moderation policies across review cohorts, which generates quasi-random assignment
of cohorts to differing moderation exposure, conditional on observed covariates.
Using a dataset of 3.4 million reviews, we estimate the effect of review valence
on sales and find it to be positive and significant. Our identification strategy
improves upon prior approaches that rely on instrumental variables of
questionable validity.
```

**Version 2**

```
The endogeneity of review valence with respect to unobserved product quality is a well-known obstacle to identification in this literature. Unobserved quality can shape both a product's reviews and its sales, so the raw link between valence and sales does not isolate the effect of valence. Prior approaches to this problem rely on instrumental variables of questionable validity. Our identification strategy improves upon them by exploiting unequal moderation: platforms differentially apply moderation policies across review cohorts. This platform-level heterogeneity in content moderation is a source of exogenous variation: it generates quasi-random assignment conditional on observed covariates. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and significant.
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
We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks common to all stores in a given week. The specification also includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures the change in outcomes for a store after the loyalty program reaches it, relative to the change at other stores over the same period.

The loyalty program was rolled out to stores on different dates, a staggered design in which stores enter treatment at different times rather than all at once. As a result, we do not need a separate group of stores that never receive the program. At any point in time, the comparison group consists of stores that are never treated and stores that are not yet treated, meaning those that will receive the program later but have not yet received it. Because a two-way fixed effects estimate can be sensitive to differences in when stores are treated, we report the Callaway and Sant'Anna estimator alongside it. This estimator addresses heterogeneity in treatment timing.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates, so we use two kinds of stores as the control group: never-treated stores, which never receive the program, and not-yet-treated stores, which have not received it yet. We estimate a two-way fixed effects model with store and week fixed effects and controls for foot traffic, local unemployment, and promotional intensity, clustering standard errors at the store level. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
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
The loyalty program was rolled out to stores on different dates, so at any given time some stores have it and others do not yet. We use two groups of stores as controls: the never-treated stores, which never receive the program, and the not-yet-treated stores, which receive it on a later date. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate, to address the differences across stores in when treatment began.
```

**Version 2**

```
We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The store fixed effects absorb stable differences across stores, and the week fixed effects absorb shocks that affect all stores in the same week. The specification also includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which compares the change in repeat purchase at stores after they receive the loyalty program with the change at stores that have not received it. Because the loyalty program was rolled out to stores on different dates, there is no single "before" and "after" period shared by all treated stores. We therefore use the never-treated stores (those that never receive the program) and the not-yet-treated stores (those that will receive it later but have not yet) as controls. Because differences in treatment timing can complicate the interpretation of the two-way fixed effects estimate, we report the Callaway and Sant'Anna estimator alongside it to address heterogeneity in treatment timing.
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
We estimate a two-way fixed effects model, which includes a separate intercept for each store and each week. These fixed effects absorb stable differences across stores and shocks common to all stores in a given week. We cluster standard errors at the store level. The specification also controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures the change in repeat purchase after a store receives the loyalty program, relative to comparison stores.

The loyalty program was rolled out to stores on different dates, a staggered design in which stores enter treatment at different times. Because of this, a store that has not yet received the program can still serve as a comparison until its own rollout date. We therefore use the never-treated and not-yet-treated stores as controls. Two-way fixed effects estimates can be difficult to interpret when treatment timing varies, because the effect of the program may differ across stores or over time. To address this heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate. This estimator compares each group of stores that began treatment on the same date only with stores not yet treated or never treated, and then aggregates those comparisons.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates, so at any point some stores are treated, some are not yet treated, and some never will be. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. Because the rollout was staggered, we use the never-treated and not-yet-treated stores as controls. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
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
Table 3 reports the estimates, and they point to a clear role for reviewer identity. In column 2, the identity-disclosed indicator carries a coefficient of 0.18 (SE = 0.04). Adding product fixed effects in column 3 trims it only modestly, to 0.15 (SE = 0.05), so the effect does not hinge on differences across products. Identity matters more as reviewers gain experience: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. Star rating remains a strong driver of sales throughout, with a coefficient of 0.42 (SE = 0.02) across all specifications, yet identity adds explanatory power beyond it, as R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates, and the identity-disclosed indicator survives the addition of product fixed effects. Its coefficient is 0.18 (SE = 0.04) in column 2 and 0.15 (SE = 0.05) in column 3, which adds them. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. The coefficient on star rating stays at 0.42 (SE = 0.02) across all specifications, and R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
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
Identity disclosure matters over and above the star rating. Table 3 reports the estimates. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2, and it survives the addition of product fixed effects in column 3, where it is 0.15 (SE = 0.05). The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across all specifications. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates, and they show that who writes a review matters. In column 2, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04). It remains substantial after we add product fixed effects in column 3, where it is 0.15 (SE = 0.05). Identity also interacts with reviewer tenure: the interaction in column 4 is 0.09 (SE = 0.03). Star rating, by contrast, carries a steady coefficient of 0.42 (SE = 0.02) across all specifications. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
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
Table 3 reports the estimates, and they point to a clear role for reviewer identity. In column 2, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04). It remains substantial after we add product fixed effects in column 3, where it is 0.15 (SE = 0.05). Identity also conditions the influence of a review: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. Star rating matters as well, with a coefficient of 0.42 (SE = 0.02) across all specifications, but identity adds to its effect rather than being absorbed by it. Model fit improves accordingly, as R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
Table 3 reports the estimates. Star rating has a coefficient of 0.42 (SE = 0.02) across all specifications, and identity disclosure carries a coefficient of its own. The coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2 and 0.15 (SE = 0.05) in column 3, after adding product fixed effects. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level. R-squared rises from 0.31 to 0.47 across the columns.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-connectors/run-1

**Original**

```
We find the gain from retrieval augmentation is concentrated in long-tail questions. Since the retriever was frozen, accuracy on frequent questions did not change, while accuracy on rare questions rose from 41.2% to 57.8% (Table 3), with median latency increasing by 210 ms per query. As the index grows, retrieval cost rises: we observe the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes the retrieved passages are relevant [@lewis2020], but our annotation shows 23% of the top-ranked passages do not contain the answer.
```

**Version 1**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. With the retriever frozen, accuracy on frequent questions did not change, but accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency rose by 210 ms per query. Retrieval cost also grows with index size: median retrieval time roughly doubled between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

**Version 2**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change. Accuracy on rare questions rose from 41.2% to 57.8% (Table 3), and median latency increased by 210 ms per query. Retrieval cost also rises as the index grows: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-connectors/run-2

**Original**

```
We find the gain from retrieval augmentation is concentrated in long-tail questions. Since the retriever was frozen, accuracy on frequent questions did not change, while accuracy on rare questions rose from 41.2% to 57.8% (Table 3), with median latency increasing by 210 ms per query. As the index grows, retrieval cost rises: we observe the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes the retrieved passages are relevant [@lewis2020], but our annotation shows 23% of the top-ranked passages do not contain the answer.
```

**Version 1**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. With the retriever frozen, accuracy on frequent questions did not change, whereas accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. Retrieval cost also rises as the index grows: the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

**Version 2**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change. Accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. As the index grows, retrieval cost rises: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-connectors/run-3

**Original**

```
We find the gain from retrieval augmentation is concentrated in long-tail questions. Since the retriever was frozen, accuracy on frequent questions did not change, while accuracy on rare questions rose from 41.2% to 57.8% (Table 3), with median latency increasing by 210 ms per query. As the index grows, retrieval cost rises: we observe the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes the retrieved passages are relevant [@lewis2020], but our annotation shows 23% of the top-ranked passages do not contain the answer.
```

**Version 1**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change. In contrast, accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. As the index grows, retrieval cost rises: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

**Version 2**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. With the retriever frozen, accuracy on frequent questions did not change, whereas accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency also increased by 210 ms per query. Retrieval cost rises as the index grows: we observe that median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-procedure/run-1

**Original**

```
Responses were screened and recoded after the field period closed, with respondents excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Open-ended answers were coded by two research assistants using the codebook in Appendix B, disagreements being resolved by discussion, and the coded categories were merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region, and the analytic sample is N = 2,184 after exclusions.
```

**Version 1**

```
After the field period closed, we processed the data in four steps. First, we screened the responses and excluded respondents who failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Second, two research assistants coded the open-ended answers using the codebook in Appendix B, resolving disagreements by discussion. Third, we merged the coded categories with the panel's demographic file using the respondent ID. Fourth, before estimation, raking weights were to be applied to the merged file, matching the 2020 Census margins for age, sex, and region. The analytic sample after exclusions is N = 2,184.
```

**Version 2**

```
Responses were screened and recoded after the field period closed. Respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Open-ended answers were coded by two research assistants using the codebook in Appendix B, and disagreements were resolved by discussion. The coded categories were then merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region. The analytic sample is N = 2,184 after exclusions.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-procedure/run-2

**Original**

```
Responses were screened and recoded after the field period closed, with respondents excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Open-ended answers were coded by two research assistants using the codebook in Appendix B, disagreements being resolved by discussion, and the coded categories were merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region, and the analytic sample is N = 2,184 after exclusions.
```

**Version 1**

```
After the field period closed, responses were screened, and respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Open-ended answers were then coded by two research assistants using the codebook in Appendix B, with disagreements resolved by discussion. The coded categories were next merged with the panel's demographic file using the respondent ID. Raking weights were to be applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region. The analytic sample is N = 2,184 after exclusions.
```

**Version 2**

```
Responses were processed after the field period closed, in four steps. First, we screened responses, excluding respondents who failed both attention checks or finished in under one third of the median completion time (4.1 minutes); the analytic sample after these exclusions is N = 2,184. Second, two research assistants coded the open-ended answers using the codebook in Appendix B, with disagreements resolved by discussion. Third, we merged the coded categories with the panel's demographic file using the respondent ID. Fourth, raking weights were expected to be applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-procedure/run-3

**Original**

```
Responses were screened and recoded after the field period closed, with respondents excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Open-ended answers were coded by two research assistants using the codebook in Appendix B, disagreements being resolved by discussion, and the coded categories were merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region, and the analytic sample is N = 2,184 after exclusions.
```

**Version 1**

```
After the field period closed, the data were processed in four steps. First, responses were screened, and respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes); the analytic sample after these exclusions is N = 2,184. Second, two research assistants coded the open-ended answers using the codebook in Appendix B, resolving disagreements by discussion. Third, the coded categories were merged with the panel's demographic file using the respondent ID. Fourth, before estimation, raking weights were applied to the merged file, matching the 2020 Census margins for age, sex, and region.
```

**Version 2**

```
After the field period closed, responses were screened and recoded. Respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Two research assistants coded the open-ended answers using the codebook in Appendix B and resolved disagreements by discussion. The coded categories were then merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region. The analytic sample is N = 2,184 after exclusions.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-vague/run-1

**Original**

```
Our approach addresses the cold-start problem in recommender systems. We came up with a two-stage model that deals with sparse interaction histories, and the results point out that new-user engagement prediction model accuracy improves by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement ended up higher for users who received the warm-start recommendations. Our data come from a single streaming platform. Future work should look at whether the effect carries over to other domains.
```

**Version 1**

```
We developed a two-stage model that addresses the cold-start problem in recommender systems by handling sparse interaction histories. It improves the accuracy of new-user engagement prediction by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement was higher for users who received the warm-start recommendations. Because our data come from a single streaming platform, future work should look at whether the effect carries over to other domains.
```

**Version 2**

```
Our approach addresses the cold-start problem in recommender systems. We developed a two-stage model that handles sparse interaction histories, and the results show that it improves new-user engagement prediction accuracy by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement was also higher for users who received the warm-start recommendations. Our data come from a single streaming platform, so future work should examine whether the effect carries over to other domains.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-vague/run-2

**Original**

```
Our approach addresses the cold-start problem in recommender systems. We came up with a two-stage model that deals with sparse interaction histories, and the results point out that new-user engagement prediction model accuracy improves by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement ended up higher for users who received the warm-start recommendations. Our data come from a single streaming platform. Future work should look at whether the effect carries over to other domains.
```

**Version 1**

```
We address the cold-start problem in recommender systems with a two-stage model for sparse interaction histories. The results show that accuracy in predicting new-user engagement improves by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement was also higher for users who received the warm-start recommendations. Because our data come from a single streaming platform, future work should examine whether these findings carry over to other domains.
```

**Version 2**

```
Our approach addresses the cold-start problem in recommender systems. We developed a two-stage model for sparse interaction histories, and it improves new-user engagement prediction accuracy by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement was also higher for users who received the warm-start recommendations. Our data come from a single streaming platform; future work should test whether the effect carries over to other domains.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-vague/run-3

**Original**

```
Our approach addresses the cold-start problem in recommender systems. We came up with a two-stage model that deals with sparse interaction histories, and the results point out that new-user engagement prediction model accuracy improves by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement ended up higher for users who received the warm-start recommendations. Our data come from a single streaming platform. Future work should look at whether the effect carries over to other domains.
```

**Version 1**

```
Our approach addresses the cold-start problem in recommender systems. We built a two-stage model that handles sparse interaction histories. Compared with the matrix factorization baseline (Koren et al., 2009), it improves new-user engagement prediction accuracy by 8.3 points. Engagement was higher for users who received the warm-start recommendations. Our data come from a single streaming platform, so future work should look at whether the effect carries over to other domains.
```

**Version 2**

```
Our approach addresses the cold-start problem in recommender systems. We developed a two-stage model that handles sparse interaction histories, and new-user engagement prediction accuracy improves by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Users who received the warm-start recommendations showed higher engagement. Our data come from a single streaming platform, so future work should test whether the effect carries over to other domains.
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
Forman et al. 2008; Dellarocas 2003), and these studies found that reviews
matter: a one-star increase leads to a 5-9% increase in revenue. However, to
the best of our knowledge, whether reviewer identity affects this relationship
remains underexplored.

To investigate this question, we leverage a novel dataset comprising 1.2
million reviews. Our analysis demonstrates that reviewer identity has a
significant effect. This finding has important implications for platform
design: managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, to our knowledge, whether reviewer identity affects this relationship remains underexplored in the literature.

To investigate this question, we use a dataset of 1.2 million reviews. In our analysis, reviewer identity has a significant effect on this relationship. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
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
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several studies have investigated how online reviews relate to sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. Yet, to the best of our knowledge, whether reviewer identity affects this relationship remains somewhat underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. In our data, reviewer identity has a significant effect on the relationship between reviews and sales. Platform managers should therefore consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how
consumers make purchasing decisions. Several researchers have investigated the
relationship between online reviews and sales (Chevalier and Mayzlin 2006;
Forman et al. 2008; Dellarocas 2003), and these studies found that reviews
matter: a one-star increase leads to a 5-9% increase in revenue. However, to
the best of our knowledge, whether the identity of reviewers affects this
relationship remains somewhat underexplored.

To investigate this question, we leverage a novel dataset of 1.2 million
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
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. To the best of our knowledge, however, whether the identity of reviewers affects this relationship remains underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. We find that reviewer identity has a significant effect on the relationship between reviews and sales. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how
consumers make purchasing decisions. Several researchers have investigated the
relationship between online reviews and sales (Chevalier and Mayzlin 2006;
Forman et al. 2008; Dellarocas 2003), and found that reviews matter: a one-star
increase leads to a 5-9% increase in revenue. Crucially, however, whether the
identity of reviewers affects this relationship remains, to the best of our
knowledge, somewhat underexplored.

To investigate this question, we leverage a novel dataset of 1.2 million
reviews. Our analysis demonstrates that reviewer identity has a significant
effect. This finding has important implications for platform design: managers
should consider highlighting reviewer credentials.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

