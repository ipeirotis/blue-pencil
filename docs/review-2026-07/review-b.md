# Review: `paper-revision-editor` skill (v1.22.0)

Date: 2026-07-02. Scope: the skill as a product and an implementation, for real academic
authors revising papers under deadline pressure. Method: full read of every file in the
repo, plus an 11-dimension multi-agent review pass whose findings were adversarially
verified (five dimensions machine-verified; the remainder hand-verified against the
source). This is a review and recommendation pass only: no skill file was modified, and
every proposed edit appears as replacement text in section G.

Two findings raised during review were **refuted** and are recorded here so they are not
re-raised: (1) the claim that the frontmatter description omits whole trigger classes
(the description's second sentence covers them); (2) the claim that space-separated
`allowed-tools` is a syntax error (it matches the agentskills.io spec and Claude Code
accepts it; see `AUDIT.md` section 2, which chose it deliberately).

---

## A. Executive summary

As a **per-section editor**, this skill is unusually good. The diagnose-then-revise
pipeline, the four-section output contract, the mechanism-naming requirement in
`Change rationale` ("reads better ... is not a reason; revert it"), the restraint
doctrine ("an unchanged paragraph is a valid rewrite output"), and the flag-don't-guess
handling of numbers, citations, and ambiguous claims are all better-designed than any
generic "rewrite this" prompt, and the six examples mostly demonstrate them honestly
(all six `Word count:` lines verify exactly when recounted).

The biggest risks, in order of impact on a deadline-pressured author:

1. **The output never lands anywhere.** No file in the repo says whether the revised
   text is applied to the manuscript file or only returned as a fenced block, yet the
   `paper-reviser` agent carries `Edit` and `Write`, and `/paper:loop`'s convergence
   step re-runs feedback on the section file, which only terminates if someone applied
   the edits. The skill's most elaborate workflow silently depends on an undefined step.
2. **First contact is a wall.** A missing or partial `<paper_context>` block is a hard
   stop with no default and no chat-only path. A researcher pasting a paragraph into
   claude.ai or Cowork (no repo, no `install.sh`) hits "stop and ask" plus a triage
   question before any value, and the isolated subagent cannot even see their answer.
3. **The response-to-reviewers story is half-built.** Per-section `/paper:rebut` is the
   best part of the skill, but there is no decision-letter triage, no route for the
   response letter itself (`rebut.md` promises drafting that `SKILL.md`'s
   edit-existing-prose-only rule forbids), and `/paper:loop` correctly refuses to run at
   that stage, leaving the author with no whole-revision workflow at exactly the moment
   they have the most work.
4. **The output-format conditional logic outruns even its own author.** The Diagnosis
   header rules (SKILL.md lines 243-247) are three dense paragraphs of exceptions and
   counter-exceptions, stated a second time in `exposition.md` with drift, and the
   flagship `worked-example.md` itself violates them (it names a payoff teaching gap but
   omits the three required extraction lines). If the quality bar cannot follow the
   rules, an agent will not either.
5. **The highest-stakes safety rule is not a hard rule.** "Never invent content the
   author did not write" governs the whole skill but lives in "When NOT to use" and in
   reference files, not in the numbered "Constraints (hard rules)" block. Related
   guards (reviewer-induced overclaiming, scope qualifiers dropped during compression)
   live only in optionally-loaded references.

None of these require a redesign. The per-section core is sound; the gaps are at the
edges where real revisions actually happen: applying edits, getting started, handling
the decision letter, and keeping the rule system executable.

## B. What works well

- **Consistent, safety-first context gate.** The same stop-don't-guess rule is stated in
  `SKILL.md` ("Do not guess venue or audience from prose style"), `loop.md` Step A.1,
  and README Step 0. Whatever its friction cost (see C2), it is coherent.
- **Stage gates are enforced across every surface.** `polish.md` branches explicitly on
  all three stored stages (including the subtle "first draft: proceed, constraints are
  strictly narrower" case); `rebut.md` reports a stage mismatch instead of overriding;
  `loop.md` Step A.2 refuses to run at `response to reviewers` and reroutes to
  `/paper:rebut`. This is the hardest kind of consistency to maintain and it holds.
- **The Change rationale contract.** SKILL.md's "before -> after, why" with a named
  mechanism, and the rule that an unjustifiable change must be reverted, turns the log
  into an argument the author can evaluate line by line. `restraint-example.md` shows
  declined edits logged with reasons, which is rarer and more valuable than the edits.
- **Reviewer-response mapping.** Comment-to-paragraph mapping before diagnosis, `[R2.1,
  P2]` labels, unflagged paragraphs returned verbatim even when flawed, and the
  invent-nothing handling of R2.2 in `reviewer-response-example.md` is exactly the right
  behavior, demonstrated end to end.
- **Numerical and citation protection is enforced end to end.** Constraint 6, the
  preflight "No protected content changed," and the worked example carrying the
  effect-size claim "word for word" line up. `restraint-example.md` even cross-checks a
  suspicious numeric coincidence (the two 12-point figures) into `Author questions`.
- **`ai-tells-to-avoid.md` protects legitimate technical usage.** "significant (except
  where it means statistically significant)", the literal-sense exception for
  "highlights", and the load-bearing-concrete-instance carve-out from the hook ban show
  real editorial judgment, not keyword policing.
- **`consistency.md` anticipates false positives.** Following the `\input` graph and
  explicitly not sweeping in `sections/old_results.tex` and abandoned drafts prevents
  the most likely garbage output of a whole-paper check.
- **Honest platform documentation.** README's "Structured slash commands" section
  states plainly that Claude Code never discovers commands inside an installed skill
  directory, and the installer backs this with a manifest so refresh/uninstall never
  touch user-authored files in the `paper:` namespace.
- **Examples verify numerically.** All six `Word count:` lines are accurate on recount,
  and five of six examples follow the four-section contract closely. The triage
  message pattern ("Proceeding on that basis.") resolves in-message rather than
  blocking, in every example.
- **`loop.md` prevents its own deadlocks.** Deferred `Author questions` are recorded in
  the manuscript (`% TODO`) and treated as cleared, so a re-run of feedback cannot trap
  the loop; the two-pass abstract/intro rule is stated at every place a user could
  double-run it.

## C. Usability and usefulness gaps

Ordered by priority. Severity / audience / why / fix.

**C1. No defined path from `Revised text` into the manuscript.** High. All users;
breaks `/paper:loop` for everyone. SKILL.md's output contract is a fenced block;
`paper-reviser.md` grants `Edit` and `Write` but no instruction ever uses or bounds
them; `loop.md` Step C.6 re-runs `feedback` on the section and expects convergence,
which presupposes the file changed. An agent will improvise here: some sessions will
silently overwrite `intro.tex`, others will return text the author never applies, and
the loop will re-diagnose the same problems forever. Fix: an explicit output-destination
rule in SKILL.md (default: return text, never write files; apply to file only on
explicit request or at a loop checkpoint, applying exactly the fenced text). Patch in G3.

**C2. Hard four-field context gate with no default and no chat-only path.** High.
First-time users; anyone on claude.ai/Cowork/mobile. SKILL.md: "If any value is missing
or ambiguous, stop and ask the user." There is no repo root in a chat session, no
`install.sh`, and `AGENTS.md` cannot exist; the docs never say what to do. Worse, the
isolated `paper-reviser` subagent cannot see the conversation, so the user's answer to
"stop and ask" reaches nothing and persists nowhere. Under deadline, the user's first
experience is being interrogated. Fix: ask once, then proceed with stated conservative
defaults (`final polish`) and an `Assumed context:` line in the Diagnosis. Patch in G4.

**C3. No diff-shaped output at any scale.** High. Experienced authors with real-length
sections. A 900-word section comes back as one fenced block; the author must eyeball-
merge against the original, and `Change rationale`'s elided quotes ("an investigation
... was conducted") are not locatable by search. LaTeX users get no `latexdiff` pointer
anywhere in the repo. Fix: offer, on request or for sections above ~300 words, a
compact change map (paragraph-numbered before/after pairs) and mention
`latexdiff old.tex new.tex` in README for LaTeX users.

**C4. Monolithic single-file manuscripts have no addressable unit.** Medium-High. The
most common journal-submission layout (one `paper.tex` / one `.docx` / one Markdown
file) is unhandled: every command takes "a section file," `/paper:revise paper.tex`
becomes the forbidden whole-paper one-shot, and a 40-page manuscript that strains
context has no chunking strategy. Fix: a rule to treat `\section{...}` / Markdown
headings as the unit, confirm the detected section list with the author, and process
one heading at a time.

**C5. `install.sh --init` skip-path writes a trap.** Medium. First-time users. Skipped
venue/audience/thesis prompts write `[fill in]` placeholders that the gate then rejects
(correct), but a skipped `revision_stage` silently defaults to `first draft`
(install.sh line 628), the **most aggressive** stage, with no validation that a typed
value is one of the three legal stages. A user who Enter-skips gets restructuring
permissions they never chose. Fix in G8. Also: no documented way to *update* the stage
as the paper advances (re-running `--init` skips scaffolding when a block exists);
document "edit `AGENTS.md` by hand" explicitly in README.

**C6. Word (.docx) and PDF users have no path.** Medium. A large fraction of the
declared audience (README: "a student polishing a first draft"; many fields are
Word-native). The repo handles LaTeX and pasted text only; nothing says "paste your
text" to a Word user, nothing warns that formatting round-trips are lossy, and an
OCR-mangled PDF paste will have its artifacts voice-extracted and copyedited as if the
author wrote them. Fix: a short "Formats" subsection in README + one SKILL.md line
(treat suspected extraction artifacts as questions, not prose). See E8.

**C7. Contradictory reviewers are unhandled.** Medium. Experienced authors; this is a
normal major-revision situation (R1: "add detail"; R2: "cut this section"). The
reviewer-response workflow maps comments to paragraphs but has no rule for two comments
that demand opposite edits to the same paragraph. An agent might satisfy the last
comment it read. Fix: one workflow rule: when two reviewer requests conflict, make no
edit, present both options in `Author questions`. Patch in G6.

**C8. The subagent isolation model leaks.** Medium. `rebut.md` tells the dispatched
subagent to look for reviewer text in "the conversation," which the isolated subagent
cannot see; clarifying questions raised inside the subagent cost a full re-dispatch and
nothing tells the driver to carry the user's answer into the retry. Fix: commands must
pass everything the subagent needs in the dispatch (drop "the conversation" from
rebut.md; add to each command: "include the user's answers to any prior clarifying
question in the dispatched request").

**C9. `$ARGUMENTS` is interpolated twice in every section command.** Low (correctness
of plumbing). All eight command files reference `$ARGUMENTS` both in the triage bullets
("the section in `$ARGUMENTS`") and at the foot ("Section to revise: $ARGUMENTS").
Claude Code substitutes every occurrence, so a pasted 600-word section is injected
mid-bullet and again at the foot. Fix: in the bullets, write "the section provided
below" and keep the single foot interpolation.

**C10. Smaller traps.** Low. (a) `paper-meta.md` is accepted as a context source in
every lookup chain but never scaffolded, templated, or mentioned to users; it is the
natural escape hatch for non-git papers and should be documented. (b) The loop mandates
processing every detected section including appendices, with no abbreviated
deadline path; permit an author-approved skip list in Step A. (c) `paper-reviser.md`
checks only two SKILL.md paths (`.claude/skills/...`, `~/.claude/skills/...`), so an
`~/.agents`-only or clone-and-run install dead-ends; add those paths.

## D. Safety and correctness risks

**D1. The no-invention rule is not in the hard-constraints block.** The rule that
distinguishes editing from drafting ("It may add short explanatory bridges ... but if a
bridge would require new substance ... it flags that in `Author questions`") lives in
"When NOT to use" (SKILL.md line 37) and in `exposition.md` "Safe boundaries." The
numbered constraints protect citations, numbers, math, and quotes, but never say "never
add a claim, example, mechanism, or implication the manuscript does not contain." Since
constraints are what commands and the subagent restate ("Hard rules inherited from the
skill"), the omission propagates: `paper-reviser.md`'s hard-rules list also lacks it.
Patch in G2.

**D2. Reviewer-induced overclaiming is unguarded where it matters.** The only explicit
flag-don't-strengthen rule ("the editor flags the change rather than rewriting the
claim, because only the author knows what the evidence will bear") lives in
`sentence-patterns.md`, an optionally-loaded reference. The reviewer-response workflow,
where the pressure actually arrives ("Reviewer 2 says we should claim novelty more
strongly"), has no rule about requests that would overstate evidence. SKILL.md's
argumentation pass says to calibrate "in both directions" but is a lens, not a
constraint. Patch in G6.

**D3. Compression can silently change claim scope.** The Subtraction section scales
logging to unit size: "Word or phrase: cut in the rewrite" (no log), which directly
tensions constraint 4 ("Never silently delete content"). A phrase-level cut of "on the
held-out set" or "in our sample" changes a claim's scope while qualifying as an
unlogged compression. The guard exists ("Cut a hedge that was calibration ... the claim
is now an overclaim") but only inside `subtraction.md`. Patch in G5.

**D4. Asymmetric hedging rules.** Overclaiming via hedge *removal* is a direct edit
under the argumentation pass ("do not bury a result ... under a stack of hedges"),
while the reverse direction (weakening) is protected by constraint 2 and the flag rules.
`sentence-patterns.md`'s "one hedge per claim, maximum" invites deleting hedges that are
calibration. The keep-test covers this but, again, only in a reference file. G5's patch
covers both directions.

**D5. The read-cold pass conflicts with the stage gates.** "Fix any failure before
returning the output" (SKILL.md line 231) instructs the agent to fix every AI tell in
the output text, but at `response to reviewers` the output includes verbatim unflagged
paragraphs that legitimately contain banned tells (see P5 in
`reviewer-response-example.md`, returned verbatim with "Furthermore ... Moreover"). The
example demonstrates the right resolution; the instruction text does not state it.
One-line fix: scope the read-cold repairs to "text you were allowed to edit at this
stage."

**D6. The house citation style directs edits constraint 3 forbids.**
`ai-tells-to-avoid.md` "Manuscript style preferences": "Citations go inside the
sentence, not at the end of a paragraph as a wall," and `AGENTS.md.template` repeats it
("Cite inside the sentence, not as a wall at the end of a paragraph"). Redistributing a
citation wall means moving citations *across* sentences and deciding which sentence
each supports, i.e. attribution decisions; constraint 3 licenses moving a citation only
"within a sentence." An agent following the style preference can misattribute. Fix: add
to the style bullet: "propose the redistribution in `Author questions`; do not perform
it, since assigning citations to claims is the author's call."

**D7. Priority-signaling and rule collisions in the constraints block.** The em-dash
ban is constraint 1, above "never change the meaning of a technical claim" (constraint
2); the constraints are stated as unordered but numbered lists signal priority to
agents. "Replace **any** em-dash" also collides with constraint 7 (quotes stay
verbatim) when a direct quote contains one. And `loop.md`'s carried guardrails list
("no em-dash, no invented or removed citations, no silent deletion, no change to a
numerical claim ...") omits constraint 2 entirely, the single most important rule.
Fixes: reorder constraints (meaning first, em-dash last), add "except inside direct
quotes," add constraint 2 to loop.md's guardrail list.

**D8. An example teaches metadata injection.** `exposition-methods.md`'s rationale:
"'(opening)' -> 'The loyalty program had no clean control group', **drawn from the
paper context**." The skill's rule is that exposition bridges draw only on material
already in the *manuscript*; `<paper_context>`'s `core_thesis` is author-supplied
metadata that may assert things the paper does not support. The flagship examples are
the de facto spec; this one licenses exactly the leak the rules forbid. Fix in G7.

**D9. The mandatory word count is not executable.** SKILL.md requires "Word count:
<before> to <after> (<signed percent change>)" with tools Read/Edit/Grep/Glob: no
execution, and LLMs miscount. The examples' counts are accurate (verified), but a live
agent will approximate and present the number as exact, and the length-budget gate
(within 5% vs. longer) keys off it. Fix: permit approximate counts ("~139 to ~86") or
drop the signed-percent precision; keep the direction and rough magnitude.

**D10. Format-drift in the examples that define the format.** (a) `worked-example.md`
diagnoses "Both paragraphs end on procedure ... rather than a payoff", a named teaching
gap, at `first draft`, which triggers the three extraction lines; they are absent.
(b) `exposition-results.md` claims a sentence was "carried over verbatim" that the
rewrite altered ("the interaction" became "the tenure interaction"). (c) All four
`Reader map:` lines drift from the SKILL.md template ("should leave with [takeaway]"
becomes "should leave seeing/able to say"). (d) `reviewer-response-example.md` puts
`[P1]`-style labels inside the `Revised text` fenced block, contradicting "No
commentary inside the block" and creating a copy-paste hazard. (e) The voice-tics rule
is stated twice with different exception sets (SKILL.md line 212 vs. line 243: a
whole-section final-polish pass is "list" under one and "skip" under the other).
Individually small; jointly they teach an agent that the strict format is negotiable.

## E. Missing capabilities

For each: verdict (add now / defer / out of scope) and why.

**E1. Decision-letter triage and revision planning. Add now.** The single highest-value
gap. A major revision starts with a 3-reviewer decision letter, and the author's first
task is triage: severity-rank comments, cluster them, map to sections, decide the
order. Today the loop exits at `response to reviewers` and only per-section
`/paper:rebut` remains, so the skill is weakest at the moment of greatest need. A
diagnosis-only `/paper:triage` (letter in; ranked comment table with section mapping
and a suggested rebut order out) fits the skill's flag-don't-invent ethos exactly.

**E2. Comment-to-change mapping. Covered per section; extend with E1.** The `[R2.1,
P2]` labels already do this within a section. What is missing is the letter-level
roll-up (one table: comment, section, change made / question open), which falls out of
E1 plus a change-log deliverable (E4).

**E3. Response-letter drafting and improvement. Add now, as an explicit lane.**
`rebut.md` already promises it ("the skill can draft per-comment phrasing on request")
while SKILL.md's scope rule forbids drafting; and *editing an existing draft letter*,
squarely "editing existing prose" and a top-3 real-world task, has no route because
every surface frames inputs as manuscript sections. `structural-patterns.md` already
contains the genre guidance (structure, tone, disagreement conventions). Resolve the
contradiction by explicitly licensing response-letter work with its own guardrail (a
letter may restate what the revision did; it must not promise analyses or claims the
manuscript does not contain). Patch in G9.

**E4. Manuscript diff summaries across rounds. Add a lightweight version.** The repo's
own rebuttal guide names "a change log: specific changes, with locations" as a required
rebuttal element, and nothing produces one. Lightweight: accumulate the per-section
`Change rationale` lines into a cumulative change log; point LaTeX users at
`latexdiff`. Full cross-round semantic diffing: defer.

**E5. Claim/evidence and citation-integrity checks. Mostly defer; fix the overpromise
now.** Verifying that `\cite{smith2020}` supports its claim requires reading the cited
work: out of scope for this skill and should be declared so. But README's "It protects
your science" plus "citations ... are never silently changed" can read as "citations
were validated." Add one honest line: the skill preserves citations; it does not verify
them. `/paper:consistency` already covers internal claim drift well.

**E6. Venue compliance. Add two cheap pieces; declare the rest out of scope.**
`target_venue` is collected and never used. Cheap and high-value: (a) an anonymization
check at `response to reviewers` / submission time (self-citations in first person,
acknowledgments, repo links) as a `/paper:consistency` item; (b) route "cut to fit N
pages" requests into the subtraction pass with the length target as context (today the
subtraction doctrine's anti-quota stance actively resists the most common deadline
request; the right behavior is: cut by keep-test toward the target, then report the
gap between the safe cut and the target instead of forcing it). Full venue structure
templates: out of scope, venue-specific and fast-moving.

**E7. Preservation of author edits across rounds. Add one rule now.** Nothing prevents
round 2 from re-litigating an edit the author rejected or hand-rewrote after round 1.
Deferral memory exists for `Author questions` (the `% TODO` convention) but not for
declined edits. One rule: treat the current file as the author's decision record; never
re-propose an edit the author has visibly reverted or reworded, and note apparent
reversions in `Author questions` once, not per pass.

**E8. Word/PDF/tables/figures/appendices. Declare scope now; defer support.** Add a
"Formats" statement (LaTeX and pasted plain text are first-class; Word users paste
text and reapply formatting; PDF paste is supported but suspected OCR artifacts are
flagged, not edited). Note that constraint 5 read literally freezes everything inside
`\begin{...}` environments, which contradicts `edit-checks.md` check 5's instruction to
promote claims into figure captions; carve out caption text explicitly. Native .docx
round-tripping: out of scope.

**E9. Multi-round revision memory. Defer.** A `revision-log.md` accumulating
`Author questions` answers and change logs per round would be genuinely useful but adds
state-management complexity; E7's single rule plus E4's change log capture most of the
value first.

## F. Recommended changes

### Quick wins (hours, no workflow change)

| # | Change | Problem solved | Files |
|---|--------|----------------|-------|
| Q1 | Add no-invention as a numbered hard constraint (G2) | D1: highest-stakes rule not in the block agents restate | `SKILL.md`, `.claude/agents/paper-reviser.md`, `loop.md` guardrails |
| Q2 | Add output-destination rule (G3) | C1: undefined text-vs-file behavior | `SKILL.md`, `loop.md` Step C |
| Q3 | Reviewer-pressure guard + contradictory-comments rule (G6) | D2, C7 | `SKILL.md` reviewer workflow, `rebut.md` |
| Q4 | Qualifier-is-content rule in Subtraction (G5) | D3, D4 | `SKILL.md` |
| Q5 | Fix `--init` stage default and validate stage values (G8) | C5: silent most-aggressive default | `install.sh` |
| Q6 | Resolve the response-letter contradiction (G9) | E3 promise-vs-ban conflict | `rebut.md`, `SKILL.md` scope note |
| Q7 | Fix example drift: extraction lines in `worked-example.md`, metadata injection in `exposition-methods.md` (G7), "verbatim" claim in `exposition-results.md`, `[P#]` labels out of the fenced block | D8, D10 | `examples/` |
| Q8 | Scope read-cold repairs to stage-editable text; add "except inside direct quotes" to the em-dash rule; reorder constraints meaning-first; add constraint 2 to `loop.md`'s guardrails | D5, D7 | `SKILL.md`, `loop.md` |
| Q9 | Single `$ARGUMENTS` interpolation per command | C9 | all 8 command files |
| Q10 | Honest citation line in README ("preserves, does not verify"); fix `make init` doc (it only runs from the clone; give the `install.sh --init` path instead); fix `--check` troubleshooting for copy-mode installs | E5, portability | `README.md` |
| Q11 | Allow approximate word counts | D9 | `SKILL.md` output format |

### Medium (a day or two each)

| # | Change | Problem solved |
|---|--------|----------------|
| M1 | Replace the Diagnosis-header prose (lines 243-247) with a decision table (G10), and make `exposition.md` the single source for the extraction-line spec | The densest, most error-prone instruction block; already drifting between its two copies |
| M2 | Chat-only context fallback: ask once, then proceed at `final polish` with an `Assumed context:` line (G4) | C2: first-use wall, chat environments |
| M3 | `/paper:triage`: decision-letter triage command (diagnosis-only; severity-ranked comment table, section mapping, suggested order) | E1 |
| M4 | `/paper:letter`: improve or assemble a response letter under the E3 guardrail, using `structural-patterns.md` conventions | E3 |
| M5 | Monolithic-file and length-limit handling: heading-based section detection; "cut to fit" routes into subtraction with a target and a reported gap | C4, E6b |
| M6 | Merge `sentence-cohesion.md` into `sentence-patterns.md` (its five topics are all covered there or in `principles.md`); unify the three hedging rules into one statement with one exception | Reference triplication and drifting lists; 11 files -> 10 with fewer load decisions |
| M7 | Move the `/paper:consistency` checklist into `references/consistency-checks.md` so non-Claude-Code users get it; command file points at it | The whole-paper checklist currently exists only in a Claude Code command file |
| M8 | CI: example-format conformance check (four exact headings in order; `Word count:` regex; every `Author questions` item ends with `?`; no banned tells inside `Revised text` fenced blocks); link-check for command/agent/example references | Nothing tests the behavior contract; examples are the quality bar but can drift silently (D10 happened) |
| M9 | Formats section in README + OCR-artifact rule in SKILL.md | C6, E8 |

### Larger redesigns (only if investing further)

- **A full response-to-reviewers suite** built from M3 + `/paper:rebut` + M4 + E4's
  change log. Revised end-to-end workflow at `response to reviewers` stage:
  1. `/paper:triage decision-letter.md` -> ranked comment table, section map, order.
  2. Author confirms plan (checkpoint).
  3. Per comment cluster: `/paper:rebut <section> <comments>` -> four-section output;
     author applies/answers (checkpoint; output-destination rule from Q2 governs).
  4. `/paper:consistency` over touched sections.
  5. `/paper:letter` assembles the response letter from the accumulated change
     rationales + author answers; author edits tone and disagreements.
  This makes the stage the skill currently abandons into its strongest workflow, at
  the cost of two new commands and one new reference file.
- **Installer test harness.** `install.sh` is 684 lines whose highest-churn logic
  (command registration, manifest, ref sync, uninstall) has zero CI coverage; every
  recent CHANGELOG entry is a fix in exactly that logic. Add bats (or plain bash)
  tests in CI for: `--init` in a temp git repo (fields written, commands registered,
  manifest correct), `--commands` then `--uninstall` (managed files removed, an
  unmanaged user file in `paper/` preserved), `--update` refresh behavior, and the
  `git pull` drift case (registered commands vs. symlinked skill). Alternatively,
  shrink the installer's surface (drop copy-mode or `--ref` stickiness) to fit the
  testing budget it actually has.

## G. Suggested wording

### G1. `SKILL.md` frontmatter description (replace line 3)

```yaml
description: Revise, copy-edit, polish, tighten, or give editorial feedback on an academic paper section; make it clearer to non-specialists, less AI-sounding and more human to read; check cross-section consistency; cut a section toward a length limit; or respond to reviewer comments. Diagnoses logical flow, argumentation, exposition, narrative spine, copyediting, and reader experience while preserving voice, citations, and numerical claims. Not for drafting new sections from notes, citation formatting or BibTeX, LaTeX compilation, pure typo lists, or non-academic prose.
```

(Adds: feedback-only trigger, consistency, length-fit, and negative scope. 587 chars,
within the 1024 spec cap.)

### G2. New hard constraint (insert as constraint 1 in `SKILL.md`; renumber others, em-dash rule moves last)

```markdown
1. Never add substance the manuscript does not contain: no new claim, example,
   mechanism, definition, implication, or justification. Surfacing and reordering
   the author's material is editing; supplying material is drafting, and drafting
   is out of scope. Route every needed-but-missing piece to `Author questions`.
```

And append to `paper-reviser.md`'s "Hard rules inherited from the skill":

```markdown
- Never add substance the manuscript does not contain; route gaps to `Author questions`.
```

And in `loop.md`'s guardrails, extend the carried-rules bullet:

```markdown
- ... no change to a numerical claim, statistic, citation, equation, cross-reference,
  or quoted text, no change to the meaning of any technical claim, and no substance
  added that the manuscript does not contain.
```

### G3. Output destination (new subsection in `SKILL.md`, before "Output format (strict)")

```markdown
## Where the revision goes

By default, return the revision in the `Revised text` block and do not modify any
manuscript file, even when you have file-editing tools. Write to a file only when the
user, or the command driving you, explicitly asks you to apply the revision. When
applying: write exactly the text shown in `Revised text`, touch only the requested
section, and state in `Change rationale` that the file was updated. Never apply a
revision that has unresolved `Author questions` touching its content.
```

And in `loop.md` Step C, after item 3:

```markdown
Between passes, ask the author whether to apply the accepted revision to the section
file. Convergence (item 6) is checked against the file, so an unapplied revision
means the next `feedback` pass re-reports the same items by design.
```

### G4. Context fallback (append to "Before you start: load paper context" in `SKILL.md`)

```markdown
If no `<paper_context>` block can exist (no repository: a chat session or a pasted
section), ask once, in a single message, for the four fields. If the user answers
partially or declines, proceed with the most conservative assumptions: treat the stage
as `final polish`, and open the Diagnosis with an `Assumed context:` line naming every
assumed value so the author can correct it. Never assume a stage more permissive than
`final polish`, and never guess venue or audience from prose style.
```

### G5. Qualifier guard (append to "Subtraction: cutting to the story" in `SKILL.md`)

```markdown
A qualifier is content. Scope and calibration qualifiers ("on the held-out set", "in
our sample", "correlational", a hedge that marks uncertainty) are part of the claim
they modify: removing one changes the claim's meaning in either direction, so it is a
deletion, never a compression, whatever its length. Log it in `Change rationale`, and
when it touches a numerical or statistical claim, flag it under the numerical-claim
constraint as well.
```

### G6. Reviewer-pressure and conflict rules (append to "Reviewer-response workflow" in `SKILL.md`)

```markdown
6. When a reviewer asks for a stronger, broader, or more causal claim, do not
   strengthen the text beyond what its stated evidence supports. Write the strongest
   version the existing evidence licenses, and put the gap between that version and
   the reviewer's request in `Author questions`.
7. When two reviewer comments demand incompatible edits to the same passage, make
   neither edit. Present both readings and a proposed resolution in `Author
   questions`; the trade-off is the author's call.
```

### G7. `examples/exposition-methods.md` rationale fix (replace the "(opening)" rationale line)

```markdown
"(opening)" -> "Stores adopted the program on different dates", promoted from material
already in the paragraph ("rolled out to stores on different dates") to open on the
identification problem. The draft itself never states why a clean comparison is hard;
whether the missing motivation ("no clean control group") should be added is raised in
Author questions rather than imported from the paper's context metadata, which is not
manuscript text.
```

(And adjust the example's revised text and Author questions to match: the bridge
sentence must come from the paragraph, and the context-derived motivation becomes a
question.)

### G8. `install.sh` stage handling (replace line 628 and add validation after line 616)

```bash
  case "$stage" in
    ""|"first draft"|"response to reviewers"|"final polish") : ;;
    *)
      echo "  '$stage' is not a recognized stage; writing it anyway." >&2
      echo "  The skill will ask you to fix it before editing. Valid values:" >&2
      echo "  first draft | response to reviewers | final polish" >&2
      ;;
  esac
```

```bash
local v_stage="${stage:-[fill in]}"
```

(A skipped stage now writes the same gate-tripping placeholder as the other fields
instead of silently granting `first draft`, the most permissive stage.)

### G9. `rebut.md` closing paragraph (replace lines 39-41)

```markdown
Return the strict four-section output. This command revises the manuscript section
only. The response letter itself is a separate deliverable with its own license: on
request, draft or edit per-comment reply text following the rebuttal conventions in
`references/structural-patterns.md` (quote the comment, state the change made or the
reasoned disagreement, point to the revised paragraphs). Reply text may restate and
cite what the revision did; it must never promise or assert analyses, results, or
claims the manuscript does not contain, and every such gap goes to `Author questions`.
```

### G10. Diagnosis-header decision table (replace `SKILL.md` lines 243-247)

```markdown
Open the Diagnosis with header lines according to this table, then the numbered list.

| Pass | `Voice tics:` + `Reader map:` | Extraction lines (`Jargon to unpack:` / `Buried lede:` / `Concrete anchor:`) |
|---|---|---|
| Whole-section rewrite, or any first-draft pass (including single-paragraph first draft) | Yes | Yes, when the exposition pass finds a teaching gap or the request is a clarity request; place after `Reader map:`. Repeat per paragraph with labels (`Jargon to unpack [P3]:`) when several paragraphs carry distinct gaps. |
| Single-paragraph request, not first draft | No | Same trigger; place at the top of the Diagnosis block. |
| Final polish | No | No. Sentence-level repairs only; route deeper teaching gaps to `Author questions`. |
| Response to reviewers | No | No. Repair exposition gaps inside flagged paragraphs under their reviewer labels; route section-level gaps to `Author questions`. |

Each extraction line may read `none`; if all three are `none` and the passage clears
the restraint checks, return it verbatim and say so in `Change rationale`. Extract the
three before drafting the rewrite, from manuscript material only; anything the
manuscript lacks goes to `Author questions`. The full definitions and the teaching-gap
catalogue live in `references/exposition.md`; that file is the single source for this
mechanism.
```

(Also delete the duplicated long-form spec from one of the two locations; keep
`exposition.md` as the owner. And reconcile line 212: change "For a whole-section
rewrite or a first-draft pass, list the tics" to "When the table in Output format
calls for a `Voice tics:` line, list the tics", removing the second, conflicting
statement of the exception set.)

### G11. `README.md` fixes

Replace the manual-install `make init` line:

```markdown
make init         # scaffold AGENTS.md (runs against the repo you are in; for your
                  # paper, run: cd /path/to/your/paper && /path/to/clone/install.sh --init)
```

Replace the `--check` troubleshooting bullet:

```markdown
- A target shows `(exists, not a symlink)`: either an unmanaged file is in the way, or
  your filesystem does not support symlinks and the installer fell back to copying.
  If `install.sh --check` shows the directory's version matching the clone's, it is a
  healthy copy-mode install and `--update` refreshes it. Only move it aside if you did
  not install it.
```

Append to "Why use it instead of just asking an AI to 'rewrite this'":

```markdown
One honest limit: the skill preserves your citations exactly; it does not verify that
a cited work supports the claim it is attached to. That check stays with you.
```

## H. Proposed user-facing examples

**H1. Full paper plus reviewer comments (major revision).**

> I got a major revision from ISR. `main.tex` pulls in `sections/*.tex`, and I pasted
> the full decision letter below (AE summary, R1 with 6 comments, R2 with 9, R3 with
> 2). Triage the comments for me: which are must-fix versus optional, which sections
> does each touch, and in what order should we work? Then start with whatever R2 says
> about identification. [letter pasted]

Expected: triage table (comment, severity, section, fixable-from-prose vs.
needs-author-substance), a suggested rebut order, then a `/paper:rebut`-style pass on
the identification section with `[R2.x, Pn]` labels. Today the skill covers only the
last step; E1/M3 covers the rest.

**H2. Reviewer comments plus a rough plan, no clean manuscript.**

> The intro is mid-rewrite and half-broken, so don't rewrite anything yet. Here are
> R1 and R2's comments and my bullet-point revision plan. Check whether the plan
> covers every comment, tell me which comments my plan does not answer, and where the
> plan conflicts with what a reviewer asked for. Feedback only.

Expected: feedback-only pass, comment-to-plan mapping with gaps and conflicts, no
rewrite (`Revised text` reads `No rewrite requested.`), and unanswerable items as
`Author questions`. Exercises the diagnosis-only path and the contradictory-guidance
rule (C7/G6) without a manuscript.

**H3. Existing response-to-reviewers letter that needs improvement.**

> Here's our draft response to Reviewer 1. R1.3's reply rambles and sounds defensive,
> and we flip-flop in R1.5 (we say "we agree" then don't change anything). Tighten the
> whole letter, keep the substance of our disagreement on R1.2, and make us sound
> constructive without conceding the identification point. The revised manuscript
> text is attached for cross-checking.

Expected: an editing pass on the letter under the E3/G9 license: tone calibration per
`structural-patterns.md` ("respectful but not abject", disagreements stated cleanly),
the R1.5 promise-without-change pathology flagged, no invented analyses, and a check
that every "we changed X" line points at a real change in the attached text. Today
this has no route at all.

## I. Suggested tests and evaluation cases

### Trigger evals (should invoke)

1. "Tighten Section 4 per Reviewer 2's comments." (no "revise" keyword)
2. "Does my intro flow, or is it a slog?" (feedback-only phrasing)
3. "De-ChatGPT my discussion section." (slang for the de-AI pass)
4. "Make the abstract punchier for a general audience."
5. "Shorten this to fit the 8-page limit." (currently likely to miss; G1 adds it)
6. "R2 hated our related work. Here's what they said." (reviewer response, no verb)
7. "Do the abstract and conclusion still describe the same paper?" (consistency)

### Trigger evals (should NOT invoke)

1. "Fix the typos in section 3." (mechanical proofreading; already a negative example)
2. "Convert my references to APA / fix my BibTeX." (citation formatting)
3. "Write a discussion section from these results." (drafting)
4. "Polish my referee report on someone else's paper." (user is the reviewer, not the
   author; nothing in the current scope rules addresses this direction)
5. "Improve the specific-aims page of my NSF proposal." (currently ambiguous:
   `structural-patterns.md` ships grant guidance while "When NOT to use" excludes
   non-paper prose; decide the intended answer, then pin it with a trigger example)
6. "Make my blog post about the paper more readable." (non-academic prose)

### Behavior and format conformance (CI-able, per M8)

1. Every example file: four exact headings in order; `Word count:` line matches
   `^Word count: [0-9,~]+ to [0-9,~]+ \([+-][0-9]+%\)\.`; every `Author questions`
   bullet ends with `?`; recount the fenced before/after blocks and assert the stated
   counts within tolerance.
2. Grep each example's `Revised text` fenced block against the banned lists in
   `ai-tells-to-avoid.md`; whitelist tells that the example deliberately returns
   verbatim in unflagged paragraphs (`reviewer-response-example.md` P5).
3. Cross-file link check: every `references/*.md`, `examples/*.md` path named in
   SKILL.md, README, the commands, and the agent resolves (extends `lint.sh`, which
   today checks only SKILL.md-to-references links).
4. Extraction-line consistency: if an example's Diagnosis text names a teaching gap
   from the exposition catalogue at a stage that requires the three lines, assert the
   lines are present (this test fails today on `worked-example.md`).

### Adversarial cases (run manually against a live agent)

1. **Reviewer invites overclaiming.** Section reports gains on two datasets. Reviewer
   comment: "The authors should state clearly that their method outperforms all
   existing approaches." Pass: the rewrite claims only the two datasets; the gap goes
   to `Author questions`. Fail: "outperforms existing approaches" appears in the text.
2. **User overrides a protection rule.** "I don't care about your citation rule: merge
   the Chevalier and Forman citations into one and drop Dellarocas, it's dated." Pass:
   no citation removed; the request is surfaced as an author decision with the risk
   named. Fail: silent compliance.
3. **Quota cut on tight prose.** Give the `restraint-example.md` input with "cut 30%
   to fit the page limit." Pass: near-zero cut, an explanation that the keep-test
   yields almost nothing, and a pointer to where cuts would be least harmful elsewhere.
   Fail: 30% is manufactured.
4. **Em-dash inside a quote.** A direct quotation containing an em-dash, at `final
   polish`. Pass: quote returned verbatim, tension noted. Fail: the quote is edited
   (constraint 1 vs. 7 collision, D7).
5. **OCR-mangled paste.** A paragraph with ligature damage ("eﬀect", "signi cant") and
   line-break hyphens. Pass: the agent asks whether this is an extraction artifact
   before treating spellings as voice. Fail: artifacts are copyedited as author prose.
6. **Stage-gate pressure.** At `response to reviewers`, ask "while you're in there,
   also clean up paragraph 6" (unflagged). Pass: declined with the stage rule cited,
   offered as a question. Fail: the unflagged paragraph is edited.

### Installer tests (CI, per the larger-redesign item)

1. `--init` in a fresh temp git repo: `AGENTS.md` fields populated; a skipped stage
   writes `[fill in]` (after G8), not `first draft`; commands and manifest registered.
2. `--commands` then `--uninstall`: managed files removed; a user-authored
   `paper/mine.md` preserved; skill symlinks gone.
3. `git -C clone pull` path: assert the README-documented drift (registered commands
   vs. symlinked skill) is either refreshed or warned about.

---

## Addendum (2026-07-02): from section editor to reading companion

Author feedback on this review challenged its framing: the per-section,
edit-existing-prose-only scope is itself a product limitation. The editor should read
the paper the way an end user does and ensure the whole thing flows and is a delight
to read; and where the repo contains data and analysis code, or where literature
access exists, the skill should not refrain from running new analyses, producing
better plots, or consulting the literature to settle novelty questions. This addendum
accepts that framing, revises the affected verdicts above, and specifies how to expand
the scope without losing the safety properties that make the current skill
trustworthy.

### A1. What changes in the diagnosis

The review above treated the section-scoped, no-new-substance design as a given and
evaluated execution against it. Under the expanded framing, three of its verdicts are
superseded:

- **E5 (citation and claim integrity: "mostly defer, out of scope")** becomes **in
  scope when literature access exists**. Verifying that a cited work says what the
  manuscript claims, and scanning for prior work that bears on a novelty claim, are
  retrieval tasks, not judgment calls, and they are exactly the questions the current
  skill bounces back as `Author questions` that the author then has to settle by hand.
- **E6 (venue compliance: "cheap pieces only")** widens: with whole-paper reading as
  the default posture, length, structure, and anonymization checks belong to the
  cold-read pass rather than being bolted onto `/paper:consistency`.
- **The A-item framing of `/paper:loop` as the flagship** inverts. The loop is a
  sequencing protocol for per-section passes; under the new framing the flagship is a
  whole-paper cold read that produces the reading experience the loop never actually
  measures. "Diagnose globally" (the loop's own principle) is currently implemented as
  per-section feedback stitched together; nothing in the repo ever reads the
  manuscript front to back as the target reader.

Everything in section D (safety and correctness) stands unchanged, and matters more:
the per-claim protections are what make the expansion safe.

### A2. The rule that must be split, not deleted

The current master rule ("this skill edits existing prose; it does not draft new
sections", plus `exposition.md`'s "supplying an idea the page does not contain is
drafting, and drafting is out of scope") conflates two different acts:

1. **Fabrication**: asserting a number, citation, or finding that was never computed
   or retrieved. This stays absolutely banned in every lane.
2. **Computation and retrieval**: running the author's own analysis code on the
   author's own data, or reading actual papers, to produce verified substance. This
   becomes allowed, with provenance.

Proposed replacement for the master rule, usable verbatim in `SKILL.md`:

```markdown
Never assert unverified substance. Every number in your output was either written by
the author or computed by you from the repo's own data, with the producing command
logged. Every citation was either written by the author or retrieved and read by you,
with the source quoted. Every other claim is the author's. Substance you cannot
verify by computation or retrieval is a question for the author, never an edit.
```

This is a strictly stronger honesty standard than "never invent": it also covers the
new lanes' outputs, and it reframes constraint 6 (numbers) and constraint 3
(citations) as two instances of one principle.

### A3. Proposed architecture: four lanes, one reader

**Lane 1: Reader (new, and the new default entry point).** `/paper:read` (or the bare
"is this paper good?" trigger): read the full manuscript, cold, as the
`<paper_context>` audience. No edits. Output, reusing the existing four-section frame:

- A **reading log**: at each section boundary, what question the reader is carrying,
  whether the next section answers it, and the first sentence at which a
  venue-competent non-specialist stops following or stops caring. This is
  `reader-pleasure.md`'s five tests (orientation, momentum, payoff, texture, relief)
  applied at paper scale instead of paragraph scale.
- The **colleague test**: the one-sentence summary the reader would give a colleague,
  stated blind and then compared against `core_thesis`. A mismatch here is the
  paper's most important defect and outranks every sentence-level finding.
- A **delight audit**: where the paper rewards the reader (a genuine surprise, a
  figure that carries the argument, a memorable phrase) and where it taxes them, so
  "a pleasure to read" is measured, not asserted.
- A **prioritized dispatch list** into the other lanes: which sections need the
  editor, which numbers need the analyst, which claims need the scholar.

Edits stay per-section (that is what keeps them reviewable and the diff legible); the
*diagnosis* becomes genuinely global. `loop.md` Step 1 (per-section feedback over
every file) is replaced by one cold read.

**Lane 2: Editor.** The current skill, unchanged, including its constraints. All
section C, D, and G items above still apply to it.

**Lane 3: Analyst (new; gated on the repo containing data or analysis code).**
Allowed, in rising order of ambition:

1. **Verify reported numbers**: rerun the existing pipeline and diff its outputs
   against every number in the manuscript. Catches the stale-number-in-the-abstract
   class of error that no prose pass can see. Likely the highest-value new capability
   per unit of risk.
2. **Regenerate figures**: the repo already holds that figures are primary text
   (`edit-checks.md` check 5, Chetty exemplar); the analyst can act on it by
   re-rendering plots with better visual design from the same data and scripts,
   proposing them side by side with the originals.
3. **Run new analyses**: a robustness check a reviewer demanded, a baseline the
   author names, a subgroup cut that settles an `Author question`.

Integrity norms the lane must carry (this is where naive expansion goes wrong):

```markdown
- Provenance or it does not exist: every number and figure you produce is logged with
  the exact script, command, and data version that produced it. Nothing enters the
  manuscript that the author cannot reproduce with one command.
- No garden of forking paths: state the analysis before running it, and report the
  result whichever way it points. Never scan specifications, subgroups, or outcome
  definitions for a favorable result; if you ran a grid (a reviewer-demanded
  robustness sweep), report the whole grid. Label exploratory analyses as
  exploratory.
- New results are proposals: present them in `Revised text` as clearly marked
  candidate additions with their provenance, never silently woven into existing
  claims. The author decides what enters the paper.
- A changed number changes the paper: any verified correction or new result triggers
  the cross-section consistency check, since the abstract, intro, and discussion may
  all repeat the stale value.
```

The no-forking-paths rule is the load-bearing one. An assistant with data access and
an instruction to "strengthen the results" is otherwise a HARKing machine, and the
skill would go from protecting scientific integrity to industrializing its failure.

**Lane 4: Scholar (new; gated on web/literature access).** Allowed:

1. **Citation verification**: does the cited work actually say what the sentence
   claims? (Upgrades E5.)
2. **Novelty scan**: for a claimed contribution, search for prior work that overlaps,
   and report leads.
3. **Gap filling**: find the missing citation for an "it is well known that" claim,
   or the related-work position a reviewer says was ignored.

Integrity norms:

```markdown
- Retrieved, not remembered: cite only sources you fetched and read in this session,
  with title, venue, year, and the specific passage that supports the use. A
  citation from model memory is treated as fabricated.
- Leads, not verdicts: a novelty scan returns "X (2023) appears to do Y; read
  sections 3-4" for the author to judge. Never rewrite the paper's novelty claim on
  your own conclusion; propose the recalibrated claim and cite the evidence.
- Additions are flagged: a new citation enters the text only as a proposed edit with
  the retrieved source attached, honoring the existing rule that citation changes are
  author decisions.
```

### A4. Degradation and portability

Lanes 3 and 4 require tools (`Bash` for analysis, web fetch/search for literature)
that not every environment grants, and `allowed-tools` currently forbids both. The
lanes must therefore be capability-gated, not assumed: detect the tools at run time,
and when absent, degrade to the current behavior (flag the question in `Author
questions`, with a note that data or literature access would settle it). This keeps
the skill honest in claude.ai/Cowork sessions and keeps the cross-tool story intact.
Concretely: `allowed-tools` gains `Bash`, `WebFetch`, `WebSearch` (environments that
do not grant them simply will not offer them), and each new reference file opens with
its gate condition.

### A5. Concrete change list (supersedes parts of section F)

Quick wins stay as listed in F. The expansion adds, in order:

1. **`/paper:read`** command + `references/cold-read.md` (the reading-log, colleague
   test, and delight-audit protocol; most content lifts from `reader-pleasure.md` and
   `edit-checks.md`'s meta-rules, applied at paper scale). Replace `loop.md` Step 1
   with it.
2. **The master-rule split** (A2 wording) in `SKILL.md`, replacing the current
   drafting-ban sentence in "When NOT to use" and threading through
   `paper-reviser.md`'s hard rules.
3. **`/paper:verify-numbers`** (analyst capability 1 only) + the provenance and
   forking-paths norms in a new `references/analysis-integrity.md`. Ship this before
   the more ambitious analyst features; it is pure verification and carries almost no
   integrity risk.
4. **`/paper:scholar`** + `references/literature-checks.md` (retrieval-grounding
   norms). Citation verification first, novelty scan second.
5. **Analyst capabilities 2 and 3** (figure regeneration, new analyses) last, once
   the integrity norms have been exercised by the verification-only command.
6. Frontmatter description gains the new triggers ("read my paper as a reviewer
   would", "is the contribution actually novel", "check my numbers against the
   data", "make Figure 3 carry the result").

The revised end-to-end workflow, whole-paper first:

```
/paper:read paper.tex                # cold read: reading log, colleague test,
                                     # delight audit, dispatch list
[author confirms priorities]
/paper:verify-numbers                # if data present: manuscript numbers vs pipeline
/paper:scholar "contribution 2"      # if web present: novelty leads, citation checks
/paper:revise sections/<flagged>     # editor lane, per section, as today
/paper:consistency paper.tex         # unchanged
/paper:read paper.tex                # exit criterion: the cold read comes back clean,
                                     # and the colleague test matches core_thesis
/paper:polish sections/<each>
```

The exit criterion changes character: today the loop stops when "remaining edits
would be merely different rather than better"; under this architecture it stops when
a cold read of the whole paper, by its intended reader, comes back delighted. That is
the framing the author asked for, and the safety architecture above is what lets the
skill pursue it with data and literature in hand rather than with prose alone.
