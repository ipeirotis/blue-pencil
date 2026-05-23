# Audit: paper-revision-editor portability pass

Date: 2026-05-21. Pre-revision baseline for the v1.7.0 portability pass. Updated in v1.8.0 with a cross-tool-first install strategy; see CHANGELOG.md for that diff.

## 1. Current structure

```
paper-revision-editor/
├── SKILL.md                 (267 lines)
├── VERSION                  (1.6.0)
├── CHANGELOG.md
├── README.md                (Claude-Code-specific)
├── install.sh               (Claude-Code-only target)
├── update.sh                (Claude-Code-only target)
└── references/
    ├── ai-tells-to-avoid.md
    ├── edit-checks.md
    ├── principles.md
    ├── sentence-cohesion.md
    ├── sentence-patterns.md
    └── structural-patterns.md
```

No `scripts/`, no `assets/`, no `.claude/agents/`, no `examples/`, no `Makefile`,
no `AGENTS.md`.

## 2. Spec compliance gaps

Checked against the Agent Skills open standard at
`https://agentskills.io/specification.md` (the cross-tool spec adopted by
Claude Code, Codex, Gemini CLI, Cursor, Copilot Agent Mode, OpenCode, Goose,
Cline, Roo Code, and others) and the Claude Code extension fields at
`https://code.claude.com/docs/en/skills`.

| Gap                                                  | Detail                                                                                                                                                                                                                  | Action                                                                            |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| Non-standard `version:` frontmatter field            | The spec recognises `name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`. Bare `version:` is not in the spec. Cursor and Copilot validators may warn.                                         | Move to `metadata.version`. Keep `VERSION` file for the updater.                  |
| `description` field length                           | Current description is 396 characters. Within the 1024-character spec cap but exceeds the user's brief of <200 chars and contains five trigger verbs that dilute the auto-invocation signal.                            | Rewrite under 200 chars with the strongest trigger phrases first.                 |
| `allowed-tools` separator                            | Current value uses comma separation. Spec says space-separated.                                                                                                                                                         | Switch to space separation.                                                       |
| Missing `license` field                              | License is documented as MIT in the README but not surfaced in SKILL.md frontmatter. Optional but useful for downstream tools that surface license at install time.                                                     | Add `license: MIT`.                                                               |
| No `scripts/` directory or `scripts/README.md`       | Helper scripts (`install.sh`, `update.sh`) live at the repo root. Spec recommends `scripts/` for executables.                                                                                                           | Move installer / updater logic into `scripts/` and add a `scripts/README.md`. Keep top-level `install.sh` as a thin wrapper so `curl \| bash` still works. |
| SKILL.md length                                      | 267 lines, mostly within the spec's <500-line guidance but above the user's 200-line target. Voice-extraction and read-cold-pass sections can collapse into bullet form.                                                | Trim and push long examples to a new `references/edit-examples.md`.               |

## 3. Content quality issues

| Issue                                              | Detail                                                                                                                                                                                                                                                          |
| -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| No explicit consolidated constraints list          | Constraints live in five places: "What is never edited", "Style constraints", "Preflight checks", "Read-cold pass", "Restraint". A reader skimming the file cannot see the full constraint surface in one pass.                                                |
| No explicit "good vs bad edit" examples            | The skill describes patterns (nominalization, stress position) but does not show one or two short before-and-after pairs inside SKILL.md itself. New users invoking the skill from another agent will not see these unless they open `principles.md`.           |
| "When NOT to use" lives inline                     | Present in the file but interleaved with triggers. Splitting into its own section is clearer.                                                                                                                                                                  |
| Numerical-claim / figure-reference rule is implicit| "What is never edited" mentions cross-references and citations but does not explicitly say to flag changes to numerical claims or figure / table references for human review. Implied but not stated.                                                          |
| Em-dash policy contradiction                       | The skill bans em-dashes, but `references/ai-tells-to-avoid.md` and `README.md` both contain literal em-dashes. The contradiction undermines the constraint.                                                                                                    |

## 4. Portability issues

| Issue                                              | Detail                                                                                                                                                                                                                                                          |
| -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| README markets Claude Code only                    | Badges, copy, install instructions all reference Claude Code on the Web. The skill is in fact spec-compliant and will run in Codex, Gemini CLI, Cursor, Copilot Agent Mode, OpenCode, and Goose with the right path.                                            |
| `install.sh` installs only to `.claude/skills/`    | Cross-tool portability requires symlinks into each tool's directory: `~/.codex/skills/`, `~/.gemini/skills/`, `~/.openclaw/skills/`, `.cursor/skills/`, `~/.copilot/skills/`.                                                                       |
| Context loading references `CLAUDE.md` first       | `CLAUDE.md` is Claude-specific. `AGENTS.md` is the cross-tool open standard, supported by 24+ tools per `agents.md`. SKILL.md should look at `AGENTS.md` first, fall back to `CLAUDE.md`, then `paper-meta.md`.                                                  |
| `install.sh` writes `CLAUDE.md` only               | Should write to `AGENTS.md` by default and offer `CLAUDE.md` as a one-line bridge.                                                                                                                                                                              |
| No `Makefile`, no `make check`                     | Users on tools other than Claude have no install path.                                                                                                                                                                                                          |
| No git-submodule install pattern documented        | A paper repo that wants to pin the skill to a specific commit currently has to use `REF=<tag>` with `curl`, which copies files. Submodules give better pinning semantics.                                                                                       |
| Em-dashes in `README.md` (10) and `ai-tells-to-avoid.md` (5) | Direct violation of the user's no-em-dash standing constraint.                                                                                                                                                                                                  |

## 5. Subagent decision

Verdict: add a Claude Code subagent at `.claude/agents/paper-reviser.md` as a
thin dispatcher onto the skill.

Reasoning: a full revision pass loads up to seven files (`SKILL.md` plus six
references) and produces three intermediate artifacts (voice tics list,
diagnostic list, read-cold pass). On a long manuscript that conversation
overhead crowds out the user's primary thread. Isolating the work in a
subagent context window means the main session sees only the four-section
output. Tool access for the subagent is restricted to `Read, Edit, Glob,
Grep, Write` (no `Bash`) to match the skill's actual needs.

The subagent is a Claude-Code-only convenience layer. The skill remains the
source of truth, so users on Codex, Gemini, Cursor, Copilot, or any other
Agent-Skills-compatible tool get the same value without the subagent.

## 6. Standing constraints to honour during the revision

- No em-dashes anywhere in the repo after this pass. The existing em-dashes
  in `ai-tells-to-avoid.md` and `README.md` must go.
- License (MIT), author attribution, and git history preserved.
- Behaviour changes recorded in `CHANGELOG.md` under v1.7.0.
- No standalone CLI, no MCP server. File-based portability only.
