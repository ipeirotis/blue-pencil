# paper-revision-editor

[![Version](https://img.shields.io/badge/version-1.7.0-blue.svg)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Standard: Agent Skills](https://img.shields.io/badge/Agent_Skills-SKILL.md-blueviolet.svg)](https://agentskills.io)

A portable SKILL.md skill that turns any Agent-Skills-compatible coding agent into a top-tier academic editor. The skill diagnoses structural and stylistic problems first, then revises while preserving the author's voice, citations, math, and numerical claims.

## What this skill does

When you ask an agent to "revise the introduction" or "respond to reviewer 2", the skill runs a disciplined diagnose-then-revise pipeline: load the paper context, triage the request, apply a section-specific diagnostic lens, extract voice tics from the original prose, produce a rewrite, run a read-cold pass on the rewrite, check the length budget, and return a strict four-section output (Diagnosis, Revised text, Change rationale, Author questions). Numerical claims, citations, and analytical conclusions are never edited; changes to them come back as questions for you. No em-dashes, no banned transitions, no throat-clearing.

## Cross-tool support matrix

The skill follows the [Agent Skills open standard](https://agentskills.io). Every tool below reads the same `SKILL.md` file from its own skills directory.

| Tool                            | Skills directory                                | Personal scope | Project scope |
| ------------------------------- | ----------------------------------------------- | -------------- | ------------- |
| Claude Code                     | `~/.claude/skills/<name>/`                      | Yes            | `.claude/skills/<name>/` |
| Codex CLI                       | `~/.codex/skills/<name>/`                       | Yes            | `.codex/skills/<name>/`  |
| Gemini CLI                      | `~/.gemini/skills/<name>/`                      | Yes            | `.gemini/skills/<name>/` |
| Cursor                          | (project only) `.cursor/skills/<name>/`         | No             | Yes |
| GitHub Copilot (Agent Mode)     | `~/.config/github-copilot/skills/<name>/`       | Yes            | `.github/skills/<name>/` |
| OpenClaw                        | `~/.openclaw/skills/<name>/`                    | Yes            | `.openclaw/skills/<name>/` |
| OpenCode, Goose, Cline, Roo Code, Zed, Junie | reads SKILL.md from the same paths as the tools above per the [Agent Skills spec](https://agentskills.io/specification.md) and bridges via [AGENTS.md](https://agents.md) | varies | varies |

All tools above also read `AGENTS.md` (the cross-tool instruction file) at the repo root. The skill looks for `<paper_context>` there first.

## Quickstart

```bash
# 1. Clone the repo once.
git clone https://github.com/ipeirotis/paper-revision-editor.git
cd paper-revision-editor

# 2. Install for every detected agent on this machine.
make install-all

# 3. Drop the AGENTS.md template into your paper repo.
cp examples/AGENTS.md.template /path/to/your/paper/AGENTS.md
# (Edit the placeholders for venue, audience, thesis, revision_stage.)

# 4. Open the paper repo in any supported agent and ask it to revise a section.
```

The installer uses symlinks, so updates to the cloned repo propagate to every tool. Run `git pull` in the clone and you are done.

## Per-tool install

If you only use one tool, install for that one:

```bash
make install-claude     # ~/.claude/skills/paper-revision-editor
make install-codex      # ~/.codex/skills/paper-revision-editor
make install-gemini     # ~/.gemini/skills/paper-revision-editor
make install-openclaw   # ~/.openclaw/skills/paper-revision-editor
make install-cursor     # $PWD/.cursor/skills/paper-revision-editor (project-scope; run inside the paper repo)
make install-copilot    # ~/.config/github-copilot/skills/paper-revision-editor
```

Or use the underlying script directly:

```bash
./install.sh                # install for every detected tool
./install.sh claude codex   # install for the listed tools only
./install.sh --check        # detect which tools are present
./install.sh --uninstall    # remove every symlink
FORCE_COPY=1 ./install.sh   # copy files instead of symlinking
```

## Per-repo install via git submodule (version pinning)

If you want a paper repo to use a specific commit or tag of the skill, vendor it as a submodule. This is the right pattern for camera-ready revisions where you want the skill frozen.

```bash
cd /path/to/your/paper

# Add the submodule under .claude/skills/ for Claude Code:
git submodule add https://github.com/ipeirotis/paper-revision-editor.git .claude/skills/paper-revision-editor

# Pin to a release tag:
cd .claude/skills/paper-revision-editor
git checkout v1.7.0
cd ../../..
git add .claude/skills/paper-revision-editor
git commit -m "Pin paper-revision-editor to v1.7.0"

# Later, to update to the latest commit on main:
git submodule update --remote .claude/skills/paper-revision-editor
git commit -am "Bump paper-revision-editor"

# Or pin to a different tag:
cd .claude/skills/paper-revision-editor
git fetch --tags
git checkout v1.8.0
cd ../../..
git commit -am "Pin paper-revision-editor to v1.8.0"
```

The same submodule pattern works for any other tool's skills directory: swap `.claude/skills/` for `.codex/skills/`, `.gemini/skills/`, `.cursor/skills/`, etc. A multi-tool paper repo can add the submodule once and then symlink it into each tool's directory.

## Per-paper context

Drop `examples/AGENTS.md.template` into your paper repo as `AGENTS.md` and fill in the placeholders. Every Agent-Skills-compatible tool reads `AGENTS.md`, so the same file briefs Claude Code, Codex, Gemini, Cursor, Copilot, and others.

If you also want Claude Code to load the same context (Claude Code reads both `CLAUDE.md` and `AGENTS.md`, but some setups prefer `CLAUDE.md` only), drop in `examples/CLAUDE.md.template` as `CLAUDE.md`. It is a one-liner that points at `AGENTS.md`.

## How to invoke the skill from each agent

Once installed, every agent can pick up the skill automatically from your phrasing ("revise this section", "polish the introduction", "respond to reviewer 2"). You can also invoke it explicitly:

| Agent                       | Explicit invocation                                                        |
| --------------------------- | -------------------------------------------------------------------------- |
| Claude Code                 | `/paper-revision-editor` or use the `paper-reviser` subagent (auto-loaded from `.claude/agents/`) |
| Codex CLI                   | `/paper-revision-editor`                                                   |
| Gemini CLI                  | `/paper-revision-editor`                                                   |
| Cursor                      | Mention the skill by name in chat ("use the paper-revision-editor skill on the introduction"), or rely on auto-invocation |
| GitHub Copilot (Agent Mode) | Mention the skill by name; Copilot loads it when the description matches   |
| OpenClaw                    | `/paper-revision-editor`                                                   |

The skill description is identical across tools, so auto-invocation works the same way: any phrasing that contains "revise", "polish", "copy-edit", "tighten", or "reviewer comments" applied to a paper section will trigger the skill.

## Files in this repository

| Path | Purpose |
|------|---------|
| `SKILL.md` | The skill itself: frontmatter plus instructions |
| `references/` | Load-on-demand reference material (principles, sentence patterns, structural patterns, edit-checks, AI tells, sentence cohesion) |
| `.claude/agents/paper-reviser.md` | Claude Code subagent that dispatches to the skill in an isolated context |
| `install.sh` | Cross-tool installer (symlinks the repo into each tool's skills directory) |
| `Makefile` | `make install-claude`, `make install-codex`, etc. |
| `scripts/update.sh` | Legacy updater for the pre-v1.7 copy-based install pattern |
| `examples/AGENTS.md.template` | Drop into a paper repo as `AGENTS.md` |
| `examples/CLAUDE.md.template` | Drop into a paper repo as `CLAUDE.md` if you want a Claude-Code-only bridge |
| `CHANGELOG.md`, `VERSION` | Release history and current version |
| `AUDIT.md` | Portability audit captured during the v1.7.0 pass |

## Updating

If you installed via symlink (the v1.7+ default):

```bash
cd /path/to/paper-revision-editor
git pull
```

Every linked tool sees the updated content on the next invocation. No reinstall needed.

If you installed via submodule in a paper repo:

```bash
cd /path/to/your/paper
git submodule update --remote .claude/skills/paper-revision-editor
git commit -am "Bump paper-revision-editor"
```

If you installed via the legacy `curl | bash` copy pattern (pre-v1.7), use `scripts/update.sh`.

## License

MIT. See `LICENSE`. Author: ipeirotis. Repository: https://github.com/ipeirotis/paper-revision-editor.
