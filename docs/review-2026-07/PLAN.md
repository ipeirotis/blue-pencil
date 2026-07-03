# Execution plan: 2026-07 review remediation

Status: **active**. This file is the single source of truth for applying the
2026-07 skill review. Every batch PR must update the checkboxes below in the same
PR that lands the work. When all batches are merged or explicitly dropped, mark
this file historical (the `AUDIT.md` precedent) and stop updating it.

## Documents in this directory

| File | What it is |
|---|---|
| `review-a.md` | Independent review A of the skill (v1.22.0) |
| `review-b.md` | Independent review B, including the "reading companion" addendum |
| `reconciliation.md` | Cross-verification of both reviews, adjudicated conflicts, merged action plan (section 5), canonical patch selection per file (section 6) |
| `PLAN.md` | This file: batch checklists, acceptance criteria, session prompts |

Decision authority: `reconciliation.md` section 6 names which review's patch text
to use wherever both proposed wording. Do not re-litigate decisions recorded
there; if a patch no longer applies cleanly because the source drifted, stop and
flag it in the PR rather than improvising a new design.

## Status board

| Batch | PR | Version | Status |
|---|---|---|---|
| 1. Plumbing + docs | #28 | v1.23.0 | merged |
| 2. Rule-system rewrite | #29 | v1.24.0 | in review |
| 3. Examples + CI (atomic) | | v1.25.0 | not started |
| 4. Capability: triage, letter, fallback | | v1.26.0 | not started |
| 5+. Addendum lanes (one PR each) | | v1.27.0+ | not started |

Merge strictly in order: Batch 2 depends on nothing, Batch 3 depends on Batch 2's
constraint wording, the addendum depends on Batch 2's master-rule ground. Each PR
follows the release steps in `scripts/README.md` (bump, CHANGELOG, `make test`,
then tag after merge).

## Working conventions (every batch)

- One commit per checklist item, message prefixed with the item ID
  (example: `B-C9: interpolate $ARGUMENTS once per command`).
- Apply the canonical patch text from the reviews' section G as selected in
  `reconciliation.md` section 6. Adapt only for source drift, and say so in the
  commit message.
- No em-dashes or en-dashes anywhere, including docs and CHANGELOG:
  `scripts/lint.sh` greps every tracked file and CI fails on one.
- `make test` green before opening the PR. From Batch 3 on, the new CI checks
  must also pass.
- Update this file's checkboxes and status board in the same PR.
- Do not touch items outside the batch, even easy ones; they belong to their own
  PR and release.

## Batch 1: plumbing + docs (v1.23.0)

Goal: bug fixes and doc corrections that cannot change editorial behavior, plus
merging this directory into `main` so later sessions can read it.

