# Exposition example: methods

A methods paragraph that opens with machinery: the estimator, the specification, and
the controls arrive before the reader knows what identifies the effect or why this
design is the right one. The exposition pass moves the identification logic ahead of
the implementation, using only material the draft already states. The output follows
the strict four-section format in `SKILL.md`.

## Scenario

```
<paper_context>
target_venue: Journal of Marketing Research
audience: quantitative marketing researchers
core_thesis: A staggered rollout of a loyalty program lets us estimate its effect on repeat purchase without a clean control group.
revision_stage: first draft
</paper_context>
```

The request:

> Can you make my estimation paragraph readable for someone who does not already
> work with staggered designs?

## Input

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

## Triage

> Scope: direct rewrite. Unit: the one paragraph you pasted. Aggressiveness: stage
> is `first draft`, so I will reorder the paragraph to put the identification logic
> before the specification, and add a short bridge sentence from material already
> present. Proceeding on that basis.

## Skill output

### 1. Diagnosis

Voice tics: first-person plural for the authors' own analysis; named estimators
cited by author (Callaway and Sant'Anna); controls listed in a compact series.

Reader map: starts with knowing the program might raise repeat purchase but having
no obvious control group; must learn that stores adopting the program on different
dates supply each other's controls; should leave able to say what makes the
comparison credible before they see the regression that implements it.

1. [P1] Machinery before motive: the paragraph opens on the two-way fixed effects
   specification and its controls before the reader knows what identifies the
   effect. The "why this design" arrives only in the last sentence.
2. [P1] Intuition before formalism is inverted: the staggered-rollout idea, which is
   the whole reason the design works, is the last thing stated, after the estimator,
   the clustering, and the controls.
3. [P1] Definition debt: "never-treated and not-yet-treated stores as controls" uses
   the design's vocabulary before the reader has the picture (some stores have the
   program, some do not yet, and timing differs) that makes those labels mean
   something.
4. [P1] Compressed inference: the paragraph reports the Callaway and Sant'Anna
   estimator "to address heterogeneity in treatment timing" without saying why
   staggered timing threatens the simple estimate, so the reader cannot tell what
   problem the second estimator solves.

### 2. Revised text

```
The loyalty program has no clean control group: every store eventually gets it. What
saves the comparison is timing. Stores adopted the program on different dates, so on
any given week some stores already have it and others do not yet, and a store that
has not yet adopted stands in as a control for one that has. That is what we
estimate: comparing repeat purchase at adopting stores against stores not yet
adopting, before and after each rollout date. We implement it with a two-way fixed
effects model with store and week fixed effects, controlling for foot traffic, local
unemployment, and promotional intensity, and we cluster standard errors at the store
level. Because the simple two-way estimate can be biased when stores adopt at
different times, we also report the Callaway and Sant'Anna estimator, which compares
each adopting group only against stores not yet treated.
```

### 3. Change rationale

Word count: 96 to 134 (+40%). The rewrite is longer because the draft stated the
identification idea in one trailing clause; the added sentences move it to the front
and unpack it, using only facts already in the paragraph (staggered dates,
not-yet-treated controls, timing heterogeneity). Flagged under the length budget.

"We estimate a two-way fixed effects model ... The coefficient of interest is the
interaction ..." (opening) -> moved after the identification logic; the
specification now follows the question it answers rather than leading the paragraph.

"Because the loyalty program was rolled out to stores on different dates, we use the
never-treated and not-yet-treated stores as controls" -> "Stores adopted the program
on different dates, so on any given week some stores already have it and others do
not yet, and a store that has not yet adopted stands in as a control for one that
has", put the intuition before the formalism and translated "not-yet-treated" into
the picture it names.

"report the Callaway and Sant'Anna estimator alongside the two-way fixed effects
estimate to address heterogeneity in treatment timing" -> "Because the simple
two-way estimate can be biased when stores adopt at different times, we also report
the Callaway and Sant'Anna estimator, which compares each adopting group only
against stores not yet treated", restored the missing inference: named why staggered
timing threatens the simple estimate so the reader sees what the second estimator is
for.

### 4. Author questions

- The bridge I added says "a store that has not yet adopted stands in as a control".
  Is the not-yet-treated group your actual comparison set throughout, or only for
  the Callaway and Sant'Anna estimate? I want the intuition to match the design.
- Should the paragraph state the identifying assumption (parallel trends in repeat
  purchase absent the program) explicitly, or is that argued elsewhere?
- Are foot traffic, local unemployment, and promotional intensity measured at the
  store-week level? The controls read as time-varying, but the draft does not say,
  and it affects how a reader reads the fixed effects.

## What this demonstrates

- **Question before machinery.** The estimator and its controls now follow the
  identification idea instead of leading it; the reader knows what makes the
  comparison credible before they see the regression that implements it.
- **Intuition before formalism.** The staggered-rollout picture, the engine of the
  whole design, moves from the last clause to the first sentences.
- **Vocabulary earned, not assumed.** "Not-yet-treated controls" arrives only after
  the reader has the picture that gives the label meaning.
- **The added bridge is flagged.** The control-group intuition the rewrite makes
  explicit is raised for the author to confirm, since the draft stated it only in
  passing.
