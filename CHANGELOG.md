# Changelog

All notable changes to paper-revision-editor are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/). Versions use [Semantic Versioning](https://semver.org/).

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
