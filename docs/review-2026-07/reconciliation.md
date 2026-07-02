# Reconciliation of the two skill reviews (v1.22.0)

Date: 2026-07-02. Inputs: `review-a.md` in this directory ("review A") and a second
independently produced review (`review-b.md`, "review B", the one with the
multi-agent method note and the "reading companion" addendum). Method: every finding
unique to review B was re-verified against the repo source before adoption; the two
conflicts between the reviews are adjudicated explicitly below, including one place
where review B's evidence invalidates the *mechanism* of one of review A's own
patches.

**Bottom line.** The reviews agree on roughly 80% of substance, including all five
top-line risks, which makes those findings high-confidence: fix them first. Review B
is stronger on close-reading defects (it caught real spec-vs-example contradictions
and plumbing bugs review A missed, all of which I verified); review A is stronger on
mechanical verification (deterministic protected-content checking) and a few gaps B
lacks (the consistency-pass item cap, the style opt-out). Review B's addendum
reframes the product's scope in a way that *supersedes, conditionally*, review A's
two "out of scope" verdicts; the reconciliation below adopts the addendum with one
architectural refinement (tool gating per lane, not on the shared skill).

---

## 1. Convergent findings (independent agreement; highest confidence, act first)

Both reviews independently found, with materially identical fixes:

