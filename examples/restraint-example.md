# Restraint example

The hardest thing a good editor does is leave strong prose alone. The skill says
so directly: "An unchanged paragraph is a valid rewrite output" and "A rewrite
that touches every paragraph is suspect" (see the *Restraint* section in
`SKILL.md`). Every other example in this folder shows the skill changing a lot.
This one shows it changing almost nothing, on purpose, and explaining why each
tempting edit was declined.

The input is a results passage that is already tight. The request asks for a
heavy pass anyway. The skill makes the one mechanical fix the text actually
needs, returns the rest verbatim, declines two edits that would be different
rather than better, and routes a terminology question to `Author questions`
instead of silently collapsing the terms. The output follows the strict
four-section format in `SKILL.md`.

## Scenario

```
<paper_context>
target_venue: NeurIPS
audience: machine learning researchers
core_thesis: An auxiliary loss improves accuracy specifically on rare labels, and the same mechanism explains the model's robustness under distribution shift.
revision_stage: final polish
</paper_context>
```

The request:

> This results paragraph feels flabby. Can you tighten it hard and cut whatever
> is not pulling its weight?

## Triage

> Scope: direct rewrite. Unit: the two paragraphs you pasted. Aggressiveness:
> the stage is `final polish`, so I am limited to sentence-level work (word
> choice, given-new flow, mechanics) and will not reorder or cut whole units.
> One caution up front: this passage is already close to clean, so a hard cut
> would likely remove load-bearing words. I will fix what is genuinely off and
> tell you where I declined to edit. Proceeding on that basis.

## Input

```
On the held-out test set, the model reaches 91.2% accuracy, a 3.4-point gain
over the strongest baseline (Table 3). The gain concentrates in the long-tail
classes: accuracy on the rarest quartile of labels rises from 62% to 74%, while
head-class accuracy is unchanged. This is the pattern we would expect if the
auxiliary loss helps the model where labels are scarce rather than where they
are plentiful.

We see the same pattern under distribution shift. On the out of domain split,
accuracy falls by 6 points for both models, but the tail-class advantage holds:
the auxiliary-loss model keeps its 12-point edge on rare labels. Robustness,
then, comes from the same mechanism as the in-domain gain, not from a separate
effect.
```

## Skill output

The strict four-section return. Because the stage is `final polish` and this is
not a first-draft or whole-section pass, the Diagnosis opens straight into the
numbered list, with no `Voice tics:` or `Reader map:` line (per the output
contract in `SKILL.md`).

### 1. Diagnosis

1. [P2] "out of domain" is an unhyphenated compound modifier in front of
   "split"; the consistent form is "out-of-domain". This is the one mechanical
   fix the passage needs.
2. [P1, P2] The scarce-label classes are named four ways ("long-tail classes",
   "the rarest quartile of labels", "tail-class", "rare labels"). These may be
   one set or three different sets; consistency is an editorial claim, so this
   is flagged rather than silently collapsed.
3. [P1, P2] Otherwise both paragraphs clear the restraint bar: topic sentence
   first, coherent topic string, numbers in the stress position, calibrated
   claims, and each paragraph ends on a consequence rather than a procedural
   afterthought. No safe structural or sentence-level improvement is available
   beyond item 1.

### 2. Revised text

```
On the held-out test set, the model reaches 91.2% accuracy, a 3.4-point gain
over the strongest baseline (Table 3). The gain concentrates in the long-tail
classes: accuracy on the rarest quartile of labels rises from 62% to 74%, while
head-class accuracy is unchanged. This is the pattern we would expect if the
auxiliary loss helps the model where labels are scarce rather than where they
are plentiful.

We see the same pattern under distribution shift. On the out-of-domain split,
accuracy falls by 6 points for both models, but the tail-class advantage holds:
the auxiliary-loss model keeps its 12-point edge on rare labels. Robustness,
then, comes from the same mechanism as the in-domain gain, not from a separate
effect.
```

### 3. Change rationale

Word count: 120 to 118 (-2%). Within 5%, acceptable here because the original
was already tight; the brief asked for a hard cut, but cutting by the keep-test
yields almost nothing to remove, and manufacturing cuts to look productive is
itself a defect.

"out of domain split" -> "out-of-domain split", hyphenated the compound
modifier; the only mechanical fix the passage needed.

Paragraph 1: no safe improvement available.

Paragraph 2: no safe improvement available beyond the hyphen fix.

Declined: shortening "This is the pattern we would expect if the auxiliary loss
helps the model where labels are scarce" to "As expected, the auxiliary loss
helps where labels are scarce". The original is a calibrated conditional (the
result *matches* a prediction); the shorter form asserts the mechanism flatly.
The hedge is doing real work, so the original stays.

Declined: collapsing "long-tail classes", "the rarest quartile of labels", and
"rare labels" to a single term to "tighten" the wording. They may name
different sets (a quartile is a specific cut; "long-tail" and "rare" may be
looser), and merging them silently could change a claim. Raised in Author
questions instead.

### 4. Author questions

- Do "long-tail classes", "the rarest quartile of labels", "tail-class", and
  "rare labels" all refer to the same set of labels? If so, do you want one
  consistent term throughout; if not, can the distinct sets be named so the
  reader can tell them apart?
- The in-domain tail-class gain is 62% to 74% (12 points), and the
  out-of-domain "12-point edge on rare labels" is also 12 points, both of which
  I left exactly as written: is that the same measured quantity, a coincidence,
  or a number carried over by mistake?

## What this demonstrates

- **Verbatim return is a valid output.** Both paragraphs come back essentially
  unchanged, with explicit `no safe improvement available` lines, rather than
  reworded to look busy. A near-zero diff is the correct answer when the prose
  already passes the lens.
- **Declined edits are logged, not hidden.** The two tempting changes (drop the
  hedge, unify the terms) are named in `Change rationale` with the reason each
  was rejected, so the author can overrule the editor with full information.
- **Consistency is flagged, not forced.** Four names for the scarce-label
  classes look like a copyedit, but collapsing them could alter a claim, so the
  skill asks rather than merges.
- **The brief does not override the keep-test.** "Cut it hard" did not produce
  cuts the text could not afford; subtraction runs by test, never to a quota or
  to satisfy a request for visible change.
- **Numbers are untouched and cross-checked.** Every figure (91.2%, 3.4, 62,
  74, 6, 12) is carried over verbatim, and the one suspicious coincidence is
  raised as a question instead of being silently reconciled.
