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

Jargon to unpack: "two-way fixed effects", "never-treated and not-yet-treated", and
the "Callaway and Sant'Anna" estimator, each named before the reader has the picture
that makes the label mean something.

Buried lede: stores adopt the program on different dates, so never-treated and
not-yet-treated stores both supply controls for the already-treated ones, and that
staggered timing, not the estimator, is what makes the comparison credible.

Concrete anchor: the stores in the draft that adopted on different dates, together
with the never-treated and not-yet-treated stores that serve as controls, which the
rewrite uses to build the picture before the specification.

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
Stores adopted the program on different dates, so on any given week some already have
it while others do not, either because they adopt later or never adopt at all. Those
not-yet-treated and never-treated stores are the controls. We compare repeat purchase
at adopting stores against them before and after each rollout date, reading the effect
off the interaction between the post-rollout and treatment indicators. We estimate it
with a two-way fixed effects model with store and week fixed effects, controlling for
foot traffic, local unemployment, and promotional intensity, and cluster standard
errors at the store level. Because that simple two-way estimate can be biased when
adoption is staggered, we also report the Callaway and Sant'Anna estimator, which is
built for staggered adoption.
```

Added bridges: "Because that simple two-way estimate can be biased when adoption is
staggered, we also report the Callaway and Sant'Anna estimator, which is built for
staggered adoption." Unpacks the draft's own "to address heterogeneity in treatment
timing"; confirmed in Author questions.

### 3. Change rationale

Word count: 88 to 123 (+40%). The rewrite is longer because the draft compressed the
identification logic into trailing clauses; the added sentences move it to the front
and unpack it, using only facts already in the paragraph (staggered dates, the
never-treated and not-yet-treated controls, the interaction estimand, timing
heterogeneity). No technical claim is dropped. Flagged under the length budget.

"(opening)" -> "Stores adopted the program on different dates", promoted from material
already in the paragraph ("rolled out to stores on different dates") to open on the
identification problem. The draft itself never states why a clean comparison is hard;
whether the missing motivation ("no clean control group") should be added is raised in
Author questions rather than imported from the paper's context metadata, which is not
manuscript text.

"We estimate a two-way fixed effects model ..." and "The coefficient of interest is
the interaction between the post-rollout indicator and the treatment indicator" ->
moved after the identification logic and kept intact; the specification and its
estimand now follow the question they answer rather than leading the paragraph. The
interaction is preserved as the coefficient of interest, not dropped.

"Because the loyalty program was rolled out to stores on different dates, we use the
never-treated and not-yet-treated stores as controls" -> "Stores adopted the program
on different dates, so on any given week some already have it while others do not,
either because they adopt later or never adopt at all. Those not-yet-treated and
never-treated stores are the controls", put the intuition before the formalism and
unpacked the labels while keeping both the never-treated and not-yet-treated control
groups the draft named.

"report the Callaway and Sant'Anna estimator alongside the two-way fixed effects
estimate to address heterogeneity in treatment timing" -> "Because that simple
two-way estimate can be biased when adoption is staggered, we also report the
Callaway and Sant'Anna estimator, which is built for staggered adoption", restored
the missing inference (why staggered timing threatens the simple estimate) without
specifying which control group the second estimator uses, since the draft does not
say.

### 4. Author questions

- The paragraph never states why a clean comparison is hard (the paper context calls
  it the lack of a clean control group, but that is metadata, not manuscript text):
  do you want the paragraph to open on that motivation, and if so, how would you
  state it?
- The draft does not say whether the Callaway and Sant'Anna estimate should compare
  against never-treated stores, not-yet-treated stores, or both, and the choice
  changes the estimand, so which did you intend?
- Should the paragraph state the identifying assumption (parallel trends in repeat
  purchase absent the program) explicitly, or is that argued elsewhere?
- Are foot traffic, local unemployment, and promotional intensity measured at the
  store-week level, as the time-varying reading assumes, or at the store level?
- I explained the second estimator by saying the simple two-way estimate "can be
  biased when adoption is staggered", unpacking your "to address heterogeneity in
  treatment timing": is that the threat you had in mind?

## What this demonstrates

- **Question before machinery.** The estimator and its controls now follow the
  identification idea instead of leading it; the reader knows what makes the
  comparison credible before they see the regression that implements it.
- **Intuition before formalism.** The staggered-rollout picture, the engine of the
  whole design, moves from the last clause to the first sentences.
- **Vocabulary earned, not assumed.** The "not-yet-treated" and "never-treated"
  labels arrive only after the reader has the picture that gives them meaning.
- **Protected claims preserved.** Both control groups the draft named (not-yet-treated
  and never-treated) and the interaction estimand are carried into the rewrite, not
  dropped; the pass reorders and explains the technical content without removing any
  of it.
- **Nothing invented to fill a gap.** Where the draft is silent (why a clean
  comparison is hard, whether assignment was random, which control group the Callaway
  and Sant'Anna estimate uses), the rewrite stays silent and raises the point in
  Author questions rather than importing it from context metadata or inventing a
  design detail to make the prose flow.
