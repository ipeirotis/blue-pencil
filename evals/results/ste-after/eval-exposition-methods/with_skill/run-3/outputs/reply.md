### 1. Diagnosis

Assumed context: none assumed. Audience, revision stage (first draft), target venue, and core thesis all come from `AGENTS.md`. The core-thesis comparison is skipped because this is a methods paragraph, not an opening or contribution paragraph.

Voice tics: first-person plural "we" with active verbs; plain declarative sentences, one setup fact each; hyphenated compound terms of art kept in full ("not-yet-treated", "two-way fixed effects"); no hedging; the estimator named in running text with no citation attached.

Reader map: starts with a trained quantitative marketing researcher who knows fixed effects and basic difference-in-differences logic but not staggered-adoption designs; must learn that the staggered rollout drives the choice of control stores and the second estimator; should leave understanding that the two-way fixed effects estimate is reported alongside the Callaway and Sant'Anna estimator because treatment timing differs across stores.

Jargon to unpack: "never-treated" and "not-yet-treated" stores; "heterogeneity in treatment timing".
Buried lede: the staggered rollout is the reason for the control-store choice and the second estimator, but it appears only in the fourth sentence, after the specification.
Concrete anchor: the author's own fact that the loyalty program reached stores on different dates.

1. [P1, structure] Machinery before motive. The paragraph opens with the fixed-effects specification and covariates. The staggered rollout, which explains the control choice and the second estimator, arrives in sentence 4.
2. [P1, exposition] Definition debt. "Never-treated" and "not-yet-treated" are used without a gloss. A reader who does not work with staggered designs cannot tell how the two control groups differ.
3. [P1, exposition] Compressed inference. The paragraph never says why the two-way fixed effects estimate alone is not enough under staggered timing, or what the Callaway and Sant'Anna estimator does differently. The manuscript supplies neither, so I did not write them (see Author questions).
4. [P1, sentence] The last sentence has a left-branching "Because" preamble. It also carries two topics, the control-store choice and the second estimator, and the first topic's role is not marked.
5. [P1, copyediting] "Controls" has two senses: covariates in sentence 2 ("controls for foot traffic") and control stores in sentence 4. A second-language reader can misparse the second one as covariates.
6. [P1, payoff] The paragraph ends on unglossed jargon ("heterogeneity in treatment timing"). The new lead sentence supplies the referent.
7. [P1, scope] The paragraph never names the outcome the coefficient measures, and never says how "post-rollout" is defined when rollout dates differ by store. The manuscript does not say either, so both go to Author questions.

### 2. Revised text

```
The loyalty program was rolled out to stores on different dates, and this staggered timing shapes how we estimate its effect. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. Because of this timing, we use never-treated stores (stores that never receive the program) and not-yet-treated stores (stores that receive it later than the week in question) as control stores. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate to address heterogeneity in treatment timing.
```

Added bridges: None.

### 3. Change rationale

Word count: ~90 to ~125 (+40%).
The rewrite is longer because it adds a lead sentence and two short term glosses for readers new to staggered designs. All three are built from the author's own wording.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. precision-budget.md was skipped: this is a methods paragraph, and no hedge in the abstract, introduction, or contribution zone was added or removed. Altitude ran with no relocation, because the machinery already sits in its home Methods section. cold-read.md and consistency-checks.md belong to the whole-paper passes and were not loaded here.

- (new lead sentence) -> "The loyalty program was rolled out to stores on different dates, and this staggered timing shapes how we estimate its effect.", the author's own fact from the old sentence 4, moved to the front. Question before machinery: the reader now knows why the estimation looks as it does.
- "Because the loyalty program was rolled out to stores on different dates, we use the never-treated and not-yet-treated stores as controls, and we report ..." -> "Because of this timing, we use ... as control stores." and "We also report ...", split into two sentences. The left-branching preamble is gone, each sentence has one topic, and the "Because" now points back to a stated referent.
- "never-treated and not-yet-treated stores" -> "never-treated stores (stores that never receive the program) and not-yet-treated stores (stores that receive it later than the week in question)". Defines each term at first serious use from its own wording, so a reader new to staggered designs can see how the groups differ.
- "as controls" -> "as control stores". One word, one sense: "controls" now means only covariates in sentence 3, and the control stores are named as stores.
- "the never-treated ... stores" -> "never-treated stores". Drops an article that did no work once the glosses were added.
- "and we report" -> "We also report". A one-topic sentence that closes on the author's phrase, "heterogeneity in treatment timing", whose referent is now the lead sentence's "staggered timing".
- The specification, covariate, and coefficient sentences are unchanged. They already parse in one pass, have a clear topic string, and carry no tells.
- No numbers or citations were present or changed. No em-dashes, banned phrases, or decorative narrative were introduced.

### 4. Author questions

- Why is the two-way fixed effects estimate alone insufficient under staggered timing, and what does the Callaway and Sant'Anna estimator do differently? A single sentence from you would give non-specialists the missing bridge, and I could not supply it without adding substance.
- Do the never-treated and not-yet-treated control stores apply only to the Callaway and Sant'Anna estimate, or to the two-way fixed effects model as well? The original joined the two clauses with "and", and my sentence order could be read either way.
- Do the glosses of "never-treated" and "not-yet-treated" match your definitions? I built them from the terms themselves.
- Does "this staggered timing shapes how we estimate its effect" in the lead sentence match your intent?
- Which outcome does the coefficient of interest measure (for example, repeat purchase), and should the paragraph name it before the coefficient is introduced?
- How is the post-rollout indicator defined when stores were treated on different dates (relative to each store's own rollout date, or a calendar date)? How does it combine with the treatment indicator in the interaction?
- Is the Callaway and Sant'Anna estimator cited elsewhere in the manuscript? No citation appears in this paragraph, and I added none.
- Do you want the paragraph to say outright that the staggered rollout leaves no clean control group? That is your core thesis, but this paragraph never states it, so I did not write it in.