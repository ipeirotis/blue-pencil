# Response-letter example

The response letter is a separate deliverable from the manuscript, with its own
license: reply text may restate and cite what the revision did, but it must
never promise or assert analyses, results, or claims the manuscript does not
contain, and every claimed change must point at a real location. This example
shows the letter lane end to end: a defensive reply is recalibrated without
conceding the authors' position, a verified location claim stands, an
unverifiable one becomes an `Author questions` item instead of staying
unexamined, and a promise-without-a-change is flagged rather than papered over.
The genre conventions (structure, tone, disagreement discipline) come from the
rebuttal section of `references/structural-patterns.md`; the manuscript-side
run for the same revision is `examples/reviewer-response-example.md`.

## Scenario

```
<paper_context>
target_venue: Management Science
audience: empirical economists and IS researchers
core_thesis: Earning a platform badge causes a measurable increase in seller revenue, identified from the staggered rollout of the badge program across categories.
revision_stage: response to reviewers
</paper_context>
```

The request:

> Here is our draft response to Reviewer 1, plus the relevant parts of the
> revised manuscript. The reply on the instrument sounds defensive, and I am
> not sure the letter holds up against what we actually changed. Tighten the
> letter, keep our disagreement on the instrument, and check every claimed
> change against the manuscript.

The manuscript excerpts supplied for cross-checking:

```
From Section 4.2 of the revised manuscript:

We construct the estimation panel from all sellers active in the twelve months
before the badge program reached their primary category. Sellers with fewer
than ten transactions in that window are excluded, as are sellers who changed
primary category during the sample period.

From the end of Section 6 (Discussion) of the revised manuscript:

Our estimates are identified from the staggered rollout of the badge program
within a single platform, and we discuss threats to internal validity above.
The construction of the revenue measure is described in Section 4.
```

The draft letter (paragraph labels added by the skill; quoted reviewer
comments are reviewer text and carry no labels):

```
Dear Editor,

[P1] We would like to thank the reviewers for their valuable feedback. We have
made a number of changes to the manuscript. We believe the paper is now much
improved.

> R1.1: The estimation sample is never described. How were sellers selected
> into the panel?

[P2] We have added the sample-construction details to Section 4.2, which now
states the selection window and the exclusions.

> R1.2: The instrument seems weak. The authors should consider a different
> identification strategy.

[P3] The reviewer appears to have misread our identification section. As we
already explained in the paper, the first-stage F-statistic is 48, which is
well above conventional thresholds. It is not clear to us what the reviewer
would prefer instead, and we note that alternative strategies have their own
problems. Furthermore, our approach follows standard practice.

> R1.3: The discussion should say how far the results generalize beyond the
> platform studied.

[P4] We agree. The discussion now addresses generalizability.

> R1.4: Please clarify whether the revenue measure includes shipping fees.

[P5] We agree that this is an important point.

[P6] We hope these revisions address the reviewers' concerns.

Sincerely,
The Authors
```

## Triage and letter mapping

> Scope: direct rewrite of the letter; the manuscript excerpts are cross-check
> material only and stay untouched. Unit: the response letter below. The
> stored stage is `response to reviewers`, which matches the deliverable. The
> letter is not the manuscript, so the stage's flagged-paragraph gate does not
> bind the letter's own prose, but the protection constraints do: quoted
> reviewer comments stay verbatim, and every number, location, and claim the
> letter carries from the manuscript is preserved exactly. Mapping before
> diagnosing:
>
> - **R1.1** (sample construction) -> **P2**; location claim to verify against
>   the Section 4.2 excerpt.
> - **R1.2** (instrument strength) -> **P3**; tone recalibration, disagreement
>   preserved.
> - **R1.3** (generalizability) -> **P4**; location claim to verify against
>   the Section 6 excerpt.
> - **R1.4** (shipping fees) -> **P5**; an agreement with no change described.
> - Opening and closing -> **P1**, **P6**.
>
> Proceeding on that basis.

## Skill output

The strict four-section return. The deliverable is the letter, so the
Diagnosis is organized by reviewer thread; the stage is `response to
reviewers`, so there is no `Voice tics:` or `Reader map:` line and every item
carries its reviewer label.

### 1. Diagnosis

1. [R1, P1] The opening performs gratitude instead of summarizing: "valuable
   feedback" and "much improved" thank no one for anything specific, and the
   paragraph never says what changed or where the authors disagree, which the
   rebuttal conventions ask the opening to signal.
2. [R1.2, P3] The reply is defensive: it opens by telling the reviewer they
   misread the paper, adds "As we already explained" as a grievance marker,
   and closes on a banned transition. The disagreement itself is legitimate
   and stays; the conventions want it stated cleanly with its evidence, not as
   a complaint about the reviewer. The evidence it cites (the first-stage
   F-statistic) is carried from the draft but cannot be verified against the
   excerpts supplied, which do not include the identification section; it is
   flagged, not endorsed.
3. [R1.3, P4] An unverifiable location claim: the reply says the discussion
   now addresses generalizability, but it names no location, and the Section 6
   excerpt supplied for cross-checking does not contain that material. Only
   the author knows whether the change exists, so the claim is flagged rather
   than edited or endorsed.
4. [R1.4, P5] A promise without a change: the reply agrees the point is
   important and stops. It neither answers the question asked (whether the
   revenue measure includes shipping fees) nor names a change or a location;
   the answer is substance only the author can supply.

### 2. Revised text

