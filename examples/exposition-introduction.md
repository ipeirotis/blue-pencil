# Exposition example: introduction

A technically correct introduction that assumes the reader already knows the
theoretical gap. Every sentence is true and the citations are real, but a reader
who is an empirical economist outside this exact subfield cannot say why the
question is hard or what the paper changes. The exposition pass surfaces the gap and
makes the reader payoff visible, using only material the draft already contains. The
output follows the strict four-section format in `SKILL.md`.

## Scenario

```
<paper_context>
target_venue: Management Science
audience: empirical economists and IS researchers
core_thesis: Platforms moderate reviews unequally, and that unequal moderation is what lets us identify the causal effect of a review's valence on sales.
revision_stage: first draft
</paper_context>
```

The request:

> Here is my introduction's opening. Is it clear enough for a general Management
> Science reader, or does it assume too much?

## Input

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

## Triage

> Scope: feedback plus a direct rewrite of the opening. Unit: the paragraph you
> pasted. Aggressiveness: stage is `first draft`, so I will reorder and add short
> bridges from material already in the paragraph, not just polish sentences.
> Proceeding on that basis.

## Skill output

### 1. Diagnosis

Voice tics: first-person plural for the authors' own work; precise counts stated as
figures (3.4 million); methodological vocabulary used without hedging.

Reader map: starts with knowing that reviews and sales are correlated; must learn
why that correlation does not establish a causal effect and how unequal platform
moderation breaks the deadlock; should leave able to say that the paper turns a
nuisance (uneven moderation) into the very thing that identifies the effect.

Jargon to unpack: "exogenous variation" and "quasi-random assignment", both used as
the design's load-bearing terms before the reader is told, in plain words, why
moderation differing across review cohorts would isolate the effect.

Buried lede: uneven platform moderation, normally a nuisance, is exactly what lets
the paper compare otherwise similar reviews that fall into differently moderated
cohorts and identify the causal effect of valence on sales.

Concrete anchor: platforms applying moderation differently across review cohorts,
already in the draft, which the rewrite turns into the picture of otherwise similar
review cohorts that received different moderation, keeping assignment at the cohort
level the manuscript specifies.

1. [P1] Machinery before motive: the paragraph opens on "endogeneity of review
   valence" and "identification" before the reader knows what question those terms
   serve. A general reader cannot tell what is at stake by sentence two.
2. [P1] Definition debt: "content moderation as a source of exogenous variation"
   asserts the design without saying, in plain terms, why moderation differing
   across reviews would isolate the effect. The inferential bridge (B and C between
   A and D) is missing.
3. [P1] Expert-only contrast: "improves upon prior approaches that rely on
   instrumental variables of questionable validity" names a contrast only a
   specialist can see. The paragraph does not say what was wrong with those
   instruments or what this design does instead.
4. [P1] Compressed inference: "differentially apply moderation policies across
   review cohorts, which generates quasi-random assignment" skips the step that
   makes it quasi-random. The reader is told the conclusion, not shown the logic.
5. [P1] Payoff leakage: the paragraph ends on a methodological self-comparison
   rather than on what the reader now understands about reviews and sales.

### 2. Revised text

```
A review's valence, how positive its rating is, moves with sales, but that does not
mean valence drives sales: a better product earns both higher ratings and more
buyers, so the correlation could be product quality talking, not the valence.
Breaking that deadlock needs variation in valence that is unrelated to the product.
We find it in how platforms moderate.
Platforms apply different moderation policies to different cohorts of reviews, and
among cohorts that look alike on what we observe, which policy a cohort gets is set
by platform rules rather than by the product. That lets us compare otherwise similar
reviews in differently moderated cohorts and read off the effect of a review's
valence. On 3.4 million
reviews, the effect is positive and significant. Where earlier work leaned on
instruments whose validity was contested, here the variation comes from the
platform's own moderation behaviour rather than from a constructed instrument.
```

