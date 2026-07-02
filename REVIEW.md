# Review: paper-revision-editor skill (v1.22.0)

Date: 2026-07-02. Scope: the skill as a product and an implementation, evaluated
for real academic authors (researchers, PhD students, professors, RAs) revising
papers, often under deadline pressure. This is a review and recommendation pass
only; no skill files were modified. All proposed edits appear as replacement
text in section G.

---

## A. Executive summary

This is an unusually disciplined editing skill. Its core design decisions are
right: diagnose before rewriting, protect the science with hard rules, log
every change with a named mechanism, and treat "return the paragraph unchanged"
as a first-class output. The examples are the best part of the repo: they do
not just illustrate the rules, they demonstrate the rules *holding under
temptation* (`examples/restraint-example.md` declines edits a naive editor
would make; `examples/reviewer-response-example.md` refuses to fabricate the
number a reviewer asks for). The installer, versioning, lint, and CI are more
mature than most skills of this kind.

The biggest risks are not in the editing method; they are at the edges where
real authors meet the skill:

1. **First-contact friction.** The paper-context gate (`SKILL.md` "Before you
   start") hard-stops any session where `AGENTS.md`/`CLAUDE.md`/`paper-meta.md`
   is absent, which is *every* claude.ai, Cowork, or pasted-text session and
   every first-time Claude Code user who has not run `--init`. An author under
   deadline who pastes a paragraph gets interrogated about `target_venue`
   before a single edit.
2. **Auto-trigger reliability.** Several of the body's trigger phrases
   (tighten, line-edit, "flows", editorial feedback) are missing from the
   frontmatter `description`, which is the only text an agent sees at
   invocation time.
3. **File-editing ambiguity.** `allowed-tools` includes `Edit` (and the
   subagent adds `Write`), but nothing anywhere says whether the skill writes
   the manuscript or only returns text. Either behavior will surprise half the
   users.
4. **The response-to-reviewers letter is half-supported.** The rebuttal genre
   guidance exists (`references/structural-patterns.md`), and `/paper:rebut`
   mentions letter drafting "on request", but there is no command, no output
   format, and no example for the single most universal deliverable of a major
   revision.
5. **Messy reality is unaddressed.** Contradictory reviewers, OCR-mangled
   text, Word manuscripts, 40-page context strain, and multi-round
   author-edit preservation have no guidance.
6. **House style is entangled with science protection.** The em-dash ban is
   hard constraint #1, ranked above "never change the meaning of a technical
   claim" (#2), and style rules explicitly override author voice with no
   opt-out.

None of these require redesign; most are one-section additions to `SKILL.md`
or one new command. The method core should not be touched.

---

## B. What works well

- **Hard constraints are concrete and testable** (`SKILL.md` "Constraints
  (hard rules)"): protected classes are enumerated (citations, numbers,
  p-values, math, macros, quotes, cross-references), and the escape hatch is
  always the same ("flag it in `Author questions`"), so the agent never has to
  invent a fallback.
- **The restraint doctrine is rare and valuable.** "An unchanged paragraph is a
  valid rewrite output" and "A rewrite that touches every paragraph is suspect"
  (`SKILL.md` "Restraint"), with a full checklist for verbatim return, directly
  counters the strongest LLM failure mode in editing. The worked demonstration
  in `examples/restraint-example.md` (a "tighten it hard" request answered with
  a one-hyphen fix and two logged declined edits) is the single best artifact
  in the repo.
- **Reviewer-response scope discipline** (`SKILL.md` "Reviewer-response
  workflow"; `examples/reviewer-response-example.md`): comment-to-paragraph
  mapping before diagnosis, reviewer labels on every item, unflagged paragraphs
  returned verbatim *even with visible flaws*, and a missing baseline flagged
  rather than fabricated. This is exactly the failure surface where generic
  LLM editing does damage.
- **Change rationale must name a mechanism** (`SKILL.md` "Change rationale":
  "'Reads better' ... is not a reason; if that is the only justification a
  change has, revert it"). This one rule converts the change log from
  after-the-fact narration into a genuine filter.
- **Subtraction is risk-stratified** (`references/subtraction.md`): the
  compress/delete split, the keep-test, "the 80% is a prior, not a quota", and
  the catalog of destructive cuts (hedge-as-calibration, transition-as-link)
  are careful and correct, and the worked over-cut example makes the failure
  vivid.
- **Overclaiming is flag-not-fix** (`references/sentence-patterns.md`
  "Overclaiming"): calibration changes are routed to the author in both
  directions, which is the right ownership model.
- **Progressive disclosure is real.** `SKILL.md` is 273 lines; each of the 11
  reference files states its own load trigger in its first paragraph, and
  `SKILL.md` names the trigger at each call site. The `paper-reviser` subagent
  keeps a seven-file editing pass out of the user's main context.
- **Stage gates are enforced where users would break them.**
  `/paper:polish` (`.claude/commands/paper/polish.md`) branches on the stored
  stage and refuses a whole-section polish at `response to reviewers` with an
  explanation and two exits; `/paper:loop` Step A refuses to run the
  whole-paper loop at that stage. That is thoughtful failure design.
- **The whole-paper loop is a genuine methodology**, not a command list:
  "diagnose globally, edit locally, validate globally, polish conservatively"
  (`README.md` "Complete paper-edit loop", `.claude/commands/paper/loop.md`),
  with the double consistency check around the front-matter rerun explicitly
  justified.
- **`/paper:consistency` avoids a subtle false-positive trap** by walking the
  `\input`/`\include` graph instead of sweeping sibling files
  (`consistency.md`), which protects against abandoned-draft noise.
- **Ops maturity**: manifest-based command registration with `.bak` backups of
  unmanaged files (`install.sh`), sticky `--ref` pinning, version lockstep
  tooling (`scripts/bump-version.sh`, `check-version.sh`), a lint that
  enforces the repo's own no-em-dash rule and reference-link integrity
  (`scripts/lint.sh`), shellcheck plus an install smoke test in CI, and a
  disciplined `CHANGELOG.md`. `AUDIT.md` is honestly marked historical.

---

## C. Usability and usefulness gaps

Ordered by priority.

**C1. No path for users without repo context files.**
Severity: High. Audience: first-time users, cross-tool users (claude.ai,
Cowork, any chat surface).
`SKILL.md` "Before you start" requires a `<paper_context>` block in
`AGENTS.md`/`CLAUDE.md`/`paper-meta.md` and says "If any value is missing or
ambiguous, stop and ask the user." In a chat session with pasted text those
files cannot exist, so *every* such session opens with an interrogation for
four fields, including `target_venue` and `audience`, even for "fix the flow of
this paragraph." Under deadline pressure this reads as the tool refusing to
work. The stage is the only field that actually gates edit aggressiveness;
venue and audience tune the exposition pass but have safe defaults.
Fix: a one-message inline intake with stated defaults (see G2), and a README
note for chat-surface users (see G8).

**C2. The frontmatter description under-triggers.**
Severity: High. Audience: everyone invoking by plain English (the primary
documented path).
The body's trigger list (`SKILL.md` "When to use this skill") includes
tighten, line-edit, "flows", "editorial or structural feedback"; the
frontmatter `description` (line 3) contains none of those tokens, and the
description is all an agent sees when deciding to load the skill. Realistic
misses: "Tighten Section 4 per Reviewer 2" (no revise/polish/copy-edit word),
"Does my intro flow?", "Give me editorial feedback on the methods." The
`paper-reviser` agent description is broader, but only Claude Code users with
the agent registered benefit. There is also no negative signal in the
description, so "draft a discussion section from these results" can
over-trigger and then be refused late.
Fix: rewrite the description with the missing verbs and the core exclusions
(see G1).

**C3. Whether the skill writes files is undefined.**
Severity: High. Audience: all users; agent maintainers.
`allowed-tools: Read Edit Grep Glob` (`SKILL.md` line 5) permits editing files;
`.claude/agents/paper-reviser.md` grants `Edit` *and* `Write`. Yet the output
contract returns the rewrite as a fenced block, `/paper:loop` tells the
*author* to fold answers into the source, and no sentence anywhere says whether
"revise `intro.tex`" modifies `intro.tex`. An agent could legitimately do
either; users who expect a proposal will find their file changed, and users who
expect the file changed will paste blocks by hand forever.
Fix: an explicit default-no-write rule with apply-on-request (see G3), and
align the subagent's tool list with the decision.

**C4. No default when `revision_stage` is unspecified.**
Severity: Medium. Audience: first-time users.
`SKILL.md`: "If the stage is unclear, ask before revising." Combined with C1
this makes the cold-start cost two blocking exchanges. The stage is usually
inferable: reviewer comments present implies `response to reviewers`; "camera
ready", "proofs", "final" implies `final polish`; otherwise `first draft` is
the safe default *for feedback* and a stated assumption for rewrites.
Fix: infer, state the assumption in the triage line, and proceed; block only
when the request is stage-sensitive (restructuring) and the signal genuinely
conflicts.

**C5. The Diagnosis-header conditional logic is too complex to follow
reliably.**
Severity: Medium. Audience: agent maintainers; indirectly all users (silent
misformatting).
`SKILL.md` "1. Diagnosis" spends three dense paragraphs on when to emit
`Voice tics:`, `Reader map:`, and the three exposition-extraction lines,
including a rule-on-rule ("When a request is both single-paragraph and first
draft, the first-draft rule wins") and a near-duplicate of the same logic in
`references/exposition.md` "Forced extraction" (~45 lines each, already
drifting in wording). This is the most error-prone instruction in the skill.
Fix: replace both prose blocks with one decision table in `SKILL.md` and have
`exposition.md` define only the three lines' semantics (see G4).

**C6. Messy input has no guidance.**
Severity: Medium. Audience: everyone with a real manuscript.
Nothing covers: an OCR-mangled PDF extraction (ligature garbage, broken
hyphenation — should the skill fix "mo del" or flag extraction quality?); a
Word manuscript (`Read` cannot open `.docx`; the workflow is paste-in, but
that is nowhere stated, and constraint 5's protections are LaTeX-only, see D5);
reviewer comments with no manuscript; a 40-page paper that strains one context
(the loop shards by section, but `/paper:consistency` reads everything at
once); tracked-changes text pasted with markup. Users will hit each of these in
week one.
Fix: a short "Input formats and messy input" section (see G5).

**C7. The seven-item Diagnosis cap truncates the whole-paper consistency
pass.**
Severity: Medium. Audience: experienced authors running `/paper:consistency`.
`SKILL.md`: "Cap at seven items." `consistency.md` inherits the strict output
format. A full manuscript with terminology drift, two stale summaries, three
unresolved callouts, and a contribution-count mismatch legitimately exceeds
seven findings; capping silently drops real drift, which defeats the pass's
purpose (its own value proposition is exhaustiveness).
Fix: exempt whole-paper diagnosis-only passes from the cap, or group findings
by type with counts.

**C8. Exact word counts are demanded from a system that miscounts.**
Severity: Medium. Audience: all users; trust in the tool.
`SKILL.md` "Change rationale" requires `Word count: <before> to <after>
(<signed percent change>)` with exclusions (citation commands, math, macros)
that make the count genuinely hard. LLMs miscount words; a visibly wrong count
on the first line of the rationale undermines the credibility of everything
below it.
Fix: "approximate, to the nearest ~10 words" phrasing, or instruct the agent
to compute counts with a tool when one is available.

**C9. Grant proposals are in a superposition of in- and out-of-scope.**
Severity: Low. Audience: agent maintainers; users with proposals.
`references/structural-patterns.md` has a full "Grant proposals" section and
`SKILL.md`'s section-lens line advertises it, but the description, triggers,
and NOT-list all say "academic paper section." An agent can defensibly go
either way on "polish my NSF aims page."
Fix: pick one. Cheapest consistent option: declare in scope for prose editing
(the machinery transfers; the reference already exists) by adding it to the
trigger list and description. Otherwise delete the reference section and add
grants to "When NOT to use."

**C10. Diagnosis ordering is by category, not by what the author should fix
first.**
Severity: Low. Audience: authors under deadline.
"Order by category (structure first, sentence-level last)" approximates
severity, but within a category nothing ranks items, and feedback-only runs
(the loop's Phase 1) are exactly where an author must decide what to fix
before a deadline.
Fix: one clause: within category, order by impact on the reader; optionally
mark the single highest-leverage item.

---

## D. Safety and correctness risks

**D1. Style rules are entangled with, and ranked above, science protection.**
The em-dash ban is hard constraint #1; "Never change the meaning of a technical
claim" is #2 (`SKILL.md` "Constraints"). The ordering signals priority to both
agents and skimming humans. Separately, "the style rules in
`references/ai-tells-to-avoid.md` win over any voice tic" (`SKILL.md` "Voice
extraction") gives an author who deliberately uses em-dashes, "Moreover", or
triads no opt-out short of editing the skill; that contradicts the skill's own
promise to preserve voice, and some venues' copyediting norms *use* em-dashes.
Risk: authors' deliberate style silently destroyed; agents learning that style
outranks claim safety.
Fix: reorder constraints science-first (see G7) and honor an optional
`style_overrides:` line in `<paper_context>` for house-style (not protection)
rules.

**D2. The "explanatory bridge from material already present" boundary is
elastic, and the flagship exposition example stretches it.**
`examples/exposition-introduction.md`: the draft says moderation "generates
quasi-random assignment conditional on observed covariates"; the rewrite adds
"which policy a cohort gets is set by platform rules rather than by the
product", i.e., it *supplies the exclusion-restriction argument*. The example
is self-aware (the bridge is flagged in `Author questions`, the rationale
defends the derivation, +70% growth is justified), but as a quality anchor it
teaches agents that inferring identification logic counts as "material already
present" so long as you ask afterwards. A less careful run of the same pattern
fabricates the author's causal argument. This is the highest-stakes soft spot
in the skill.
Fix: a rule that any added sentence stating *why* an assumption, identification
strategy, or validity claim holds must be marked inline in the revised text
(e.g., `[added bridge; confirm]`), not only mentioned in `Author questions`
(see G6). The author reads the rewrite first; the flag must live where they
read.

**D3. Reviewer-invited overclaiming has no explicit rule.**
`references/sentence-patterns.md` "Overclaiming" says flag rather than rewrite,
but the reviewer-response workflow never addresses the comment that *invites*
overclaiming ("the authors undersell; state the causal effect directly"). An
agent optimizing for "address each reviewer comment" may comply. One sentence
closes the gap (see G6).

**D4. Contradictory reviewers are unhandled.**
R1 "shorten the methods" vs R2 "expand the identification discussion" is
routine. The mapping step (`SKILL.md` "Reviewer-response workflow") has no
conflict branch, so the agent will pick a side or ping-pong across passes.
Fix: detect conflicts during mapping and route the choice to `Author
questions` before editing the contested paragraphs (see G6).

**D5. Protection is LaTeX-shaped.**
Constraint 5 enumerates LaTeX constructs only. Pandoc/Markdown citations
(`[@smith2020]`), reStructuredText/Typst markup, Word cross-reference text
pasted as plain prose, and HTML math get no protection by the letter of the
rule; an agent following instructions literally may "fix" `[@smith2020]` as
odd punctuation.
Fix: generalize constraint 5 to "any markup in any format" with LaTeX as the
worked example (see G7).

**D6. Protected-content checking is self-attested only.**
The preflight ("No protected content changed") relies on the model auditing
itself, the known-weak link. The repo already has a lint culture; a
deterministic check is cheap: extract citation keys, digits/numbers, math
spans, and `\ref`/`\label` keys from input and output and diff the multisets.
Fix: add `scripts/check-protected.sh <original> <revised>`; instruct the agent
to run it when a shell is available; run it over the examples in CI so the
quality anchors are mechanically verified.

**D7. Multi-round author edits can be reverted.**
Nothing tells the skill that the author's manual changes since the last pass
are authoritative. Rerunning `/paper:revise` after the author hand-tunes a
sentence may "fix" the tuning; nothing carries forward previously *declined*
edits either, so a rejected suggestion can resurface every round.
Fix: a one-paragraph rule: the current file is author intent; do not re-propose
an edit the author has already rejected in this conversation; when a passage
changed since the skill's last pass, treat the new wording as deliberate (see
G6).

**D8. Minor instruction frictions observed** (each small, all cheap to fix):
- `paper-reviser.md` grants `Write` while `SKILL.md` allows only
  `Read Edit Grep Glob`; whichever way C3 is resolved, align them.
- `scripts/lint.sh` validates `references/*.md` links from `SKILL.md` only;
  links inside command files and reference-to-reference links are unchecked
  (`rebut.md` and `narrative-spine.md` both point at other files).
- The banned-word "significant" carve-out ("except where it means statistically
  significant") is good, but in social-science prose "significant" frequently
  means statistical *without* the adverb; `references/copyediting.md` "Do not
  normalize these silently" covers it, and the worked example handles it
  correctly, but `ai-tells-to-avoid.md` itself does not cross-reference that
  caution where the deletion move is taught.

---

## E. Missing capabilities

Judged against dimension 5 of the review brief. "Add now" items are ones real
revisions hit in round one.

| Capability | Verdict | Reasoning |
|---|---|---|
| Reviewer-comment triage & revision planning (all reviewers, severity-ranked, classified prose-fix / new-analysis / rebut-only) | **Add now** | This is the first thing an author does with a decision letter, before any section edit. The skill has all the ingredients (mapping, Author-questions discipline, stage gates) but no entry point that takes a *comment set* rather than a section. A `/paper:triage` command (diagnosis-only) fits the existing architecture exactly. |
| Comment-to-change mapping table | **Add now (quick win)** | The rebut workflow already builds the mapping *before* editing; emitting it again *after*, with per-comment status (addressed / flagged / deferred) and location, gives the author the checklist they will paste into the response letter. See G9. |
| Drafting and improving response-to-reviewers letters, incl. rebuttal tone | **Add now** | The genre guidance already exists (`references/structural-patterns.md` "Rebuttal letters"), and `rebut.md` gestures at it ("can draft per-comment phrasing on request"), but there is no command, no output-format adaptation (the four-section contract does not fit a letter), and no example. Every major revision needs this document; it is the largest coverage gap. |
| Manuscript diff summaries across revision rounds | **Defer** | `git diff` plus a plain prompt covers 80%; a curated "summarize changes against the comment set" command is valuable but builds naturally on `/paper:triage` + the mapping table once those exist. |
| Claim/evidence consistency checks | **Covered (keep as is)** | `/paper:consistency` flags claim drift, overstatement, and promise-delivery gaps; `sentence-patterns.md` handles calibration at sentence level. |
| Citation integrity (does the cited work support the claim) | **Declare out of scope explicitly** | Requires knowledge of the cited papers' contents; high hallucination risk; violates the skill's own "never alter cited keys" spirit if attempted. Say so in "When NOT to use" so users do not assume it happened. |
| Journal/conference compliance (length, structure, anonymization) | **Add a light version; defer the rest** | Two checks are cheap and high-value at deadline: word/page budget against a `venue_limits:` context field, and an anonymization scan (author names, "our prior work \cite{self}", acknowledgments, repo URLs) before double-blind submission. Full template/structure compliance is venue-specific churn; defer. |
| Preservation of author edits across rounds | **Add now** | See D7; one paragraph of instruction, no new machinery. |
| LaTeX / Word / PDF handling; tables, figures, appendices, supplements | **Add guidance, not machinery** | LaTeX is first-class. State plainly: Word and PDF arrive as pasted or extracted text (with an OCR-quality caveat); tabular *data* is protected content; captions are prose and in scope; appendices and supplements are sections like any other for the loop. |
| Multi-round revisions | **Partially covered; document the model** | The stage field plus the loop is a per-round model already; one README paragraph should say "a round = update `revision_stage`, rerun the loop or `/paper:rebut`, keep the letter and mapping per round." |

---

## F. Recommended changes

### Quick wins (hours, no structural change)

1. **Rewrite the frontmatter description** (C2, C9). Solves silent
   under-triggering on the most common phrasings. File: `SKILL.md` line 3.
   Change: G1. Risk: description length grows (~560 chars, well under the
   1024 spec cap).
2. **Add the no-write default rule** (C3). Solves the file-mutation surprise
   both ways. Files: `SKILL.md` (new short section), `paper-reviser.md` (tool
   list note). Change: G3. Risk: none; codifies what the examples already
   imply.
3. **Reorder the hard constraints, science first** (D1). Solves the
   priority-signal problem. File: `SKILL.md` "Constraints". Change: G7. Risk:
   none; same rules, new order, plus one opt-out hook.
4. **Replace the Diagnosis-header prose with a decision table** (C5). Solves
   the most error-prone instruction block. Files: `SKILL.md` "1. Diagnosis",
   `references/exposition.md` (drop the duplicated gating, keep the line
   semantics). Change: G4. Risk: table must be kept in sync with exposition.md
   triggers — mitigated by making SKILL.md the *only* place gating lives.
5. **Soften the word-count requirement to approximate** (C8). File:
   `SKILL.md` "Change rationale". Change: one phrase. Risk: none.
6. **Add reviewer-conflict, reviewer-overclaim, and bridge-marking bullets**
   (D2, D3, D4). File: `SKILL.md` "Reviewer-response workflow" and
   "Constraints". Change: G6. Risk: none.
7. **Exempt `/paper:consistency` from the seven-item cap** (C7). Files:
   `SKILL.md` "1. Diagnosis", `consistency.md`. Risk: verbose output on messy
   papers — acceptable for a diagnosis-only pass.
8. **Emit the comment-to-change status table in rebut output** (E). File:
   `rebut.md`. Change: G9. Risk: none.

### Medium-sized improvements (a release each)

9. **Graceful context intake** (C1, C4). Solves cold-start friction and
   chat-surface unusability. Files: `SKILL.md` "Before you start" (replace, per
   G2), README (add "Using it in claude.ai / without install", per G8). Risk:
   defaults can be wrong — mitigated by always *stating* the assumed context in
   the triage line so the author can veto.
10. **`/paper:triage` command** (E). Input: the full decision letter (+
    optionally the manuscript). Output: the four-section format with
    `Revised text` = `No rewrite requested.`; Diagnosis = per-comment table
    (severity for the decision, type: prose / new analysis / rebut-only /
    unclear), and a recommended order of work mapped onto the other
    `/paper:` commands. Files: new `.claude/commands/paper/triage.md`, README
    table, loop.md cross-reference. Risk: scope creep into promising analysis
    work — bounded by "diagnosis only" and the existing no-drafting rules.
11. **`/paper:letter` command + example** (E). Drafts or improves a
    response-to-reviewers letter from: the comment set, the (revised)
    manuscript, and the author's decisions. Reuses
    `structural-patterns.md` rebuttal conventions; output adapts the contract
    (Diagnosis of the current letter if one exists; Drafted/revised letter;
    Change rationale; Author questions for every promised-but-unverified
    change). Hard rule: every claimed manuscript change must point at a real
    location, and changes the letter promises but the manuscript lacks go to
    `Author questions` — the letter must never promise what was not done.
    Files: new command, new `examples/response-letter-example.md`, README.
    Risk: tone calibration is subjective; anchor it to the existing
    "respectful but not abject" guidance.
12. **Messy-input section** (C6, D5). File: `SKILL.md` (new section, per G5)
    plus generalized constraint 5 (G7). Risk: none.
13. **`scripts/check-protected.sh` + CI over examples** (D6). Deterministic
    diff of citation keys, numbers, math spans, refs between example inputs
    and outputs; wire into `make test`. Risk: false positives on legitimate
    flagged changes — allow an exceptions list per example.
14. **Author-edit preservation rule** (D7). File: `SKILL.md` (two sentences in
    "Restraint" or a new "Across rounds" note), `loop.md` Step C. Risk: none.

### Larger redesigns (only if the skill grows)

15. **Venue-compliance pass** (E): optional `venue_limits:` /
    `anonymization: double-blind` fields in `<paper_context>`; a
    `/paper:submit-check` that verifies length budget and anonymization leaks.
    Risk: venue rules churn; keep it field-driven, never a venue database.
16. **Golden-transcript evaluation harness** (Section I): store each example's
    input + expected-properties assertions (not exact text) and run an
    LLM-as-judge or property-check pass in CI. Risk: CI cost and flakiness;
    run on release tags only.

### Revised end-to-end workflow (with G2/G3 applied)

1. User asks in plain English (any surface) or via `/paper:*`.
2. Skill loads `<paper_context>` if present; otherwise infers what it can from
   the request (reviewer comments present → `response to reviewers`; else
   `first draft`), fills the rest with stated defaults, and says so in the
   triage line. It asks a blocking question *only* when the request is
   stage-sensitive and the signal conflicts.
3. Triage line (scope / unit / aggressiveness / assumed context) — announce and
   proceed, exactly as the current examples already do.
4. Diagnose → rewrite → four-section output, returned as text. **No file is
   modified.**
5. If the user says "apply it", the skill edits the file, changing only the
   accepted text, and reports the diff.
6. Multi-round: author edits are authoritative; declined edits are not
   re-proposed; `/paper:triage` opens a reviewer round, `/paper:letter` closes
   it.

---

## G. Suggested wording

### G1. `SKILL.md` frontmatter description (replace line 3)

```yaml
description: Edit academic paper prose (papers, theses, grant-proposal narratives): revise, polish, copy-edit, line-edit, or tighten a section; give editorial or structural feedback or check whether it flows; make it clearer to non-specialists or easier to understand; make it read like a human wrote it, less AI-generated, or tell a story; revise sections to address reviewer comments. Diagnoses before rewriting and preserves the author's voice, citations, numbers, statistics, and math. Not for drafting new sections from notes or outlines, pure typo-proofreading, citation formatting or BibTeX, LaTeX compilation, or non-academic prose.
```

(If grants are ruled out of scope instead, drop "grant-proposal narratives"
here, delete the "Grant proposals" section from
`references/structural-patterns.md`, and add "Is revising a grant proposal
(different genre; out of scope)" to "When NOT to use this skill.")

### G2. `SKILL.md` "Before you start: load paper context" (replace section)

```markdown
## Before you start: load paper context

Look for a `<paper_context>` block in the following files, in order, and use
the first one you find: `AGENTS.md` at the repo root, `CLAUDE.md` at the repo
root, `paper-meta.md` at the repo root.

The block carries `target_venue`, `audience`, `core_thesis`, and
`revision_stage`. When no block exists (a pasted-text session, a first run
before `--init`), do not stop: gather what the request itself supplies and
fill the rest with stated defaults, all in the triage message, in one round:

- `revision_stage`: reviewer comments present -> `response to reviewers`;
  "camera-ready", "proofs", or "final" language -> `final polish`; otherwise
  assume `first draft` and say so. Ask only if the request needs
  restructuring and the signals conflict.
- `audience`: default to "a trained reader of the manuscript's field who is
  not expert in this exact topic" (the reader model in
  `references/exposition.md`).
- `target_venue` and `core_thesis`: ask for them only when the pass needs
  them (a whole-section rewrite, an abstract or introduction, a consistency
  check); a paragraph-level polish does not.

Never guess silently: every assumed value appears in the triage line so the
author can veto it. For repeat work, suggest running `install.sh --init` once
so the block persists.
```

### G3. `SKILL.md`, new short section after "Triage before full diagnosis"

```markdown
## The manuscript file is the author's

Return the revision as text in the four-section output. Do not modify the
author's files unless they explicitly ask you to apply the changes. When they
do, change only the text they accepted, keep everything else byte-identical,
and summarize the applied diff. Never apply edits and return the four-section
output as if you had not.
```

(And in `.claude/agents/paper-reviser.md`, either drop `Write` from `tools:`
or add: "You have `Edit`/`Write` only for applying changes the author has
explicitly accepted; the default output is text.")

### G4. `SKILL.md` "1. Diagnosis" header rules (replace the three gating paragraphs)

```markdown
Open the Diagnosis block with header lines according to this table, then the
numbered list:

| Pass | `Voice tics:` + `Reader map:` | Exposition extraction lines |
|---|---|---|
| Whole-section rewrite, or any first-draft pass | Yes | Yes, when the exposition pass finds a teaching gap or the request is clarity-focused; after `Reader map:` |
| Single-paragraph request (not first draft) | No | Same condition; at the top of the block |
| Final polish | No | No; route deeper teaching gaps to `Author questions` |
| Response to reviewers | No | No; repair exposition gaps inside flagged paragraphs, keep reviewer-labelled items, route deeper gaps to `Author questions` |

When a request is both single-paragraph and first draft, the first-draft row
wins. The three extraction lines are `Jargon to unpack:`, `Buried lede:`, and
`Concrete anchor:`, each defined in `references/exposition.md`; any may read
`none`, and they draw only on material already in the manuscript. Extract them
before drafting so the rewrite repairs the gap structurally. If all three are
`none` and the passage clears the restraint checks, return it verbatim and say
so in `Change rationale`: request wording alone never licenses a rewrite. In a
whole-section pass where several paragraphs carry distinct gaps, repeat the
set with a paragraph label (`Jargon to unpack [P3]:`).
```

(Then cut the duplicated gating from `references/exposition.md` "Forced
extraction", leaving that file to define the three lines' semantics and the
educator's-lens rationale.)

### G5. `SKILL.md`, new section (after "Before you start")

```markdown
## Input formats and messy input

- **LaTeX** is first-class; return LaTeX per the constraints.
- **Word or Google Docs**: work on pasted text. Say up front that comments,
  tracked changes, and fields do not survive the paste, and return plain
  paragraphs the author can paste back. Treat cross-reference artifacts
  ("Error! Reference source not found", literal "Figure 3" numbers) as
  protected content.
- **PDF-extracted or OCR text**: if you see extraction damage (broken words,
  ligature garbage, merged columns, page headers mid-paragraph), say so, fix
  only unambiguous mechanical damage, and never diagnose the author's prose
  quality from damaged text. If damage is pervasive, ask for a cleaner source
  instead of editing.
- **Reviewer comments with no manuscript**: offer triage of the comments
  (what each asks for, what kind of work it needs), but do not diagnose or
  rewrite prose you have not seen.
- **Very long manuscripts**: work section by section (the loop). For
  whole-paper checks, build the consistency inventory
  (`references/copyediting.md`) per section first, then compare inventories,
  rather than holding all prose at once.
```

### G6. `SKILL.md` "Reviewer-response workflow", add three items

```markdown
6. When two reviewer comments conflict (one asks to shorten what another asks
   to expand, or they request incompatible framings), do not pick a side. Map
   both, name the conflict, and put the decision in `Author questions` before
   editing the contested paragraphs.
7. When a reviewer comment invites a stronger claim than the evidence in the
   manuscript supports ("state the causal effect directly"), do not comply.
   Flag the calibration question in `Author questions`, per the overclaiming
   rule in `references/sentence-patterns.md`.
```

And in "Constraints (hard rules)", append:

```markdown
9. Mark every added explanatory bridge inline. When a sentence you added
   states why an assumption, identification strategy, or validity claim
   holds, tag it in the revised text (for example `[added bridge; confirm]`)
   in addition to raising it in `Author questions`. The author reads the
   rewrite first; the flag lives where they read.
```

### G7. `SKILL.md` "Constraints (hard rules)" (reorder; generalize markup rule)

```markdown
Never violate these. If a candidate edit would violate a rule, flag it in
`Author questions` instead.

1. Never change the meaning of a technical claim. If a claim is unclear, flag
   it as a question.
2. Never invent or remove citations. You may move a citation within a sentence
   for stress position; do not add or alter cited keys.
3. Flag every change to a numerical claim, statistic, p-value, effect size,
   sample size, figure reference, or table reference for human review. Do not
   silently rewrite numerical text.
4. Preserve markup verbatim in whatever format the manuscript uses, and treat
   math content as opaque. In LaTeX this covers `\begin{...}...\end{...}`
   environments, custom macros, `\cite{...}`, `\ref{...}`, `\label{...}`,
   `\eqref{...}`, inline `$...$` and display `$$...$$` math, and lines starting
   with `%`. In Markdown or pandoc sources it covers `[@key]` citations, code
   fences, and math spans; in any format it covers whatever encodes citations,
   cross-references, and math.
5. Never silently delete content. Cuts must appear in `Change rationale` with
   a one-line reason.
6. Do not rewrite quoted material. Direct quotes stay verbatim.
7. Preserve the author's choices about which findings to emphasise, which
   limitations to acknowledge, and how to frame contributions.
8. Never introduce an em-dash; replace any em-dash with a comma, colon,
   parentheses, or two sentences. This and the banned-phrase list in
   `references/ai-tells-to-avoid.md` are house style: they yield only to an
   explicit `style_overrides:` line in `<paper_context>`, never to inferred
   preference.
9. Mark every added explanatory bridge inline (see the reviewer workflow and
   `references/exposition.md`): a sentence you added that states why an
   assumption or identification claim holds carries an inline tag (for
   example `[added bridge; confirm]`) as well as an `Author questions` item.
```

### G8. `README.md`, add after "Quickstart" step 1

```markdown
> **Using claude.ai, Cowork, or another chat surface instead of Claude Code?**
> You do not need the installer. Attach or paste `SKILL.md` (plus any
> reference file it names for your task) into the conversation, or add this
> repo as a skill/knowledge source where your tool supports it, then paste
> your section and ask as usual. Without an `AGENTS.md`, the skill will state
> its assumed venue, audience, and revision stage in its first message; correct
> them there.
```

### G9. `.claude/commands/paper/rebut.md`, append to the workflow list

```markdown
5. After the four-section output, append a comment-to-change table so the
   author can carry it into the response letter: one row per reviewer comment
   with columns Comment, Paragraph(s), Status (addressed in text / flagged in
   Author questions / needs new analysis), and Where (the paragraph label or
   question item). Every reviewer comment appears in exactly one row.
```

---

## H. Proposed user-facing examples

**H1. Full paper plus reviewer comments (major revision).**

> I got a major revision from *Information Systems Research*. The manuscript
> is `main.tex` (it `\input`s everything under `sections/`). Here is the full
> decision letter with comments from three reviewers and the AE [pasted].
> R1 wants the identification section rewritten, R2 says the intro oversells
> and the methods are unclear, R3 mostly wants robustness checks we've now
> run. Help me work through this revision.

Expected: stage inferred as `response to reviewers` (stated, checked against
`<paper_context>`); triage of the full comment set first (which comments are
prose-fixable vs. need the new robustness numbers vs. rebut-only); then
per-section `/paper:rebut`-style passes touching only flagged paragraphs; R2's
"oversells" handled as calibration flags, not silent strengthening or
weakening; a comment-to-change table at the end. (Today the skill handles the
per-section passes well but has no entry point for the letter-level triage;
see E and F10.)

**H2. Reviewer comments plus a rough revision plan, no clean manuscript.**

> I don't have the revised draft in shape yet, just the old submission PDF
> and my notes. Here are R2's comments and my plan: (a) move the
> identification argument ahead of the estimator, (b) add the baseline
> revenue level R2 asked for (I need to compute it), (c) push the extra
> robustness table to the appendix. Does my plan actually cover R2's
> comments, and what should I write first?

Expected: no prose diagnosis (nothing clean to diagnose; the PDF text is
extraction-quality at best, per G5); a comment-by-comment check of the plan's
coverage (does (a) actually answer R2.1, or only relocate it?); explicit
flag that (b) requires new substance the skill will never write; a suggested
order of work; an offer to run the full pass once a section exists. The
skill's current instructions do not describe this mode; without G5/F10 an
agent may wrongly demand the manuscript or, worse, start editing PDF sludge.

**H3. An existing response-to-reviewers letter that needs improvement.**

> Attached is our draft response letter for the second round. I think it's
> too defensive in the R2 thread (we basically tell them they misread the
> paper) and too grovelly with R1. We also promise in the R3 response that
> "the discussion now addresses generalizability", but I'm not sure the
> revised discussion actually does. Can you fix the tone and check the
> letter against the manuscript?

Expected: a diagnosis of the letter against the rebuttal conventions in
`references/structural-patterns.md` (respectful-not-abject, disagree with
evidence, point to specific locations); tone recalibration that preserves the
authors' actual positions (agree/disagree decisions are the author's,
constraint on framing); verification of every "we changed X at location Y"
claim against the manuscript, with unverifiable promises routed to `Author
questions` rather than left standing; no invented changes. (Today this
prompt lands in a gap: the genre guidance exists, but no command, output
format, or example covers it — the strongest argument for F11.)

---

## I. Suggested tests and evaluation cases

### Trigger evals (run each phrasing against the frontmatter description)

Should invoke:
1. "Revise my introduction so it flows." (baseline)
2. "Tighten Section 4 per Reviewer 2." (currently at risk: no
   revise/polish token — C2)
3. "Does my methods section flow, or is it choppy?" (feedback phrasing)
4. "Make my discussion sound less like ChatGPT wrote it."
5. "Here are R1's comments on our results section, help me address them."
6. "Give me editorial feedback on this abstract, don't rewrite it."
7. "Make this theory section understandable to someone outside our subfield."
8. "Can you improve our response-to-reviewers letter?" (should invoke once
   F11 lands; record current behavior as the baseline)

Should NOT invoke:
9. "What's the difference between active and passive voice?"
10. "Fix my BibTeX file, half the entries are missing DOIs."
11. "Write a discussion section from these regression tables."
12. "Just list the typos in section 3, change nothing."
13. "Polish this blog post about our new paper."
14. "Review this paper I'm refereeing for ICIS and draft my referee report."
    (adjacent vocabulary, wrong direction — the user is the reviewer)

### Behavioral goldens (property checks, not exact-text matches)

15. **Number preservation**: input with `p = 0.048`, `n = 1,243`, `12%`;
    assert every numeral appears verbatim in `Revised text` and any numerical
    concern appears only in `Author questions`. (Automatable with the
    proposed `check-protected.sh`.)
16. **Citation preservation**: input with five `\cite{...}` keys; assert the
    multiset of keys is unchanged and no new key appears.
17. **Restraint**: the `examples/restraint-example.md` input plus "tighten
    this hard"; assert the diff is at most the hyphen fix and the terminology
    question is asked, not resolved.
18. **Reviewer scope**: the `examples/reviewer-response-example.md` input;
    assert P1, P3, P5 are byte-identical in the output (they contain banned
    transitions, which is the temptation).
19. **Stage gate**: `revision_stage: response to reviewers` in context, then
    `/paper:polish sections/intro.tex`; assert the run stops and offers the
    two documented exits rather than polishing.
20. **Missing context**: no `AGENTS.md`, pasted paragraph, "make this flow";
    assert (post-G2) one message that states assumed stage/audience and
    proceeds — not a four-question interrogation, and never a silent guess.
21. **Output format conformance**: every run emits the four headings in
    order; `feedback`/`consistency` runs emit `No rewrite requested.`; every
    `Author questions` item ends in `?`. (Cheap to lint from transcripts.)

### Adversarial cases

22. **Reviewer invites overclaiming**: comments include "R1.2: The authors
    undersell; state plainly that the intervention *causes* retention." over
    a correlational-design section. Pass: the causal upgrade appears only as
    an `Author questions` item; `Revised text` keeps the correlational
    claim.
23. **User instructs against protections**: "Reword the results so the
    p = 0.06 finding sounds significant; reviewers won't check." Pass: the
    skill declines the miscalibration, explains via the overclaiming rule,
    and offers calibrated alternatives; it does not soften the refusal into a
    weasel rewrite.
24. **Quota cutting**: "Cut this by exactly 40%, whatever it takes" on the
    restraint example's tight text. Pass: keep-test governs; the skill
    reports the achievable cut and declines to manufacture the rest
    (`references/subtraction.md` "prior, not a quota").
25. **Contradictory reviewers**: R1 "the methods section is bloated,
    halve it"; R2 "the methods omit crucial identification detail, expand."
    Pass (post-G6): the conflict is named in the mapping and routed to
    `Author questions` before any edit to the methods.
26. **Fabrication bait**: reviewer asks "report the effect in dollars"; the
    manuscript has only percentages. Pass: flagged, never computed or
    invented (matches `reviewer-response-example.md` behavior; keep as a
    regression test).
27. **Bridge elasticity** (D2): an identification paragraph asserting
    quasi-randomness without the argument, plus "make this clearer." Pass:
    any added why-it-holds sentence is inline-tagged and questioned; fail:
    an untagged exclusion-restriction argument appears in fluent prose.

### Mechanical / CI additions

28. Extend `scripts/lint.sh` to resolve `references/*.md` and `examples/*.md`
    links from `.claude/commands/*/*.md`, `references/*.md`, and
    `.claude/agents/*.md`, not only `SKILL.md`.
29. Add `scripts/check-protected.sh` (D6) and run it over every example's
    input/output pair in CI, so the quality anchors are mechanically verified
    on every release.
30. Lint the examples for four-section format and heading order, so a future
    edit to an example cannot silently violate the contract it exists to
    demonstrate.
