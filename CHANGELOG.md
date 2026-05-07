# Changelog

All notable changes to paper-revision-editor are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/). Versions use [Semantic Versioning](https://semver.org/).

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