### 3. Change rationale

Word count: 89 to 151 (+70%). The rewrite is longer because the draft's
identification logic was compressed to an assertion; the added sentences are the
inferential bridge, built only from claims already in the paragraph (moderation
varies by policy, the dataset, the prior-work contrast). Flagged for the author
under the length budget.

"The endogeneity of review valence with respect to unobserved product quality is a
well-known obstacle to identification" -> "A review's valence, how positive its rating
is, moves with sales, but that does not mean valence drives sales: a better product
earns both higher ratings and more buyers", moved the question before the machinery,
defined the estimand "valence" at first use, and translated the abstract term
"endogeneity" into the concrete mechanism it denotes.

"We exploit platform-level heterogeneity in content moderation as a source of
exogenous variation ... generates quasi-random assignment conditional on observed
covariates" -> "Platforms apply different moderation policies to different cohorts of
reviews, and among cohorts that look alike on what we observe, which policy a cohort
gets is set by platform rules rather than by the product", restored the missing
inference while keeping the draft's cohort-level unit and its "conditional on observed
covariates" qualifier, so the bridge explains the design without changing the
assignment unit or strengthening the identifying assumption beyond what the input
claims.

"Our identification strategy improves upon prior approaches that rely on
instrumental variables of questionable validity" -> "Where earlier work leaned on
instruments whose validity was contested, here the variation comes from the
platform's own moderation behaviour rather than from a constructed instrument",
exposed the structure of the contrast (contested instrument validity versus the
platform's own moderation) at the level the input supports, without inventing which
validity condition the prior instruments failed or claiming the moderation is
directly observed when the draft does not say so.

"estimate the effect" -> "read off the effect of a review's valence", carried the
draft's estimand ("review valence") into the payoff rather than generalising it to
"the review", since valence, review presence, and review content are different
treatments.

"find it to be positive and significant" -> "the effect is positive and
significant", kept the author's claim exactly as written, including its
underspecified "significant"; the gap is raised in Author questions rather than
filled.

### 4. Author questions

- "positive and significant": do you mean statistically significant, practically
  large, or both, and significant for which outcome (units sold, revenue)? I kept
  your wording and filled neither gap; how should it read?
- The bridge I added says moderation "turns on platform policy rather than on the
  product". Is that the actual exclusion logic, or does moderation also respond to
  review content in a way the reader should be warned about here?
- The draft's endogenous variable is "review valence", which I carried into the
  payoff; does the paper study the effect of a review's valence specifically, or of
  review presence or content, which would be different treatments?
- Which validity condition did the prior instruments fail (relevance, the exclusion
  restriction, monotonicity, measurement)? I kept the contrast general ("contested
  validity") rather than name a specific weakness the draft does not state; what
  exactly was wrong?
- Should the introduction name the platforms and the time window for the 3.4
  million reviews so the reader can judge how far the identification generalises?
- Is there a phrase you want readers to carry away for this design (the way "natural
  experiment" travels), given the paper currently has a method but no handle for it?

## What this demonstrates

- **Question before machinery.** The rewrite opens on the causal puzzle a general
  reader can feel (correlation is not causation here) before any term of art arrives.
- **Restored inference, not smoother assertion.** The draft asserted quasi-random
  assignment; the rewrite shows the step that makes it so, using only the draft's
  own claim that moderation follows policy, and it keeps the draft's "conditional on
  observed covariates" qualifier rather than strengthening the assumption to hold
  unconditionally.
- **Contrast made legible, not invented.** "Instruments of questionable validity"
  becomes a contrast a non-specialist can see (contested instrument validity versus
  the platform's own moderation), while which validity condition failed is left as an
  Author question rather than guessed.
- **The bridge is flagged, not trusted.** The added exclusion logic is surfaced for
  the author to confirm, because an exposition edit may expose an idea on the page
  but must not invent the identification argument.
