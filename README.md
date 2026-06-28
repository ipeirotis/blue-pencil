# paper-revision-editor

[![Version](https://img.shields.io/badge/version-1.20.0-blue.svg)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**An expert academic editor for your papers, run by an AI agent.** Point Claude (or any AI coding agent) at a section of your paper. It first tells you what is weak, then rewrites it to read more clearly, and shows you exactly what it changed and why, all while leaving your citations, numbers, math, and personal writing voice untouched.

It is built for researchers writing for peer review: a student polishing a first draft, an author responding to reviewers, or anyone who wants a section to read like a person wrote it instead of a chatbot.

> **New to this?** "Skill" here means a set of instructions you add to an AI coding agent such as [Claude Code](https://claude.com/claude-code). Once installed, you talk to the agent in plain English ("revise my introduction") and it follows the editing method in this repo. You do not write any code. Jump to [Quickstart](#quickstart-use-it-on-your-own-paper).

## Why use it instead of just asking an AI to "rewrite this"

A generic "rewrite my paragraph" prompt hands the text back as a black box: you cannot see what changed, it may quietly alter your claims, and it tends to make everything sound the same. This skill is built to avoid those failures:

- **It diagnoses before it edits.** You get a numbered list of the real problems first, so you understand *why* a change is needed.
- **It protects your science.** Numbers, statistics, p-values, citations, equations, and quoted text are never silently changed. Anything that looks off comes back as a question for you, not a silent edit.
- **It shows its work.** Every change is logged with a one-line reason, so you stay in control and learn the craft as you go.
- **It knows when to stop.** A paragraph that is already good is returned unchanged, not reworded to look busy.
- **It keeps your voice.** It identifies your stylistic habits and preserves them, instead of flattening the section into generic prose.
- **It strips the "AI tells."** No em-dashes, no "Furthermore / Moreover," no throat-clearing, no manufactured hooks, so the result reads human.

## What you can ask for

Talk to the agent in plain English. Common requests and what each produces:

| You ask | What the skill does |
|---------|---------------------|
| "Revise my introduction so it flows." | Full pass: diagnosis, rewrite, change log, and questions for you. |
| "Make this section clearer for a non-specialist." | Restores missing definitions and skipped reasoning so the section *teaches*, not just states. |
| "Make my discussion read like a human wrote it, not an LLM." | Gives the section a narrative spine and removes AI tells, without adding cheesy storytelling. |
| "Is my abstract a pleasure to read? Just give me feedback." | Diagnosis only, no rewrite. |
| "Tighten this paragraph." | Cuts what does not earn its place, and logs every cut with a reason. |
| "Reviewer 2 says my methods are unclear. Here are the comments." | Edits only the paragraphs the reviewer flagged, and flags anything it cannot fix from your text alone. |

Every run returns the same four labelled sections, so you always know how to read it:

1. **Diagnosis** - a numbered list of what is weak, each tied to a specific paragraph.
2. **Revised text** - the rewrite (or "No rewrite requested." if you asked for feedback only).
3. **Change rationale** - one line per change, each with a concrete reason.
4. **Author questions** - decisions only you can make (an ambiguous claim, a missing number, a term that might mean two things).

Want to see a real one end to end? Read [`examples/worked-example.md`](examples/worked-example.md): a flawed introduction goes in, the four-section output comes back.

## Quickstart: use it on your own paper

1. **Install the skill** (one line, needs only `git` and `bash`):

   ```bash
   curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash
   ```

2. **Tell the editor about your paper.** From your paper's folder, run the setup once:

   ```bash
   cd /path/to/your/paper
   ~/.local/share/paper-revision-editor/install.sh --init
   ```

   It asks four short questions (your target venue, your audience, your paper's main point, and how far along you are: `first draft`, `response to reviewers`, or `final polish`) and saves the answers so the editor tailors its work to your paper. The revision stage matters: a `first draft` may be restructured, while a `final polish` only gets light sentence-level edits.

   `--init` runs inside a git repository (it writes `AGENTS.md` at the repo root). If your paper folder is not a git repo yet, run `git init` first, or skip the script and copy [`examples/AGENTS.md.template`](examples/AGENTS.md.template) to `AGENTS.md` and fill in the four fields by hand.

3. **Ask for a revision.** Open your paper in Claude Code and just say what you want:

   > Revise the introduction in `intro.tex` so it flows better.

   The skill runs automatically, so the plain-English request above needs no extra setup. (Claude Code users can optionally enable ready-made commands such as `/paper:revise intro.tex`. The standard install does not register these; the one-time copy step is in [Structured slash commands](#structured-slash-commands-claude-code).)

4. **Read the four sections, then decide.** Skim the Diagnosis, compare the Revised text against your original, check the rationale for anything you disagree with, and answer the Author questions. You stay the author; the skill never has the last word on your claims.

The rest of this README covers installation options, updating, and the internals.

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

Each file in `examples/` is a complete run you can read before trying your own. They double as the skill's quality bar:

- [`worked-example.md`](examples/worked-example.md): the place to start. A flawed first-draft introduction in, the four-section output out, every constraint honored.
- [`exposition-introduction.md`](examples/exposition-introduction.md), [`exposition-methods.md`](examples/exposition-methods.md), [`exposition-results.md`](examples/exposition-results.md): making a section clearer to a non-specialist (restoring a missing gap, moving intuition ahead of machinery, turning a table into a takeaway).
- [`reviewer-response-example.md`](examples/reviewer-response-example.md): a response-to-reviewers run that edits only the flagged paragraphs and flags what it cannot fix.
- [`restraint-example.md`](examples/restraint-example.md): strong prose returned almost unchanged, showing the editor declining edits that would be different rather than better.

## Invoking the skill

Any prompt that mentions revising, polishing, copy-editing, tightening, or responding to reviewer comments on a paper section will auto-trigger the skill. Explicit invocation:

- Claude Code: `/paper-revision-editor`, or use the `paper-reviser` subagent under `.claude/agents/`.
- Any other agent reading `~/.agents/skills/`: mention the skill by name or use that agent's slash-command convention.

### Structured slash commands (Claude Code)

For predictable, one-shot invocation, the repo ships a `paper:` command namespace under `.claude/commands/paper/`. Each command pre-sets the triage (scope, unit, focus) so the skill skips the clarifying round-trip, then dispatches to the `paper-reviser` subagent. `revise`, `feedback`, `clarify`, and `human` follow the `revision_stage` in your `<paper_context>`; `rebut` applies response-to-reviewers scope (pasting reviewer comments is itself a trigger in the skill) and tells you if your stored stage says otherwise.

| Command | What it does |
|---------|--------------|
| `/paper:revise` | Full diagnose-then-rewrite pass, four-section output. |
| `/paper:feedback` | Diagnosis only, no rewrite (`Revised text` reads `No rewrite requested.`). |
| `/paper:clarify` | Exposition pass: make the section clearer to a non-specialist. |
| `/paper:human` | Narrative-spine plus AI-tell scrub: read more human, less LLM. |
| `/paper:rebut` | Response-to-reviewers workflow: map comments, edit only flagged paragraphs. |

Each takes the section as an argument (a file path or pasted text), for example `/paper:revise sections/intro.tex`.

Like the `paper-reviser` subagent, these commands are Claude-Code conveniences. Claude Code discovers commands under `.claude/commands/` and subagents under `.claude/agents/` (project level), or the same paths under `~/.claude/` (all projects). To use them in your own paper repo, copy the `paper/` directory to `<your-repo>/.claude/commands/paper/` and `paper-reviser.md` to `<your-repo>/.claude/agents/paper-reviser.md`; or copy them to `~/.claude/commands/paper/` and `~/.claude/agents/paper-reviser.md` to make them available in every project. Keep the `paper/` directory under `commands/`, since it is the subdirectory name that produces the `paper:` namespace. The skill itself stays the cross-tool source of truth and needs none of this.

## How it works (under the hood)

When you ask an agent to "revise the introduction" or "respond to reviewer 2", the skill runs a disciplined diagnose-then-revise pipeline: load the paper context, triage the request, apply a section-specific diagnostic lens, run exposition, reader-experience, narrative-spine, and research-paper copyediting passes when prose quality matters, including exemplar-based technique checks, extract voice tics from the original prose, produce a rewrite, run a read-cold pass on the rewrite, check the length budget, and return a strict four-section output (Diagnosis, Revised text, Change rationale, Author questions). The exposition pass makes the paper teach: it repairs missing definitions, skipped inferential steps, and machinery introduced before intuition, using only material already in the manuscript and flagging the rest as questions. Numerical claims, citations, and analytical conclusions are never edited; changes to them come back as questions for you. No em-dashes, no banned transitions, no throat-clearing, no filler adjectives or importance-signaling verbs, no decorative flourish, no manufactured hooks or anthropomorphized data, no explanatory bridge built from anything but material already in the manuscript, and no change that is merely different rather than better.

## Files

| Path | Purpose |
|------|---------|
| `SKILL.md` | The skill itself (frontmatter + instructions) |
| `references/` | Load-on-demand reference material, including reader-experience and research-paper copyediting checks |
| `.claude/agents/paper-reviser.md` | Claude Code subagent that dispatches to the skill |
| `.claude/commands/paper/` | Claude Code slash commands with preset triage (`/paper:revise`, `/paper:feedback`, `/paper:clarify`, `/paper:human`, `/paper:rebut`) |
| `install.sh` | Installer, updater, uninstaller; supports `--ref`, `--version`, `--check` |
| `scripts/` | Maintenance helpers: `check-version.sh`, `bump-version.sh`, `lint.sh` |
| `.github/workflows/ci.yml` | CI: shellcheck, version consistency, lint, install smoke test |
| `Makefile` | Thin wrapper over `install.sh` and `scripts/` |
| `examples/worked-example.md` | A complete run of the skill: flawed draft in, four-section output out |
| `examples/exposition-introduction.md` | Exposition run: an introduction that assumes the reader knows the gap |
| `examples/exposition-methods.md` | Exposition run: a methods paragraph that opens on machinery |
| `examples/exposition-results.md` | Exposition run: a results paragraph that reports numbers but no takeaway |
| `examples/reviewer-response-example.md` | Reviewer-response run: comment mapping, flagged-paragraph-only edits, gaps flagged |
| `examples/restraint-example.md` | Restraint run: strong prose returned almost verbatim, declined edits logged |
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