- [x] Merge `docs/review-2026-07/` (this directory) into main (landed via PR #27)
- [x] B-C9: single `$ARGUMENTS` interpolation per command (all 8 files under
      `.claude/commands/paper/`; bullets say "the section provided below")
- [x] B-G8: `install.sh` skipped stage writes `[fill in]`, not `first draft`;
      warn on unrecognized stage values (`install.sh` ~line 628 and the
      `read_field` block)
- [x] B-D7b: `loop.md` guardrails gain "no change to the meaning of any technical
      claim"
- [x] B-D5: scope the read-cold pass to "text you were allowed to edit at this
      stage" (`SKILL.md`, read-cold section)
- [x] A-C8/B-D9: word counts become approximate ("~139 to ~86"); keep direction
      and rough magnitude (`SKILL.md`, Change rationale + Length budget)
- [x] A-C7: exempt whole-paper diagnosis-only passes from the seven-item
      Diagnosis cap (`SKILL.md` + `consistency.md`)
- [x] B-G11: README fixes (`make init` wording, `--check` copy-mode
      troubleshooting, "preserves citations, does not verify them" line)
- [x] A-G8: README note for claude.ai/Cowork users (use the skill without the
      installer; the closing sentence states current ask-first behavior until
      the Batch 4 context fallback lands)
- [x] B-C10: document `paper-meta.md` as the non-git escape hatch; add the
      `~/.agents/skills` path to `paper-reviser.md` step 1; allow an
      author-approved section skip list in `loop.md` Step A
- [x] Release: CHANGELOG entry, `make bump VERSION=1.23.0`, `make test`

Acceptance: CI green; no behavioral wording in `SKILL.md` changed beyond the
three items listed; diff reviewable in one sitting.

## Batch 2: rule-system rewrite (v1.24.0)

Goal: the one behavioral release. Rewrites the constraint block and output
contract. Review this PR's `SKILL.md` diff line by line.

- [x] B-G2: new constraint 1 (never add substance the manuscript does not
      contain); thread through `paper-reviser.md` hard rules and `loop.md`
      guardrails
- [x] A-G7 structure: reorder constraints science-first, em-dash last, folding
      in: quote exception (B-D7a), caption carve-out (B-E8), citation-wall rule
      (B-D6: propose redistribution in Author questions, never perform),
      qualifier-is-content rule (B-G5), any-format markup generalization,
      `style_overrides:` opt-out (A-D1)
- [x] B-G3: output-destination rule (default: return text, never write files;
      apply only on explicit request; never apply with unresolved Author
      questions) + `loop.md` Step C checkpoint note; align `paper-reviser.md`
      tools with the decision
- [x] Merged description: B-G1 base + "line-edit"; grants stay out of
      auto-trigger (reconciliation conflict 4: explicit-request only, note in
      "When NOT to use")
- [x] B-G10: Diagnosis-header decision table replaces SKILL.md lines ~243-247;
      `exposition.md` becomes single owner of the extraction-line spec; fix the
      line ~212 duplicate voice-tics statement
- [x] Conflict 3 resolution: mandatory `Added bridges:` line immediately after
      the `Revised text` block (quoting each added why-it-holds sentence, or
      `None.`); do NOT use inline bracketed tags inside the fenced block
- [x] B-G6: reviewer workflow gains the overclaim guard and the
      contradictory-comments rule
- [x] Behavioral eval: run the adversarial set (both reviews, section I) against
      the `paper-reviser` subagent before and after the rewrite; paste the
      before/after summary into the PR body
- [x] Release: CHANGELOG entry explaining each behavioral delta,
      `make bump VERSION=1.24.0`, `make test`

Acceptance: every changed rule traceable to a reconciliation item; eval results
in the PR body; no example files touched (that is Batch 3).

## Batch 3: examples + CI, atomic (v1.25.0)

Goal: fix the four example defects and land the CI that locks the examples from
then on. Must land together: the new CI checks fail against today's examples by
design.

- [ ] B-D10a: add the three extraction lines to `worked-example.md` (it diagnoses
      a payoff gap at `first draft`)
- [ ] B-D8/B-G7: `exposition-methods.md` bridge rebuilt from manuscript text, not
      `core_thesis` metadata; the missing motivation becomes an Author question
- [ ] B-D10b: `exposition-results.md` rationale stops claiming "carried over
      verbatim" for an altered passage; describe the actual edit
- [ ] B-D10d: move `[P#]` labels out of the `Revised text` fenced block in
      `reviewer-response-example.md`
- [ ] A-D2: re-audit `exposition-introduction.md`'s added identification bridge
      against the new constraint 1; add the `Added bridges:` line the Batch 2
      contract now requires
- [ ] B-D10c: align all `Reader map:` lines with the SKILL.md template wording
- [ ] B-M8: CI example conformance (four exact headings in order; word-count line
      regex; every Author-questions bullet ends with `?`; banned-tell grep on
      `Revised text` blocks with a whitelist for deliberate verbatim returns;
      extraction-line consistency check)
- [ ] A-D6: `scripts/check-protected.sh` (diff citation keys, numbers, math
      spans, refs between example input and output) wired into `make test` and CI
- [ ] Both: extend `lint.sh` link checking to commands, agent, references, and
      examples (today it checks only SKILL.md-to-references)
- [ ] Release: CHANGELOG, `make bump VERSION=1.25.0`, `make test`

Acceptance: new CI checks pass; deliberately breaking an example (e.g. removing a
heading) fails CI locally.

## Batch 4: capability (v1.26.0; may split into 4a/4b)

- [ ] Conflict 2 resolution: context fallback (B-G4 + restrictive-only stage
      inference; never assume `first draft`; `Assumed context:` line)
- [ ] E1/M3 + A-F10: `/paper:triage` command (decision letter in; severity-ranked
      comment table, section mapping, work order out; diagnosis-only)
- [ ] E3 + B-G9 + A-F11: `/paper:letter` command + `examples/`
      response-letter example (may restate what the revision did; never promise
      what the manuscript lacks; every claimed change points at a real location)
- [ ] A-G9/B-E2: comment-to-change status table appended to `rebut` output
- [ ] B-C4 + B-E6b: monolithic-file section detection; "cut to fit N pages"
      routes into subtraction with a target and a reported gap
- [ ] A-G5/B-M9: "Input formats and messy input" section (Word/OCR/PDF/paste)
- [ ] B-C8: dispatch-completeness rule (commands pass everything the isolated
      subagent needs; drop "the conversation" from `rebut.md`)
- [ ] A-D7/B-E7: author-edit preservation rule (current file is the author's
      decision record; never re-propose a rejected edit)
- [ ] B-M7: consistency checklist moves to `references/consistency-checks.md`
- [ ] Release: CHANGELOG, `make bump VERSION=1.26.0`, `make test`

## Batch 5+: addendum lanes (one PR and one release each, in this order)

Architecture note (reconciliation conflict 5): lanes get their own commands and
subagents with their own tool lists. `SKILL.md`'s `allowed-tools` stays
`Read Edit Grep Glob`.

- [ ] 5a: `/paper:read` + `references/cold-read.md`; replace `loop.md` Step 1
      with the cold read; keep "merely different rather than better" as the
      editor-lane stop rule
- [ ] 5b: master-rule split (B-A2 wording: never assert unverified substance)
- [ ] 5c: `/paper:verify-numbers` + `references/analysis-integrity.md`
      (provenance, no forking paths) as a gated `paper-analyst` agent;
      verification only
- [ ] 5d: `/paper:scholar` + `references/literature-checks.md` (retrieved, not
      remembered; leads, not verdicts) as a gated `paper-scholar` agent;
      citation verification before novelty scan
- [ ] 5e: analyst capabilities 2-3 (figure regeneration, new analyses)
- [ ] 5f: installer test harness (review B, larger redesigns), or shrink the
      installer surface instead
- [ ] Optional, anytime after Batch 2: B-M6 merge of `sentence-cohesion.md` into
      `sentence-patterns.md` (low priority)

## Session prompts (Claude Code on the Web)

Each batch is one session. Sessions have no memory of previous ones; the prompt
plus this directory is everything they know. Copy, fill in N, and adjust only the
bracketed parts.

### Prompt A: execute a batch

```
Read docs/review-2026-07/PLAN.md and execute Batch [N], and only Batch [N].

Background: docs/review-2026-07/ holds two independent reviews of this skill
(review-a.md, review-b.md) and a reconciliation (reconciliation.md) whose
section 6 names the canonical patch text per file. Apply those patches; do not
redesign them. Where review B's section G is cited (B-G1, B-G8, ...), the text
is in review-b.md; A-G items are in review-a.md.

Follow PLAN.md's working conventions exactly: one commit per checklist item
prefixed with the item ID; no em-dashes or en-dashes anywhere (scripts/lint.sh
enforces this repo-wide); make test green; update the PLAN.md checkboxes and
status board in the same PR. If a patch no longer applies cleanly to the
current source, stop and ask me instead of improvising.

Finish by opening a PR titled "Batch [N]: [title from PLAN.md] (v1.2[X].0)"
whose body lists the checklist with each item checked, then subscribe to the
PR and address CI failures and review comments until it is mergeable. Do not
merge it yourself.
```

### Prompt B: Batch 2 only, add the eval evidence

Append to Prompt A:

```
Before changing anything, run the adversarial evaluation prompts from
review-a.md section I (items 22-27) and review-b.md's adversarial cases
against the current skill by dispatching the paper-reviser subagent on each.
Save the outputs. After the rewrite, run the same prompts again and put a
before/after summary table in the PR body: for each case, pass or fail,
before and after. If any case regresses, stop and show me.
```

### Prompt C: resume or review a stalled batch

```
Read docs/review-2026-07/PLAN.md. Batch [N] is partially done on PR #[n].
Compare the PR's commits against the Batch [N] checklist, list what is done,
missing, or diverged from the canonical patches in reconciliation.md section
6, then finish the remaining items under the same conventions.
```
