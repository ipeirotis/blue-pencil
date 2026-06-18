# Changelog

All notable changes to paper-revision-editor are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/). Versions use [Semantic Versioning](https://semver.org/).

## [1.16.0] - 2026-06-05

A documentation pass that shows the skill working end to end. The repo described the strict four-section output and gave isolated good-and-bad sentence pairs, but it never demonstrated a full run on a realistic draft. The new worked example closes that gap and doubles as a quality anchor: its output honors every constraint, so a reader and the agent both have a concrete reference for what a correct invocation looks like.

### Added

- `examples/worked-example.md`: a complete run of the skill on a flawed first-draft introduction. It shows the paper context, the request, the triage message, the two-paragraph input, and the exact four-section output (Diagnosis with voice tics, Revised text, Change rationale with a word-count line and per-change reasons, Author questions), plus a short note mapping the result back to the skill's rules. The example removes throat-clearing and banned transitions, reproduces the effect size ("5-9%") and sample size ("1.2 million") verbatim, keeps the author's ambiguous "significant" and managerial framing unchanged while raising them as questions, and logs a 42% subtractive cut.

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

An exemplar-technique pass for pleasurable research prose. The reader-experience pass now names writers whose papers are widely treated as pleasurable to read and, more importantly, extracts the techniques an editor can safely borrow without imitating their voices.

### Added

- `references/reader-pleasure.md`: an **Exemplars and transferable techniques** section covering Coase, Akerlof, Schelling, Hirschman, Kleinberg, Roth, Lampson, Brooks, Chetty, Varian, Angrist-Pischke, Dijkstra, and McCloskey. The table maps each exemplar to a concrete editing check for ordinary papers.

### Changed

- `SKILL.md`: the reader-experience principle now says to use the exemplar catalog for techniques to borrow, not voices to imitate.
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.14.0.

### Rationale

A paper can be a pleasure to read even when the result is mundane if the writer uses the right technique at the right moment: puzzle before literature, question before machinery, named ideas, examples that do argumentative work, figures as the empirical spine, progressive disclosure, and exact claims instead of importance signaling. Naming exemplars helps the skill recognize these moves, while the technique-not-voice rule prevents pastiche.

## [1.13.0] - 2026-05-30

A reader-experience pass. The skill was strong on clarity, safety, and copyediting, but those qualities do not automatically make a paper a pleasure to read. This release makes enjoyment operational through orientation, momentum, payoff, rhythm, concrete anchors, and useful surprise.

### Added

- `references/reader-pleasure.md`: a dedicated guide for making research prose a pleasure to read without hype or decorative flourish. It defines a five-part pleasure test, safe edit moves, anti-patterns, stage boundaries, and concrete rationale language.
- `SKILL.md`: an explicit **Reader experience** editing principle, with instructions to load `references/reader-pleasure.md` when the user asks whether prose is enjoyable, compelling, elegant, readable, or a pleasure to read.

### Changed

- `SKILL.md`: stage controls, restraint checks, preflight, read-cold, change-rationale, and author-question rules now include reader-experience concerns: visible questions, momentum, payoff, rhythm, concrete anchors, restored contrast, and unclear reader payoff.
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.13.0.

### Rationale

The previous copyediting pass could make prose correct and consistent, but correct prose can still be airless. A paper becomes pleasurable when the reader is oriented, feels forward motion, gets a payoff at the end of paragraphs, receives relief after dense material, and encounters useful tension rather than smoothed-over generality. The new pass keeps the skill's safety model: pleasure edits must name the reader-experience mechanism they improve, and anything that would require adding evidence, changing emphasis, or inventing an example becomes an author question instead of an edit.

## [1.12.0] - 2026-05-30

A research-paper copyediting pass. The skill already handled structure, sentence cohesion, and final polish; this release makes copyediting explicit so grammar and consistency fixes protect precision instead of becoming untracked rewrites.

### Added

- `references/copyediting.md`: a dedicated copyediting guide for research manuscripts. It covers grammar and agreement, punctuation for parsing, parallelism, terminology consistency, abbreviation handling, capitalization, hyphenation, units and symbols, tense and aspect, table and figure callouts, and citation punctuation. It adds a safe-fix / consistency-risk / evidence-risk triage, a consistency inventory, common high-value fixes, a list of items not to normalize silently, and a final copyediting checklist.
- `SKILL.md`: an explicit **Copyediting** editing principle with a before/after example, plus instructions to load `references/copyediting.md` for copy-edit requests, final-polish passes, and revisions that touch sentence mechanics.

### Changed

- `SKILL.md`: the trigger and non-trigger guidance now distinguishes research-paper copyediting from mechanical typo-only proofreading.
- `SKILL.md`: `final polish`, restraint, preflight, and read-cold checks now include terminology, abbreviations, capitalization, hyphenation, unit notation, tense, punctuation, and parallelism.
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.12.0.

### Rationale

Research-paper copyediting is a precision pass, not a cosmetic pass. The previous skill could polish sentences, but it did not name the mechanical consistency checks that often matter in manuscripts: terms that drift across a section, abbreviations introduced unevenly, nonparallel contribution lists, tense shifts between prior work and results, unit-format drift, and vague table or figure callouts. Making those checks explicit gives the agent permission to fix safe mechanics while preserving the hard boundary around technical claims, citations, numerical values, and author framing.

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
