# paper-revision-editor

[![Version](https://img.shields.io/badge/version-1.16.1-blue.svg)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A SKILL.md skill that turns Claude Code (and any other agent that reads `~/.agents/skills/`) into a top-tier academic editor. The skill diagnoses structural, stylistic, copyediting, and reader-experience problems first, then revises while preserving the author's voice, citations, math, and numerical claims.

## What this skill does

When you ask an agent to "revise the introduction" or "respond to reviewer 2", the skill runs a disciplined diagnose-then-revise pipeline: load the paper context, triage the request, apply a section-specific diagnostic lens, run reader-experience and research-paper copyediting passes when prose quality matters, including exemplar-based technique checks, extract voice tics from the original prose, produce a rewrite, run a read-cold pass on the rewrite, check the length budget, and return a strict four-section output (Diagnosis, Revised text, Change rationale, Author questions). Numerical claims, citations, and analytical conclusions are never edited; changes to them come back as questions for you. No em-dashes, no banned transitions, no throat-clearing, no filler adjectives or importance-signaling verbs, no decorative flourish, and no change that is merely different rather than better.

## Install

One line. Requires only `git` and `bash`. It clones the repo into `~/.local/share/paper-revision-editor`, then symlinks it into both skill directories:

```bash
curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash
```

This installs to:

- `~/.agents/skills/paper-revision-editor/` (cross-tool standard)
- `~/.claude/skills/paper-revision-editor/` (Claude Code)

That's it. Two locations, one clone, one symlink each.

### Pin to a version

Track a tagged release, branch, or commit instead of `main`:

```bash
curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash -s -- --ref v1.16.0
```

Setting `PAPER_REVISION_EDITOR_REF=v1.16.0` does the same thing. The pin is sticky: install or reinstall with `--ref` moves an existing clone onto that ref, and a plain `--update` keeps it there. Pass a new `--ref` to move off it (for example `--ref main` to follow the latest again).

You can also tell your agent in chat:

> Install the paper-revision-editor skill.

The agent will run the curl command above.

## Update

```bash
curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash -s -- --update
```

Or, if you have a local clone:

```bash
git -C ~/.local/share/paper-revision-editor pull
```

Or in chat:

> Update the paper-revision-editor skill.

Because both targets are symlinks into the same clone, a single `git pull` (or `--update`) refreshes both at once.

`--update` reports the change (`Updated 1.15.0 -> 1.16.0 (ref main).`, or `Already up to date (1.16.0, ref main).` when nothing moved). To see what you have without updating, run `install.sh --version` or `install.sh --check`.

## Uninstall

```bash
curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash -s -- --uninstall
```

Removes both symlinks. The clone at `~/.local/share/paper-revision-editor` is left alone; delete it manually if you want.

## Verify and troubleshoot

```bash
~/.local/share/paper-revision-editor/install.sh --check
```

`--check` lists both targets, flags a `BROKEN` symlink if the clone moved, and prints the clone's version and tracked ref. Common cases:

- `git is required but was not found`: install `git`, then re-run.
- A target shows `(exists, not a symlink)`: an unmanaged file or directory is in the way. Move it aside, then re-run install.
- Symlinks are unsupported on the filesystem: the installer copies the files instead and says so. `--update` still refreshes the copy.

## Per-paper setup

Inside a paper repo, scaffold `AGENTS.md` (read by both Claude Code and any agent that reads `~/.agents/skills/`):

```bash
cd /path/to/your/paper
~/.local/share/paper-revision-editor/install.sh --init
```

You'll be prompted for venue, audience, thesis, and revision stage. The script writes `AGENTS.md` plus a one-line `CLAUDE.md` bridge.

## Manual install

If you'd rather clone the repo yourself:

```bash
git clone https://github.com/ipeirotis/paper-revision-editor.git
cd paper-revision-editor
make install      # symlink into ~/.agents/skills/ and ~/.claude/skills/
make update       # update the clone and re-link
make uninstall    # remove both symlinks
make check        # show install state and tracked ref
make version      # print the installed version
make init         # scaffold AGENTS.md (run from your paper repo)
```

## See it in action

`examples/worked-example.md` shows a full run: a flawed first-draft introduction
goes in, and the strict four-section output (Diagnosis, Revised text, Change
rationale, Author questions) comes back, with every constraint honored.

## Invoking the skill

Any prompt that mentions revising, polishing, copy-editing, tightening, or responding to reviewer comments on a paper section will auto-trigger the skill. Explicit invocation:

- Claude Code: `/paper-revision-editor`, or use the `paper-reviser` subagent under `.claude/agents/`.
- Any other agent reading `~/.agents/skills/`: mention the skill by name or use that agent's slash-command convention.

## Files

| Path | Purpose |
|------|---------|
| `SKILL.md` | The skill itself (frontmatter + instructions) |
| `references/` | Load-on-demand reference material, including reader-experience and research-paper copyediting checks |
| `.claude/agents/paper-reviser.md` | Claude Code subagent that dispatches to the skill |
| `install.sh` | Installer, updater, uninstaller; supports `--ref`, `--version`, `--check` |
| `scripts/` | Maintenance helpers: `check-version.sh`, `bump-version.sh`, `lint.sh` |
| `.github/workflows/ci.yml` | CI: shellcheck, version consistency, lint, install smoke test |
| `Makefile` | Thin wrapper over `install.sh` and `scripts/` |
| `examples/worked-example.md` | A complete run of the skill: flawed draft in, four-section output out |
| `examples/AGENTS.md.template` | Drop into a paper repo as `AGENTS.md` |
| `examples/CLAUDE.md.template` | Drop into a paper repo as `CLAUDE.md` (bridge to AGENTS.md) |
| `CHANGELOG.md`, `VERSION` | Release history and current version |
| `LICENSE` | MIT license text |

## For maintainers

The version lives in three places (`VERSION`, `SKILL.md` `metadata.version`, and the README badge). Keep them in lockstep with the helper scripts:

```bash
make bump VERSION=1.16.0   # update all three at once
make test                  # check-version + lint (em-dashes, frontmatter, refs)
```

CI (`.github/workflows/ci.yml`) runs shellcheck, the version check, the lint, and an install smoke test on every push and pull request. See `scripts/README.md` for the full release steps, including tagging.

## License

MIT. See `LICENSE`. Author: ipeirotis. Repository: https://github.com/ipeirotis/paper-revision-editor.
