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
Identifying the effect of review valence on sales faces a well-known obstacle in this literature: valence is endogenous with respect to unobserved product quality. We exploit platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply their moderation policies differently across review cohorts, and this unequal application generates quasi-random assignment, conditional on observed covariates. Our identification strategy improves upon prior approaches that rely on instrumental variables of questionable validity. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find that effect to be positive and significant.
```

**Version 2**

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identifying the causal effect of valence on sales: the same
quality that makes reviews favorable also makes a product sell. We exploit
platform-level heterogeneity in content moderation as a source of exogenous
variation. Specifically, we leverage the fact that platforms differentially apply
moderation policies across review cohorts, which generates quasi-random assignment
conditional on observed covariates. Because this unequal moderation is unrelated to
product quality, it lets us isolate the effect of valence on sales. Using a dataset
of 3.4 million reviews, we estimate this effect and find it to be positive and
significant. Our identification strategy improves upon prior approaches that rely on
instrumental variables of questionable validity.
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
Reviews that are more favorable tend to accompany products that are better, which makes it hard to
tell whether a review's valence (how positive or negative it is) causes sales or merely reflects
unobserved product quality. This endogeneity of review valence with respect to unobserved product
quality is a well-known obstacle to identification in the literature on how online reviews affect
sales. We exploit platform-level heterogeneity in content moderation as a source of exogenous
variation, that is, variation in which reviews are seen that is unrelated to product quality.
Specifically, we leverage the fact that platforms differentially apply moderation policies across
review cohorts, which generates quasi-random assignment conditional on observed covariates. Using a
dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be
positive and significant. Our identification strategy improves upon prior approaches that rely on
instrumental variables of questionable validity.
```

**Version 2**

```
The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identification in this literature. We exploit
platform-level heterogeneity in content moderation as a source of exogenous
variation: platforms apply moderation policies differentially across review
cohorts, and this differential application generates quasi-random assignment
conditional on observed covariates. Our identification strategy improves upon
prior approaches that rely on instrumental variables of questionable validity.
Using a dataset of 3.4 million reviews, we estimate the effect of review valence
on sales and find it to be positive and statistically significant.
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

**Version 2**

```
In this literature, review valence is endogenous to unobserved product quality, which obstructs identification of its effect on sales. Prior approaches to this problem rely on instrumental variables of questionable validity. Our identification strategy improves upon these approaches. It exploits platform-level heterogeneity in content moderation as a source of exogenous variation. Platforms apply moderation policies unequally across review cohorts. Conditional on observed covariates, this unequal moderation generates quasi-random assignment. Using a dataset of 3.4 million reviews, we estimate the effect of review valence on sales and find it to be positive and statistically significant.
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
We estimate the effect of the loyalty program with a two-way fixed effects model, which includes a separate intercept for each store and each week and clusters standard errors at the store level. The specification also controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator (whether a given week falls after the program launched) and the treatment indicator (whether a store ever received the program).

The loyalty program was rolled out to stores on different dates, so there is no single before-and-after moment for all treated stores. Comparisons must therefore be constructed with care. We use two kinds of control stores: never-treated stores, which do not receive the program during the sample, and not-yet-treated stores, which have not yet received it at the time of comparison. Because treatment timing varies, a two-way fixed effects estimate alone can be difficult to interpret. We therefore report the Callaway and Sant'Anna estimator alongside it. This estimator compares each group of stores that launched on the same date with its control stores, which addresses heterogeneity in treatment timing.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates. We therefore use two kinds of stores as controls: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received it. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
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
The loyalty program was rolled out to stores on different dates, so treatment timing is staggered. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. Because of the staggered timing, we use the never-treated and not-yet-treated stores as controls: stores that never received the program and stores that had not yet received it on a given date. We report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

**Version 2**

```
We estimate a two-way fixed effects model with store and week fixed effects,
clustering standard errors at the store level. The store fixed effects absorb
stable differences across stores, and the week fixed effects absorb shocks that
affect all stores in the same week. The specification also includes controls for
foot traffic, local unemployment, and promotional intensity. The coefficient of
interest is the interaction between the post-rollout indicator and the treatment
indicator, which captures the change in repeat purchase at a store after the
loyalty program arrives there, relative to stores without it. Because the loyalty
program was rolled out to stores on different dates, a simple comparison of
treated and untreated stores is not sufficient: a store treated early could
otherwise serve as a comparison for a store treated later. We therefore use the
never-treated and not-yet-treated stores as controls, meaning stores that have
not received the program by the period being compared. We report the Callaway and
Sant'Anna estimator alongside the two-way fixed effects estimate to address
heterogeneity in treatment timing, that is, the possibility that the program's
effect differs depending on when a store was treated.
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
We estimate a two-way fixed effects model, which includes a fixed effect for each store and for each week and clusters standard errors at the store level. The specification also controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator, which captures the change in repeat purchase after a store receives the loyalty program, relative to stores that have not received it. Because the program was rolled out to stores on different dates (a staggered design), a simple two-way fixed effects comparison can be misleading: stores treated earlier can end up serving as controls for stores treated later, and this can distort the estimate when the effect varies across stores or over time. To avoid this, we use the never-treated and not-yet-treated stores as controls. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate, which addresses heterogeneity in treatment timing by estimating the effect separately for each group of stores treated at the same time and then averaging across groups.
```

