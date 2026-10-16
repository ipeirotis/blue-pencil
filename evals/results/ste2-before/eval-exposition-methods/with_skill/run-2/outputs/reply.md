### 1. Diagnosis

Assumed context: none assumed. `audience`, `revision_stage` (first draft), `target_venue`, and `core_thesis` all come from the AGENTS.md `<paper_context>` block. The dispatch carries no `style_overrides:` line, so house style applies in full.

Voice tics:
- First-person plural with plain active verbs ("We estimate", "we use", "we report").
- Terms spelled out in full and repeated verbatim, with no abbreviations ("two-way fixed effects" appears twice).
- Hyphenated compound labels (never-treated, not-yet-treated, post-rollout).
- Short declarative sentences for the specification, one long sentence for the design logic.
- "alongside" as the connective for reporting two estimators.

Reader map: the reader is a trained marketing quantitativist who knows fixed effects and clustering but not staggered-adoption estimators. They must learn that the stores' different rollout dates supply the control group (never-treated and not-yet-treated stores) and why a second estimator is reported. They should leave with the design logic first, then the specification, then why two estimators appear.

Jargon to unpack: "never-treated and not-yet-treated" (the controls are named, never defined). "Heterogeneity in treatment timing" (an abstract noun stack). "Post-rollout indicator" (what switches it on is unstated, so it goes to Author questions).

Buried lede: the design logic sits in the last sentence, after the model and specification. That logic is that the program reached stores on different dates, so untreated stores serve as controls at each date.

Concrete anchor: the loyalty program's rollout to stores on different dates, which the author already states.

1. [P1] Machinery before motive. The model, controls, and coefficient arrive before the reader learns why a control group exists at all. The reason is the staggered rollout, and it comes last.
2. [P1] Definition debt. "Never-treated" and "not-yet-treated" are used as controls with no gloss. A reader new to staggered designs cannot tell the two groups apart.
3. [P1] Abstract stack. "Heterogeneity in treatment timing" names the issue in the form an expert has internalised. A plain statement of what varies (when stores were treated) is already implied by the paragraph.
4. [P1] Compressed inference. The paragraph never says why two-way fixed effects alone is not enough under staggered timing, or what the Callaway and Sant'Anna estimator does differently. The manuscript lacks this material, so it goes to Author questions rather than being written in.
5. [P1] Left-branching preamble. The last sentence opens with a "Because" clause, then packs two coordinate main clauses (controls; second estimator) behind it. The core "we use ... controls" is held off, and the sentence ends on the weakest word, "timing", rather than on a payoff.
6. [P1] Altitude. The estimation detail sits in Methods, which is its home, so nothing is relocated. Sentences 2 and 3 pass the restraint checks and are returned verbatim.

### 2. Revised text

```
The loyalty program was rolled out to stores on different dates, so at any given time some stores have it and others do not yet. We use two groups of stores as controls: the never-treated stores, which never receive the program, and the not-yet-treated stores, which receive it on a later date. We estimate a two-way fixed effects model with store and week fixed effects, clustering standard errors at the store level. The specification includes controls for foot traffic, local unemployment, and promotional intensity. The coefficient of interest is the interaction between the post-rollout indicator and the treatment indicator. We also report the Callaway and Sant'Anna estimator alongside the two-way fixed effects estimate, to address the differences across stores in when treatment began.
```

Added bridges: "so at any given time some stores have it and others do not yet"; "the never-treated stores, which never receive the program, and the not-yet-treated stores, which receive it on a later date".

### 3. Change rationale

Word count: ~90 to ~125 (+40%). The rewrite grew because the request asks for terms a new reader cannot yet parse to be unpacked. The additions are one design-logic sentence and two glosses, all derived from the paragraph's own statements about different rollout dates and the two control groups.

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Skipped: precision-budget.md (not an abstract, introduction, or contribution paragraph, and no hedge was added or removed). cold-read.md and consistency-checks.md belong to the whole-paper passes and were not loaded. Altitude, narrative-spine, and reader-pleasure ran and produced no relocation or added narrative.

- Final sentence's "Because the loyalty program was rolled out to stores on different dates" became the opening sentence "The loyalty program was rolled out to stores on different dates, so at any given time some stores have it and others do not yet". This moves the question before the machinery and puts the design logic ahead of the specification. The new clause is derived from the different rollout dates and is logged under Added bridges.
- "we use the never-treated and not-yet-treated stores as controls" became "We use two groups of stores as controls: the never-treated stores, which never receive the program, and the not-yet-treated stores, which receive it on a later date". Both terms are now defined at first serious use. The colon form keeps "use ... as controls" together instead of holding "as controls" behind two parentheticals.
- "to address heterogeneity in treatment timing" became "to address the differences across stores in when treatment began". This translates the abstract noun stack into the concrete variation (when each store was treated) already established in sentence 1.
- "Because ..., we use ..., and we report ..." is now a design sentence, a controls sentence, and a closing estimator sentence. This removes the left-branching preamble and the two coordinate clauses stacked behind it.
- "we report ... alongside ..." became "We also report ... alongside ...". The second estimator now reads as an addition to the model just described, so the paragraph ends on why it is reported rather than on a procedure.
- Sentences 1 to 3 of the original (model, specification controls, coefficient of interest) are unchanged apart from their new position. They clear all restraint checks, and the position is the only edit.
- No numbers, statistics, or citations appeared in the paragraph, and none were added or changed. No cuts: every original clause is retained in the rewrite.

### 4. Author questions

- Does the paragraph need one sentence saying why two-way fixed effects alone is not enough when stores are treated at different dates, and what the Callaway and Sant'Anna estimator does differently? The manuscript contains neither, and this is the main remaining barrier for a reader new to staggered designs.
- By "heterogeneity in treatment timing", do you mean only that stores were treated on different dates, or also that treatment effects may differ across rollout cohorts or over time? I rendered it as "differences across stores in when treatment began" and will revise if you mean the second.
- Please confirm the two added bridges: "at any given time some stores have it and others do not yet", and the glosses "never receive the program" and "receive it on a later date". Do they match your design?
- What exactly switches on the post-rollout indicator, and what does the treatment indicator mark (stores that ever receive the program)? A reader new to staggered designs will need that to follow the coefficient of interest, and the paragraph does not say.
- Should the paragraph name the outcome (repeat purchase) and say that the coefficient of interest estimates the program's effect on it? Neither appears in the paragraph, so I did not add them.
- Should the Callaway and Sant'Anna estimator carry a citation here? The original has none, and I added none.
- Do you want the paragraph to state the tension in your core thesis, that the rollout offers no clean control group and the staggered timing is what supplies controls? The paragraph does not say this, so I did not supply it.