---
description: "Draft, improve, or assemble a response-to-reviewers letter with the blue-pencil skill, checking every claimed change against the manuscript."
argument-hint: "[paste the draft letter (or the comment set and your decisions) plus the revised manuscript, or give file paths]"
---

Dispatch the request below to the `paper-reviser` subagent, which loads the
`blue-pencil` skill and applies it in an isolated context. If that
subagent is unavailable, load the skill's `SKILL.md` directly instead.

The subagent is isolated: it sees only what the dispatch carries, not this
conversation. Pass everything it needs in the dispatched request, including
the user's answers to any prior clarifying question and, on a repeat pass
over the same text, the edits the author declined, reworded, or reverted
since the last pass, so the across-rounds preservation rule can hold inside
the isolated dispatch.

This is the response-letter lane. The letter is a separate deliverable from the
manuscript, with its own license (the skill's reviewer-response workflow states
it): reply text may restate and cite what the revision did; it must never
promise or assert analyses, results, or claims the manuscript does not contain,
and every claimed manuscript change must point at a real location. Load the
rebuttal conventions in `references/structural-patterns.md` before diagnosing.

The text provided below may hold: an existing draft letter to improve (the
common case), or the comment set plus the author's decisions and change log to
assemble a letter from, plus the revised manuscript (or file paths to it) for
cross-checking. If it names files, read them first; decide which inputs are
present from the contents, never from the filenames alone. If neither a draft
letter nor a comment set is present after reading, ask for one before doing
anything else. Assembling a letter needs the author's
decisions: when the input carries reviewer comments but no draft letter and no
author decisions or change log, do not choose concessions, disagreements, or
claimed changes yourself; ask for the author's per-comment decisions (agree or
disagree, what changed, where) before drafting any reply text. If the
manuscript is absent, say that the verification checks cannot run and route
every claimed manuscript change, result, analysis, or evidence statement to
`Author questions` rather than letting it stand unverified; a claim without a
location is not exempt, since it is just as unverifiable under the letter
license.

Run the letter pass:

1. Diagnose the letter (or the supplied parts) against the rebuttal
   conventions: structure (an opening that thanks in specifics and summarizes
   at the highest level; per-comment responses that quote each comment; a
   change log with locations), tone (respectful but not abject; disagreements
   stated cleanly with evidence, not wishy-washy half-agreements), and coverage
   (every reviewer comment answered exactly once). Coverage is verifiable only
   against the full comment set: when only the draft letter is supplied, you
   can check it solely against the comments the draft itself quotes, so mark
   coverage as unverified, ask for the full decision letter, and never report
   full coverage from the draft alone.
2. Verify every claimed change: each "we changed X" line must point at a real
   location (page, section, or paragraph) in the manuscript provided. A
   claimed change you cannot locate is flagged in `Author questions` as
   unverified, with the reply left in the author's wording: whether the change
   exists is a fact only the author can settle, so deleting the claim and
   endorsing it are both wrong. Say plainly that the letter is not ready to
   send while such a flag is open, and never let the letter gain a location or
   a change you could not verify.
3. Flag the promise pathology: a reply that promises a future change, or
   agrees while changing nothing, is flagged; reviewers want the change, not
   the promise.
4. Preserve the author's positions. Agree-or-disagree decisions are the
   author's: recalibrate framing and tone, never flip a disagreement into a
   concession or a concession into a disagreement.
5. Where a comment demands substance the manuscript does not contain, the
   reply must not assert or promise it; state what the revision actually did
   and put the gap in `Author questions`.

Preset triage:

- **Scope:** direct rewrite of the letter (or assembly from the supplied
  parts). The letter is the unit; the manuscript is read-only cross-check
  material, never edited by this command.
- **Unit:** the letter provided below, or, in assembly mode, the supplied
  bundle (comment set, author decisions, change log) the letter is assembled
  from; either counts as a complete unit, so do not ask again for a draft
  letter the assembly inputs replace.
- **Aggressiveness:** the letter is not the manuscript, so the manuscript
  stage gates do not bind its prose; the protection constraints still do.
  Quoted reviewer text stays verbatim, and every number, citation, location,
  and claim the letter carries from the manuscript is preserved exactly. If
  the stored `revision_stage` in `<paper_context>` is not
  `response to reviewers`, note the mismatch rather than silently overriding
  it.

Return the strict four-section output: `Diagnosis` of the letter, the full
letter in `Revised text`, `Change rationale`, and `Author questions` carrying
every promised-but-unverified change and every gap between a reviewer request
and what the manuscript contains. In assembly mode there is no original letter
to count or diff, so adapt `Change rationale` the way the skill's no-rewrite
runs do: omit the `Word count:` line, open with a one-line note that the
letter was assembled, then give one line per reply naming the supplied
decision or change-log entry it was built from, so the author can trace every
reply to their own inputs. For a complete worked run, see
`examples/response-letter-example.md`.

Letter, comments, and manuscript:

$ARGUMENTS