**Version 2**

```
The loyalty program was rolled out to stores on different dates, so the set of treated stores changes over time. We therefore use two kinds of control stores: never-treated stores, which never receive the program, and not-yet-treated stores, which have not yet received the program at a given date. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. To address heterogeneity in treatment timing, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate.
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
Table 3 reports the estimates. Identity disclosure carries weight beyond the rating itself: the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04) in column 2, and it persists at 0.15 (SE = 0.05) in column 3 after adding product fixed effects. The effect also grows with reviewer tenure, with an interaction coefficient of 0.09 (SE = 0.03) in column 4. Star rating remains a strong predictor throughout, with a coefficient of 0.42 (SE = 0.02) across all specifications, so identity matters alongside the rating, not in place of it. R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
With the star rating in the model, the identity-disclosed indicator is positive and significant (Table 3). The coefficient on the indicator is 0.18 (SE = 0.04) in column 2 and holds at 0.15 (SE = 0.05) in column 3 after product fixed effects are added. The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across all specifications. All coefficients are significant at the 1% level except this interaction, which is significant at the 5% level. R-squared rises from 0.31 to 0.47 across the columns.
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
Table 3 reports the estimates: the identity-disclosed indicator has a positive, significant coefficient that survives product fixed effects. The coefficient is 0.18 (SE = 0.04) in column 2; in column 3, after adding product fixed effects, it is 0.15 (SE = 0.05). The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. The coefficient on star rating is 0.42 (SE = 0.02) across all specifications. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level. R-squared rises from 0.31 to 0.47 across the columns.
```

**Version 2**

```
Table 3 reports the estimates, and they point to a clear role for reviewer identity. In column 2, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04). Adding product fixed effects in column 3 leaves the effect largely intact, at 0.15 (SE = 0.05). Identity also conditions the weight a review carries: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. Star rating remains a strong predictor, with a coefficient of 0.42 (SE = 0.02) across all specifications, yet identity adds explanatory power beyond it, as R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
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
Table 3 reports the estimates, and the pattern is clear: who writes a review matters, not just what it says. In column 2, the coefficient on the identity-disclosed indicator is 0.18 (SE = 0.04). It remains substantial in column 3 after we add product fixed effects, at 0.15 (SE = 0.05). The effect also grows with experience: the interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. Star rating, as expected, carries a strong effect of its own, with a coefficient of 0.42 (SE = 0.02) across all specifications. Model fit improves accordingly, as R-squared rises from 0.31 to 0.47 across the columns. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level.
```

**Version 2**

```
In Table 3, the coefficient on the identity-disclosed indicator is positive: 0.18 (SE = 0.04) in column 2. It remains positive after adding product fixed effects in column 3, at 0.15 (SE = 0.05). The interaction with reviewer tenure is 0.09 (SE = 0.03) in column 4. The coefficient on star rating stays at 0.42 (SE = 0.02) across all specifications. All coefficients are significant at the 1% level except the interaction, which is significant at the 5% level. R-squared rises from 0.31 to 0.47 across the columns.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-connectors/run-1

**Original**

```
We find the gain from retrieval augmentation is concentrated in long-tail questions. Since the retriever was frozen, accuracy on frequent questions did not change, while accuracy on rare questions rose from 41.2% to 57.8% (Table 3), with median latency increasing by 210 ms per query. As the index grows, retrieval cost rises: we observe the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes the retrieved passages are relevant [@lewis2020], but our annotation shows 23% of the top-ranked passages do not contain the answer.
```

**Version 1**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Since the retriever was frozen, accuracy on frequent questions did not change, whereas accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. As the index grows, retrieval cost rises: we observe that the median retrieval time roughly doubles between the indexes of 1M and 10M documents. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

**Version 2**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. The retriever was frozen, so accuracy on frequent questions did not change. Accuracy on rare questions rose from 41.2% to 57.8% (Table 3), and median latency increased by 210 ms per query. As the index grows, retrieval cost rises: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-connectors/run-2

**Original**

```
We find the gain from retrieval augmentation is concentrated in long-tail questions. Since the retriever was frozen, accuracy on frequent questions did not change, while accuracy on rare questions rose from 41.2% to 57.8% (Table 3), with median latency increasing by 210 ms per query. As the index grows, retrieval cost rises: we observe the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes the retrieved passages are relevant [@lewis2020], but our annotation shows 23% of the top-ranked passages do not contain the answer.
```

**Version 1**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change. In contrast, accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. Retrieval cost rises with index size: we observe that the median retrieval time roughly doubles between the 1M-document and 10M-document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

**Version 2**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change. In contrast, accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. As the index grows, retrieval cost rises: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-connectors/run-3

**Original**

```
We find the gain from retrieval augmentation is concentrated in long-tail questions. Since the retriever was frozen, accuracy on frequent questions did not change, while accuracy on rare questions rose from 41.2% to 57.8% (Table 3), with median latency increasing by 210 ms per query. As the index grows, retrieval cost rises: we observe the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes the retrieved passages are relevant [@lewis2020], but our annotation shows 23% of the top-ranked passages do not contain the answer.
```

**Version 1**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change. Accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. As the index grows, retrieval cost rises: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020]. However, our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

**Version 2**

```
We find that the gain from retrieval augmentation is concentrated in long-tail questions. Because the retriever was frozen, accuracy on frequent questions did not change, whereas accuracy on rare questions rose from 41.2% to 57.8% (Table 3). Median latency increased by 210 ms per query. Retrieval cost rises with index size: we observe that the median retrieval time roughly doubles between the 1M and 10M document indexes. Prior work assumes that the retrieved passages are relevant [@lewis2020], but our annotation shows that 23% of the top-ranked passages do not contain the answer.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-procedure/run-1