| Finding | A | B |
|---|---|---|
| Whether the skill writes files is undefined; `Edit`/`Write` granted but unused by any instruction | C3/G3 | C1/G3 (adds the sharper argument: `loop.md` Step C.6 convergence *presupposes* someone applied the edits) |
| Context gate hard-stops chat/first-run sessions; no defaults, no chat path | C1/G2 | C2/G4 (adds: the isolated subagent cannot even see the user's answer) |
| Response-to-reviewers letter is half-built: genre guidance exists, `rebut.md` promises drafting the scope rule forbids, no command/format/example | E, F11 | E3/G9 |
| Decision-letter triage command (`/paper:triage`) | F10 | E1/M3 |
| Diagnosis-header conditional logic too complex, duplicated in `exposition.md`, drifting | C5/G4 | A-item 4, M1/G10 |
| Reviewer-invited overclaiming unguarded in the reviewer workflow | D3/G6 | D2/G6 |
| Contradictory reviewers unhandled; route the conflict to `Author questions` | D4/G6 | C7/G6 |
| Constraint ordering signals style above science (em-dash is #1) | D1/G7 | D7 |
| Exact word counts demanded from a system that miscounts; allow approximate | C8 | D9/Q11 |
| OCR/Word/PDF/messy input has no guidance | C6/G5 | C6, E8, M9 |
| Author edits across rounds can be reverted / declined edits re-proposed | D7 | E7 |
| Comment-to-change roll-up table as a rebut deliverable | G9 | E2/E4 |
| Venue compliance: add anonymization + length pieces, skip venue templates | E | E6 |
| CI should test the behavior contract, not just the installer | I(28-30) | M8 |

Where the wording differs, section 4 below names the canonical patch to use.

## 2. Adopted from review B (verified against source; review A missed these)

Every item below was checked against the repo before adoption. All confirmed.

- **B-D8, metadata injection in the flagship exposition example.**
  `examples/exposition-methods.md:108` writes: `"(opening)" -> "The loyalty program
  had no clean control group", drawn from the paper context`. The bridge is built
  from `core_thesis` metadata, not manuscript text, while `exposition.md` requires
  bridges "grounded only in material already on the page" and the example's own
  closing section claims "Nothing invented to fill a gap." Confirmed;
  spec-vs-example contradiction. Adopt B's G7 fix.
- **B-D10(b), false "verbatim" claim.** `examples/exposition-results.md:138-140`
  says the significance/R-squared passage was "carried over verbatim"; the rewrite
  (line 96) adds "tenure" ("the interaction" → "the tenure interaction") and merges
  and reorders the two sentences. The edit is benign and even well-motivated; the
  *rationale line misdescribing it* is the defect, in the example set that is the
  de facto spec. Confirmed. Fix the rationale line.
- **B-D10(a), the worked example violates the extraction-line rule.**
  `examples/worked-example.md` diagnosis item 7 names a payoff teaching gap at
  `first draft`, which SKILL.md's Diagnosis rules say triggers the three extraction
  lines; they are absent. Confirmed. Either the example or the rule must change;
  fixing the example is cheaper and keeps the rule.
- **B-C5, `--init` silently defaults a skipped stage to the most permissive value.**
  `install.sh:628`: `local v_stage="${stage:-first draft}"`, with no validation of
  typed values. Confirmed. Adopt B's G8 (write `[fill in]`, warn on unrecognized
  values); it correctly makes the skip trip the context gate instead of granting
  restructuring permissions nobody chose.
- **B-C9, `$ARGUMENTS` interpolated twice per command.** All section commands
  reference `$ARGUMENTS` in a triage bullet and again at the foot (e.g.
  `revise.md:13` and `:27`); pasted section text is injected twice. Confirmed.
  Adopt the one-interpolation fix.
- **B-D5, read-cold pass conflicts with the stage gates.** `SKILL.md:231` ("Fix any
  failure before returning the output") instructs fixing AI tells that
  `response to reviewers` requires returning verbatim (see P5 in
  `reviewer-response-example.md`, correctly returned with "Furthermore ...
  Moreover"). Confirmed. Adopt the one-line scoping fix ("text you were allowed to
  edit at this stage").
- **B-D6, the house citation style directs edits constraint 3 forbids.**
  `ai-tells-to-avoid.md:148` (and `AGENTS.md.template`) say to break up
  paragraph-end citation walls; constraint 3 licenses moving citations only "within
  a sentence." Redistribution across sentences assigns citations to claims, an
  attribution decision. Confirmed. Adopt: propose in `Author questions`, never
  perform.
- **B-D7 details.** (a) `loop.md`'s carried-guardrails list omits "never change the
  meaning of a technical claim", the single most important rule. Confirmed
  (`loop.md:30-33`). (b) "Replace **any** em-dash" collides with "quotes stay
  verbatim" when a quote contains one. Confirmed. Adopt both fixes.
- **B-D10(d), `[P1]`-style labels inside the `Revised text` fenced block**
  (`reviewer-response-example.md:102-126`) contradict "No commentary inside the
  block" and create a copy-paste hazard. Confirmed. This finding also invalidates
  part of a review A patch; see conflict 3 below.
- **B-D10(e), the voice-tics rule is stated twice with different exception sets**
  (`SKILL.md:212` vs `:243`): a whole-section final-polish pass is "list the tics"
  under one and "skip" under the other. Confirmed. Adopt B's G10 tail (make the
  output-format table the single owner).
- **B-E8 (caption carve-out).** Constraint 5 read literally freezes
  `\begin{figure}...\end{figure}` including `\caption{...}`, while
  `edit-checks.md` check 5 instructs promoting claims into captions. Confirmed
  collision. Adopt: captions are editable prose; the rest of the environment stays
  opaque.
- **B-C3 (no diff-shaped output within a pass).** Real-length sections come back as
  one fenced block; the elided quotes in `Change rationale` are not searchable; no
  `latexdiff` pointer anywhere. Adopt (change map on request or above ~300 words;
  README pointer to `latexdiff`).
- **B-C4 (monolithic single-file manuscripts).** Every command takes "a section
  file"; a one-file `paper.tex`/`.docx` has no addressable unit and
  `/paper:revise paper.tex` becomes the forbidden whole-paper one-shot. Adopt
  heading-based section detection with author confirmation.
- **B-C8 (subagent isolation leak).** `rebut.md` tells the dispatched, isolated
  subagent to look for reviewer text "in the conversation," which it cannot see.
  Confirmed. Adopt dispatch-completeness rule.
- **B-C10, Q10, G11 smaller items.** `paper-meta.md` accepted but never
  scaffolded/documented; `make init` as documented runs against the clone, not the
  paper repo; `--check` troubleshooting mislabels healthy copy-mode installs;
  honest "preserves citations, does not verify them" README line; loop skip-list
  for appendices; `paper-reviser.md` missing the `~/.agents` path. All confirmed;
  all adopted.
- **B-E6b ("cut to fit N pages").** Review A missed this entirely: the subtraction
  doctrine's anti-quota stance actively resists the most common deadline request.
  B's resolution is correct and elegant: cut by keep-test *toward* the target, then
  report the gap between the safe cut and the target instead of forcing it. Adopt,
  including the `Shorten this to fit the 8-page limit` trigger eval.

## 3. Retained from review A (review B lacks these)

- **A-C7: the seven-item Diagnosis cap truncates `/paper:consistency`.** A
  whole-paper drift check can legitimately exceed seven findings; capping silently
  drops real drift in the one pass whose value is exhaustiveness. Keep; merge with
  B-M7 (move the consistency checklist into `references/consistency-checks.md` so
  non-Claude-Code users get it).
- **A-D6: deterministic protected-content checking** (`scripts/check-protected.sh`
  diffing citation keys, numbers, math spans, refs between input and output; run
  over the examples in CI). B's M8 covers format conformance but leaves protected
  content self-attested. Note the complementarity with the addendum:
  `check-protected.sh` verifies *the edit* didn't mutate protected content;
  `/paper:verify-numbers` verifies *the manuscript* against the pipeline. Keep
  both.
- **A-D1 (style opt-out).** B reorders the constraints but keeps house style
  unconditional. Review A's `style_overrides:` hook in `<paper_context>` stands:
  the em-dash/banned-list rules should yield to an explicit per-paper declaration
  (and only to that), consistent with the voice-preservation promise and with the
  per-paper "Editing conventions" section the `AGENTS.md.template` already ships.
- **A-D2 (bridge elasticity in `exposition-introduction.md`).** B flagged the
  methods example's metadata injection; A flagged the introduction example deriving
  an exclusion-restriction argument the draft only asserts. Both stand. Merged
  finding: **two of the three exposition examples bend the no-new-substance rule in
  different ways, and the third misdescribes an edit as verbatim**: the exposition
  example set needs a consistency pass as a unit, against the new constraint 1
  (B-G2) once adopted.
- **A's adversarial evals** ("make p = 0.06 sound significant", quota-cut,
  fabrication bait) merge with B's (citation-drop override, em-dash-in-quote,
  OCR paste, stage-gate pressure) into one suite; they overlap on reviewer-invited
  overclaiming, which both rank first.