```
Dear Editor,

We thank the reviewers for their close reading of the estimation sample and
the identification strategy. We respond to each comment in turn below; on the
instrument, we explain why we respectfully disagree rather than change the
strategy.

> R1.1: The estimation sample is never described. How were sellers selected
> into the panel?

We have added the sample-construction details to Section 4.2, which now
states the selection window and the exclusions.

> R1.2: The instrument seems weak. The authors should consider a different
> identification strategy.

We respectfully disagree that the instrument is weak, for the following
reason: the first-stage F-statistic is 48, which is well above conventional
thresholds. Our approach follows standard practice, and alternative
strategies have problems of their own; if the reviewer has a specific
alternative in mind, we would welcome the pointer.

> R1.3: The discussion should say how far the results generalize beyond the
> platform studied.

We agree. The discussion now addresses generalizability.

> R1.4: Please clarify whether the revenue measure includes shipping fees.

We agree that this is an important point.

We hope these revisions address the reviewers' concerns.

Sincerely,
The Authors
```

Added bridges: None.

### 3. Change rationale

Word count: ~190 to ~190 (+2%). The cuts in the opening and the R1.2 reply are
offset by the invitation sentence that replaces the complaint; the letter's
substance is unchanged.

"We would like to thank the reviewers for their valuable feedback. We have
made a number of changes ... now much improved." -> "We thank the reviewers
for their close reading of the estimation sample and the identification
strategy. We respond to each comment in turn below; on the instrument, we
explain why we respectfully disagree rather than change the strategy.", thanks
in specifics rather than performed gratitude, and the opening now signals the
one disagreement up front, per the rebuttal conventions. Cut: "We have made a
number of changes to the manuscript" and "We believe the paper is now much
improved" (an evaluation with no specifics; the per-comment replies carry the
actual changes).

"The reviewer appears to have misread our identification section. As we
already explained in the paper," -> "We respectfully disagree that the
instrument is weak, for the following reason:", the disagreement is stated
cleanly and attached to its evidence instead of opening with an accusation;
the grievance marker is cut and logged.

"It is not clear to us what the reviewer would prefer instead, and we note
that alternative strategies have their own problems. Furthermore, our
approach follows standard practice." -> "Our approach follows standard
practice, and alternative strategies have problems of their own; if the
reviewer has a specific alternative in mind, we would welcome the pointer.",
the complaint becomes an invitation, the banned transition is removed, and
both original claims (standard practice; alternatives have problems) are
carried over without strengthening or dropping either.

Paragraphs P2, P4, P5, P6: returned verbatim. P2's location claim verifies
against the Section 4.2 excerpt (the selection window and the exclusions are
both there), so it stands. P4 and P5 carry the two defects only the author can
resolve (an unverified location claim and a promise without a change);
rewording them would either invent a change or delete the authors'
commitment, so both are flagged in Author questions and left in the authors'
wording, and the letter is not ready to send until both flags are resolved.
The quoted reviewer
comments are reviewer text and stay verbatim throughout, and the F-statistic
of 48 and the Section 4.2 pointer are carried over unchanged. The excerpts
supplied do not include the identification section, so the F-statistic the
reply cites is flagged as unverified in Author questions rather than endorsed.

### 4. Author questions

- R1.3's reply claims the discussion now addresses generalizability, but the
  Section 6 excerpt does not contain that material and the reply names no
  location: does the revised discussion address it, and if so, where (section
  and paragraph), so the reply can point there?
- R1.4's reply agrees the shipping-fee point is important but never answers
  it: does the revenue measure include shipping fees, and did the manuscript
  change in response (if so, where)?
- The R1.2 reply cites a first-stage F-statistic of 48, but the excerpts
  supplied for cross-checking do not include the identification section: can
  you confirm the manuscript reports that value, and where, so the reply's
  evidence is verifiable?
- The revised opening signals the R1.2 disagreement; do you also want it to
  name the sample-construction addition as the round's main manuscript
  change, or keep the opening minimal?

## What this demonstrates

- **The letter has its own license.** Editing reply text is not manuscript
  drafting: the letter may restate and cite what the revision did, under the
  license stated in the skill's reviewer-response workflow, with the genre
  conventions loaded from `references/structural-patterns.md`.
- **Every claimed change is checked against the manuscript.** R1.1's claim
  verifies against the Section 4.2 excerpt and stands. R1.3's claim cannot be
  located in the Section 6 excerpt, so it becomes an `Author questions` item,
  and the letter never gains a location the editor could not verify. The
  unverified reply keeps the authors' wording (whether the change exists is a
  fact only the author can settle; deleting the claim and endorsing it are
  both wrong), and the rationale says the letter is not ready to send while
  the flag is open. The same discipline covers evidentiary claims: the
  F-statistic the R1.2 reply carries cannot be verified against the supplied
  excerpts, so it too is flagged rather than endorsed.
- **Promises are not changes.** R1.4's agreement with nothing behind it is the
  classic rebuttal pathology (reviewers want the change, not the promise); the
  fix needs author substance, so it is flagged, not papered over.
- **Positions are preserved.** The R1.2 disagreement survives the tone pass:
  the accusation goes, the F-statistic evidence and the standard-practice
  claim stay, and no concession is manufactured in either direction.
- **Reviewer text is untouchable.** The quoted comments return byte-identical;
  only the authors' own prose is edited, and the `[P#]` labels stay outside
  the `Revised text` block so the letter can be pasted back whole.
