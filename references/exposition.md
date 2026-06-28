# Exposition pass

Load this file when a section must teach an idea, not merely report it: abstracts,
introductions, theory and conceptual-framework sections, methods that carry
unfamiliar machinery, and any request to make the paper clearer to non-specialists,
more educational, more readable, or easier to understand. This pass protects the
reader from the author's curse of knowledge (`references/principles.md`, Pinker).
It runs after the logical-flow and argumentation checks and before the
reader-pleasure, narrative-spine, and copyediting passes: a paragraph can have a
clean ABT spine and a pleasant rhythm and still fail to teach. It never outranks
the hard constraints in `SKILL.md`. Any explanatory move that needs material the
author did not write is an `Author questions` item, not an edit.

## Goal

A research paper educates when it leaves the reader with a usable mental model, not
just a sequence of correct claims. After a load-bearing section, the reader should
be able to say:

1. What question is this section answering?
2. Why was that question not already settled?
3. What object, mechanism, method, or contrast does the paper introduce?
4. What evidence or reasoning makes the answer credible?
5. What should I now believe, notice, or be able to do differently?

If the reader cannot answer these, the prose has not yet educated them, however
smooth each sentence is.

## Reader model

Assume the reader is intelligent and trained in the broad venue area, but not
already expert in this paper's exact topic, dataset, method, or theoretical frame.
They know the field and its research norms. They do not know the paper's private
vocabulary, its exact dataset, its institutional context, its modelling
assumptions, or its identification logic.

Do not write down to the reader. Write the missing steps. The fix for the curse of
knowledge is not simpler claims; it is the inferential bridge the author has
internalised and skipped.

## The exposition ladder

For each load-bearing paragraph, check the rungs in order. A failure low on the
ladder is worth more than three failures high on it.

1. **Question before machinery.** Does the paragraph reveal the question before
   delivering the model, regression, theorem, taxonomy, or algorithm? (This is the
   "question before machinery" check of `references/edit-checks.md`, applied at the
   paragraph grain.)
2. **Role before name.** Before naming a construct, variable, theorem, model, or
   dataset, does the prose say what role it plays in the argument?
3. **Intuition before formalism.** Does the reader get the simplest version before
   notation, the full specification, robustness checks, or caveats?
4. **One new object at a time.** Does a single sentence introduce too many
   unfamiliar terms at once for the reader to hold?
5. **Concrete anchor after abstraction.** Does an abstract claim get anchored in an
   example, mechanism, dataset feature, figure, failure case, or measured
   consequence already present in the manuscript?
6. **Payoff after effort.** After dense material, does the paragraph tell the reader
   what they now understand, rather than ending on procedure?

## Common failures

### Definition debt

A term appears before the reader knows what it means or why it matters. Acronyms
used before they are defined, definite articles ("the framework", "the effect")
pointing at referents the reader has not met.

- Fix when safe: define the term in plain language at first serious use, using only
  material already in the paper.
- Flag when unsafe: ask the author for the intended definition.

### Machinery before motive

The model, regression, theorem, algorithm, or taxonomy appears before the reader
knows what problem it solves.

- Fix when safe: move or add the motivating question before the machinery, drawn
  from material already in the paper.
- Flag when unsafe: the motive is not on the page.

### Compressed inference

The paragraph jumps from A to D because the author has internalised B and C. This
is the curse of knowledge in its purest form.

- Fix when safe: restore the missing bridge from material already present.
- Flag when unsafe: ask what assumption, mechanism, or prior result licenses the
  jump.

### Expert-only contrast

The text says "unlike prior work" or "this differs from existing approaches" but
never names the difference a non-specialist would recognise.

- Fix when safe: state the contrast directly.
- Flag when unsafe: the contrast is asserted but not specified anywhere in the text.

### Abstract stack

Several abstract nouns appear together with no concrete object behind them:
framework, mechanism, heterogeneity, affordance, robustness, dynamics, governance,
quality.

- Fix when safe: replace at least one abstraction with the concrete thing it
  denotes, drawn from the manuscript.

## Section-specific exposition checks

### Abstract

Can a reader outside the narrow subfield explain the paper after reading only the
abstract? Required sequence: context, gap, contribution, evidence, implication.

### Introduction

By the end of page one, can the reader say who should care, what is hard, what the
paper claims, and why the claim changes something? (This is the McEnerney test of
`references/structural-patterns.md` and `references/principles.md`, read as an
exposition requirement.)

### Theory or conceptual framework

Does each construct have a role, not just a definition? Does the reader know why
this construct is needed before it is formalised?

### Methodology

Does the reader know why the method is appropriate, and what identifies the effect,
before seeing the implementation details and the specification?

### Results

Does each result paragraph start with the claim, then give the evidence, then say
what the result teaches? (Claim, then evidence, per Mensh and Kording rule 7 in
`references/principles.md`.)

### Discussion

Does the section convert results into understanding, or merely restate them?

## The memorable idea

A paper the reader can teach to someone else has a handle: a phrase the reader will
use when they describe it ("market for lemons", "no silver bullet"). This is the
"one named idea" check of `references/edit-checks.md`, read from the exposition
side. For abstracts, introductions, conclusions, and contribution paragraphs,
identify the paper's memorable idea. If the paper has only a topic, a method, or a
numbered contribution list, flag it in `Diagnosis` as a structural gap. Do not
invent a slogan; ask the author what phrase they want readers to carry away.

## Safe boundaries

Do not invent examples, mechanisms, definitions, or implications. If the manuscript
lacks the material needed to teach the idea, ask for it in `Author questions`. The
distinction that licenses an exposition edit: surfacing an idea already on the page
is editing; supplying an idea the page does not contain is drafting, and drafting is
out of scope.

- At `first draft`, you may add short explanatory bridges, definitions, and
  reader-orientation sentences from material already present in the manuscript.
- At `final polish`, do not add new explanatory content. Repair referents,
  definitions already implied, sentence order, and stress position only.
- At `response to reviewers`, apply exposition edits only to the flagged paragraphs
  and their immediate neighbours.

## Rationale language

In `Change rationale`, name the teaching benefit, not the feeling. Good rationale:

- restored a missing inference
- defined the term at first serious use
- put the role before the name
- moved the question before the machinery
- added a concrete anchor from existing material
- separated two new concepts the sentence had stacked
- made the reader payoff explicit
- translated an abstract claim into the mechanism it denotes
- exposed the contrast with prior work

Bad rationale: "clearer", "easier to read", "more engaging", "more accessible".
Those are outcomes, not mechanisms; if that is the only justification a change has,
revert it and keep the original.