## 4. Adjudicated conflicts

**Conflict 1: the frontmatter description gap (A: High severity; B: "refuted").**
Partially in B's favor. The description's second sentence does carry "logical flow"
and "copyediting", so "Does my intro flow?" has a token match, and A's High was
overstated. But "tighten" and feedback-only phrasing are genuinely absent, and B's
own G1 patch *adds exactly those tokens* (plus length-fit and consistency triggers),
conceding the substance. Resolution: severity Medium; the fix is common ground.
**Use B's G1 text as the base** (it adds length-fit and consistency, which A's
lacked) with one addition from A: "line-edit". Hold "grant-proposal narratives"
pending conflict 4.

**Conflict 2: default stage when context is missing (A: infer, assume
`first draft` stated; B: ask once, then `final polish`, never more permissive).**
Resolved in B's favor, with A's inference kept only where it is risk-free. The
asymmetry decides it: an under-aggressive pass costs one round-trip ("please
restructure too"); an over-aggressive default rewrites the structure of what might
be a camera-ready paper. Merged rule: ask once, in one message; infer only toward
*more restrictive* stages from unambiguous signals (reviewer comments pasted →
response-to-reviewers scope; "camera-ready"/"proofs" → `final polish`); with no
answer and no signal, proceed at `final polish` with an `Assumed context:` line;
never assume `first draft` without explicit confirmation. Use B's G4 text with the
inference sentence inserted.

**Conflict 3: how to mark added explanatory bridges (A's G6/constraint-9 inline
tag vs B's D10(d) evidence).** B's finding defeats A's mechanism. A proposed an
inline `[added bridge; confirm]` tag inside the revised text; B independently
established that bracketed editor labels inside the fenced block are a copy-paste
hazard and contradict "No commentary inside the block." A's *requirement* survives
(the flag must live where the author actually reads, not only in `Author
questions`); the mechanism changes: add a mandatory **`Added bridges:` line
immediately after the `Revised text` block**, quoting each added sentence that
states why an assumption or identification claim holds (or `None.`). The fenced
block stays clean; the flag stays adjacent to what the author reads.

**Conflict 4: grant proposals (A: declare in scope; B: ambiguous, decide and pin).**
Middle path. The genuinely broken state is the superposition
(`structural-patterns.md` ships grant guidance while scope excludes it). Resolution:
keep the reference section but mark grants **explicit-request only, never an
auto-trigger**: the description stays paper-scoped, "When NOT to use" says grants
are served only on explicit request with the same constraints, and B's trigger-eval
#5 gets its pinned expected answer (no auto-invoke). This preserves the useful
guidance without scope creep, and fits the addendum's paper-centric reading lanes.

**Conflict 5: scope verdicts vs the addendum (A: citation integrity out of scope,
venue compliance light; B addendum: in scope when tools exist).** Not a true
conflict once conditioned on the tool surface. A's verdicts were correct *under
`allowed-tools: Read Edit Grep Glob`*: with no retrieval, a "citation check" is
memory, and memory-cited references are fabrication, precisely why A said "declare
out of scope so users don't assume it happened." The addendum removes the premise
(capability-gated lanes, "retrieved, not remembered", "provenance or it does not
exist"), and its no-forking-paths norm addresses the HARKing risk head-on. Adopt
the addendum, with two refinements:

1. **Gate tools per lane, not on the shared skill.** The addendum's A4 widens the
   skill's `allowed-tools` to include `Bash`, `WebFetch`, `WebSearch`. That widens
   *every* invocation, including plain editing passes, and undoes the deliberate
   minimal footprint `AUDIT.md` chose for the editor. Cleaner: keep `SKILL.md` at
   `Read Edit Grep Glob`; ship the analyst and scholar lanes as their own commands
   and subagents (`paper-analyst`, `paper-scholar`) carrying their own tool lists
   and their own reference files (`analysis-integrity.md`,
   `literature-checks.md`). Same capabilities, same gating, smaller blast radius,
   and the editor lane's safety audit stays valid unchanged.
2. **Keep both stop rules.** The addendum's exit criterion (a cold read of the
   whole paper comes back clean and the colleague test matches `core_thesis`) is
   the right *product* goal; keep "remaining edits would be merely different rather
   than better" as the editor lane's *internal* stop so chasing delight can never
   justify churn edits. The two compose: the cold read decides whether another
   dispatch happens; the editor rule decides when a dispatched pass stops.

With that, A's E-table verdicts are formally superseded as follows: citation
integrity → in scope in the scholar lane when retrieval exists, otherwise the
honest README line still applies verbatim; venue compliance → moves from
`/paper:consistency` bolt-on to the cold-read pass; A's "flagship is the loop"
framing → the loop's Step 1 (per-section feedback sweep) is replaced by
`/paper:read`, and the loop survives as the sequencing protocol the dispatch list
feeds.

## 5. Merged action plan (supersedes both F sections)

**Quick wins** (order matters only for the first two):
1. New constraint 1, no-new-substance (B-G2), threaded through `paper-reviser.md`
   and `loop.md` guardrails (which also gain the missing "meaning of a technical
   claim" rule). Then reorder the block science-first with the em-dash rule last,
   carrying: the quote exception (B), the `style_overrides:` opt-out (A), the
   citation-wall Author-questions rule (B-D6), the caption carve-out (B-E8), the
   qualifier-is-content rule (B-G5), and the generalized any-format markup wording
   (A-G7).
2. Output-destination rule (B-G3, which includes A-G3), plus B's loop checkpoint
   note.
3. Merged frontmatter description (B-G1 base + "line-edit").
4. Reviewer workflow additions: overclaim guard + conflict rule (B-G6 wording) +
   the `Added bridges:` output line (conflict 3 resolution).
5. Diagnosis-header decision table (B-G10, which subsumes A-G4 and fixes the
   line-212 duplicate); `exposition.md` becomes the single owner of the
   extraction-line spec.
6. Read-cold scoping fix (B-D5). Approximate word counts (both).
7. Example repairs as one batch: extraction lines into `worked-example.md`;
   metadata-injection fix in `exposition-methods.md` (B-G7); "verbatim" rationale
   fix in `exposition-results.md`; `[P#]` labels out of the fenced block; and an
   A-D2 pass on `exposition-introduction.md`'s bridge against the new constraint 1.
8. `install.sh` stage default + validation (B-G8). Single `$ARGUMENTS`
   interpolation (B-C9). README fixes (B-G11 + A-G8 chat-surface note).
9. Consistency pass de-cap (A-C7).

**Medium:**
10. Context fallback, merged rule from conflict 2 (B-G4 + A's restrictive-only
    inference).
11. `/paper:triage` (both reviews, near-identical specs).
12. `/paper:letter` under B-G9's license ("may restate what the revision did; must
    never promise analyses or claims the manuscript does not contain") + example.
13. Monolithic-file handling + "cut to fit" routing (B-C4, B-E6b).
14. Messy-input/Formats section (both) + dispatch-completeness rule (B-C8).
15. CI: merged block = B-M8 format conformance + A's `check-protected.sh` over the
    examples + cross-file link check (both) + B's extraction-line consistency check
    (fails today on `worked-example.md`, by design).
16. Author-edit preservation rule (both). Consistency checklist into
    `references/` (B-M7). Optional: `sentence-cohesion.md` merge (B-M6; low
    priority, mild payoff).

**Larger (the addendum, sequenced as B proposes, with refinement 1 above):**
17. `/paper:read` + `references/cold-read.md`; replace loop Step 1.
18. Master-rule split (B-A2 wording), which lands naturally on top of the new
    constraint 1.
19. `/paper:verify-numbers` (verification only) + `analysis-integrity.md`, as its
    own gated agent.
20. `/paper:scholar` + `literature-checks.md` (citation verification before novelty
    scan), as its own gated agent.
21. Analyst capabilities 2-3 (figures, new analyses) last. B's response-suite
    redesign (triage → rebut → consistency → letter) ships alongside, since items
    11-12 provide its parts.
22. Installer test harness (B), or shrink the installer surface to fit the testing
    budget; either resolves the "684 lines, zero CI on its highest-churn logic"
    finding.

## 6. Canonical patch selection

Where both reviews patched the same location, use:

| Location | Use | Note |
|---|---|---|
| Frontmatter description | B-G1 + "line-edit" | Grants stay out per conflict 4 |
| No-substance constraint | B-G2 verbatim | A had no equivalent constraint text |
| Output destination | B-G3 | Strict superset of A-G3 (adds the unresolved-questions guard and the loop note) |
| Context fallback | B-G4 + one sentence of A-G2 inference (restrictive stages only) | Conflict 2 |
| Qualifier guard | B-G5 verbatim | |
| Reviewer workflow rules | B-G6 verbatim | A's versions materially identical; B's phrasing more operational |
| Bridge marking | Neither as written; the `Added bridges:` line from conflict 3 | B's D10(d) invalidates A's inline mechanism |
| Constraints reorder | A-G7 structure, folding in B's quote exception, caption carve-out, citation-wall rule | A's was the full-block rewrite |
| Diagnosis decision table | B-G10 | Subsumes A-G4; also fixes line 212 |
| `--init` stage handling | B-G8 verbatim | A missed the finding |
| Rebut letter license | B-G9 verbatim | A-F11's location-verification rule folds into `/paper:letter`'s spec |
| README fixes | B-G11 + A-G8 chat note + A's comment-table wording (A-G9) for rebut output | |
