# Precision budget

Load this on any abstract, introduction, or contribution-paragraph pass, whenever deleting, adding, or moving a hedge in the paper's first two pages is on the table, and whenever a draft reads either hedged and defensive up front or suspiciously clean up front. Three neighbours divide the work: the keep-test (`references/subtraction.md`) asks whether a unit earns its place at all, the altitude test (`references/altitude.md`) asks which section a surviving unit belongs in, and this file asks how much precision each location must carry, which decides whether a qualification may leave its claim at all.

## Why the rule exists

Precision is purchased with the reader's attention, and attention is most expensive exactly where the paper opens. A caveat delivered before the reader can appreciate why it matters is wasted twice: it spends scarce attention, and it discounts a claim the reader has not yet grasped, so the hedge lands as noise where the same hedge, placed where the claim is actually tested, would land as competence. Mathematicians call the earned version of this post-rigorous writing: the author speaks loosely because they know exactly where the looseness is and where in the paper it is repaid. Pedagogy calls it the simplified first version that a later, fuller version refines; journalism calls it the inverted pyramid. A research paper is neither a contract nor a technical manual: uniform full precision everywhere is not rigor, it is a failure to spend the reader's attention where a referee would actually test the claim. Spend precision where a referee would quote the sentence in a rejection; economize everywhere else.

The failure this file prevents runs in both directions, and both matter. LLM-drafted prose defaults to technical correctness everywhere, so every early claim arrives pre-qualified and the introduction reads as apology. The naive cure, a find-and-delete pass over hedge words, strips the calibration that keeps a claim honest and turns compression into overclaiming. Neither is editing. The tests below decide, hedge by hedge, which is spent noise and which is load-bearing content.

## The precision gradient

Sections run at different precision levels by design:

- **Abstract and introduction: directional truth.** Clean claims the reader can hold, no inline caveat clauses, and none of the paper's own contributions qualified with "may", "might", or "potentially".
- **Methods and results: full precision.** Every condition stated where the claim is established.
- **Discussion and limitations: where hedges live.** Concentrate them here rather than sprinkling them through the paper.

The gradient is the reason behind two rules that live elsewhere: the altitude directive that sends each caveat to its home section, and the progressive-disclosure check (`references/edit-checks.md`, check 6) that defers complications in the first pages. This file supplies the decision rule both of them need: which qualifications are deferrable and which must stay.

## Two kinds of hedge

- A **scope hedge** says "this is true under conditions X". It can almost always be deferred: the claim runs clean at first mention, and the conditions are stated in full where the claim is established, with at most one forward pointer left behind (the one-signpost rule below).
- An **epistemic hedge** says "we are not sure this is true". On a peripheral claim it follows the ordinary rules. On the paper's central claim it can never be edited away, only relocated to where the evidence is presented, and when the uncertainty is itself part of the finding (a borderline or fragile result, per the fragility rule in `references/altitude.md`) it stays with the claim even at the top of the paper.

The reading-out test in `references/subtraction.md` separates scope from filler; this distinction separates scope from epistemic. A hedge that marks what the evidence cannot support is content wherever it sits. What the gradient licenses is moving it, never deleting it.

## The refinement-vs-retraction test

A simplification early in the paper is legitimate exactly when the precise version, where it eventually arrives, reads as a sharpening of what was promised: same sign, roughly the same magnitude, scope trimmed rather than gutted. It is a defect when the full statement reverses the sign, guts the magnitude, or narrows the scope so far that the opening reads as bait. The test is decidable, not aesthetic: after reading the full paper, would an expert feel the introduction was compressed, or misled? Compressed is the goal; misled is the bug.

Apply the test before deleting, deferring, or adding any hedge in the first two pages:

- A hedge whose removal still passes the test is deferrable (a relocation, under the gates below) or, when the reading-out test says filler, cut.
- A hedge whose removal fails the test stays inline, whatever the gradient says. This is the epistemic keeper.
- An early claim that already fails the test is not fixed by re-hedging it: the mismatch between the promise and the delivery is the author's to resolve (weaken the claim or strengthen the evidence), so report it in `Diagnosis` and route the decision to `Author questions`.

The test reads across the whole paper, so on a single-section pass it may need text you do not have. Verifying that the precise version exists, and preserves the claim, requires the section that establishes it; when that section is outside the supplied scope, mark the deferral unverified in `Author questions` rather than asserting the debt is paid.

## One signpost, not a caveat clause

When an early claim genuinely needs qualification at first mention, the ceiling is one short forward pointer ("we characterize the boundary conditions in Section 6"), never an inline caveat clause, and never two pointers on one claim. The signpost buys honesty at almost no attention cost: it tells the reader a boundary exists without making them hold it before they can value it. This composes with the hedge-stacking rule in `references/sentence-patterns.md` (one hedge per claim, maximum): a claim that keeps an epistemic hedge has spent its one hedge, and a signpost on top of it needs a reason.

## The precision debt ledger

Every simplification in the first two pages is a debt, and the full statement where the claim is established is the payment. When revising front matter, keep an explicit ledger: list each simplification you make or keep, and verify each has its discharging full statement in the body. An unpaid debt is a finding, not an edit:

