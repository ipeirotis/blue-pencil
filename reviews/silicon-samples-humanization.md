# Humanization review: "Non-LLM Forecasting Baselines for the Silicon-Samples Program"

Applying this repo's `paper-revision-editor` skill (the `references/ai-tells-to-avoid.md`,
`reader-pleasure.md`, and `sentence-cohesion.md` standards) to the attached
9-page report. Goal: make it read less like LLM output and more like prose a
human wrote for human readers.

**Scope and method.** I worked from the compiled PDF, not the LaTeX source, so
this is a diagnosis plus a set of representative before/after rewrites and a
repeatable recipe, not a full source edit. All structure, numbers, math,
notation, and citations are preserved. This is a sentence-level (final-polish)
pass: no paragraph reordering, no structural changes. If you share the `.tex`,
I can apply the full sweep against the source with math and macros treated as
opaque.

**Calibration first, because it matters.** The draft is already past beginner
LLM prose. The crude tells are absent: no *Furthermore / Moreover / Crucially /
Notably*, no *delve*, no *tapestry / myriad / landscape*, no "in today's
fast-paced world." The argument is clear, the structure is sound, and the
figures carry real weight. What is left is the subtler layer that still reads as
machine-written, and it is concentrated in five habits.

---

## 1. Diagnosis

1. **Em-dashes everywhere: 24 in ~2,400 words, roughly one every 100 words.**
   [Summary; throughout §1, §2, §3] This is the strongest single tell. Almost
   every instance is the same "claim, then dash, then gloss" shape: "hardest to
   predict—precisely the event-sensitive cells where...", "no real attitude
   change—an important confound", "the most room either to help—where R is
   low—to fail." The em-dash has become an LLM signature because the model
   reaches for it as a default connector. The skill bans it outright. (Your
   en-dash *ranges* like `3–3.5%`, `2020–21`, `Jensen–Shannon` are correct
   typography; leave those alone.)

