# blue-pencil

[![Version](https://img.shields.io/badge/version-2.1.0-blue.svg)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

An academic-editor skill for AI coding agents such as [Claude Code](https://claude.com/claude-code). Point the agent at a section of your paper: it diagnoses what is weak, rewrites it, and logs every change with a reason. Your citations, numbers, math, and writing voice are never silently altered.

## Quickstart

1. **Install** (needs `git` and `bash`):

   ```bash
   curl -sSL https://raw.githubusercontent.com/ipeirotis/blue-pencil/main/install.sh | bash
   ```

2. **Set up your paper** (once, inside your paper's git repo):

   ```bash
   cd /path/to/your/paper
   ~/.local/share/blue-pencil/install.sh --init
   ```

   This asks four questions (target venue, audience, core thesis, revision stage), writes `AGENTS.md`, and registers the `/paper:` commands in the repo. If your paper folder is not a git repo, copy [`examples/AGENTS.md.template`](examples/AGENTS.md.template) to `AGENTS.md` by hand instead.

3. **Ask in plain English:**

   > Revise the introduction in `intro.tex` so it flows better.

Every run returns four sections: **Diagnosis**, **Revised text**, **Change rationale**, and **Author questions**. See [`examples/worked-example.md`](examples/worked-example.md) for a complete run; the other files in `examples/` show more scenarios.

Using claude.ai or another chat surface instead of a coding agent? Skip the installer: paste `SKILL.md` into the conversation along with your section.

## What it guarantees

- **Diagnoses before editing.** You see what is weak, and every change comes with a reason.
- **Protects your science.** Numbers, statistics, citations, equations, and quotes are never silently changed; anything suspect comes back as a question for you.
- **Keeps your voice, and knows when to stop.** Already-good prose is returned unchanged, not reworded to look busy.
- **Strips AI tells.** No em-dashes, no "Furthermore/Moreover", no throat-clearing, no manufactured hooks.

LaTeX and pasted plain text are first-class. From Word or Google Docs, paste the text in and reapply formatting afterwards.

## Commands

Plain-English requests work in any agent that reads the skill. In Claude Code, `--init` also registers these:

| Command | What it does |
|---------|--------------|
| `/paper:revise <section>` | Full diagnose-then-rewrite pass. |
| `/paper:feedback <section>` | Diagnosis only, no rewrite. |
| `/paper:clarify <section>` | Make the section clearer to a non-specialist. |
| `/paper:human <section>` | Narrative spine plus AI-tell scrub: read human, not LLM. |
| `/paper:polish <section>` | Sentence-level copyediting only, no restructuring. |
| `/paper:rebut <comments + section>` | Edit only the paragraphs reviewers flagged. |
| `/paper:triage <decision letter>` | Severity-ranked comment table and suggested order of work. |
| `/paper:letter` | Draft or improve the response-to-reviewers letter. |
| `/paper:read <paper>` | Whole-paper cold read: where a reader stops following, plus a dispatch list. |
| `/paper:consistency <paper>` | Cross-section drift and stale-summary check. |
| `/paper:verify-numbers` | Rerun your own analysis pipeline and diff its outputs against the manuscript's numbers. Needs your data and code in the repo. |
| `/paper:figures <figure>` | Re-render a figure from the same data with better design, proposed beside the original. |
| `/paper:analyze <analysis>` | Run a new analysis you name (robustness check, baseline) and report the whole result. |
| `/paper:scholar` | Check that cited sources support their claims and scan novelty; needs literature retrieval. |
| `/paper:loop <paper>` | Plan and drive a whole-paper edit, section by section, pausing at each author checkpoint. |

The analyst commands (`verify-numbers`, `figures`, `analyze`) and `scholar` only propose: they never edit your manuscript, code, or data, and they say so when the tools they need are missing.

To register the commands in every project instead of one repo, run `install.sh --commands`.

## Editing a whole paper

Run `/paper:loop`. It plans the full loop (whole-paper cold read, section-by-section rewrite, consistency check, front-matter refresh, final polish) and drives it with you, one section at a time. The governing principle: diagnose globally, edit locally, validate globally, polish conservatively. Stop when the remaining edits would be merely different rather than better; unchanged prose is a valid result.

## Managing the install

The installer clones into `~/.local/share/blue-pencil` and symlinks it into `~/.agents/skills/` and `~/.claude/skills/`. Run these as `~/.local/share/blue-pencil/install.sh <flag>`, or append the flag to the curl one-liner as `bash -s -- <flag>`:

```bash
install.sh --update       # update both targets (or: git -C ~/.local/share/blue-pencil pull)
install.sh --check        # show install state, version, and tracked ref
install.sh --ref v1.16.0  # pin to a tag, branch, or commit (sticky until changed)
install.sh --uninstall    # remove the symlinks and globally registered commands
```

If you installed this under its old name, `paper-revision-editor`, running any `install.sh` mode once migrates the install in place; usage is unchanged.

## For maintainers

`make bump VERSION=x.y.z` keeps `VERSION`, `SKILL.md`, and the README badge in lockstep; `make test` runs the same checks as CI. See `scripts/README.md` for the release steps.

## License

MIT. See `LICENSE`.
