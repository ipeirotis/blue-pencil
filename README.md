# paper-revision-editor

[![Version](https://img.shields.io/badge/version-1.8.0-blue.svg)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Standard: Agent Skills](https://img.shields.io/badge/Agent_Skills-SKILL.md-blueviolet.svg)](https://agentskills.io)

A portable SKILL.md skill that turns any Agent-Skills-compatible coding agent into a top-tier academic editor. The skill diagnoses structural and stylistic problems first, then revises while preserving the author's voice, citations, math, and numerical claims.

## What this skill does

When you ask an agent to "revise the introduction" or "respond to reviewer 2", the skill runs a disciplined diagnose-then-revise pipeline: load the paper context, triage the request, apply a section-specific diagnostic lens, extract voice tics from the original prose, produce a rewrite, run a read-cold pass on the rewrite, check the length budget, and return a strict four-section output (Diagnosis, Revised text, Change rationale, Author questions). Numerical claims, citations, and analytical conclusions are never edited; changes to them come back as questions for you. No em-dashes, no banned transitions, no throat-clearing.

## Cross-tool support matrix

The skill follows the [Agent Skills open standard](https://agentskills.io). The recommended install location is `~/.agents/skills/paper-revision-editor/`, which is the cross-tool standard read by Zed, Goose, Codex, Gemini CLI, OpenCode, Cline, and any other Agent-Skills-compatible tool that follows the spec. For tools that read only a tool-specific directory, the installer also symlinks into that directory.

| Tool                          | Reads `~/.agents/skills/`? | Native global path                               | Project path                  |
| ----------------------------- | -------------------------- | ------------------------------------------------ | ----------------------------- |
| Claude Code                   | no                         | `~/.claude/skills/<name>/`                       | `.claude/skills/<name>/`      |
| Codex CLI                     | yes                        | `~/.codex/skills/<name>/`                        | `.codex/skills/<name>/`       |
| Gemini CLI                    | yes                        | `~/.gemini/skills/<name>/`                       | `.gemini/skills/<name>/`      |
| Cursor                        | no                         | (none, project-scope only)                       | `.cursor/skills/<name>/`      |
| GitHub Copilot (Agent Mode)   | no                         | `~/.copilot/skills/<name>/`        | `.github/skills/<name>/`      |
| OpenClaw                      | yes                        | `~/.openclaw/skills/<name>/`                     | `.openclaw/skills/<name>/`    |
| OpenCode                      | yes                        | `~/.config/opencode/skills/<name>/`              | `.opencode/skills/<name>/`    |
| Goose                         | yes                        | `~/.config/goose/skills/<name>/`                 | `.goose/skills/<name>/`       |
| Zed                           | yes (only)                 | (none, uses `~/.agents/skills/`)                 | `.agents/skills/<name>/`      |
| JetBrains Junie               | tracking                   | `~/.junie/skills/<name>/`                        | `.junie/skills/<name>/`       |
| Cline                         | yes                        | `~/.cline/skills/<name>/`                        | (varies)                      |
| Roo Code                      | tracking                   | `~/.roo/skills/<name>/`                          | (varies)                      |

All tools above also read [AGENTS.md](https://agents.md), the cross-tool instruction file at the repo root. The skill looks for `<paper_context>` in `AGENTS.md` first, then `CLAUDE.md`, then `paper-meta.md`.

## Quickstart

One line. The installer clones the repo into `~/.local/share/paper-revision-editor`, then symlinks it into `~/.agents/skills/` plus every other detected agent's skills directory:

```bash
curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash
```

Or if you prefer to clone the repo yourself (recommended for contributors):

```bash
git clone https://github.com/ipeirotis/paper-revision-editor.git
cd paper-revision-editor
make install-all
```

Then scaffold the per-paper context inside your paper repo:

```bash
cd /path/to/your/paper
~/.local/share/paper-revision-editor/install.sh --init   # or `make init` from the clone
```

The init step writes `AGENTS.md` from the template, prompting for venue, audience, thesis, and revision stage. Open the paper repo in any supported agent and ask it to revise a section.

Updates propagate automatically because the install is a symlink. To pull new versions:

```bash
git -C ~/.local/share/paper-revision-editor pull
# Or, if you cloned the repo manually:
git -C /path/to/paper-revision-editor pull
```

## Per-tool install

The default install hits the cross-tool location plus every detected tool. If you want a narrower install, name the tools explicitly:

```bash
make install-agents     # ~/.agents/skills/ only (cross-tool standard)
make install-claude     # ~/.claude/skills/
make install-codex      # ~/.codex/skills/
make install-gemini     # ~/.gemini/skills/
make install-openclaw   # ~/.openclaw/skills/
make install-cursor     # $PWD/.cursor/skills/ (project-scope; run inside the paper repo)
make install-copilot    # ~/.copilot/skills/
make install-opencode   # ~/.config/opencode/skills/
make install-goose      # ~/.config/goose/skills/
make install-zed        # alias for install-agents (Zed reads ~/.agents/skills/ only)
make install-junie      # ~/.junie/skills/
make install-cline      # ~/.cline/skills/
make install-roo        # ~/.roo/skills/
```

Or use the underlying script directly:

```bash
./install.sh                # cross-tool plus every detected tool
./install.sh agents         # only ~/.agents/skills/
./install.sh claude codex   # only the listed tools
./install.sh --check        # detect which tools are present
./install.sh --init         # scaffold AGENTS.md (run inside the paper repo)
./install.sh --uninstall    # remove every symlink
FORCE=1 ./install.sh codex  # install even if codex was not detected
FORCE_COPY=1 ./install.sh   # copy files instead of symlinking (Windows)
```

### Windows note

The installer is bash plus `ln -s`. On Windows it works under WSL or under Git Bash with developer mode enabled. If symlinking fails the installer automatically falls back to copying, but copy-mode updates require re-running the installer.

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
