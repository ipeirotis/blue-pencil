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

To answer this, we use a new dataset of 1.2 million reviews. Reviewer identity
has a significant effect on sales. For platform design, managers should consider
highlighting reviewer credentials.
```

### 3. Change rationale

Word count: 130 to 80 (-38%).

- "It is important to note that the proliferation of online platforms has
  fundamentally transformed the way in which consumers make purchasing
  decisions" -> "Online platforms have changed how consumers decide what to
  buy", removed throat-clearing and "the way in which"; concrete subject, active
  verb.
- "Furthermore ... Moreover ... Crucially" -> removed; the connections now ride
  on given-new order instead of connectives bolted on the front.
- "an investigation ... was conducted by several researchers" plus the trailing
  citation group -> folded into the sentence stating the effect size; citations
  kept and grouped inside the claim they support.
- "reviews matter, a one-star increase leads to a 5-9% increase in revenue" ->
  "reviews are part of that decision: a one-star increase leads to a 5-9%
  increase in revenue", colon repairs the comma splice; the numerical claim
  itself ("a one-star increase leads to a 5-9% increase in revenue") is carried
  over word for word, since numerical claims are never edited.
- "the question of whether the identity of reviewers affects this relationship
  remains, to the best of our knowledge, somewhat underexplored in the existing
  literature" -> "What these studies leave open is who wrote the review. We ask
  whether a reviewer's identity changes how much the review moves sales",
  removed the hedge stack and put the contribution in the stress position as a
  short, direct claim.
- "In order to investigate this question, we leverage a novel dataset comprising
  of" -> "To answer this, we use a new dataset of", tightened "in order to" to
  "to", "leverage" to "use", and fixed the ungrammatical "comprising of".
- "The results of our analysis demonstrate that reviewer identity has a
  significant effect" -> "Reviewer identity has a significant effect on sales",
  removed the nominalization and supplied the missing referent; "significant" is
  kept verbatim and the ambiguity is flagged, not resolved (see Author
  questions).
- "It should be noted that this finding has important implications for platform
  design: managers should consider highlighting reviewer credentials" -> "For
  platform design, managers should consider highlighting reviewer credentials",
  removed throat-clearing and the promotional "important implications"; the
  author's recommendation, including its tentative "should consider" modality, is
  kept unchanged.

### 4. Author questions

- "significant effect" is ambiguous: do you mean statistically significant,
  practically large, or both? I kept your wording and did not resolve it; should
  the final text say which?
- Should "1.2 million reviews" name the platform and time window so the reader
  can judge representativeness?
- The implication is framed for "managers"; do you also want to name the
  platform-side action, or keep the managerial framing as written?

## What this demonstrates

- **Orientation first.** The rewrite leads with the paper's question instead of
  a platitude, so the reader knows what is being answered from the first line.
- **Transitions from content.** The banned connectives are gone; each sentence
  hands the next its subject through given-new order.
- **Numbers and claims are protected.** The whole effect-size claim ("a one-star
  increase leads to a 5-9% increase in revenue") and "1.2 million" are carried
  over word for word, and the citation group is preserved; the editor tightens
  the prose around the claim without touching the claim itself.
- **Ambiguous claims are flagged, not resolved.** The author's "significant" is
  kept as written and raised as a question rather than rewritten into a stronger
  or weaker claim.
- **Author framing is preserved.** The managerial recommendation stays, modality
  and all; the rewrite drops the throat-clearing around it without changing who
  acts, softening or hardening the recommendation, or inventing a new claim.
- **Triage first.** The skill confirms scope, unit, and aggressiveness in a short
  message before the four-section return, rather than jumping straight into
  edits.
- **Subtraction by test.** The cut is 38%, logged line by line, with no content
  removed without a stated reason.
