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

## Skill output

### 1. Diagnosis

Voice tics: first-person plural for the authors' own work; author-year
citations grouped in one parenthetical; effects stated as concrete numbers
(the 5-to-9% figure, the 1.2 million reviews).

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
part of that decision: a one-star increase raises revenue by 5 to 9%
(Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). What these
studies leave open is who wrote the review. We ask whether a reviewer's
identity changes how much the review moves sales.

To answer this, we use a new dataset of 1.2 million reviews. Reviewer identity
does move sales, and the size of the effect depends on who the reviewer is. The
result gives platforms a concrete lever: surface the reviewer credentials that
buyers actually weigh.
```

### 3. Change rationale

Word count: 129 to 93 (-28%).

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
  "reviews are part of that decision: a one-star increase raises revenue by 5 to
  9%", colon repairs the comma splice; active "raises".
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
  significant effect" -> "Reviewer identity does move sales, and the size of the
  effect depends on who the reviewer is", removed the nominalization and the
  ambiguous "significant" (see Author questions).
- "It should be noted that this finding has important implications for platform
  design: managers should consider highlighting reviewer credentials" -> "The
  result gives platforms a concrete lever: surface the reviewer credentials that
  buyers actually weigh", removed throat-clearing and the promotional "important
  implications"; the paragraph now ends on a payoff.

### 4. Author questions

- I reformatted the effect size "5-9%" as "5 to 9%" for prose; does that
  preserve your intended figure?
- "significant effect" was ambiguous: do you mean statistically significant,
  practically large, or both? I replaced it with a plain claim and left the
  magnitude to your results, is that the right scope for the introduction?
- Should "1.2 million reviews" name the platform and time window so the reader
  can judge representativeness?
- The original implication addressed "managers"; I generalized to "platforms".
  Is the managerial framing one you want to keep?

## What this demonstrates

- **Orientation first.** The rewrite leads with the paper's question instead of
  a platitude, so the reader knows what is being answered from the first line.
- **Transitions from content.** The banned connectives are gone; each sentence
  hands the next its subject through given-new order.
- **Numbers and citations are protected.** "1.2 million" is untouched, the
  citation group is preserved, and the one numerical reformat is raised as a
  question rather than applied silently.
- **Claims are calibrated, not flattened.** An ambiguous "significant" becomes a
  question for the author, not a guess.
- **Subtraction by test.** The cut is 28%, logged line by line, with no content
  removed without a stated reason.
