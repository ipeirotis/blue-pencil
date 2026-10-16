```
We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator.

Because the loyalty program was rolled out to stores on different dates (a staggered rollout), stores enter the treated group at different times. We therefore use two kinds of stores as controls: never-treated stores, which do not receive the program during our data, and not-yet-treated stores, which have not yet received it at the point of comparison. Because treatment timing varies across stores, we report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

I made three changes, all for readers new to staggered designs:
- I split the paragraph in two, so the model specification is separate from the staggered-rollout logic.
- I added a short gloss on "staggered rollout," "never-treated," and "not-yet-treated."
- I added a clause saying that treatment timing varies across stores before introducing the Callaway and Sant'Anna estimator.

The citation, its name order, and all variables and terms are unchanged, and the paragraph has no numbers to alter. One thing to check: "do not receive the program during our data" is my wording for never-treated, so adjust it if your sample window is defined differently.