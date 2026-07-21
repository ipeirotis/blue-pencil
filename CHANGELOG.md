# Changelog

All notable changes to paper-revision-editor are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/). Versions use [Semantic Versioning](https://semver.org/).

## [1.36.0] - 2026-07-21

Adds detection of the interrupted clause, drawn from author feedback on a Discussion section that still read awkward after several passes. The awkward sentences shared one shape: a subject split from its verb, or a verb from its object, by an interruptive appositive or parenthetical ("Our data leave that question, calibration, open"; "Those conditions, team literacy, schema design, and task framing, are the axes most likely to vary"). They survived every pass because the skill had no check for within-clause parse difficulty, and worse, three mechanisms actively protected them: the voice-tic machinery filed the habit as authorial voice, the restraint checklist could not see it and returned the sentence verbatim, and the change-rationale schema offered no sanctioned reason for the fix, so "better, not merely different" reverted it. The 1.35.0 "buried thesis" pattern already covered the special case of a paragraph's main-claim sentence being the most nested; this release generalizes it to any interrupted clause and closes the three protection gaps. All of it stays inside the existing constraints: a change in syntax that carries every scope and calibration qualifier through unchanged, no new substance.

### Changed

- `references/sentence-patterns.md` gains "The interrupted clause" pattern: an appositive or parenthetical opening in the gap between a subject and its verb, or a verb and its object, forces the reader to hold an unfinished clause, and the fix is to let the main clause complete first and attach the interrupting material as a trailing clause or its own sentence. Carries three before-and-after pairs and a subject-then-verb-then-object diagnostic, framed as the general case of "The buried thesis" and cross-linked to the load-bearing-sentence-is-plainest rule in `references/altitude.md` and the qualifier-is-content rule in `references/subtraction.md`.
- `SKILL.md`'s "Writing quality" principle now names subject-verb and verb-object adjacency and points at the new pattern. The restraint checklist gains a matching verbatim-return gate (no interruptive appositive or parenthetical splits a subject from its verb or a verb from its object; the main clause parses in one pass), the voice-tic exclusion list now names interruptive appositives that split a subject from its verb so the habit is not preserved as voice, the change-rationale reason set gains "a reunited subject and verb" so the edit has a sanctioned justification, and the read-cold pass gains a per-sentence subject-verb-split check on the rewrite.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.36.0.

## [1.35.0] - 2026-07-20

Adds altitude as a named editing axis, drawn from author feedback on an abstract that read as obtuse. The nine separate complaints were one failure mode nine times: the prose over-explained, dragging body-level detail (a mixed-effects specification, a confidence interval, a single-annotator caveat, a derived per-hour rate) up into the abstract, restating a finding it had just stated, and padding claims with qualifiers true of every study. The skill already covered whether a unit earns its place (Subtraction) and whether machinery precedes motive within a section (Exposition), but not which section a unit that does earn its place belongs in. This release names that axis and its three directives (report the finding not the machinery, send each caveat to its home section, keep one number per claim), plus the two cross-cutting rules the same feedback surfaced (say it once, and the load-bearing sentence is the plainest). All of it stays inside the existing constraints: relocation and cutting of the author's own material, no new substance, and numerical or scope-qualifier moves still flagged.

### Added

- `references/altitude.md`, a new reference. It defines the altitude of a passage (high-altitude text states findings; low-altitude text carries the machinery), gives the three directives with too-high-versus-at-altitude pairs, states the altitude test (what is this clause's altitude, and does it belong there) and how it composes with the keep-test and the say-it-once rule, and carries the load-bearing-sentence-is-plainest rule with a pointer to its sentence-level pattern. The fix for a too-high clause is relocation, not compression, and it is scope- and stage-gated: logged in `Change rationale` when performed; routed to `Author questions` when the home section is out of scope or the stage forbids a structural move (final polish, non-flagged response-to-reviewers paragraphs); and flagged under the numerical-claim constraint when the clause is a number. The directives carry their own exceptions so the examples never teach cutting protected content: a fragility-revealing robustness sweep, a venue-required or precision-carrying interval, a load-bearing derived rate or heterogeneity range, a modeled value's estimate marker, a power qualifier on a null finding, and sample-scope wording (participants, not users) all stay rather than riding down or broadening.

### Changed

- `SKILL.md` gains an "Altitude: match detail to the section" section after Subtraction, framed as a distinct axis (the keep-test asks whether a clause survives, the altitude test asks where it belongs), with the three directives, the relocation-not-compression fix, a bad-versus-good abstract pair, and the load trigger for `references/altitude.md`. The preflight checklist gains an altitude check, and the restraint checklist gains the matching verbatim-return gate.
- `references/subtraction.md` gains two subsections. "Say it once" cuts a redundant restatement, keeping the clearer or more load-bearing of the two (usually but not always the first, since a plain-language gloss or a rhythm-setting restatement is the keeper by keep-test criteria 4 and 6), and distinguishes an echo from a genuine next-step inference. "Filler qualifiers and scope qualifiers" makes the reading-out test the sole arbiter: no phrase is filler by its wording, since "at this sample size" and "observable" each read as filler beside one claim and as scope beside another (power calibration, observed-versus-latent) while "to some extent" almost always limits magnitude and stays, so the editor cuts on what the qualifier does to the claim, with the tie broken toward keeping.
- `references/sentence-patterns.md` gains "The buried thesis" pattern: the sentence stating a paragraph's main claim should be the easiest to parse, not the most nested, with before-and-after pairs and a split-and-lead diagnostic, cross-linked to the altitude rule.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.35.0.

## [1.34.0] - 2026-07-19

Incorporates external feedback on why LLM-drafted prose reads dense and what reliably fixes it. The through-line is one diagnosis: a model treats every sentence as a chance to convey maximum information, so every sentence works equally hard, and prose that never varies its load exhausts the reader even when every sentence is true. The release names that cause and adds the moves that address it, all inside the existing constraints (no new substance, reorder the author's own material, propose what needs drafting). The pieces the feedback already had a home for (commit to claims over hedging, cut nominalizations, sentence-length variety, diagnose before editing) were already covered and are unchanged; this batch adds only what was genuinely new. No new commands, subagents, tools, or reference files; edits land in the reader-experience and narrative-spine references and their `SKILL.md` summaries.

### Changed

- `references/reader-pleasure.md` gains three additions. A "Load variation" section names the density cause and legitimizes the low-load sentence: after settling argument and structure, the reader-experience pass adds no information (constraint 1), and that restriction is what redirects its effort into rhythm and load, so a sentence that only orients, restates, or transitions earns its place by relief rather than being compressed away as redundant. A "The running example" section adds the highest-leverage delight move, one concrete example threaded from introduction through discussion, bounded by constraint 1: the editor may thread an example the author already wrote and flag where scattered examples could become one, but inventing or extending a running example is an `Author questions` item, not an edit. The exemplar section now accepts an author-supplied pacing exemplar ("match the sentence-length variation and paragraph pacing of this"), treated as a rhythm model only, never a voice, diction, or content to copy. A "tired-reviewer read" is added to the pleasure test (read as a tired reviewer at 11pm and quote every sentence where attention drops), and the rationale-language list gains the matching mechanisms.
- `references/narrative-spine.md` gains a "What the reader believes, in and out" section: before restructuring, name what the reader believes walking in and what they should believe walking out, and treat that delta as the section's job and the spine as the path across it. It names the deeper cause of density, a section organized by topic rather than by the reader's evolving understanding, and directs reordering of the author's own material toward the reader's changing beliefs while routing missing belief-changing content to `Author questions`. This uses the existing `Reader map:` output line as a structural test rather than a reporting line.
- `references/cold-read.md`'s delight audit now finds the taxes adversarially, reading the whole paper as a tired reviewer at 11pm and quoting each attention-drop, on the premise that a model diagnoses dead prose far better than it avoids writing it, and checks for a single running example as an unclaimed reward. The pass stays diagnosis-only and feeds the dispatch list.
- `SKILL.md`'s "Reader experience" and "Narrative spine" editing principles gain one-sentence summaries of load variation, the pacing exemplar, the reader-belief delta, and the topic-versus-understanding density cause, so the concepts are discoverable from the top level and reachable in the already-loaded reference files.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.34.0.

## [1.33.0] - 2026-07-14

Batch B-M6 of the 2026-07 skill review: the optional reference consolidation. `sentence-cohesion.md` duplicated material already carried elsewhere (its stress-position, throat-clearing, active-voice, and nominalization topics were pattern entries in `sentence-patterns.md`, and the deep given-new and reader-expectation theory lives in `principles.md`), so it is merged away and the reference set drops from 11 files to 10, with fewer load decisions and no drifting duplicate lists. Item ID refers to `review-b.md`'s section M (M6) and its adjudication in `docs/review-2026-07/reconciliation.md` (item 16, marked low priority). No editorial behavior changes: the same guidance is reachable, from one fewer file.

### Changed

- `references/sentence-patterns.md` gains a compact "Cohesion within the paragraph" section (the given-new chain, topic strings, and sentence-length variety) that captures the cohesion topics not already present as patterns, pointing at `references/principles.md` for the underlying theory. Its "Hedge stacking" section now states one rule with one exception (one hedge per claim, maximum; a hedge that marks genuine calibration or scope is content, kept and counted as the claim's one hedge) in place of the three separate imperative sentences, resolving the review's three-hedging-rules finding.
- The live references to the removed file are retargeted: `SKILL.md`'s transition rule now points at the given-new chain in `references/sentence-patterns.md` (theory in `references/principles.md`), `paper-reviser.md`'s reference-trigger list drops it, and `polish.md` loads `references/sentence-patterns.md` for the cohesion moves. `references/sentence-cohesion.md` is deleted.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.33.0.

### Removed

- `references/sentence-cohesion.md`, merged into `references/sentence-patterns.md` and `references/principles.md`.

## [1.32.0] - 2026-07-14

Batch 5f of the 2026-07 skill review: a test harness for `install.sh`. The installer is the repository's largest untested surface, and its highest-churn logic (command registration, the install manifest, refresh, uninstall, and the ref-sync/update path) had no CI coverage even though nearly every recent installer fix landed in exactly that logic. Rather than shrink the installer's surface (the review's alternative, which would drop user-facing features like copy-mode or `--ref` stickiness), this release adds the coverage. Item ID refers to `review-b.md`'s section F/testing note and its adjudication in `docs/review-2026-07/reconciliation.md` (item 22); the batch checklist lives in `PLAN.md`. No skill behavior changes; this is CI only.

### Added

- `scripts/test-install.sh`, a hermetic behavior test for `install.sh`, covering the four scenarios the review names: `--init` in a fresh temp git repo (the `<paper_context>` block is scaffolded, a skipped field writes `[fill in]` and never the old `first draft` default, and the paper: commands, the three subagents, and the manifest are registered); `--commands` then `--uninstall` (the skill symlinks and every managed file are removed, a user's own file in the paper: namespace survives, and the manifest is dropped); refresh (re-registering from a changed source drops a command no longer shipped, registers a newly shipped one, rewrites the manifest, and leaves an unmanaged file untouched); and `--update` against a local origin ahead of the clone (the clone fast-forwards and the registered commands refresh to include a command added upstream, with a user's own command preserved). Each scenario runs in a throwaway sandbox with `HOME` and `PAPER_REVISION_EDITOR_HOME` pointed inside it, so it never touches the real `~/.claude`, `~/.agents`, or managed clone, and it builds a local git origin for the update test, so the whole suite needs no network. It is wired into `make test` and CI, and is shellcheck-clean (CI already shellchecks `scripts/*.sh`).

### Changed

- `make test` now runs `test-install` after the format checks; the Makefile gains a `test-install` target and help line, `.github/workflows/ci.yml` gains an "Installer behavior tests" step, and `scripts/README.md` documents the new script.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.32.0.

## [1.31.0] - 2026-07-14

Batch 5e of the 2026-07 skill review: the analyst lane's two generative capabilities. The computation branch shipped verification-only in v1.29.0 (rerun the author's pipeline, diff its outputs against the manuscript's numbers). This release adds the two capabilities the addendum sequenced last and highest-risk, once the integrity norms had been exercised by verification: regenerate a named figure with better design from the same data and script, and run a new analysis the author names. Both author only new files in a proposal location and never touch the author's code, data, figures, or manuscript; the no-forking-paths rule is the load-bearing constraint on new analyses, keeping data access from becoming a machine for hypothesizing after the results are known. `SKILL.md`'s `allowed-tools` stays `Read Edit Grep Glob` per the reconciliation's conflict-5 architecture; the capability lives in the gated `paper-analyst` subagent, whose tool list gains `Write` so it can author new scripts and render new outputs. Item IDs refer to `review-b.md`'s addendum (A3 lane 3 capabilities 2-3, A5 item 5) and its adjudication in `docs/review-2026-07/reconciliation.md` (item 21); the batch checklist lives in `PLAN.md`.

### Added

- Addendum A3 lane 3 capability 2: `/paper:figures`, figure regeneration. Dispatches to the `paper-analyst` subagent, which finds a named figure's own producing script and data, authors a new plotting script that reads the same data and produces the same series, improves only the presentation (color, scale labeling, ordering, gridlines) per `references/edit-checks.md`, verifies the re-render plots the same values as the original, and proposes the two side by side for the author to choose. It changes how the data is shown, never which data: a re-render that alters a value, hides points, adds a series, or smooths where the original did not is a new analysis and routes to `/paper:analyze`. It never overwrites the author's figure or figure script.
- Addendum A3 lane 3 capability 3: `/paper:analyze`, running a new analysis the author (or a reviewer through the author) names. Dispatches to the same subagent, which pins the specification before running (the outcome, the sample or subgroup, the model or test, and what result counts as which answer), authors a new analysis script, runs it, logs the script, command, data version, and full output, and reports the whole result whichever way it points, the whole grid when the author named one, labeling exploratory output as exploratory. The result enters `Revised text` as a clearly marked candidate addition with its provenance, never woven into an existing claim. It never invents the question itself and never runs a new analysis to "strengthen the results" on its own initiative.
- `references/analysis-integrity.md`, previously the verification-only reference, is rewritten to own all three capabilities under one set of integrity norms (provenance or it does not exist; no garden of forking paths; read and execute, author only new files; results and figures are proposals; a changed number changes the paper). It opens with the gate condition covering all three (data and analysis code, a shell, and for the generative capabilities a write tool), and its reporting conventions cover both the verification sentinel (`No rewrite requested.`) and the proposal outputs.

### Changed

- `paper-analyst`'s tool list gains `Write` (now `Read, Grep, Glob, Bash, Write`) so it can author new plotting and analysis scripts and render new outputs to a proposal location; its hard rules replace the old "never run new analyses or regenerate figures" ban with the no-overwrite, no-forking-paths, and proposal-only rules that make the expansion safe. `SKILL.md` names all three capabilities where the master rule anticipates the computation branch, adds the "When NOT to use" routes and the two trigger examples ("Make Figure 3 carry the result", "Run the subgroup robustness check reviewer 2 asked for"), and updates the frontmatter description; `allowed-tools` is unchanged.
- README documents the two capabilities (command table, the analyst-lane paragraph, the honest-limit paragraph, the loop's on-demand note) and `loop.md` carries them as on-demand targeted passes dispatched from the cold read's list rather than standing whole-paper phases. `install.sh` and the CI scripts already glob `.claude/agents/*.md` and `.claude/commands/paper/*.md`, so `figures.md` and `analyze.md` register and lint with no change.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.31.0.

## [1.30.0] - 2026-07-13

Batch 5d of the 2026-07 skill review: the scholar lane. The master rule's retrieval branch (a citation is verified when retrieved and read by you, with the source quoted) gets its own working lane, shipped per the reconciliation's conflict 5 architecture: its own command and its own gated subagent carrying its own tool list, while `SKILL.md`'s `allowed-tools` stays `Read Edit Grep Glob` and the editor's safety audit stays valid unchanged. This closes the honest limit the README carried since v1.0 (the skill preserved citations but could not verify them): where the environment grants literature retrieval, citation verification and novelty scanning are now in scope, exactly as the addendum's conflict-5 adjudication anticipated. Retrieval only: the two capabilities ship citation verification before novelty scan, and both report leads and flagged candidates the author decides on, never edits. Item IDs refer to `review-b.md`'s addendum (A1 E5, A3 lane 4, A4, A5 item 4) and its adjudication in `docs/review-2026-07/reconciliation.md` (conflict 5, item 20); the batch checklist lives in `PLAN.md`.

### Added

- Addendum A3 lane 4 / A5 item 4: `/paper:scholar`, the scholar lane. Dispatches to the new `paper-scholar` subagent (`tools: Read, Grep, Glob, WebFetch, WebSearch`), which fetches and reads the sources the manuscript cites, judges whether each supports the claim attached to it, scans stated contributions for overlapping prior work, and returns the four-section output with a citation-verification table (supported, mismatch reported as unsupported, unverifiable; every source carries title, venue, year, and the passage read) and novelty leads. It never edits the manuscript: a citation change or a recalibrated novelty claim is a flagged candidate in `Revised text` with its retrieved source attached, and the skill's shared `No rewrite requested.` sentinel is the default. Citation verification maps each `\cite{key}` through the manuscript's bibliography (`.bib` or `thebibliography`) before retrieval, and an absence from an abstract-only source is `unverifiable`, never `unsupported`.
- `references/literature-checks.md` owns the lane's protocol and, per addendum A4, opens with its gate condition: the pass runs only when the environment grants literature retrieval; when it is missing it says so, asserts nothing about any source, and routes the question to `Author questions` instead of citing from memory. The protocol orders its steps (inventory the cited and novelty claims before the first search, verify each citation against the retrieved source, scan novelty and fill gaps, report) and carries the addendum's integrity norms: retrieved, not remembered (a citation from model memory is treated as fabricated); leads, not verdicts (a novelty scan proposes candidates for the author to judge, never rules on the contribution); additions are flagged (a citation change enters only as a proposed edit with the source attached); and a recalibrated claim changes the paper, so accepted corrections route to `/paper:consistency`.
- `SKILL.md` names the lane where the master rule already anticipated the retrieval branch (now stated as two lanes, one per branch), adds the "When NOT to use" route (citation verification and novelty scanning are the scholar lane's job; the editor preserves citations and flags what it cannot verify), the when-to-use trigger, and the trigger example ("Does reference 12 actually support what we say it does, and is our contribution really novel?"). `allowed-tools` is unchanged.

### Changed

- README documents the lane (command table, the retrieval-branch paragraph, the loop's Phase 1 option) and shrinks the honest limit: citations are now verifiable where retrieval exists, via `/paper:scholar`, alongside the numbers lane. `loop.md`'s staged plan carries the conditional scholar step after the cold read, gated the same way, so `/paper:loop` users are not silently skipped past it. `install.sh` and the CI scripts already glob `.claude/agents/*.md` and `.claude/commands/paper/*.md`, so `paper-scholar.md` and `scholar.md` register and lint with no change.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.30.0.

## [1.29.0] - 2026-07-05

Batch 5c of the 2026-07 skill review: the analyst lane's first capability, number verification. The master rule's computation branch (a number is verified when computed from the repo's own data, with the producing command logged) gets its first working lane, shipped per the reconciliation's conflict 5 architecture: its own command and its own gated subagent carrying its own tool list, while `SKILL.md`'s `allowed-tools` stays `Read Edit Grep Glob` and the editor's safety audit stays valid unchanged. Verification only: the more ambitious analyst capabilities (figure regeneration, new analyses) stay out of scope until the integrity norms have been exercised, per addendum A5. Item IDs refer to `review-b.md`'s addendum (A3 lane 3 capability 1, A4, A5 item 3) and its adjudication in `docs/review-2026-07/reconciliation.md` (conflict 5, item 19); the batch checklist lives in `PLAN.md`.

### Added

- Addendum A3/A5 item 3: `/paper:verify-numbers`, the analyst lane. Dispatches to the new `paper-analyst` subagent (`tools: Read, Grep, Glob, Bash`), which reruns the author's own analysis pipeline and diffs its outputs against every number the manuscript reports, returning the four-section output with a verification table (match, mismatch, unverifiable; every recomputed value carries the producing command and data version) and `No rewrite requested.` as the revised text. It never edits the manuscript, the analysis code, or the data.
- `references/analysis-integrity.md` owns the lane's protocol and, per addendum A4, opens with its gate condition: the pass runs only when the repo contains the author's own data and analysis code and the environment grants a shell; when either is missing it says which half and routes the question to `Author questions` instead of faking a check. The protocol orders five steps (discover the pipeline, extract the manuscript's numbers, state the plan, run and log, diff and report; both the number inventory and the plan are pinned before the first run, and run provenance names the actual inputs when the working tree is dirty) and carries the addendum's integrity norms: provenance or it does not exist; no garden of forking paths (state the analysis before running it, report it whichever way it points, never scan specifications for a favorable result); recomputed values are proposals the author decides on; a changed number changes the paper, so confirmed corrections route to `/paper:consistency`.
- `SKILL.md` names the lane where the master rule already anticipated it, adds the "When NOT to use" route (number verification is the analyst lane's job; the editor treats numbers as protected content), and adds the trigger example ("Are the numbers in the abstract still what the pipeline produces?"). `allowed-tools` is unchanged.

### Changed

- `install.sh` registers every shipped subagent by globbing `.claude/agents/*.md` (mirroring the existing command glob) instead of hardcoding `paper-reviser.md`, so `--init` and `--commands` pick up `paper-analyst.md` and any future lane agent; the uninstall manifest logic already handled the general case. README documents the lane (command table, the analyst-lane paragraph, the loop's Step 1 option, the honest-limit note that numbers are now verifiable where a pipeline exists), and `loop.md`'s staged plan carries the conditional verification step after the cold read, gated the same way, so `/paper:loop` users are not silently skipped past it.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.29.0.

## [1.28.0] - 2026-07-05

Batch 5b of the 2026-07 skill review: the master-rule split. The old master rule ("this skill edits existing prose; it does not draft new sections") conflated two different acts: fabrication (asserting a number, citation, or finding that was never computed or retrieved), which stays absolutely banned in every lane, and computation or retrieval (running the author's own analysis code, reading actual papers), which later gated lanes may perform with provenance. The replacement is a strictly stronger honesty standard stated once and instanced by the existing constraints. Editor-lane behavior is unchanged: this skill's tool surface performs no computation and no retrieval, so every unverified-substance question still routes to `Author questions`, exactly as constraint 1 already requires. Item IDs refer to `review-b.md`'s addendum (A2, A5 item 2) and its adjudication in `docs/review-2026-07/reconciliation.md` (item 18); the batch checklist lives in `PLAN.md`.

### Changed

- Addendum A2/A5 item 2: `SKILL.md`'s constraints block now opens with the master rule, in the addendum's canonical wording: never assert unverified substance; every number in your output was either written by the author or computed by you from the repo's own data, with the producing command logged; every citation was either written by the author or retrieved and read by you, with the source quoted; every other claim is the author's; substance you cannot verify by computation or retrieval is a question for the author, never an edit. The substance (1), citation (3), and numerical (4) constraints are named as instances of it, and a closing sentence gates the computation and retrieval branches on a lane's tool surface, so the rule is ready for the analyst and scholar lanes without widening this skill's tools.
- The drafting-ban sentence in "When NOT to use" now states the same principle instead of a categorical scope claim: drafting a section from notes would assert substance the skill cannot verify. The "Write me a discussion section" trigger example and the README's cold-read rationale line follow.
- `paper-reviser.md`'s hard rules open with the master rule, scoped to the dispatch's tool surface (no computation, no retrieval, so every number and citation must be the author's own).
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.28.0.

## [1.27.0] - 2026-07-05

Batch 5a of the 2026-07 skill review: the first addendum lane, the reader. The whole-paper revision now opens and closes with a cold read of the full manuscript by its intended reader, instead of a per-section feedback sweep stitched together. Per the reconciliation's conflict 5 architecture, the lane ships as its own command riding the existing editor dispatch; `SKILL.md`'s `allowed-tools` stays `Read Edit Grep Glob`, and the pass needs no tools beyond reading. Item IDs refer to `review-b.md`'s addendum (A1-A5) and its adjudication in `docs/review-2026-07/reconciliation.md`; the batch checklist lives in `PLAN.md`.

### Added

- Addendum A3/A5 item 1: `/paper:read`, the whole-paper cold read. Diagnosis only: read the manuscript front to back, once, as the `<paper_context>` audience, and report the reading experience inside the four-section output: a reading log (at each section boundary, the question the reader carries, whether the finished section answered the one they brought in, and the first sentence where a venue-competent non-specialist stops following or stops caring), the colleague test compared against `core_thesis` (built from quoted manuscript sentences before `core_thesis` is re-read, since the context gate already exposed it and an honestly blind summary is impossible; a mismatch outranks every sentence-level finding), a delight audit (where the paper rewards and where it taxes the reader, measured rather than asserted), and a prioritized dispatch list into the other commands that feeds the loop's pass order. The command's file-set rule matches `/paper:consistency` (follow the wrapper's include graph in reading order, inline roots by heading, never sweep in siblings).
- `references/cold-read.md` owns the protocol and its reporting conventions (the five reader-pleasure tests and the layered-audience meta-rule from `references/edit-checks.md`, applied at paper scale), so non-Claude-Code agents get the pass too. Venue compliance moves here from its planned `/paper:consistency` bolt-on, per the reconciliation's conflict 5 supersession: length against a known venue limit (report the gap, never force the cut), venue structure, and double-blind anonymization leaks, each skipped with a note when its `<paper_context>` input is unknown.
- `SKILL.md` gains a "Whole-paper cold read" section, the when-to-use trigger ("read the whole paper the way its intended reader would"), and the cold read as a second named exemption from the seven-item Diagnosis cap; the `paper-reviser` agent's description and reference-file list carry the lane.

### Changed

- Addendum A1/A5 item 1: `loop.md`'s global diagnosis step is now one cold read, not a per-section feedback sweep. Phase 1 of the staged plan runs `/paper:read`; Step B's pass order is fed by the cold read's dispatch list; Step C's per-section `feedback` remains the local diagnosis at edit time and now carries the cold read's findings for the section in the dispatch; Step E closes with the exit cold read (before the final polish, which is sentence-level only and cannot repair what the read finds); Step G stops the loop when that read comes back clean and the colleague test matches `core_thesis`. A cold read still reads author-skipped sections, since a reader cannot skip them, but its dispatch-list entries for them are recorded, never dispatched. The README's loop steps, command tables, and repo-layout row follow.
- Reconciliation refinement 2 (both stop rules kept): the cold read decides whether the loop dispatches another pass; inside any single dispatched pass the editor's stop rule is unchanged ("the remaining edits would be merely different rather than better"), so the cold read's pursuit of a delighted reader never justifies churn edits. `loop.md` Step G and `references/cold-read.md` both state the composition.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.27.0.

## [1.26.0] - 2026-07-05

Batch 4 of the 2026-07 skill review: the capability batch. The response-to-reviewers suite gains its missing entry and exit points (`/paper:triage` in, `/paper:letter` out), and the skill gains a context fallback for chat sessions, messy-input guidance, monolithic-file handling, length-target routing, a dispatch-completeness rule, author-edit preservation across rounds, and a relocated whole-paper consistency checklist. Item IDs refer to `review-a.md` (A-), `review-b.md` (B-), and their adjudication in `docs/review-2026-07/reconciliation.md`; the batch checklist lives in `PLAN.md`.

### Added

- B-E1/B-M3/A-F10: `/paper:triage`, decision-letter triage. Diagnosis only: the decision letter in; a severity-ranked comment table (label, comment, severity, prose-fixable / needs-new-substance / rebut-only / unclear classification, section mapping, cluster) and a recommended order of work mapped onto the other `paper:` commands out. The reviewer workflow's conflict and overclaim rules apply to the plan; the seven-item Diagnosis cap does not. `loop.md` Step A and the README now route response-to-reviewers work through triage before per-section `/paper:rebut`.
- B-E3/B-G9/A-F11: the response letter is now an explicit lane. `rebut.md`'s closing paragraph is review B's G9 canonical text (reply text may restate and cite what the revision did; it must never promise or assert analyses, results, or claims the manuscript does not contain), resolving the promise-vs-ban contradiction with the skill's no-drafting scope rule. The same license lives in `SKILL.md`'s reviewer-response workflow, folded with A-F11's verification rule: every claimed manuscript change must point at a real location, and unverifiable claims go to `Author questions`, never left standing. The new `/paper:letter` command diagnoses a draft letter against the rebuttal conventions in `references/structural-patterns.md` (structure, tone, coverage), verifies location claims, flags the promise-without-change pathology, and preserves the author's agree-or-disagree positions. `examples/response-letter-example.md` demonstrates the lane end to end and passes both example CI checks.
- A-G9/B-E2: `/paper:rebut` output now ends with a comment-to-change status table (Comment, Paragraph(s), Status, Where; every reviewer comment in exactly one row), the checklist the author carries into the response letter.
- A-G5/B-M9: an "Input formats and messy input" section in `SKILL.md` (LaTeX first-class; Word and Google Docs via pasted text with the lossy round-trip stated and cross-reference artifacts protected; OCR damage named and only mechanically repaired, never diagnosed as the author's prose; comment-only triage when no manuscript is supplied; very long manuscripts processed per section with compared consistency inventories), plus a README Formats note.
- A-D7/B-E7: an across-rounds rule in the Restraint section: the current file is the author's decision record; a passage the author hand-tuned, reworded, or reverted since the last pass is deliberate; a rejected edit is never re-proposed, and an apparent reversion is noted in `Author questions` once, not per pass. `loop.md`'s Step C checkpoint carries the same rule.
- B-M7: `references/consistency-checks.md` now owns the whole-paper consistency checklist and its reporting conventions, so non-Claude-Code users get it; `consistency.md` points at the file instead of restating the list, and `SKILL.md`'s Diagnosis cap exemption names it.

### Changed

- Conflict 2 resolution (B-G4 + the A-G2 inference sentence, restrictive stages only): when no `<paper_context>` block can exist (a chat session or a pasted section), the skill asks once, in a single message, for the four fields instead of hard-stopping. Stage inference runs only toward more restrictive scopes (pasted reviewer comments imply response-to-reviewers scope; "camera-ready" or "proofs" implies `final polish`); on a partial answer or a decline the pass proceeds at `final polish` with an `Assumed context:` line naming every assumed value, and `first draft` is never assumed without explicit confirmation. The README chat-surface note drops its interim ask-first wording.
- B-C4/B-E6b: a monolithic single-file manuscript now has an addressable unit: `\section{...}` commands or Markdown headings are the section list, confirmed with the author and processed one at a time (`SKILL.md` triage and `loop.md`); "cut to fit N pages" requests route into the Subtraction pass with the target as context, never a quota: cut by keep-test toward the target, report the gap instead of forcing it, and point at where further cuts would do the least harm.
- B-C8: dispatch completeness. `rebut.md` no longer points the isolated subagent at "the conversation" it cannot see; every dispatching command states that the subagent sees only what the dispatch carries and that the request must include everything needed, in particular the user's answers to prior clarifying questions; `loop.md` carries the rule as a hard guardrail.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.26.0.

## [1.25.0] - 2026-07-03

Batch 3 of the 2026-07 skill review: the four example defects plus the CI that locks the examples from then on, landed atomically because the new checks fail against the unrepaired examples by design. Item IDs refer to `review-a.md` (A-), `review-b.md` (B-), and their adjudication in `docs/review-2026-07/reconciliation.md`; the batch checklist lives in `PLAN.md`.

### Fixed

- B-D10a: `examples/worked-example.md` diagnoses a payoff teaching gap at `first draft`, which the Diagnosis table says triggers the three extraction lines; they were absent, so the flagship example violated the rule it anchors. The three lines are now present after `Reader map:` (`Jargon to unpack:` correctly reads none, per the record-none-rather-than-manufacture rule in `references/exposition.md`).
- B-D8/B-G7: `examples/exposition-methods.md` built its opening bridge from `core_thesis` metadata ("no clean control group") while its closing section claimed nothing was invented, teaching exactly the leak the rules forbid. The rewrite now opens on the staggered-timing fact promoted from the paragraph itself, the "(opening)" rationale line is review B's G7 canonical text, and the missing motivation became an Author question instead of imported metadata. Word count recounted: 88 to 123 (+40%).
- B-D10b: `examples/exposition-results.md` claimed the significance and R-squared passage was "carried over verbatim" when the rewrite had merged the two sentences in reversed order and renamed "the interaction" to "the tenure interaction". The rationale now describes the actual edit; the stale numerical-claim pointer the 1.24.0 entry deferred here now reads constraint 4.
- B-D10d: `examples/reviewer-response-example.md` carried `[P1]`-style labels inside the `Revised text` fenced block, contradicting the no-commentary rule and creating a copy-paste hazard. The labels now live only in the mapping, the Diagnosis, and the rationale, and the example says so.
- B-D10c: all four `Reader map:` lines drifted from the SKILL.md template ("should leave seeing", "should leave able to say"); every example now uses the template's "should leave with".
- All six `Word count:` lines now carry the approximate-count markers the Change rationale contract specifies (`~139 to ~86`), and `check-examples.sh` requires them; the counts themselves are unchanged and still verify exactly on recount.

### Changed

- A-D2: the added identification bridge in `examples/exposition-introduction.md` was re-audited against constraint 1 and stands as a translation of the draft's own asserted quasi-randomness (conditional on observed covariates) into its mechanism, not new substance, provided the flag lives where the author reads. Accordingly every example now carries the mandatory `Added bridges:` line the Batch 2 output contract added (quoting each added why-it-holds sentence with a matching confirm question, or `None.`); the introduction's Author question now quotes the bridge's actual wording instead of a paraphrase, and `exposition-methods.md` gained the confirm question for its restored staggered-bias inference.

### Added

- B-M8: `scripts/check-examples.sh` (`make check-examples`, run in CI) locks the examples to the strict output format: the four exact headings once each and in order, the `Word count:` line opening `Change rationale` in the required shape, a question mark on every `Author questions` bullet, a banned-tell grep over every edited paragraph of the `Revised text` fenced block covering every mechanically decidable catalogue entry (a paragraph returned verbatim from the input is exempt, which is the deliberate-verbatim case, detected by comparison rather than a hand-kept whitelist; the catalogue's judgment-call words such as generic "robust" stay with the read-cold pass), a legal `revision_stage` value so the stage branches cannot be skipped, the stage-appropriate Diagnosis headers (`Voice tics:` opening the block and `Reader map:` preceding the numbered list at first draft; those and the extraction lines forbidden at final polish and response to reviewers), extraction-line consistency (which fails on the pre-B-D10a `worked-example.md` by design), a complete `Added bridges:` paragraph (quoted bridges with balanced quotation marks, or `None.`), no editor labels inside the block, and the `Reader map:` template.
- A-D6: `scripts/check-protected.sh` (`make check-protected`, run in CI) diffs the multisets of protected content between each example's input block and its `Revised text` block: citation keys (LaTeX `\cite` variants including optional arguments, pandoc `@key` bare or bracketed, and plain author-year runs including "Smith (2020)" and "(Smith, 2020)" forms, so an author swap that keeps the year is caught), cross-reference keys and prose callouts ("Table 4", "Appendix C", so a callout-type swap that keeps the number is caught), math spans (inline and display dollar delimiters kept distinct, `\(...\)` and `\[...\]` even when the formula contains ordinary brackets), whole `\begin{...}...\end{...}` environments including contents and their internal line breaks (SKILL.md protects source formatting inside `tabular` and `lstlisting`; `\caption` constructs in any form are blanked first since caption text is editable prose), macros with their arguments including one-character commands such as `\&` (prose-argument macros such as `\caption` are diffed by name only, honoring the constraint 5 caption carve-out), quoted text in straight, TeX, or curly quotes (constraint 7), `%` comment lines (constraint 5, diffed unflattened), and numbers with their sign, thousands-separator, range, percent, and fixed-lexicon unit-word context (so `12%` to `-12%`, a rewritten `5-9%` range, or `6 points` to `6 percent` is caught). The mechanical version of the "No protected content changed" preflight, with an in-script exceptions list for legitimate flagged changes (empty by design).
- A-D8/B-I3: `scripts/lint.sh` link checking now resolves every `references/*.md` and `examples/*.md` path named in `SKILL.md`, `README.md`, the command files, the agent file, and the reference and example files themselves; it previously covered only SKILL.md-to-references links.
- `make test` now runs check-version, lint, check-examples, and check-protected.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.25.0.

## [1.24.0] - 2026-07-03

Batch 2 of the 2026-07 skill review: the one behavioral release. Rewrites the constraint block and the output contract. Item IDs refer to `review-a.md` (A-), `review-b.md` (B-), and their adjudication in `docs/review-2026-07/reconciliation.md`; before/after adversarial-eval evidence is in the batch PR body.

### Added

- B-G2: new hard constraint 1, "never add substance the manuscript does not contain" (no new claim, example, mechanism, definition, implication, or justification; gaps route to `Author questions`). The rule that separates editing from drafting previously lived only in "When NOT to use" and `references/exposition.md`, so the numbered constraints, the commands, and the subagent never restated it. Threaded through `paper-reviser.md`'s hard rules and `loop.md`'s carried guardrails.
- Conflict 3 resolution: a mandatory `Added bridges:` line immediately after the `Revised text` fenced block, quoting every added sentence that states why an assumption, identification strategy, or validity claim holds (or `None.`), each with a matching `Author questions` item. Inline bracketed editor tags inside the fenced block are explicitly forbidden (review B's D10(d) copy-paste-hazard evidence invalidated review A's inline-tag mechanism). Enforced by a new preflight bullet.
- B-G3: a "Where the revision goes" section. By default the revision is returned in `Revised text` and no manuscript file is modified; files are written only on an explicit apply request, exactly as shown, scoped to the requested section, logged in `Change rationale`, and never with unresolved `Author questions` touching the applied content. `loop.md` Step C now tells the author an unapplied revision re-reports the same items by design; `paper-reviser.md` scopes its `Edit`/`Write` tools to the explicit apply step.
- B-G6: reviewer-workflow rules 6 and 7. A reviewer request for a stronger, broader, or more causal claim never licenses text beyond the stated evidence (write the strongest licensed version; the gap goes to `Author questions`), and two incompatible reviewer demands on the same passage get neither edit (both readings and a proposed resolution go to `Author questions`).
- A-D1: an optional `style_overrides:` line in `<paper_context>` is now the one way to set aside house style (the em-dash ban, banned-phrase entries) for a paper; protection constraints never yield. Documented in the context gate, the constraints, and the voice-extraction rule.

### Changed

- A-G7: the constraints block is reordered science-first. No-added-substance and technical-claim meaning lead; the em-dash rule moves from first to last and gains the direct-quote exception (B-D7a). The markup constraint is generalized beyond LaTeX to whatever encodes citations, cross-references, and math in any source format, with a caption carve-out (B-E8: `\caption{...}` text is editable prose, the rest of the environment stays opaque, resolving the collision with `edit-checks.md` check 5).
- B-D6: redistributing a paragraph-end citation wall is now explicitly an author decision: constraint 3, the style bullet in `references/ai-tells-to-avoid.md`, and `AGENTS.md.template` all say to propose it in `Author questions`, never perform it, since assigning citations to claims is attribution.
- B-G5: "a qualifier is content." Removing a scope or calibration qualifier ("on the held-out set", "in our sample", a hedge that marks uncertainty) is a deletion, never a compression, whatever its length; logged in `Change rationale` and flagged under the numerical-claim constraint when it touches one. Stated in the Subtraction section and constraint 6.
- B-G10: the three conditional Diagnosis-header paragraphs are replaced by a four-row decision table (whole-section/first-draft, single-paragraph non-first-draft, final polish, response to reviewers). `references/exposition.md` is now the single owner of the extraction-line definitions and teaching-gap catalogue, and the second, conflicting statement of the voice-tics exception set (old line 212) now defers to the table.
- Conflict 1 resolution: the frontmatter description is review B's G1 text plus review A's "line-edit" token, adding the feedback-only, consistency, and length-fit triggers and an explicit negative scope. Per conflict 4, grant proposals stay out of the description and auto-trigger: a new "When NOT to use" bullet serves grant narratives on explicit request only.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.24.0.

### Fixed

- Constraint renumbering fallout: `references/narrative-spine.md` now points at the renumbered numerical-claim constraint. The same stale pointer in `examples/exposition-results.md` is deferred to Batch 3, which rewrites that file's rationale line (B-D10b).

## [1.23.0] - 2026-07-03

Batch 1 of the 2026-07 skill review (`docs/review-2026-07/`): plumbing bugs and documentation corrections that do not change editorial behavior, plus three narrowly scoped `SKILL.md` wording repairs the review found internally inconsistent. Item IDs refer to `review-a.md` (A-), `review-b.md` (B-), and their adjudication in `reconciliation.md`; the batch checklist lives in `PLAN.md`.

### Fixed

- B-C9: all eight files under `.claude/commands/paper/` interpolated `$ARGUMENTS` twice (once in the body, once at the foot), so a pasted section was injected into the dispatched prompt twice. Body references now say "provided below" and only the foot interpolates.
- B-G8: `install.sh --init` silently defaulted a skipped revision-stage prompt to `first draft`, the most permissive stage, and never validated a typed value. A skipped stage now writes the same gate-tripping `[fill in]` placeholder as the other skipped fields, and an unrecognized value gets a warning naming the three legal stages.
- B-D7b: the carried-guardrails list in `loop.md` omitted "no change to the meaning of any technical claim", the skill's most important rule. It now leads that list.
- B-D5: the read-cold pass said to fix every AI tell in the output, including in text the stage gates require returning verbatim (for example unflagged paragraphs on a response-to-reviewers pass). Its repairs are now scoped to text editable at the current stage.

### Changed

- A-C8/B-D9: the `Word count:` line in `Change rationale` and the length budget now use approximate counts to the nearest ~10 words (for example `~139 to ~86`), keeping direction and rough magnitude, with a tool-computed count when a tool is available. Exact counts were demanded from a system that miscounts, and a visibly wrong first line undermined the rationale below it.
- A-C7: the seven-item Diagnosis cap no longer applies to whole-paper diagnosis-only passes such as `/paper:consistency`, whose value is exhaustiveness; long lists group findings by type with counts.
- B-C10: `README.md` documents `paper-meta.md` as the paper-context escape hatch for non-git papers; `paper-reviser.md` step 1 also checks `~/.agents/skills/` so an `~/.agents`-only install resolves; `loop.md` Step A records an author-approved section skip list (for example appendices under deadline) that Step B and the Step G stop condition honor.
- B-G11: `README.md` corrections: the Manual-install `make init` line no longer implies it scaffolds your paper repo when run from the clone; the `--check` troubleshooting bullet no longer tells copy-mode users to move aside a healthy fallback install; the "Why use it" section states the honest limit that citations are preserved exactly but not verified against the claims they support.
- A-G8: the Quickstart gains a note for claude.ai, Cowork, and other chat-surface users on using the skill without the installer. Its closing sentence states the current ask-for-context behavior; the assumed-context fallback it will eventually describe is Batch 4 work.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.23.0.

### Rationale

The review plan (`docs/review-2026-07/PLAN.md`) lands the no-behavior-change fixes first so the behavioral release (Batch 2, the constraint-block rewrite) and the example and CI work (Batch 3) start from a clean plumbing and documentation base. Every change here traces to an item adopted in `reconciliation.md`; wording follows the canonical patch selection in its section 6.

## [1.22.0] - 2026-06-29

The installer now registers the `paper:` slash commands, closing a gap where `/paper:loop` (and the rest) came back as "Unknown command" on a machine that had the skill installed. Claude Code discovers commands under `.claude/commands/` in a repo or `~/.claude/`, never from inside an installed skill directory, so shipping the command files in the skill was not enough: they had to be copied into one of those trees. Previously that copy was a documented manual step, easy to miss, and a marketplace or symlink install left no obvious source to copy from. The installer now does it.

### Added

- `install.sh`: a `--commands` mode that copies the `paper/` command directory and the `paper-reviser` agent into `~/.claude/`, registering `/paper:loop`, `/paper:revise`, `/paper:feedback`, `/paper:clarify`, `/paper:human`, `/paper:rebut`, `/paper:polish`, and `/paper:consistency` for every project. It also links the skill into the standard targets first (the agent loads the skill from `~/.claude/skills`, so registering commands without the skill would leave names that resolve to nothing), and is idempotent and safe to re-run after an `--update` to pick up new or changed commands.
- `install.sh`: an `install_commands` helper shared by `--init` and `--commands`. It resolves the command and agent files from the skill source (a local clone, or the managed clone the symlinks point at) and refreshes them in place under the target `.claude/` tree.

### Changed

- `install.sh`: `--init` now registers the `paper:` commands and the `paper-reviser` agent in the current paper repo (`<repo>/.claude/`) in addition to scaffolding `AGENTS.md`/`CLAUDE.md`, so a single setup step makes the slash commands resolve. The registration runs even when `AGENTS.md` already has a `<paper_context>` block, and it links the skill first (like `--commands`) so a standalone `--init` before any normal install does not register commands against a missing skill.
- `install.sh`: `--commands` and `--init` now sync the managed clone to its tracked ref before copying commands out of it. A piped `curl ... | bash -s -- --commands` on a machine with an older cached clone otherwise copied a stale command set (promising `/paper:loop` while `loop.md` was absent, or aborting on a pre-command cache). A local developer checkout is left untouched, and a pinned `--ref` stays pinned.
- `install.sh`: `resolve_ref` now prefers the tracked branch and only falls back to an exact tag when HEAD is detached. A clone left on `main` whose tip happened to sit on a tagged release commit (a fresh install right after a release) previously resolved to that tag, so a plain `--update` (and the new command sync) would freeze at the release and copy a stale command set instead of following `main`. Explicit `--ref` pins are checked out detached, so they still resolve to the tag and stay pinned.
- `install.sh`: refreshing the commands now replaces the managed `paper/` directory wholesale so a command removed or renamed in a later release does not linger as a stale entry. `install_commands` skips this replace when the target tree is the source checkout itself (a developer running `--init`/`make init` from the repo root), which would otherwise delete the source command files before copying them back. An existing, customized `paper-reviser.md` is backed up to `paper-reviser.md.bak` before being overwritten.
- `install.sh`: a plain `--update` now also refreshes the global `paper:` commands when they were enabled with `--commands`, and the default `install` now best-effort syncs a pre-existing managed cache before linking and printing the hint (an older cache, and the `install.sh` the hint points at, otherwise predates `--commands`). The cache sync is best-effort: an offline machine falls back to the cached clone instead of aborting.
- `install.sh`: `link_one` skips a destination that already is the source (`-ef`). Running the installer from a copy-mode install at the target path itself (`~/.claude/skills/<name>/install.sh`, the symlink fallback) otherwise hit the prior-copy-install branch, which deleted the source and recreated a self-referential link, corrupting the skill and aborting the command copy.
- `install.sh`: `ensure_source_current` is best-effort only without an explicit pin; with `--ref` it uses the fatal `sync_to_ref`, so `--commands`/`--init --ref X` aborts when `X` cannot be reached rather than silently registering the cached ref's command set.
- `install.sh`: command registration now records a hidden manifest (`.claude/.paper-revision-editor-manifest`) of exactly the files it installs, and refresh and uninstall act only on listed files. A refresh (`--commands`/`--init`/`--update`) overwrites the shipped files and drops managed files a later release renamed or removed, while preserving a user's own files in the `paper/` namespace and an older manual copy. `--uninstall` removes only manifested files (so a copy-mode uninstall works even after the skill dir is unlinked, with no clone needed) and drops the `paper/` directory only when nothing unmanaged remains. A pre-existing, differing `paper-reviser.md` is still backed up to `.bak` before being overwritten.
- `install.sh`: `ensure_skill_linked` attempts every target without aborting mid-loop and reports whether all succeeded. Command-registration modes tolerate a partial link (an unmanaged `~/.agents/skills/paper-revision-editor` from another tool no longer blocks the `~/.claude` link), while `install`/`--update` now fail loudly instead of printing `Done` when a required target could not be linked.
- `install.sh`: command registration backs up any pre-existing same-named file (a hand-written command or a customized agent) to `.bak` before overwriting it on first install, not just the agent; once a file is recorded in the manifest it is refreshed silently.
- `install.sh`: `--update` refreshes the global commands only when the target ref actually ships command files, so pinning or downgrading with `--update --ref` to a release that predates `.claude/commands/paper` no longer aborts half-applied.
- `install.sh`: the script directory now resolves through symlinks (`pwd -P`). Without it, launching the installer through an install symlink (for example `~/.claude/skills/paper-revision-editor/install.sh --commands`) made `src` the symlink path, which is also a relink target, so the skill link was removed and recreated pointing at itself, breaking the skill and hiding the bundled command files.
- `install.sh`: the default `install` now prints a hint pointing at `--init` (this repo) and `--commands` (all projects) so the command-registration step is discoverable instead of buried in the README. The hint uses the installer's absolute path rather than `$0`, which is unusable under `curl ... | bash` (where `$0` is `bash`) or after the user changes into their paper repo (where a relative `./install.sh` no longer resolves).
- `install.sh`: `--uninstall` now also removes the global `paper:` commands and the `paper-reviser` agent that `--commands` installs under `~/.claude`, so uninstall fully reverses the new registration path. Commands copied into a specific repo by `--init` are left in place, since uninstall takes no repo argument.
- `README.md`: the Quickstart, the complete-paper-edit-loop note, and the "Structured slash commands" section now describe `install.sh --init` / `--commands` as the supported way to register the commands (with the manual copy kept as an alternative), and explain why a skill-bundled command file does not register on its own.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.22.0.

### Rationale

The commands existed and were documented, but the path from "skill installed" to "`/paper:loop` works" required a manual copy that most installs never performed, and a marketplace install gave the user no local source to copy from at all. Making the installer perform the copy (per-repo with `--init`, globally with `--commands`) turns a silent failure into a one-command fix, while the skill stays the cross-tool source of truth and the manual copy remains available for anyone who wants it.

## [1.21.0] - 2026-06-28

An outer author loop over the existing single-section passes. Until now every command operated on one section, one pass, one entry point, and an author doing a full edit had to infer the sequencing (which sub-command, in what order, when to repeat, when to stop) from the sub-commands themselves. This release makes the whole-paper loop explicit, on the governing principle "diagnose globally, edit locally, validate globally, then polish conservatively," while keeping the skill the source of truth for every individual edit.

### Added

- `.claude/commands/paper/loop.md`: a `/paper:loop` planner-driver. It emits the staged whole-paper edit plan first (paper-context status, current revision stage and what it permits, detected sections, recommended pass order, the first command to run, and the stop and repeat criteria) and only then walks the loop one section at a time. The plan diagnoses every section (feedback only) before any rewrite, so global thesis or terminology problems surface before a single edit is baked in. The author checkpoint is recurring: every pass (`feedback`, `revise`, `clarify`, `human`) can surface new `Author questions`, and the driver resolves them before the next pass or the next section. It never rewrites the whole paper in one pass: each per-section pass is dispatched to the `paper-reviser` subagent, with `revise` as the default and `clarify` / `human` as targeted second passes run only when the diagnosis calls for them. The abstract and introduction are edited first (to set the spine the body must serve) and again at the end (because they go stale once the body changes); since that rerun lands after the cross-section consistency check, the loop re-runs `/paper:consistency` over the front matter before the sentence-only final polish, which cannot repair fresh drift. It carries the skill's hard constraints (no em-dash, no silent change to numbers, citations, math, claims, or quotes) through every step, and stops at "the remaining edits would be merely different rather than better" rather than rewriting for cosmetic variation.
- `.claude/commands/paper/polish.md`: a `/paper:polish` command for the final, conservative pass. It pins `final polish` constraints (sentence-level copyediting only: word choice, given-new flow, referents, stress position, terminology consistency, abbreviations, units, callouts, punctuation, tense, parallelism, rhythm, and the AI tells allowed at that stage) with no paragraph reordering, no new explanatory content, and no structural cuts. It loads `copyediting.md`, `ai-tells-to-avoid.md`, and `sentence-cohesion.md`, and branches on the stored `revision_stage`: it proceeds at `final polish`, proceeds at `first draft` (final-polish constraints are strictly narrower, so no gate is bypassed), and at `response to reviewers` stops and asks the author to either close out the reviewer round and move the stage to `final polish` or stay in reviewer-response scope with `/paper:rebut`, rather than section-wide copyediting paragraphs that stage protects.
- `.claude/commands/paper/consistency.md`: a `/paper:consistency` whole-paper check, diagnosis only (`Revised text` reads `No rewrite requested.`). When handed a root or wrapper file such as `paper.tex`, it follows `\input` and `\include` recursively and scans sibling section files rather than reading only the wrapper, so no section is missed behind an include. It flags terminology drift, claim drift and result overstatement, inconsistent contribution framing, promise-delivery gaps, missing or unresolved forward references and figure, table, or theorem callouts, unfilled citation placeholders, and stale summaries, and asks whether the abstract, introduction, methods, results, discussion, and conclusion describe the same paper. Each diagnosis item names the sections in conflict; cross-section decisions that need the author go to `Author questions`.
- `README.md`: a new user-facing "Complete paper-edit loop (editing a whole paper)" section that documents the loop as steps 0 to 5 for any agent, so it is followable by hand and not only through Claude Code. It states the stopping rule explicitly (unchanged prose is a valid result; a rewrite that touches every paragraph is suspect).

### Changed

- `README.md`: the `paper:` command table and the Structured-slash-commands prose now list `/paper:polish`, `/paper:consistency`, and `/paper:loop`, and explain that `loop` differs in kind from the section commands (it plans then drives them one section at a time rather than running a single pass). The Quickstart hand-off line and the Files table point at the new loop section and commands.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.21.0.

### Rationale

The skill was strong per section but silent about the loop. Authors had the pieces (diagnose, clarify, revise, humanize, rebut) without a protocol telling them to diagnose the whole paper first, edit one section at a time to convergence, validate across sections, and only then polish. Documenting the loop and adding a command that plans and drives it removes that inference burden and gives the model an explicit stopping rule, while every actual edit stays inside the single-section skill and its safety constraints. `/paper:loop` is deliberately a planner-driver rather than an autonomous whole-paper rewriter, so the author stays in control at each checkpoint; `/paper:polish` and `/paper:consistency` fill the two gaps the loop needs that the command set did not yet expose.

## [1.20.0] - 2026-06-28

A forced-extraction step for the exposition pass. The 1.18.0 exposition pass already set the reader model, the six-rung ladder, and the teaching-benefit rationale vocabulary, but the diagnosis-to-rewrite handoff still let a teaching gap be smoothed over with a thesaurus swap instead of repaired. This release makes the pass extract three things into the `Diagnosis` block before any rewrite is drafted, so the rewrite is structural by construction: it front-loads the buried idea, unpacks the jargon inline, and anchors the abstraction in something already on the page.

### Added

- `references/exposition.md`: a **Forced extraction before the rewrite** section. When the exposition pass surfaces any teaching gap (any ladder or common failure, for example definition debt, compressed inference, machinery before motive, expert-only contrast, abstract stack, concept overload, an unanchored abstraction, or a buried or missing payoff) or the request is to make the section clearer to non-specialists, more educational, more readable, or easier to understand, the editor extracts three grounded handles first: `Jargon to unpack` (one to three terms to define inline, or `none` when the gap is non-terminological), `Buried lede` (the most useful idea the prose suffocates, front-loaded in the rewrite), and `Concrete anchor` (the example, dataset feature, mechanism, figure, or number that makes the abstraction tangible). The section names the educator's lens behind the three: find the single hardest concept for an outsider (jargon and lede locate it), then build the bridge to it (the anchor), and write to teach the reader rather than to prove the author's command of the field.

### Changed

- `SKILL.md`: the Diagnosis output format now adds the three extraction lines (`Jargon to unpack:`, `Buried lede:`, `Concrete anchor:`) whenever the exposition pass surfaces a teaching gap or the request is to make the section clearer to non-specialists, more educational, more readable, or easier to understand. They are placed after `Reader map:` when present, otherwise at the top of the Diagnosis block; each is grounded only in material already in the manuscript, any line may read `none`, and when all three are `none` and the passage clears the restraint checks it is returned verbatim. The step is excluded at `final polish`, where the stage forbids restructuring.
- `examples/exposition-introduction.md`, `examples/exposition-methods.md`, `examples/exposition-results.md`: each Diagnosis now carries the three extraction lines, grounded in the draft each example already contains (cohort-level moderation as the identification source, both never-treated and not-yet-treated staggered controls, the star-rating coefficient as a yardstick without deriving a ratio), so the examples stay valid quality anchors under the new output contract.
- `references/ai-tells-to-avoid.md`: the "leverage" tell and its checklist item now also cover "utilize" / "utilizes" / "utilizing" used where "use" would do.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.20.0.

### Rationale

The exposition pass diagnoses well, but a strong line editor can satisfy a diagnosis item with a smoother sentence that still hides the missing step. Forcing the editor to name the buried lede, the jargon, and the concrete anchor before writing converts the diagnosis into a structural rewrite: there is a specific idea to front-load, a specific term to define, and a specific anchor to reach for, so the rewrite cannot collapse into a polite synonym swap. The three stay inside the existing safety boundary, each must come from material already on the page, and anything the manuscript lacks becomes an `Author questions` item rather than an invented example or definition. The step is scoped to the exposition pass and excluded at `final polish`, so flow-only and final-polish passes keep their lean Diagnosis header.

## [1.19.0] - 2026-06-28

A usability and coverage pass. The skill's behaviour did not change; what changed is how easy it is to invoke deliberately and how well the examples cover the skill's harder-to-get-right modes. Two behaviours that the skill describes at length but never demonstrated, returning strong prose nearly untouched and working a response-to-reviewers edit, now have full worked examples, and a `paper:` slash-command namespace gives Claude Code users predictable one-shot entry points that pre-set the triage.

### Added

- `examples/restraint-example.md`: a full four-section run that returns a strong results passage almost verbatim. It makes the one mechanical fix the text needs, logs the two edits it declined (dropping a load-bearing hedge, collapsing four near-synonyms), and routes a terminology question to `Author questions` rather than silently merging the terms. This is the skill's hardest discipline (an unchanged paragraph is a valid output) and was the one common mode with no example.
- `examples/reviewer-response-example.md`: a full run of the response-to-reviewers workflow. It maps two reviewer comments to paragraphs, edits only the flagged paragraph plus its argument, returns three unflagged paragraphs verbatim despite real stylistic flaws, fixes the comment that can be answered from existing prose, and flags the comment that needs a number the manuscript lacks. Demonstrates that not every reviewer comment yields an edit.
- `.claude/commands/paper/`: a Claude Code slash-command namespace that dispatches to the `paper-reviser` subagent with the triage pre-set, so the skill skips the scope/unit/aggressiveness round-trip. `revise` (full pass), `feedback` (diagnosis only), `clarify` (exposition pass), `human` (narrative spine plus AI-tell scrub), and `rebut` (response-to-reviewers). None override the `revision_stage` in `<paper_context>`. Each `argument-hint` is quoted so YAML reads it as a scalar string, `rebut`'s preset scope allows the immediate-neighbour edits its workflow describes and reads reviewer files passed as path arguments before asking for the text, `clarify` defers to the skill's conditional Diagnosis-header rules instead of forcing a `Reader map:` line, and the README copy instructions name the exact `commands/` and `agents/` destinations Claude Code discovers. The two new examples obey the output contract they anchor: every `Author questions` item ends as a question, and the reviewer-response example states that immediate neighbours stay eligible even though both fixes happened to fit inside the flagged paragraphs. The quickstart notes that the `paper:` slash commands need a one-time copy and are not registered by the standard install, and that `--init` runs inside a git repository (with a copy-the-template fallback for plain folders). The reviewer-response example's P2 rewrite no longer adds an unstated "rather than by category revenue" contrast, so it carries only claims the draft already makes; its Diagnosis keeps to reviewer-labelled items, leaving unflagged stylistic issues to `Change rationale`. `rebut` now tells the user when the stored `revision_stage` is not `response to reviewers` instead of silently overriding it, and the README's command docs reflect that `rebut` is the one command keyed to reviewer-response scope. The output contract and voice-extraction note now state that response-to-reviewers passes skip the `Voice tics:` and `Reader map:` Diagnosis headers (like final-polish passes), because a reviewer-limited edit revises only the flagged paragraphs rather than rewriting the section; the reviewer-response example matches. That example's P2 rewrite also names the badge program as what the platform rolled out, removing a dangling `which` clause that could attach to "category".

### Changed

- `SKILL.md`: the reviewer-response workflow and the restraint section now cross-link their new worked examples; `metadata.version` reports 1.19.0.
- `README.md`: rewritten for newcomers. The top now opens with a plain-language description of what the skill is and who it is for, a "Why use it" section, a "What you can ask for" use-case table with example prompts, a four-section output guide, and a numbered "Quickstart: use it on your own paper" walkthrough. The dense pipeline paragraph moved into a "How it works (under the hood)" section so it is still available without being the first thing a beginner reads. A new "Structured slash commands" subsection documents the `paper:` namespace and how to copy it into another repo or `~/.claude/`; the Files table lists the two new examples and the commands directory; the badge reports 1.19.0.
- `AUDIT.md`: marked as a historical v1.7.0 baseline with a header noting that its listed gaps are resolved, so it no longer reads as an open to-do list.
- `VERSION`: 1.19.0.

### Rationale

The skill had grown deep and well-tested on the cases it demonstrates, but its two most failure-prone disciplines were the two without an anchor. Restraint is the behaviour a capable editor most often gets wrong (the reflex is to find something to change), and the response-to-reviewers stage has scope rules that are easy to violate by "improving" an unflagged paragraph. An example each turns those rules from prose into a checkable artifact, the same role the existing examples play under the lint's quality-anchor intent. The slash commands address a different friction: auto-triggering works, but a deliberate user wants a named, predictable entry point that does not re-ask the triage every time, and mapping each command to one of the skill's real modes keeps them thin dispatchers rather than a second source of behaviour.

## [1.18.1] - 2026-06-28

A small enrichment of the exposition pass shipped in 1.18.0, salvaged from a parallel branch that proposed the same idea before 1.18.0 landed. The bulk of that branch duplicated the exposition pass and is dropped; these three additions did not exist on `main` and earn their place.

### Added

- `references/exposition.md`: an exemplar table (Hamming, Pearl, Knuth, MacKay, Nielsen, Varian, Tufte for figures, Strunk and White for concision), mapping each writer to a transferable technique and a check over the exposition ladder, in the same borrow-the-move-not-the-mannerism format the reader-pleasure and narrative-spine passes already use. A closing note frames notation delay as a special case of "role before name": a symbol is a high-cost object, so carry the idea in named words before introducing the symbol that abbreviates it.

### Changed

- `SKILL.md`: a **Primary objective** statement under the title (maximize reader understanding, not textual polish; treat every revision as an act of teaching), explicitly subordinated to the hard constraints and pointing at the exposition pass as where the objective becomes operational.
- `references/ai-tells-to-avoid.md`: the storytelling-tells section now distinguishes a load-bearing concrete instance from a manufactured hook, so the exposition pass's call for concrete cases and the standing ban on "Imagine a world where..." openers no longer read as contradicting each other. The ban targets the dramatizing frame; the domain case keeps its substance.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.18.1.

### Rationale

While the exposition pass was in review, a separate branch independently proposed a teaching pass with the same core (instance before intuition before formalism, one new idea at a time, concrete over abstract). Rather than merge a second overlapping reference and a colliding 1.18.0, that branch was reset onto the shipped pass and only its non-duplicate parts were kept. The exemplar table fills a real gap: the exposition pass was the one reader-facing pass without an exemplar catalog, and the named writers were the specific communicators the request asked the skill to emulate. The Primary objective statement states at the top what the exposition pass already does, so the teaching aim is visible before any reference is loaded. The hook reconciliation closes a genuine seam: a pass that asks for concrete instances and a style rule that bans "Imagine..." openers needed one sentence to agree on where the line falls.

## [1.18.0] - 2026-06-28

An exposition pass. The skill already made prose flow (reader-pleasure), gave it a spine (narrative-spine), and stripped AI tells, but it had no first-class tool for the property that turns a correct paper into a paper that teaches: whether the reader can acquire the idea with less effort than expected. A paragraph can have a clean ABT spine and a pleasant rhythm and still fail to teach, because it skips the inferential steps the author has internalised. This release promotes the curse-of-knowledge fix from supporting references (principles.md, edit-checks.md) into a first-class editing pass that asks, of every load-bearing paragraph, what mental model the reader has before it and what model they should have after.

### Added

- `references/exposition.md`: the core of the pass. It sets the reader model (intelligent and trained in the broad venue area, but not expert in this paper's exact topic, dataset, method, or frame), a six-rung exposition ladder (question before machinery, role before name, intuition before formalism, one new object at a time, concrete anchor after abstraction, payoff after effort), the common failures with safe-fix and flag-only branches (definition debt, machinery before motive, compressed inference, expert-only contrast, abstract stack), section-specific checks (abstract, introduction, theory, methodology, results, discussion), the memorable-idea check, stage-bound safe boundaries, and teaching-benefit rationale language. It runs after logical-flow and argumentation and before reader-pleasure, narrative-spine, and copyediting.
- `examples/exposition-introduction.md`, `examples/exposition-methods.md`, `examples/exposition-results.md`: three full four-section runs on subtle, common failures rather than caricatures. The introduction assumes the reader already knows the gap (the pass surfaces it and restores the identification bridge); the methods paragraph opens on the estimator (the pass moves the identification logic ahead of the specification); the results paragraph narrates a table (the pass reorders each result into claim, evidence, consequence while carrying every number over verbatim). Each shows a `Reader map:` line and teaching-benefit rationales.

### Changed

- `SKILL.md`: a new **Exposition and reader education** editing principle between Argumentation and Paragraph craft, with the reader ladder, the memorable-idea instruction, a bad/good example, and a load trigger for `references/exposition.md`; a new trigger under "When to use this skill" for making a section clearer to non-specialists, more educational, or easier to understand; the "When NOT" rule on not drafting new sections now carves out short explanatory bridges built from material already in the manuscript while still routing new substance to `Author questions`; the Diagnosis block now opens whole-section and first-draft passes with a `Reader map:` line; the change-rationale reasons add the teaching benefits (restored inference, term defined at first serious use, role before name, question before machinery, concrete anchor, separated concepts, explicit payoff, abstract claim translated to mechanism, exposed contrast); Author questions now lists the teaching gaps (missing definition, intuition, example, mechanism, contrast, why-it-is-hard, takeaway); the preflight checks add a reader-transformation check, a definition-debt check, and a machinery-before-motive check; and the restraint checklist adds definition debt to the verbatim-return bar.
- `references/reader-pleasure.md`: a short addition making delight operational ("a research paper is delightful when the reader feels their understanding growing sentence by sentence") with a six-item checklist and the repeatable-sentence test, cross-linked to the exposition pass.
- `examples/worked-example.md`: the Diagnosis now carries a `Reader map:` line so the worked example stays a valid quality anchor under the new output contract.
- `README.md`: the "What this skill does" pipeline now lists the exposition pass, the constraint summary notes that explanatory bridges use only material already in the manuscript, and the Files table lists the three exposition examples.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.18.0.

### Rationale

The skill was an excellent line editor and a strong narrative editor, but a strong line edit can smooth over a teaching gap instead of repairing it: smoother prose hides the missing step rather than supplying it. The exposition pass makes that gap visible and assigns it a fix or a flag. The dividing line is the one that keeps the pass safe: surfacing an idea already on the page is editing, supplying an idea the page lacks is drafting, and drafting stays out of scope as an `Author questions` item. The pass also unifies machinery the skill already carried. The curse of knowledge in `principles.md` and the layered-audience and question-before-machinery checks in `edit-checks.md` were supporting references; here they become an enforceable pass with its own ladder, preflight checks, and rationale vocabulary. And it closes the loop with reader-pleasure: pleasure and teaching are the same property seen from two sides, so the delight checklist and the exposition ladder point at the same edits. As with every pass, it is stage-bound: a first draft may add bridges from existing material, a final polish repairs only referents, order, and stress position, and a reviewer response touches only flagged paragraphs and their neighbours.

## [1.17.1] - 2026-06-28

A consistency pass on the dispatcher and the promotional-adjective check, fixing three places where an instruction pulled against the skill's own rules.

### Changed

- `.claude/agents/paper-reviser.md`: add `sentence-cohesion.md` to the reference-trigger list so flow and cohesion requests reach the given-new guidance, and let the skill's triage clarifying question (scope, unit, aggressiveness) be returned before the strict four-section output instead of revising under guessed assumptions.
- `references/edit-checks.md`: rework check 9 so it strips the promotional adjective or frame and applies the keep-test before any deletion, rather than deleting the whole sentence, keeping it consistent with the no-silent-deletion and preserve-emphasis rules.
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.17.1.

## [1.17.0] - 2026-06-28

A narrative pass. The skill already made prose locally pleasurable (reader-pleasure) and stripped sentence-level AI tells, but it had no tool for the property that most separates human-written papers from LLM-drafted ones: a spine. A clean paper can still read as machine-written when it enumerates equally weighted points and announces that they matter. This release adds disciplined narrative structure and, just as important, bans the decorative storytelling that a naive "add a story" instruction produces, because that decoration is itself a top LLM tell.

### Added

- `references/narrative-spine.md`: a guide to the global through-line of a section. It defines the ABT spine (And, But, Therefore) with its two failure modes (AAA list rhythm, the LLM default; DHY tension overload), the OCAR arc (Opening, Challenge, Action, Resolution) with LD and LDR for shorter units, the knowledge gap as the engine that pulls a reader forward, characters and agency in the subject slot, protecting the turn, and showing stakes through consequence instead of announcing them. It carries an exemplar table (Olson, Schimel, Akerlof and Coase, Schelling and Hirschman, Gopen and Swan, McEnerney) mapping each source to a check, an anti-pattern list, stage boundaries, and rationale language. The reader-pleasure pass manages local momentum; this file manages the section-level through-line.
- `references/ai-tells-to-avoid.md`: a "Storytelling tells (decorative narrative)" section that bans manufactured hooks ("Imagine a world where..."), scene-setting stakes openers ("In an era of..."), the journey or quest metaphor for research, anthropomorphized data ("the data tells a story"), and the dramatic reveal ("Enter X."), plus two new diagnostic-checklist lines. This is the half that keeps a narrative pass from making prose more LLM-like instead of less.

### Changed

- `SKILL.md`: a new **Narrative spine** editing principle between Reader experience and Copyediting, with a bad/good example and load triggers; a new trigger under "When to use this skill" for requests to make a paper read like a human wrote it or sound less LLM-like; the style-rules loader now names the storytelling-tell checklist; and the restraint checklist, preflight checks, read-cold pass, and change-rationale reasons now carry narrative items (a findable ABT spine, surfaced tension, stakes shown by consequence, no decorative storytelling tells).
- `README.md`: the "What this skill does" pipeline now lists the narrative-spine pass, and the constraint summary adds "no manufactured hooks or anthropomorphized data".
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.17.0.

### Rationale

The instinct to fix LLM-flat prose by "adding storytelling" is half right and dangerous if taken literally. What reads as machine-written is the absence of a through-line: a setup, a tension, a turn, and a payoff carried by one question. That is structural, and it is what `narrative-spine.md` supplies through the ABT spine and the OCAR arc. The literal reading of "tell a story", by contrast, reaches for hooks, scene-setting, research-as-journey, and data that "tells a story", and those are themselves AI tells; adding them moves prose in the wrong direction. So the two halves ship together: add structure, ban decoration. The structural half also unifies rules the skill already had. Showing stakes through consequence rather than announcing them is the same discipline as the ban on importance-signaling verbs and promotional adjectives, seen from the story side; protecting the turn is the reader-pleasure pass's "useful surprise" raised to a structural duty; and putting characters in the subject slot is the character-action sentence from Williams. The pass is stage-bound: arc restructuring belongs to a first draft, while a final polish only surfaces an existing tension in the stress position and tightens the ABT of topic sentences already present. As with every pass, a narrative move that would need material the author did not write becomes an `Author questions` item, not an edit.

## [1.16.1] - 2026-06-28

A consistency fix in the edit-check pass. The meta-rule on cutting read as a quota ("Default to a 20% cut", "When in doubt about whether to cut, cut"), which pulled against the main skill's rule to cut by the keep-test and never toward a target. On an already-tight section that bias risks removing load-bearing sentences just to approach 80%. The section now frames the 20% as an expectation to test, not a default action.

### Changed

- `references/edit-checks.md`: retitle the "Default to a 20% cut" meta-rule to "Expect roughly a 20% cut, then test for it", and replace "When in doubt about whether to cut, cut" with the keep-test framing from the Subtraction section, so the reference no longer contradicts SKILL.md's length-budget rule that "manufacturing cuts to reach 80% of the original is itself a defect".
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.16.1.

## [1.16.0] - 2026-06-05

A documentation pass that shows the skill working end to end. The repo described the strict four-section output and gave isolated good-and-bad sentence pairs, but it never demonstrated a full run on a realistic draft. The new worked example closes that gap and doubles as a quality anchor: its output honors every constraint, so a reader and the agent both have a concrete reference for what a correct invocation looks like.

### Added

- `examples/worked-example.md`: a complete run of the skill on a flawed first-draft introduction. It shows the paper context, the request, a triage message kept separate from the strict four-section return, the two-paragraph input, and the exact four-section output (Diagnosis with voice tics, Revised text, Change rationale with a word-count line and per-change reasons, Author questions), plus a short note mapping the result back to the skill's rules. The example removes throat-clearing and banned transitions, carries the effect-size claim and sample size ("1.2 million") over word for word, keeps the author's underspecified "significant effect" and the tentative managerial recommendation unchanged while raising the open points as questions, and logs a 38% subtractive cut (visible prose citations counted, since the example uses plain author-year citations rather than LaTeX commands).

### Changed

- `README.md`: a new "See it in action" section points to the worked example, and the Files table lists it.
- `SKILL.md`: the output-format section points to `examples/worked-example.md` for a complete worked example.
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.16.0.

## [1.15.0] - 2026-05-31

A technical pass on installing, updating, and maintaining the skill. The installer now pins to a version, reports what changed on update, and fails early with a clear message when git is missing. A `scripts/` directory plus CI keep the version strings and the no-em-dash rule from drifting.

### Added

- `LICENSE`: the MIT text the README badge and `SKILL.md` already pointed to but the repo was missing.
- `install.sh`: `--ref <tag|branch|commit>` and `PAPER_REVISION_EDITOR_REF` pin a version. The pin is sticky: it is honored on install and reinstall, and a plain `--update` keeps the clone on the pinned tag or commit (pass a new `--ref`, for example `--ref main`, to move off it). Also a `--version` subcommand, a `git` preflight with an actionable message, before-and-after version reporting on `--update`, an `Already up to date` path, and `BROKEN` symlink plus tracked-ref detection in `--check`.
- `scripts/`: `check-version.sh` (assert the version matches in `VERSION`, `SKILL.md`, and the README badge), `bump-version.sh` (update all three in lockstep), and `lint.sh` (em-dash and en-dash scan, frontmatter validation, reference-link resolution), with a `scripts/README.md`.
- `.github/workflows/ci.yml`: shellcheck, the version-consistency check, the lint, and an install smoke test on every push and pull request.

### Changed

- `Makefile`: added `version`, `lint`, `check-version`, `bump`, and `test` targets; the help text now separates user targets from maintenance targets.
- `README.md`: documents version pinning, `--version`, a verify-and-troubleshoot path, and a maintainers section; the Files table lists `LICENSE`, `scripts/`, and the CI workflow.
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.15.0.

### Rationale

The skill installed with one curl line, but a few technical gaps made it harder to trust and maintain: the advertised LICENSE file did not exist, the version lived in three places with nothing guarding against drift, the installer could not pin to a release or say what an update changed, and the no-em-dash standing constraint relied on manual vigilance. The new scripts and CI turn those into checks that run on every change, and the installer improvements make install, update, and verification legible to the user.

## [1.14.0] - 2026-05-30

Three editorial passes that shipped together: a research-paper copyediting pass, a reader-experience pass, and an exemplar-technique pass for pleasurable prose. Copyediting makes grammar and consistency fixes explicit so they protect precision instead of becoming untracked rewrites. The reader-experience pass makes enjoyment operational through orientation, momentum, payoff, rhythm, concrete anchors, and useful surprise. The exemplar pass then names writers whose papers are widely treated as pleasurable to read and extracts the techniques an editor can borrow without imitating their voices.

### Added

- `references/copyediting.md`: a dedicated copyediting guide for research manuscripts. It covers grammar and agreement, punctuation for parsing, parallelism, terminology consistency, abbreviation handling, capitalization, hyphenation, units and symbols, tense and aspect, table and figure callouts, and citation punctuation. It adds a safe-fix / consistency-risk / evidence-risk triage, a consistency inventory, common high-value fixes, a list of items not to normalize silently, and a final copyediting checklist.
- `references/reader-pleasure.md`: a dedicated guide for making research prose a pleasure to read without hype or decorative flourish. It defines a five-part pleasure test, safe edit moves, anti-patterns, stage boundaries, concrete rationale language, and an **Exemplars and transferable techniques** section covering Coase, Akerlof, Schelling, Hirschman, Kleinberg, Roth, Lampson, Brooks, Chetty, Varian, Angrist-Pischke, Dijkstra, and McCloskey, with a table mapping each exemplar to a concrete editing check for ordinary papers.
- `SKILL.md`: explicit **Copyediting** and **Reader experience** editing principles. The copyediting principle carries a before/after example and loads `references/copyediting.md` for copy-edit requests, final-polish passes, and revisions that touch sentence mechanics. The reader-experience principle loads `references/reader-pleasure.md` when the user asks whether prose is enjoyable, compelling, elegant, readable, or a pleasure to read, and uses the exemplar catalog for techniques to borrow, not voices to imitate.

### Changed

- `SKILL.md`: the trigger and non-trigger guidance now distinguishes research-paper copyediting from mechanical typo-only proofreading. Stage controls, restraint checks, preflight, read-cold, change-rationale, and author-question rules now include copyediting concerns (terminology, abbreviations, capitalization, hyphenation, unit notation, tense, punctuation, parallelism) and reader-experience concerns (visible questions, momentum, payoff, rhythm, concrete anchors, restored contrast, unclear reader payoff).
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.14.0.

### Rationale

These passes build on one another. Research-paper copyediting is a precision pass, not a cosmetic one: it names the mechanical consistency checks that matter in manuscripts (terms that drift across a section, abbreviations introduced unevenly, nonparallel contribution lists, tense shifts between prior work and results, unit-format drift, vague table or figure callouts) while preserving the hard boundary around technical claims, citations, numerical values, and author framing. Correct prose can still be airless, so the reader-experience pass makes a paper pleasurable when the reader is oriented, feels forward motion, gets a payoff at the end of paragraphs, receives relief after dense material, and meets useful tension rather than smoothed-over generality. Naming exemplars helps the skill recognize the moves that create that experience (puzzle before literature, question before machinery, named ideas, examples that do argumentative work, figures as the empirical spine, progressive disclosure, exact claims instead of importance signaling), while the technique-not-voice rule prevents pastiche. Pleasure and copyedit moves must name the mechanism they improve; anything that would require adding evidence, changing emphasis, or inventing an example becomes an author question instead of an edit.

Note: earlier drafts of this changelog split this release into 1.12.0 (copyediting) and 1.13.0 (reader experience), but the repository only ever reported 1.14.0, which shipped all three passes. The two entries are consolidated here so the changelog matches the version history and the release tags.

## [1.11.0] - 2026-05-30

A subtractive-editing pass. The skill already defaulted to "shorter is better"; this release gives it a test for *which* units are safe to cut, so the Strunk-and-White instinct does not become a wood chipper.

### Added

- `references/subtraction.md`: a guide to cutting to the story without destructive effects. Separates *compress* (fewer words, same content, near zero-risk) from *delete* (remove a unit, real risk), and gates deletion behind a six-function keep-test: a unit earns its place if it advances the thesis, makes a claim believable, links two ideas, serves a reader the others do not, pre-empts an objection, or sets rhythm. The same six functions are presented as the catalogue of what a naive cut destroys. Adds unit-size scaling (perform word and sentence cuts, propose paragraph and section cuts), the revision-stage interaction, the curse-of-knowledge blind spot (subtraction never finds the missing step), and a worked example that cuts 60% safely and 90% destructively from the same sentence.
- `SKILL.md`: a **Subtraction: cutting to the story** section carrying the compress/delete split, the prior-not-quota rule, the keep-test, and the perform-vs-propose scaling, pointing to `references/subtraction.md` for depth.

### Changed

- `SKILL.md`: the Length-budget preflight now cuts by the keep-test rather than toward a target, and names quota-chasing (manufacturing cuts to reach 80% of the original) as a defect in its own right.
- `SKILL.md` `metadata.version` and `VERSION` bumped to 1.11.0; `README.md` badge updated.

### Rationale

Cutting to the story is the highest-yield edit and the easiest to over-apply. The skill had the subtractive default (the length budget, the 20% cut meta-rule in `edit-checks.md`) but no test for which units are load-bearing, which is exactly where over-cutting does its damage: an editor removes a hedge that was calibration, a transition that carried the thread, a gloss the non-expert needed, or a limitation that pre-empted a reviewer. The keep-test makes "needless" operational, and tying the action to the unit size keeps the human in the loop on anything structural: compression is unconditional, sentence deletion is logged, and paragraph- or section-level cuts are proposed rather than performed. Framing the 80% as a prior rather than a quota closes the specific failure where an editor cuts good tissue out of an already-tight draft to hit a number.

## [1.10.0] - 2026-05-30

A writing-quality pass. Earlier releases (1.7-1.9) reworked packaging and portability; this one sharpens the editorial guidance so the prose the skill produces is better, not just the way the skill ships.

### Added

- `SKILL.md`: a **Paragraph craft** editing principle, inserted between Argumentation and Writing quality. It fills the gap between the section-level "Logical flow" principle and the sentence-level "Writing quality" principle: one idea per paragraph, a topic sentence in the first sentence or two, a coherent topic string across consecutive sentences, and transitions built from the content rather than from a connective bolted on the front. Includes a before/after pair.
- `SKILL.md`: a lateral-edit guard. The editing-principles preamble now states that a passage changes only when the result is clearly better, not merely different, and the `Change rationale` output spec now requires every change's `why` to name a concrete reader benefit (a removed tell, a shorter form, given-new order, a fixed referent, a sharper claim, a corrected stress position). "Reads better" or "smoother" with no named mechanism is not a reason, and the original stays.
- `SKILL.md`: a sentence-rhythm check in the read-cold pass. Uniform sentence length is now named as a tell to fix before returning output.
- `references/ai-tells-to-avoid.md`: four new categories of contemporary tell. **More filler adjectives** (comprehensive, holistic, multifaceted, nuanced, key, central, vital, pivotal, rich, deep, powerful, vast, seamless, streamlined), each with its legitimate technical exception. **Importance-signaling verbs** (underscores, highlights, emphasizes, showcases, "plays a key/central/crucial role in"), with an edit move that swaps the signal for the mechanism. **Inflated noun phrases and dead metaphors** ("the landscape of", "a myriad of", "rich tapestry", "paradigm shift", scene-setting openers). **Template sentence shapes** (the "not just X, it's Y" antithesis, the "From X to Y" opener, repeated "not only ... but also", "Firstly/Secondly" for lists meant to be remembered). The bottom-of-file diagnostic checklist picks up four matching scan items.
- `references/sentence-patterns.md`: an **Overclaiming** entry, the sibling to the existing Hedge-stacking entry, so both sides of confidence miscalibration sit together. Covers causal language on correlational evidence, "proves" versus "is consistent with", universal claims from a bounded test, and "robust" without a referent. Each row flags the gap as an Author question rather than silently weakening the claim. Five high-frequency wordiness compounds added to the search-and-replace table ("the fact that", "in terms of", "a number of", "the way in which", "serves to").

### Changed

- `SKILL.md`: the Argumentation principle now calibrates confidence in both directions, naming overclaiming (causal language on correlational evidence, a universal claim on one dataset, "proves" on "is consistent with") alongside the existing hedge-stacking concern.
- `SKILL.md`: the transition style rule now points at the given-new chain in `references/sentence-cohesion.md` and gives the positive technique (end a sentence on the term the next sentence picks up), where before it gave only the negative rule.
- `README.md`: version badge to 1.10.0; the "what this skill does" summary mentions the new filler-adjective, importance-signaling-verb, and lateral-edit guards.
- `SKILL.md` `metadata.version` and `VERSION` bumped to 1.10.0.

### Rationale

The skill was procedurally complete (context gate, revision stages, reviewer-response branch, constraints, voice extraction, read-cold pass, length budget) but had four gaps that capped the quality of its output. First, nothing forbade a lateral edit, the most common LLM-editor failure mode: swapping a synonym or reshuffling a clause without buying clarity, brevity, or flow. The guard makes "clearly better, not merely different" an enforceable bar at the point where each change is justified. Second, the editing principles jumped from section structure to sentence mechanics with no paragraph layer, so topic sentences, one-idea-per-paragraph, topic strings, and content-based transitions had no home in the always-loaded lens. Third, the AI-tells list predated the current crop of model defaults; the filler adjectives, importance-signaling verbs, inflated noun phrases, and template sentence shapes are what a careful reader now reacts to first, and they were going uncaught. Fourth, calibration was one-sided, catching the hedge-stacker but not the overclaimer, even though overclaiming is the version reviewers punish. Each addition keeps the skill's subtractive ethos: the new tells are deletions, the calibration entries flag rather than rewrite, and the lateral-edit guard reverts to the original by default.

## [1.9.0] - 2026-05-28

### Removed

- Cross-tool detection and per-tool install paths for Codex, Gemini, Cursor, Copilot, OpenClaw, OpenCode, Goose, Zed, Junie, Cline, and Roo. The installer now targets exactly two locations: `~/.agents/skills/paper-revision-editor/` and `~/.claude/skills/paper-revision-editor/`.
- `update.sh` at the repo root and `scripts/update.sh` legacy updater. Update is now `./install.sh --update` (or the equivalent `curl ... | bash -s -- --update`).
- Per-tool `make install-*` and `make uninstall-*` targets.
- `--bootstrap`, `FORCE`, and `FORCE_COPY` flags. The installer always clones to `$PAPER_REVISION_EDITOR_HOME` (default `~/.local/share/paper-revision-editor`) when not running from a clone, and falls back to copy mode automatically when symlink creation fails.

### Changed

- `install.sh` rewritten as a single ~250-line script with five modes: install (default), `--update`, `--uninstall`, `--init`, `--check`. No tool detection, no aliases, no per-tool branching.
- `Makefile` reduced to five targets: `install`, `update`, `uninstall`, `init`, `check`.
- `README.md` rewritten without the cross-tool support matrix, and now documents the simple "ask the agent to install/update" UX.
- `examples/AGENTS.md.template` and `examples/CLAUDE.md.template` reworded to drop the cross-tool tool list.
- SKILL.md `metadata.version` bumped to 1.9.0.

### Rationale

The cross-tool install machinery in v1.7 and v1.8 added detection, aliases, bootstrap, copy fallbacks, force flags, dual update scripts, and an eleven-tool Makefile matrix in service of supporting tools nobody on this project actually uses. The maintained surface is Claude Code plus the `~/.agents/skills/` standard. Stripping the rest cuts `install.sh` roughly in half, removes a redundant `update.sh`, removes the `scripts/` directory, and reduces the README from a support matrix into a five-command quickstart. Install and update are now short enough to fit in a single chat prompt to an agent.

## [1.8.0] - 2026-05-21

### Added

- `~/.agents/skills/` is now the primary install target. This is the cross-tool standard read natively by Zed (which reads only this path), Goose, Codex CLI, Gemini CLI, OpenCode, Cline, and any other Agent-Skills-compatible tool that follows the spec. `make install-all` and `./install.sh` (no args) symlink into `~/.agents/skills/paper-revision-editor` first, then into the native global directory of every other detected agent.
- New install targets: `install-opencode`, `install-goose`, `install-zed` (alias for `install-agents`), `install-junie`, `install-cline`, `install-roo`. Plus matching `uninstall-*` targets and `make install-agents` for cross-tool-only installs.
- `./install.sh --init` (or `make init`) scaffolds `AGENTS.md` in the current paper repo, prompting for venue, audience, thesis, and revision stage and substituting them into the template. Restores the interactive setup that v1.6 had and that v1.7 dropped. Also writes `CLAUDE.md` as a one-line bridge when missing.
- `./install.sh --bootstrap` and automatic `curl | bash` support. When the installer is piped via `curl ... | bash` (no SKILL.md beside the script) it clones the repo into `$PAPER_REVISION_EDITOR_HOME` (default `~/.local/share/paper-revision-editor`) and re-executes from there. Future `git -C` pulls in that location update every linked tool. Restores the one-line install that v1.6 had.
- Installer detection for `opencode`, `goose`, `zed`, `junie`, `cline`, `roo`.
- Installer auto-falls-back to copy mode when symlink creation fails (Windows without developer mode), instead of erroring.
- `FORCE=1` flag to install for a tool that detection missed. Also recognised by `uninstall` to clean up copy-mode installs.
- Same-destination de-duplication: `install-zed` and `install-agents` resolve to the same path, so `install-all` does not double-write.

### Changed

- `install-all` default order now starts with `agents`, ensuring the cross-tool location is always populated.
- Makefile generates per-tool targets from a single list, so adding a tool is one line.
- `README.md` updated with the new support matrix (which tools read `~/.agents/skills/` natively), one-line `curl | bash` quickstart, and the full per-tool target list. Windows note added.
- SKILL.md `metadata.version` bumped to 1.8.0.

### Rationale

After v1.7.0 the installer covered six tools but lost two features the v1.6 install had: the interactive paper-context prompt and the one-line `curl | bash` install. The brief also listed several Agent-Skills tools that v1.7.0 did not target (OpenCode, Goose, Zed, Junie, Cline, Roo Code). v1.8.0 closes both gaps. The bigger conceptual change is leaning into `~/.agents/skills/` as the primary install location: the spec calls for it, the newest tools (Zed) read only that path, and most other Agent-Skills tools (Codex, Gemini, OpenCode, Goose, Cline) read it as an alias. Installing there first means one symlink covers most of the ecosystem, and the per-tool targets exist as compatibility shims for tools that ignore `~/.agents/skills/` (Claude Code, Cursor, Copilot).

## [1.7.0] - 2026-05-21

### Added

- Cross-tool installer at the repo root (`install.sh`) plus a `Makefile` with per-tool targets (`install-claude`, `install-codex`, `install-openclaw`, `install-cursor`, `install-gemini`, `install-copilot`, and the matching `uninstall-*` targets). `make check` detects which agents are present on the current machine. Symlinks are the default so a single `git pull` in the cloned repo updates every installed tool.
- `.claude/agents/paper-reviser.md`: Claude Code subagent that dispatches to the skill in an isolated context. Restricted to `Read, Edit, Glob, Grep, Write` (no `Bash`). The skill remains the source of truth; the subagent is a thin wrapper so the main session sees only the four-section output.
- `examples/AGENTS.md.template`: drop-in `AGENTS.md` for paper repos. Defines `<paper_context>`, editing conventions, and the skill-invocation policy in the cross-tool format read by Claude Code, Codex, Gemini CLI, Cursor, Copilot Agent Mode, OpenCode, Goose, Cline, and Roo Code.
- `examples/CLAUDE.md.template`: one-line bridge that points Claude Code at `AGENTS.md`.
- `scripts/README.md`: documents the helper scripts and explains the v1.7 symlink update path.
- `AUDIT.md`: portability audit captured during this pass.

### Changed

- `SKILL.md` frontmatter is now spec-compliant against the Agent Skills open standard (https://agentskills.io/specification.md). The non-standard `version:` field moves to `metadata.version`. `license: MIT` is set explicitly. `allowed-tools` uses space separation as the spec requires. The `description` is rewritten to 169 characters, under 200, with the strongest trigger phrases first.
- `SKILL.md` body trimmed from 267 lines to under 200. Adds an explicit "When NOT to use this skill" section, an explicit "Constraints (hard rules)" list (no em-dashes, no meaning changes, no invented or removed citations, no silent deletes, preserve LaTeX, flag numerical-claim and figure-reference changes, do not rewrite quoted material, preserve author framing choices), and short good-vs-bad edit examples under "Editing principles". Existing semantics (revision-stage controls, reviewer-response branch, restraint, voice extraction, read-cold pass, length budget, four-section output) preserved.
- `SKILL.md` paper-context gate now reads `AGENTS.md` first (cross-tool standard), then `CLAUDE.md`, then `paper-meta.md`. Previously only `CLAUDE.md` and `paper-meta.md` were considered.
- `README.md` rewritten as a cross-tool guide: support matrix, per-tool install commands, per-repo git-submodule pin pattern, per-tool invocation syntax, and updated update instructions. Drops Claude-Code-only framing.
- `scripts/update.sh` moved from the repo root and re-labelled as the legacy updater for pre-v1.7 copy-based installs.
- `references/ai-tells-to-avoid.md`: em-dashes removed (replaced with alternative punctuation that demonstrates the rule it teaches).

### Removed

- Em-dashes throughout the repository (10 in the old README, 5 in the AI-tells reference). The skill bans em-dashes; the source files now obey their own rule.

### Rationale

The skill was operationally complete but marketed and packaged as a Claude-Code-only product. Every Agent-Skills-compatible tool can read the same `SKILL.md`, so the v1.7.0 pass keeps the skill semantics intact and ships the missing portability layer: a spec-compliant frontmatter, a cross-tool installer, a Makefile, a subagent dispatcher for Claude Code, an `AGENTS.md` template paper repos can drop in, and a submodule pin pattern for camera-ready freeze. The skill body picks up an explicit consolidated constraint list and good-vs-bad edit examples so readers do not need to open the references just to see what the skill enforces.

## [1.6.0] - 2026-05-21

### Added

- `SKILL.md`: a "Restraint: leaving prose unchanged" section. The skill now has an explicit no-edit pathway. A paragraph that clears six checks (topic sentence in the first two sentences, coherent topic string, stress position on the most important word, no banned transitions or AI tells, no nominalization where an active verb belongs, claims-evidence-interpretation distinguishable) is returned verbatim, with `Paragraph N: no safe improvement available` recorded in `Change rationale`. For whole-section requests, only the paragraphs that were actually touched appear in the rationale; a revision that touches every paragraph is flagged as suspect.

- `SKILL.md`: a "Voice extraction: before rewriting" section. Before producing the rewrite, the skill identifies three to five voice tics from the original passage across six common categories (pronoun policy, sentence length distribution, connective vocabulary, citation placement, punctuation tics, lexical preferences) and preserves the tics in the rewrite. Patterns that are problems regardless of authorship (nominalizations, throat-clearing, em-dashes, banned transitions, hedge stacks) are explicitly excluded from voice. When a voice tic conflicts with a style rule in `references/ai-tells-to-avoid.md`, the style rule wins.

### Changed

- `SKILL.md` (version 1.5.0 → 1.6.0): the `Diagnosis` output section now opens with an optional `Voice tics:` line for whole-section rewrites and first-draft passes, listing three to five tics extracted from the original so the author can confirm the read before reading the revised text. The line is skipped for single-paragraph requests and final-polish passes. The example block under `Diagnosis` reflects the new format.

### Rationale

Two claims in the prior skill versions were asserted but never operationalized. First, "preserve voice" lived in the description and in the "What is never edited" list, but the skill had no mechanism for distinguishing voice from generic academic register; preservation drifted toward a vibe. The voice-extraction step makes the operation concrete and visible to the author (via the `Voice tics:` preamble), which both improves preservation and gives the author an early checkpoint to correct misreadings. Second, every prior invocation produced revised text, which trained the model toward action even on paragraphs that already passed the diagnostic lens. The restraint section names a six-check bar for leaving prose alone and treats an unchanged paragraph as a valid rewrite output. The two changes work together: extracting voice up front makes the author's prose legible enough to know when leaving the prose alone is correct.

## [1.5.0] - 2026-05-21

### Added

- `SKILL.md`: a "Read-cold pass on the revised text" preflight sub-section. After producing the rewrite and before returning the four-section output, the skill re-reads the revised text alone and runs three checks on the rewrite in isolation: (1) every `this`, `that`, `it`, `they`, `these`, `those`, and `the [noun]` has an identifiable referent in the revised text alone; (2) the AI-tells diagnostic checklist from `references/ai-tells-to-avoid.md` runs against the output, not against memory of the rules; (3) the rewrite did not introduce new nominalizations, hedge stacks, or noun pile-ups while fixing other problems. Failures are fixed before the output is returned, not flagged as known defects.

- `SKILL.md`: a "Length budget" preflight sub-section. After the read-cold pass, the skill counts words in the original and in the rewrite (excluding citation commands, math environments, and LaTeX macros) and applies three thresholds: shorter needs no justification; within 5% is acceptable only when the original was already tight; longer requires a one-line justification in `Change rationale`. The "Change rationale" output section now opens with a `Word count: <before> → <after> (<signed percent change>).` line.

### Changed

- `SKILL.md` (version 1.4.0 → 1.5.0): the "Change rationale" output spec requires the new word-count line as the first line of the section, with an updated example block showing the format. The feedback-only path omits the word-count line.

### Rationale

Two failure modes recur in LLM-produced academic rewrites and the prior version of the skill had no enforcement against either. First, the rewrite drops antecedents that lived in the original phrasing, producing dangling `this`, `that`, and `the [noun]` references whose referents the reader cannot recover from the revised text alone. The read-cold pass forces a second look at the rewrite in isolation, which is the only condition under which dangling references become visible. Second, LLM rewrites tend to grow rather than shrink the section, accreting hedges and restatements in the name of clarity. Reporting word count before and after makes the bloat measurable; setting "shorter by default" as the expectation prevents the drift. Both checks run on the output, not the input, which is where prior style enforcement lived.

## [1.4.0] - 2026-05-16

### Added

- `references/edit-checks.md`: a pass-level checklist of ten structural and rhetorical edit-checks plus two framing meta-rules. The checks are drawn from writers whose papers are widely cited as a pleasure to read (Coase, Akerlof, Kleinberg, Schelling, Brooks, Lampson, Chetty, Varian, Roth, Hirschman, Dijkstra, McCloskey) and target the load-bearing paragraphs of a section: first paragraph, first paragraph of each subsection, paragraphs that introduce new claims. The ten checks are puzzle-first opening, one named idea per paper, question-before-machinery, working-not-illustrative examples, figures as primary text, progressive disclosure, named items in remembered lists, analogy discipline, promotional-adjective scrub, and standalone introduction-and-conclusion. The two meta-rules are layered audience passes (non-expert, generalist reviewer, technical expert) and default to a 20% cut. Loaded on demand when revising an introduction, abstract, or conclusion, or when the user asks for a holistic pass.

- `references/ai-tells-to-avoid.md`: new "Banned promotional adjectives" and "Banned framing phrases" subsections. The promotional list adds the adjectives `important`, `novel`, `interesting`, `significant` (outside the statistical sense), and `crucial`, with an edit move that tests whether the substance of the sentence survives deletion. The framing list adds the prefaces `We show that...`, `It is well known that...`, and repeated `In this paper, we propose...` after the contribution paragraph. The "Diagnostic checklist" at the bottom of the file picks up two new scan items for promotional adjectives and framing prefaces.

### Changed

- `SKILL.md` (version 1.3.1 → 1.4.0): added one load-on-demand pointer to `references/edit-checks.md` inside the diagnostic-lens preamble. Triggers are introductions, abstracts, conclusions, and holistic-pass requests. No changes to the gate, the revision-stage controls, the reviewer-response workflow, the four-section output format, or the section-specific lens.

- `install.sh` and `update.sh`: file list updated to fetch `references/edit-checks.md`.

- `README.md`: version badge, pinned-install URL example, manual-install snippet, files-created-in-your-repo table, and features-at-a-glance updated to reflect the new edit-checks reference.

### Rationale

The existing structural-patterns reference covers section architecture (what an abstract or introduction should contain) and the sentence-patterns reference covers sentence-level moves. The gap between them is the pass-level rhetorical moves that distinguish papers that are a pleasure to read: puzzle-first openings, one named idea, examples that rule out alternatives rather than illustrate claims, figures that carry the argument, named principles in remembered lists. These moves are mostly diagnostic rather than generative: an editor checks for them, and the failure modes are concrete enough to act on. Keeping them in a separate file lets the skill load them only when the section type calls for them (introductions, abstracts, conclusions, holistic passes) without inflating the always-in-context part of the skill.

## [1.2.1] - 2026-05-15

### Fixed

- Cross-reference paths inside the new reference files (`principles.md`, `sentence-patterns.md`) now use the `references/` prefix to match SKILL.md's convention. Previously they used bare filenames (`structural-patterns.md`, `sentence-cohesion.md`, `ai-tells-to-avoid.md`), which could cause file-not-found lookups in workflows that follow paths literally.

## [1.2.0] - 2026-05-15

### Added

- `references/principles.md`: deeper exposition of the theoretical grounding behind the diagnostic lens. Covers Williams (character-action sentences, old-new flow, stress position), Gopen and Swan (reader-expectation theory), Pinker (curse of knowledge, classic style), McEnerney (writing for readers, not for self), Mensh and Kording (paper architecture), with examples and exceptions. Loaded on demand when an edit needs justification beyond "this reads better".

- `references/sentence-patterns.md`: a named-pattern catalog with before-and-after tables. Covers nominalizations, throat-clearing openings, existential and expletive constructions, noun pile-ups, hedge stacking, misplaced stress, wordiness compounds, vague abstractions, misused connectives, dangling references, and voice issues. Pattern names ("nominalization", "misplaced stress") are usable as labels in the change rationale output. Does not duplicate the banned-transition list in `ai-tells-to-avoid.md`.

- `references/structural-patterns.md`: section-by-section deep guidance for abstracts (Mensh-Kording structure), introductions (the McEnerney test), related work (organize by position, not by person), methodology, results, discussion, conclusion, plus rebuttal letters and grant proposals. Mirrors the section list in SKILL.md's "Section-specific lens" and expands each from a one-liner to a full diagnostic. Loaded on demand.

### Changed

- `SKILL.md`: added three load-on-demand pointers to the new reference files. No changes to the diagnostic lens, the four-section output format, the gate, the revision-stage controls, or the reviewer-response workflow.

- `install.sh` and `update.sh`: file list updated to fetch the three new references.

- `README.md`: features-at-a-glance and files-created-in-your-repo tables updated.

### Rationale

The existing skill is operationally strong (per-paper context, three revision stages, reviewer-response branch, strict output format, explicit voice preservation) but lean on theoretical grounding. The diagnostic lens invokes moves ("old information first, new information last") without attribution or exposition. For maintenance work that's fine; for first-draft work and for cases where the author asks why a move works, having the source material accessible as load-on-demand references is useful. The three additions sit at the same architectural layer as `sentence-cohesion.md` and `ai-tells-to-avoid.md`: depth available when needed, no weight added to the always-in-context part of the skill.

## [1.1.0] - 2026-05-07

### Added
- Stage-aware behavior table: `revision_stage` (`first draft`, `response to reviewers`, `final polish`) now maps to explicit do/don't rules in SKILL.md. Previously the field was documented in the README but had no effect on output.
- Reviewer-response workflow: explicit steps for ingesting reviewer comments, mapping them to paragraphs, labeling diagnosis items with the reviewer concern, and surfacing requests that cannot be addressed from prose alone.
- "What is never edited" section calling out citations, citation commands, cross-references, math environments, custom macros, and LaTeX comments. Closes a gap where preservation rules were only in the README.

### Changed
- Banned words and banned phrases are no longer duplicated in SKILL.md. `references/ai-tells-to-avoid.md` is the single source of truth.
- `references/ai-tells-to-avoid.md` is now author-agnostic. Removed the email-closing style rule, which did not belong in a paper-revision skill.

## [1.0.0] - 2026-05-07

Initial versioned release.

### Included
- SKILL.md with TRIGGER / DO NOT TRIGGER frontmatter for reliable activation
- Diagnostic lens: structural integrity, paragraph craft, reader experience, sentence-level cohesion, claims-evidence discipline
- Section-specific guidance for Introduction, Related Work, Methodology, Results, Discussion, Conclusion
- Style constraints: no em-dashes, no AI transition words, no hedging filler
- Diagnose-then-revise output format with author-question flagging
- references/sentence-cohesion.md: deep treatment of given-new contract, topic strings, stress position, nominalization
- references/ai-tells-to-avoid.md: banned words, banned phrases, em-dash policy, house style
- Per-paper context loaded from CLAUDE.md or paper-meta.md at the repo root
- One-line installer (`install.sh`) and version-aware updater (`update.sh`)
- `REF` environment variable in `install.sh` for pinning skill content to a release tag (e.g. `REF=v1.0.0`); defaults to `main`

[1.16.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.15.0...v1.16.0
[1.15.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.14.0...v1.15.0
[1.14.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.11.0...v1.14.0
[1.11.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.10.0...v1.11.0
[1.10.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.9.0...v1.10.0
[1.9.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.8.0...v1.9.0
[1.8.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.7.0...v1.8.0
[1.7.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.6.0...v1.7.0
[1.6.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.5.0...v1.6.0
[1.5.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.2.1...v1.4.0
[1.2.1]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/ipeirotis/paper-revision-editor/releases/tag/v1.0.0