- When the paying section is in scope and carries the full statement: the debt is discharged; nothing to do.
- When the paying section is in scope and lacks the full statement: the missing statement is substance the manuscript does not contain, so drafting it is out of scope (constraint 1). Flag the unpaid debt in `Author questions`.
- When the paying section is out of scope: mark the debt unverified in `Author questions`.
- Never discharge a debt by re-hedging the introduction; that repays the reader in the currency the gradient exists to protect.

On a whole-paper pass the ledger is the precision-side twin of the consistency check's promise-delivery gap (`references/consistency-checks.md`): that check asks whether the intro promises work the body never does; this one asks whether the intro's clean claims are ever stated in full.

## First mention versus full statement

The first mention of any result states it in its cleanest form. The complete statement, with all conditions, appears exactly once, at the point where the result is established. Later mentions run clean again; do not repeat the full conditions at every mention. This composes with the say-it-once rule in `references/subtraction.md` rather than fighting it: the clean first mention and the full statement are two different claims (a headline and its conditions), so both stay, while a second full statement is the echo that goes.

## The hedge lexicon

In the abstract, the introduction, and any contribution paragraph (wherever in the paper it sits), flag every occurrence of: may, might, could, suggest, potentially, arguably, generally, typically, in many cases, to some extent, it is important to note. Build the census mechanically first, with a Grep pass over the front matter, so detection is complete and editorial judgment is spent on classification rather than on finding. Then classify each hit; the classification is the edit, and blanket deletion is never it:

1. **Epistemic keeper.** A hedge on a central claim whose removal fails the refinement test. It stays, counts as the claim's one hedge, and is logged as kept calibration, not as a missed cut.
2. **Deferrable scope.** A condition whose full statement exists, or belongs, where the claim is established. Defer it: the claim runs clean, at most one signpost remains, and the move is a relocation under the gates below and a deletion under constraint 6, so it is logged in `Change rationale` and, when it touches a numerical claim, flagged under the numerical-claim constraint.
3. **Filler.** A qualifier that rules out no reading, by the reading-out test. Cut freely.

Target near-zero hedge density in the first two pages, and never buy zero at the price of a failed refinement test. Note the asymmetry inside the lexicon: "it is important to note" is banned everywhere (`references/ai-tells-to-avoid.md`), while the rest are ordinary words that are wrong only at the wrong altitude. "May" in a Discussion paragraph about generalization is calibration doing its job, and "suggest" on the paper's own contribution is often the epistemic keeper itself, as the worked pair below shows: census it, then classify, never reflex-delete.

## Gates on the deferral

Deferring a hedge edits two places, the front-matter sentence and, when the conditions are not yet stated there, the home section, so it is a structural move and the altitude gates (`references/altitude.md`) bind it unchanged. Scope: defer only when the home section is inside the requested unit; otherwise raise the move in `Author questions` and leave the hedge. Stage: perform the deferral only at `first draft` or on a whole-section pass; at `final polish`, flag the budget issue and move nothing. In a response-to-reviewers pass, a deferral that must write the conditions into the destination needs both the hedge's paragraph and the destination paragraph flagged; when the destination already carries the full statement, nothing is written there, so a flagged source paragraph suffices, with the existing full statement verified rather than edited. A deferred qualifier on a numerical or statistical claim trips the numerical-claim constraint, so flag it there too.

## Worked pair

Too hedged (introduction, solid experimental evidence behind it): "Our results suggest that, at least in the settings we study, and subject to the caveats discussed in Section 6, retrieval augmentation may potentially reduce hallucination rates, though the effect could vary across domains."

At budget: "Retrieval augmentation cuts hallucination rates in the settings we study; Section 6 maps where the effect is strongest." The stack "suggest ... may potentially ... could vary" collapses because the evidence is experimental and Section 6's full statement preserves the sign and magnitude, so the refinement test passes. "In the settings we study" stays: it is a dataset-scope qualifier, and cutting it would broaden the claim past the data (`references/subtraction.md`). The Section 6 caveat wall becomes the one signpost.

The other branch, when Section 6 shows the effect reversing in some domains: the clean version now fails the refinement test, so a marker of the boundary stays inline: "Retrieval augmentation cuts hallucination rates in most of the settings we study, though not all; Section 6 maps the boundary." And if the evidence itself is only suggestive (observational, underpowered), "suggest" is the epistemic keeper: it stays, it is the claim's one hedge, and the rest of the stack still goes.

## Composition summary

- Constraint 6 and the qualifier-is-content rule: a deferred hedge is a deletion from its sentence, logged always; when scope versus filler is unclear the tie still breaks toward keeping, and in front matter "keeping" may mean deferring with a signpost, never a silent cut.
- Altitude: the refinement test decides whether a qualification may leave its claim; the altitude test picks its destination; the scope and stage gates bind every move.
- Hedge stacking: one hedge per claim, maximum; the gradient adds where that hedge is allowed to live.
- Progressive disclosure (check 6): the refinement test is its decision rule for the first three pages.
- Argumentation (SKILL.md): calibration still binds in both directions; the gradient never licenses a claim the evidence does not support, only a cleaner statement of the claim the evidence does.