**Original**

```
Responses were screened and recoded after the field period closed, with respondents excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Open-ended answers were coded by two research assistants using the codebook in Appendix B, disagreements being resolved by discussion, and the coded categories were merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region, and the analytic sample is N = 2,184 after exclusions.
```

**Version 1**

```
Data processing proceeded in four steps, after the field period closed. First, we screened responses and excluded respondents who failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Second, two research assistants coded the open-ended answers using the codebook in Appendix B, and disagreements were resolved by discussion. Third, we merged the coded categories with the panel's demographic file using the respondent ID. Fourth, before estimation, we applied raking weights to the merged file, matching the 2020 Census margins for age, sex, and region. The analytic sample after exclusions is N = 2,184.
```

**Version 2**

```
After the field period closed, responses were screened and recoded. Respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). After these exclusions, the analytic sample is N = 2,184. Two research assistants coded the open-ended answers using the codebook in Appendix B. Disagreements were resolved by discussion. The coded categories were then merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-procedure/run-2

**Original**

```
Responses were screened and recoded after the field period closed, with respondents excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Open-ended answers were coded by two research assistants using the codebook in Appendix B, disagreements being resolved by discussion, and the coded categories were merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region, and the analytic sample is N = 2,184 after exclusions.
```

**Version 1**

```
Responses were screened and recoded after the field period closed. Respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). After these exclusions, the analytic sample is N = 2,184. Two research assistants coded the open-ended answers using the codebook in Appendix B, and disagreements were resolved by discussion. The coded categories were then merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region.
```

**Version 2**

```
After the field period closed, data processing proceeded in four steps. First, responses were screened, and respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes); the analytic sample is N = 2,184 after these exclusions. Second, open-ended answers were coded by two research assistants using the codebook in Appendix B, with disagreements resolved by discussion. Third, the coded categories were merged with the panel's demographic file using the respondent ID. Fourth, raking weights were expected to be applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-procedure/run-3

**Original**

```
Responses were screened and recoded after the field period closed, with respondents excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Open-ended answers were coded by two research assistants using the codebook in Appendix B, disagreements being resolved by discussion, and the coded categories were merged with the panel's demographic file using the respondent ID. Raking weights would have been expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region, and the analytic sample is N = 2,184 after exclusions.
```

**Version 1**

```
After the field period closed, we processed the data in four steps. First, we screened responses and excluded respondents who failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Second, two research assistants coded the open-ended answers using the codebook in Appendix B, and disagreements were resolved by discussion. Third, we merged the coded categories with the panel's demographic file using the respondent ID. Fourth, raking weights were to be applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region. The analytic sample after exclusions is N = 2,184.
```

**Version 2**

