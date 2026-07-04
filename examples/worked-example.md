# Worked example

A complete run of the skill on a realistic draft, so you can see what the
four-section output looks like before you invoke it on your own paper. The
input is a flawed opening to an introduction; the output is exactly what the
skill returns, under the strict format in `SKILL.md`.

This is also a quality anchor: the output below honors every constraint in the
skill. No em-dash, no banned transition, no throat-clearing, citations and
numbers preserved, cuts logged, and ambiguous claims flagged as questions
rather than silently rewritten.

## Scenario

The paper repo carries this context (in `AGENTS.md`):

```
<paper_context>
target_venue: Information Systems Research
audience: empirical IS researchers
core_thesis: A reviewer's identity, not just the rating, shapes how much an online review moves sales.
revision_stage: first draft
</paper_context>
```

The request:

> Here is the opening of my introduction. Can you tighten it and make it flow?

## Input

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

## Triage

Before diagnosing, the skill confirms scope, unit, and aggressiveness in one
short message. This triage is not part of the strict four-section return; it
comes first.

> Scope: direct rewrite, not feedback only. Unit: the two paragraphs you pasted.
> Aggressiveness: the stage is `first draft`, so I will reorder, merge, and cut
> where the argument needs it, not just polish sentences. Proceeding on that
> basis.

## Skill output

The strict four-section return, exactly as `SKILL.md` requires: these four
headings, in this order, and nothing else.

### 1. Diagnosis

Voice tics: first-person plural for the authors' own work; author-year
citations grouped in one parenthetical; effects stated as concrete numbers
(the 5-9% figure, the 1.2 million reviews).

Reader map: starts with knowing that online reviews move sales; must learn
that who wrote the review, not just the star rating, changes how much it moves
sales; should leave with reviewer identity as a lever a platform can act on,
not just metadata.

Jargon to unpack: none. The draft's obstacle is throat-clearing and hedging,
not technical vocabulary; no term arrives before the reader knows its role.

Buried lede: the paper's own question, whether who wrote a review changes how
much it moves sales, sits in the last sentence of P1 under a hedge stack; the
rewrite moves it to the front of the claim sequence.

Concrete anchor: the 5-9% revenue effect and the 1.2 million reviews, both
already in the draft, which the rewrite keeps as the concrete stakes attached
to the identity question.

1. [P1] The paragraph opens with throat-clearing and a generic platitude; the
   reader does not see the paper's actual question until the final sentence.
2. [P1] Three bolted-on transitions (Furthermore, Moreover, Crucially) carry
   connections that the content should carry through given-new order.
3. [P1] The contribution is buried under a hedge stack ("to the best of our
   knowledge, somewhat underexplored"), draining the one sentence that should
   land hardest.
4. [P1, P2] Passive nominalizations ("an investigation ... was conducted",
   "The results of our analysis demonstrate") hide the actors; active verbs are
   shorter and clearer.
5. [P2] "significant effect" is ambiguous between statistical and practical
   significance; flagged for the author rather than rewritten.
6. [P2] "comprising of" is ungrammatical, and "important implications" is
   promotional filler.
7. [P1, P2] Both paragraphs end on procedure or generic claims rather than a
   payoff; an introduction should land on what is at stake.

### 2. Revised text

```
Online platforms have changed how consumers decide what to buy, and reviews are
part of that decision: a one-star increase leads to a 5-9% increase in revenue
(Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). What these
studies leave open is who wrote the review. We ask whether a reviewer's
identity changes how much the review moves sales.

To answer this, we use a dataset of 1.2 million reviews. Reviewer identity has a
significant effect. For platform design, managers should consider highlighting
reviewer credentials.
```

Added bridges: None.

### 3. Change rationale

Word count: ~139 to ~86 (-38%).

"It is important to note that the proliferation of online platforms has
fundamentally transformed the way in which consumers make purchasing decisions"
-> "Online platforms have changed how consumers decide what to buy", removed
throat-clearing and "the way in which"; concrete subject, active verb.

"Furthermore ... Moreover ... Crucially" -> removed; the connections now ride on
given-new order instead of connectives bolted on the front.

"an investigation ... was conducted by several researchers" plus the trailing
citation group -> folded into the sentence stating the effect size; citations
kept and grouped inside the claim they support.

"reviews matter, a one-star increase leads to a 5-9% increase in revenue" ->
"reviews are part of that decision: a one-star increase leads to a 5-9% increase
in revenue", colon repairs the comma splice; the numerical claim itself ("a
one-star increase leads to a 5-9% increase in revenue") is carried over word for
word, since numerical claims are never edited.

"the question of whether the identity of reviewers affects this relationship
remains, to the best of our knowledge, somewhat underexplored in the existing
literature" -> "What these studies leave open is who wrote the review. We ask
whether a reviewer's identity changes how much the review moves sales", removed
the hedge stack and put the contribution in the stress position as a short,
direct claim.

"In order to investigate this question, we leverage a novel dataset comprising
of" -> "To answer this, we use a dataset of", tightened "in order to" to "to"
and "leverage" to "use", fixed the ungrammatical "comprising of", and dropped
the promotional adjective "novel" rather than swapping it for a synonym; if the
dataset's novelty is part of the contribution, that is raised in Author
questions.

"The results of our analysis demonstrate that reviewer identity has a
significant effect" -> "Reviewer identity has a significant effect", removed only
the nominalization wrapper; the claim is left exactly as underspecified as the
author wrote it (both "significant" and the unstated outcome), with both gaps
raised in Author questions rather than filled in.

"It should be noted that this finding has important implications for platform
design: managers should consider highlighting reviewer credentials" -> "For
platform design, managers should consider highlighting reviewer credentials",
removed throat-clearing and the promotional "important implications"; the
author's recommendation, including its tentative "should consider" modality, is
kept unchanged.

### 4. Author questions

- "significant effect" is underspecified in two ways: do you mean statistically
  significant, practically large, or both, and an effect on which outcome (sales,
  helpfulness, something else)? I kept your wording and filled neither gap; how
  should the final text read?
- Should "1.2 million reviews" name the platform and time window so the reader
  can judge representativeness?
- Is the dataset's novelty part of your contribution, and if so, should the
  introduction state what makes it new rather than rely on the adjective "novel"
  I removed?
- The implication is framed for "managers"; do you also want to name the
  platform-side action, or keep the managerial framing as written?

## What this demonstrates

- **Orientation early.** The rewrite cuts the opening platitude and surfaces the
  paper's question by the second sentence, where the draft had buried it under
  hedges at the very end of the paragraph.
- **Transitions from content.** The banned connectives are gone; each sentence
  hands the next its subject through given-new order.
- **Numbers and claims are protected.** The whole effect-size claim ("a one-star
  increase leads to a 5-9% increase in revenue") and "1.2 million" are carried
  over word for word, and the citation group is preserved; the editor tightens
  the prose around the claim without touching the claim itself.
- **Ambiguous claims are flagged, not resolved.** The author's underspecified
  "significant effect" is kept exactly as written, with both the kind of
  significance and the missing outcome raised as questions rather than guessed.
- **Author framing is preserved.** The managerial recommendation stays, modality
  and all; the rewrite drops the throat-clearing around it without changing who
  acts, softening or hardening the recommendation, or inventing a new claim.
- **Triage first.** The skill confirms scope, unit, and aggressiveness in a short
  message before the four-section return, rather than jumping straight into
  edits.
- **Subtraction by test.** The cut is 38%, logged line by line, with no content
  removed without a stated reason.