2. **Self-narrated significance.** [Summary; §1; §3 "Where forecasting is
   hard," "Per country," "The hardest pairs"] The paper keeps telling the reader
   that a result matters instead of letting the result carry it: "the property
   that **lifts this work above** the existing retrospective demonstrations,"
   "This ordering is **itself informative** for Study B," "The spread is
   **research-relevant**," "is the **most revealing cut**," "This is **directly
   useful** for the program." These labels are interchangeable and removable,
   which is exactly why they read as generated. The fix is the skill's
   importance-signaling move: cut the label, keep the consequence. The
   consequence is the relevance.

3. **Bolded takeaway sentences mid-paragraph (~13 of them).** [mostly §3] Whole
   clauses are set in bold: "**persistence is a strong floor**," "**smoothing
   the sampling noise helps, but only modestly**," "**Economic-perception items
   are the hardest to forecast**," "**the advantage of smoothing grows with the
   length of the history**." Bolding the conclusion of each paragraph is a
   hallmark of LLM and blog output, not journal prose. (Bold *run-in lead-ins*
   like "Task and leakage." and "Metrics." are standard academic style; keep
   those.) A well-built topic sentence already carries the emphasis; the bold is
   doing the job the prose should do.

4. **Intensifier reflex: "genuinely / genuine / exactly / precisely" (10
   times).** [Summary; §1; §3] "genuinely contamination-resistant," "genuine
   generalisation," "precisely the event-sensitive cells," "are precisely the
   ones," "exactly the pattern... predicts," "exactly such fragile/authoritarian
   settings," "exactly the one along which." Each performs precision the
   sentence already has. The claim is equally true with the adverb deleted, and
   the repetition is what trips the reader's detector.

5. **The "Two X [verb]" template, four times.** [§2 "Two caveats"; §3 "Two
   findings stand out," "two lessons emerge," "two patterns dominate"] Four
   passages open by announcing a count and then enumerating. Once, this is a
   clean structure. Four times, it is a mold. Vary the framing or just state the
   two things.

6. **Stray business-speak and filler.** ["Drilling down to..." §3; "an
   **important** confound" twice in §2; "**holistic** detection" §1] "Drilling
   down" is in the navigate/leverage class of dead office metaphor. "important"
   is a promotional adjective the skill bans: a confound is a confound whether or
   not you call it important. "holistic" is on the filler list, though here it
   may name a specific class of joint-distribution metric, so I flag it rather
   than cut it (see Author questions).

7. **A few sentences splice three clauses with a dash plus a semicolon plus a
   trailing gloss.** [§1 "If a frontier LLM—...—cannot beat..., the case... is
   weak; if it can, that is strong evidence..."; §3 final paragraph] When every
   long sentence carries an interrupter, a contrast, and an afterthought, the
   rhythm flattens. Split them, and land the contrast in a short sentence. Uniform
   sentence weight is itself a tell.

---

## 2. Revised text (representative rewrites)

A full clean rewrite needs the source. These show the moves on the worst
offenders; the recipe at the end lets you sweep the rest.

### The Summary, rewritten in full

Before:

> We establish the bar that LLM "silicon samples" must clear: forecasting each
> (country, item) cell's next survey wave from its own history. Across 45 items
> and 168 countries (163 with enough history to backtest), persistence is a
> strong floor (mean TVD ≈ 0.052); exponential smoothing and Theta beat it by
> ∼3.5%. Economic-optimism items, and life evaluation in fragile states, are the
> hardest to predict—precisely the event-sensitive cells where a model with
> post-cutoff world knowledge has the most to prove.

After:

> We establish the bar that LLM "silicon samples" must clear: forecasting each
> (country, item) cell's next survey wave from its own history. Across 45 items
> and 168 countries (163 with enough history to backtest), persistence is a
> strong floor (mean TVD ≈ 0.052); exponential smoothing and Theta beat it by
> ∼3.5%. The hardest cells to predict are economic-optimism items and life
> evaluation in fragile states: the event-sensitive cells where a model with
> post-cutoff world knowledge has the most to prove.

### §1, the prospectivity claim

Before:

> ...it cannot appear in any model's training corpus, which makes the test
> genuinely contamination-resistant and prospective—the property that lifts this
> work above the existing retrospective demonstrations.

After:

> ...it cannot appear in any model's training corpus. The test is therefore
> contamination-resistant and prospective, unlike the retrospective
> demonstrations that dominate the existing literature.

### §1, the central test

Before:

> If a frontier LLM—armed only with its internalised world knowledge and a
> demographic persona—cannot beat a model that has literally seen the country's
> past waves, the case for silicon samples is weak; if it can, that is strong
> evidence of genuine generalisation.

After:

> If a frontier LLM, armed only with its internalised world knowledge and a
> demographic persona, cannot beat a model that has seen the country's past
> waves, the case for silicon samples is weak. If it can, that is strong
> evidence of generalisation.

### §3, the headline result (de-bold, de-template, de-dash)

Before:

> Two findings stand out. First, **persistence is a strong floor**: a mean TVD
> of ≈ 0.052 means next-wave distributions sit very close to the previous
> wave—public attitudes are sticky. Second, **smoothing the sampling noise
> helps, but only modestly**: exponential smoothing and Theta beat persistence
> by about 3–3.5%, while the 3-wave moving average is worse than persistence
> because it lags genuine drift.

After:

> The backtest shows two things. Persistence is already a strong floor: a mean
> TVD of ≈ 0.052 means next-wave distributions sit very close to the previous
> wave, because public attitudes are sticky. Smoothing the sampling noise helps,
> but only modestly: exponential smoothing and Theta beat persistence by about
> 3–3.5%, while the 3-wave moving average is worse than persistence because it
> lags real drift.

### §3, where forecasting is hard (restraint: only the bold comes out)

Before:

> **Economic-perception items are the hardest to forecast** (mean TVD ≈ 0.067):
> standards of living, the job market, and economic optimism move with events.
> **Well-being, community, and behavioural items are the easiest** (≈ 0.045):
> daily affect and prosocial behaviour are stable year to year.

After:

> Economic-perception items are the hardest to forecast (mean TVD ≈ 0.067):
> standards of living, the job market, and economic optimism move with events.
> Well-being, community, and behavioural items are the easiest (≈ 0.045): daily
> affect and prosocial behaviour are stable year to year.

These two sentences are already well-built (topic up front, colon expansion,
payoff at the end). The only change is removing the bold. Not every passage
needs a rewrite.

### §3, the hardest cells

Before:

> Drilling down to individual cells (Table 3) is the most revealing cut, and two
> patterns dominate. ... the Cantril life-evaluation ladder ("Life Today"/"Life
> in Five Years") is hard specifically in fragile, conflict-affected, or
> transition states—Burundi, Djibouti, Afghanistan, Turkmenistan, Zimbabwe—where
> subjective well-being, normally very stable, moves abruptly.

After:

> At the level of individual cells (Table 3), two patterns dominate. ... the
> Cantril life-evaluation ladder ("Life Today"/"Life in Five Years") is hard
> specifically in fragile, conflict-affected, or transition states (Burundi,
> Djibouti, Afghanistan, Turkmenistan, Zimbabwe), where subjective well-being,
> normally very stable, moves abruptly.

### The em-dash recipe (for the remaining ~18)

Replace each em-dash with the option that fits the relationship:

- **Colon** when the second half specifies the first: "TVD values are naturally
  small—a single proportion can only move so far" becomes "...naturally small: a
  single proportion can only move so far."
- **Comma** when the aside is short and tight: "without any real attitude
  change—an important confound" becomes "without any real attitude change, a
  confound" (and drop "important").
- **Parentheses** when the aside is a genuine interruption: the
  "fragile states—Burundi, Djibouti...—where" case above.
- **Two sentences** when both halves can stand alone: the central-test case
  above.
- **A pair of em-dashes** around an interrupter becomes a pair of commas or a
  pair of parentheses: "could help most—or, conversely, where R is low—to fail"
  becomes "could help most, or, where R is low, to fail."

---

## 3. Change rationale

Word count across the rewritten passages: 286 to 250 (-13%). Numbers, notation,
and citations carried over verbatim.

- "hardest to predict—precisely the event-sensitive cells" -> "...hardest to
  predict are economic-optimism items and life evaluation in fragile states: the
  event-sensitive cells", removed em-dash (colon specifies), cut "precisely",
  and reordered so "the most to prove" keeps the stress position.
- "genuinely contamination-resistant and prospective—the property that lifts
  this work above the existing retrospective demonstrations" -> "is therefore
  contamination-resistant and prospective, unlike the retrospective
  demonstrations that dominate the existing literature", removed em-dash
  (sentence split), cut the "genuinely" intensifier, and replaced the
  self-promoting "lifts this work above" with a neutral factual contrast.
- "LLM—armed only with...—cannot beat... has literally seen... weak; if it can...
  genuine generalisation" -> paired em-dashes to commas, "literally" and
  "genuine" cut, semicolon split into two sentences so the contrast lands on a
  short clause.
- "Two findings stand out. First... **bold**... wave—public attitudes... Second...
  **bold**... lags genuine drift" -> "The backtest shows two things..." with the
  template opener changed, inline bold removed, em-dash converted to a causal
  comma, and "genuine drift" to "real drift" (one more intensifier retired).
- The "where forecasting is hard" pair: bold removed only, prose returned
  verbatim, because it already passes the topic-sentence, given-new, and
  stress-position checks.
- "Drilling down to individual cells (Table 3) is the most revealing cut, and"
  -> "At the level of individual cells (Table 3),", replaced the dead "drilling
  down" metaphor and cut the "most revealing cut" significance label; the
  fragile-states em-dash pair became parentheses.

No numerical claim, p-value, effect size, sample size, figure callout, or
citation was altered.

---

## 4. Author questions

- Do you have the LaTeX source you want me to edit directly? I worked from the
  PDF, so I gave targeted rewrites plus the recipe rather than a source edit.
  With the `.tex` I can sweep all 24 em-dashes, the bold runs, and the
  intensifier tics against the source with math and macros left opaque.
- Is the inline bold load-bearing, that is, do you want a skim path for a busy
  PI or program audience? If so, one bold topic phrase per subsection reads far
  less like LLM output than bolding the concluding clause of every paragraph. If
  not, I would remove it entirely.
- "holistic detection" in §1: does "holistic" name a specific class of
  joint-distribution metric (in which case keep it and define on first use), or
  is it a general descriptor (in which case cut it)?
- "genuine generalisation" and "genuine extrapolation": do these distinguish
  real generalisation from a coincidental distributional match? If so, keep
  "genuine" once and make the contrast explicit; if it is emphasis, cut it.
- Did I read the stage right? I treated this as a near-final report for a
  technical audience and changed only sentence-level style, preserving all
  structure and numbers. Do you also want a structural pass (for example, the
  Summary could state the one-sentence punchline of Study A before the metrics)?
- The Study B fidelity equation and the CLR/softmax definitions render with
  spacing artifacts in PDF extraction; I left all math untouched. Can you
  confirm they compile as intended, since I could not see the source?