```
After the field period closed, responses were screened and recoded. Respondents were excluded if they failed both attention checks or finished in under one third of the median completion time (4.1 minutes). Two research assistants coded the open-ended answers using the codebook in Appendix B, and disagreements were resolved by discussion. The coded categories were then merged with the panel's demographic file using the respondent ID. Raking weights were expected to have been applied to the merged file before estimation, matching the 2020 Census margins for age, sex, and region. The analytic sample is N = 2,184 after exclusions.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-vague/run-1

**Original**

```
Our approach addresses the cold-start problem in recommender systems. We came up with a two-stage model that deals with sparse interaction histories, and the results point out that new-user engagement prediction model accuracy improves by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement ended up higher for users who received the warm-start recommendations. Our data come from a single streaming platform. Future work should look at whether the effect carries over to other domains.
```

**Version 1**

```
We address the cold-start problem in recommender systems with a two-stage model that handles sparse interaction histories. The results indicate that the accuracy of engagement predictions for new users improves over the matrix factorization baseline (Koren et al., 2009) by 8.3 points. Engagement was higher for users who received the warm-start recommendations. Our data come from a single streaming platform. Future work should test whether these results carry over to other domains.
```

**Version 2**

```
Our approach addresses cold-start in recommender systems. We developed a two-stage model for sparse interaction histories, and new-user engagement prediction accuracy improves by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement was also higher for users who received the warm-start recommendations. Our data come from a single streaming platform, so future work should test whether the effect carries over to other domains.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-vague/run-2

**Original**

```
Our approach addresses the cold-start problem in recommender systems. We came up with a two-stage model that deals with sparse interaction histories, and the results point out that new-user engagement prediction model accuracy improves by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement ended up higher for users who received the warm-start recommendations. Our data come from a single streaming platform. Future work should look at whether the effect carries over to other domains.
```

**Version 1**

```
We developed a two-stage model for the cold-start problem in recommender systems, where interaction histories are sparse. The model improved the accuracy of new-user engagement prediction by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement was higher for users who received the warm-start recommendations. Our data come from a single streaming platform, so future work should test whether the effect holds in other domains.
```

**Version 2**

```
Our two-stage model addresses the cold-start problem by handling sparse interaction histories. It improves new-user engagement prediction accuracy by 8.3 points over the matrix factorization baseline (Koren et al., 2009), and users who received the warm-start recommendations showed higher engagement. Our data come from a single streaming platform, so future work should test whether the effect carries over to other domains.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

## ste-vague/run-3

**Original**

```
Our approach addresses the cold-start problem in recommender systems. We came up with a two-stage model that deals with sparse interaction histories, and the results point out that new-user engagement prediction model accuracy improves by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement ended up higher for users who received the warm-start recommendations. Our data come from a single streaming platform. Future work should look at whether the effect carries over to other domains.
```

**Version 1**

```
Our two-stage model targets the cold-start problem in recommender systems, where new users have sparse interaction histories. Against the matrix factorization baseline (Koren et al., 2009), it improves accuracy in predicting new-user engagement by 8.3 points. Engagement was higher for users who received the warm-start recommendations. Our data come from a single streaming platform, so whether these results carry over to other domains remains for future work to test.
```

**Version 2**

```
Our approach addresses the cold-start problem in recommender systems. We developed a two-stage model that handles sparse interaction histories, and new-user engagement prediction accuracy improves by 8.3 points over the matrix factorization baseline (Koren et al., 2009). Engagement was also higher for users who received the warm-start recommendations. Our data come from a single streaming platform, so future work should test whether the effect carries over to other domains.
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
The proliferation of online platforms has fundamentally transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, to the best of our knowledge, whether reviewer identity affects this relationship remains somewhat underexplored.

To investigate this question, we leverage a novel dataset of 1.2 million reviews. Our analysis demonstrates that reviewer identity has a significant effect. This finding has important implications for platform design: managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several studies investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, to our knowledge, whether reviewer identity affects this relationship remains somewhat underexplored in the literature.

To investigate this question, we use a dataset of 1.2 million reviews. In our analysis, reviewer identity has a significant effect. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
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
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several studies have investigated how online reviews relate to sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. Yet, to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. We find that reviewer identity has a significant effect. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how
consumers make purchasing decisions. Several researchers have investigated the
relationship between online reviews and sales (Chevalier and Mayzlin 2006;
Forman et al. 2008; Dellarocas 2003), and they find that reviews matter: a
one-star increase leads to a 5-9% increase in revenue. Crucially, however,
whether reviewer identity affects this relationship remains, to the best of our
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
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase raises revenue by 5-9%. However, to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. Reviewer identity has a significant effect on this relationship. Platform managers should therefore consider highlighting reviewer credentials.
```

**Version 2**

```
The proliferation of online platforms has fundamentally transformed how
consumers make purchasing decisions. Several researchers have examined the
relationship between online reviews and sales (Chevalier and Mayzlin 2006;
Forman et al. 2008; Dellarocas 2003), and these studies find that reviews
matter: a one-star increase leads to a 5-9% increase in revenue. However,
whether the identity of reviewers affects this relationship remains, to the
best of our knowledge, somewhat underexplored.

To investigate this question, we leverage a novel dataset of 1.2 million
reviews. Our analysis demonstrates that reviewer identity has a significant
effect. This finding has important implications for platform design: managers
should consider highlighting reviewer credentials.
```

Better written (1 / 2 / tie): ______   Meaning changed in 1? ____  in 2? ____   Notes:

