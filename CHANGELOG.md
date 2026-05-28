# Changelog

All notable changes to paper-revision-editor are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/). Versions use [Semantic Versioning](https://semver.org/).

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
