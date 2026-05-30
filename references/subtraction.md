# Subtraction

Load this when a pass is mainly about length, when the user invokes a Strunk-and-White or "80% rule" cut, or when deciding whether to remove any unit larger than a phrase. The diagnostic lens in SKILL.md says what good prose looks like; this file says how to remove what does not serve the story without removing what does.

Subtraction is the highest-yield edit and the easiest to botch. "Omit needless words" is a goal, not a test. The damage happens when an editor cuts by instinct or by quota instead of by a test for what each unit is doing.

## Two operations, two risk levels

Separate them, because "be concise" hides the difference.

- **Compress.** Say the same thing in fewer words: a verb for a nominalisation, "because" for "due to the fact that", the deleted throat-clearing opener. Information content is preserved, so compression is near zero-risk. Apply it freely; it is most of the cut.
- **Delete.** Remove a unit (sentence, example, caveat, paragraph, section) entirely. This changes what the text says, so it carries real risk. Apply the keep-test first.

Rule of thumb: compress freely, gate deletion.

## The 80% is a prior, not a quota

Most drafts carry 15 to 25% that does not serve the story, so expect to cut and look for the cut actively. That expectation is a healthy prior. It turns destructive the moment it becomes a number you must hit: to make quota, you start cutting load-bearing tissue out of a draft that was already tight. Cut by test and let the total land where it lands. A lean draft might yield 5%, a padded one 40%. Never manufacture cuts to reach a target.

## The keep-test

Before deleting any unit, ask: if this goes, what does the reader lose? A unit earns its place if it does at least one of these.

1. **Advances the thesis.** It carries a step of the main argument.
2. **Makes a claim believable.** Evidence, or an example that rules out a misreading. An example that only illustrates a claim the reader already accepts is cuttable; one that rules out an alternative is load-bearing (see `references/edit-checks.md`, check 4).
3. **Links two ideas** the reader would not otherwise connect. The value is the link, not new information; cutting it breaks logical flow even though the sentence "said nothing new".
4. **Serves a reader the other sentences do not.** The plain-language gloss the non-expert needs. Removing it tightens the prose for the specialist and loses the generalist (the layered-audience rule in `references/edit-checks.md`).
5. **Pre-empts a predictable objection.** The caveat or limitation that stops a reviewer. It looks like weakness and reads as competence.
6. **Sets rhythm.** A short sentence that lets the reader breathe after a dense passage. Prose is not only information.

If a unit does none of these, cut it. If it does exactly one, compress it but keep it.

## The keep-test is also the catalog of destructive cuts

Every common way a cut goes wrong is a keep-criterion the cutter did not check.

- Cut a hedge that was calibration, not filler, and you broke criterion 2: the claim is now an overclaim.
- Cut a transition that "added nothing new" and you broke criterion 3: the thread is gone.
- Cut a "redundant" plain restatement and you broke criterion 4: the non-expert is lost.
- Cut the limitations paragraph because it looked like weakness and you broke criterion 5: you invited the desk reject.
- Cut an example that ruled out a reading and you broke criterion 2: the reader no longer believes you.
- Salami-slicing: ten individually safe cuts compound into the removal of a whole inferential step. The read-cold pass in SKILL.md is the check that catches the compounded loss; run it after any heavy cut.

## Scale the action to the unit size

The bigger the unit, the more a wrong cut costs, so the more the editor proposes rather than performs.

- **Word or phrase.** Cut in the rewrite.
- **Sentence.** Cut and log what was lost in `Change rationale`; the hard rule against silent deletion already requires this.
- **Paragraph or section.** Propose in `Diagnosis`, do not perform: "Section 5.2 restates the argument of Section 3; consider cutting." A structural cut is a claim about the paper's architecture, and only the author knows whether the unit is doing quiet work elsewhere.

The revision stage still binds. At `final polish`, compress only and propose no deletion larger than a phrase. At `first draft`, you may perform sentence cuts and propose larger ones. At `response to reviewers`, cut only inside the flagged paragraphs.

## The blind spot: subtraction never finds what is missing

A scan that only looks for things to remove cannot find the thing that should be added: the inferential step the author skipped because the curse of knowledge made it feel obvious (Pinker, in `references/principles.md`). Sometimes the highest-value edit is one sentence more, not one fewer. Pair the subtractive scan with one question from the reader's side: where would a smart non-expert get lost? The missing step is the one unit you must never cut, and now and then must supply. When you cannot supply it from the prose, flag the gap as an Author question.

## Worked example

Draft (about 40 words):
"It is important to note that the model, which we trained on the full dataset, achieved an accuracy of 91%, a result that, due to the fact that the baseline was at 78%, we consider to be a significant improvement."

Over-cut and destructive (4 words):
"The model hit 91%."
The baseline is gone, so the reader cannot tell whether 91% is good. Criterion 2 broken; this cuts 90% but destroys the claim.

Right cut, compress then keep what is load-bearing (16 words):
"The model reached 91% accuracy, against the baseline's 78%. We trained it on the full dataset."
The throat-clearing and "due to the fact that" are compressed away and "significant" drops as a promotional adjective, but the baseline stays because it makes the claim believable. This cuts 60% and keeps the argument. More cutting is not the enemy; cutting the wrong unit is.
