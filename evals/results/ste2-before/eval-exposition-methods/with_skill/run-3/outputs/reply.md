**Diagnosis**

Assumed context: none. The paper context supplies the audience, the stage (first draft), the venue and the thesis. I read the audience as quantitative marketing researchers who know fixed effects and clustering but don't work with staggered designs.

Voice tics kept: first-person plural, a flat declarative methods register, fully spelled-out method names, your compound labels ("never-treated", "not-yet-treated", "post-rollout indicator"), and the "Because …, we …" frame.

1. **Machinery before motive.** The model, controls and coefficient came first. The reader learned that the rollout was staggered only in sentence 4, and that fact explains the control group and the second estimator.
2. **Undefined groups.** "Never-treated" and "not-yet-treated" were used without being defined. The new opening sentence defines them with your own terms.
3. **Missing bridge.** The paragraph doesn't say why staggered timing calls for the Callaway and Sant'Anna estimator or how it differs from two-way fixed effects. Your manuscript doesn't contain that step, so I didn't write it in. It is in the questions below.
4. **Undefined referents.** "Post-rollout indicator" and "treatment indicator" are not defined here, and the outcome variable is not named.
5. **Ambiguous attachment.** The original "and" in sentence 4 doesn't say which estimator uses which controls. I kept your attachment as written.
6. **Overloaded last sentence.** It stacked two actions in about 45 words, so I split it.
7. **No AI tells found.** Sentences 1–3 were already tight and are unchanged.

**Revised text**

```
The loyalty program was rolled out to stores on different dates, so at any point some stores are treated, some are not yet treated, and some never will be. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. Because the rollout was staggered, we use the never-treated and not-yet-treated stores as controls. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

**Change rationale**

The text grows from about 100 to about 110 words (+10%). The paragraph contains no numbers or statistics, and I added or changed no citations.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped: precision-budget.md, because this is a Methods paragraph, not an abstract, introduction or contribution paragraph, and no hedge in the high-cost zone was added or removed.

- **New opening sentence.** It moves your sentence-4 fact to the front and defines both control groups where they first appear. All of its terms are yours.
- **Split final sentence.** The control choice and the second estimator now each get their own sentence ("We also report …"). The control-choice sentence says "Because the rollout was staggered", which avoids repeating "on different dates".
- **Sentences 1–3.** Unchanged. They are plain and precise.
- **Nothing cut.** "To address heterogeneity in treatment timing" is kept verbatim.

**Author questions**

- Does the opening sentence match your definitions? For example, is "never-treated" defined as never treated within the sample window?
- Do the controls apply to both estimators, or only to Callaway and Sant'Anna? Should the paragraph say which?
- Can you supply one sentence on what Callaway and Sant'Anna does differently from two-way fixed effects under staggered timing? Non-specialists need it to see why the second estimator is reported.
- Is the post-rollout indicator store-specific (after that store's own start date) or calendar-wide? Is it defined, along with the treatment indicator, earlier in the paper?
- Is the outcome (repeat purchase) named before this paragraph? If not, should it be named here?
- Is the Callaway and Sant'Anna estimator cited where it is first introduced? I added no citation.
- Should the paragraph state the thesis tension that a staggered rollout leaves no clean control group? I didn't add it because it isn't in your text.