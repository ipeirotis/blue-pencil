# blue-pencil

[![Version](https://img.shields.io/badge/version-3.0.0-blue.svg)](CHANGELOG.md)
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

   This records target venue, audience, core thesis, and revision stage, writes
   `AGENTS.md`, and registers the `/paper:` commands in the repo. Audience and
   revision stage drive editing; venue and thesis improve paper-level checks but
   no longer block a section edit. If your paper folder is not a git repo, copy
   [`examples/AGENTS.md.template`](examples/AGENTS.md.template) to `AGENTS.md`
   by hand instead.

3. **Ask in plain English:**

   > Revise the introduction in `intro.tex` so it flows better.

A full run returns four sections: **Diagnosis**, **Revised text**, **Change
rationale**, and **Author questions**. The explicit quick pass returns its
shorter three-part contract. See
[`examples/worked-example.md`](examples/worked-example.md) for a complete full
run; the other files in `examples/` show more scenarios.

Using claude.ai or another chat surface instead of a coding agent? Skip the installer: paste `SKILL.md` into the conversation along with your section.

> **Upgrading from v2:** the v2 updater cannot run migration logic introduced
> in v3 after it replaces its own checkout. After the first `--update`, run the
> new v3 `install.sh --init` once inside every paper repo previously initialized
> with v2. This removes the copied analyst and scholar commands and refreshes
> `/paper:loop`.

## What it guarantees

- **Diagnoses before editing.** You see what is weak, and every change comes with a reason.
- **Protects your science.** Numbers, statistics, citations, equations, and quotes are never silently changed; anything suspect comes back as a question for you.
- **Keeps your voice, and knows when to stop.** Already-good prose is returned unchanged, not reworded to look busy.
- **Strips AI tells.** No em-dashes, no "Furthermore/Moreover", no throat-clearing, no manufactured hooks.
- **Runs every applicable check, and shows its work.** A revision walks the skill's reference passes in a fixed order (logic, section lens, exposition, altitude, hedging, narrative, rhythm, subtraction, style, copyediting) and lists the ones it ran on a `References loaded:` line, so a skipped pass is visible, not silent.

LaTeX and pasted plain text are first-class. From Word or Google Docs, paste the text in and reapply formatting afterwards.

## Commands

Plain-English requests work in any agent that reads the skill. Start with
`/paper:revise` unless one of the narrower intents below fits better. In Claude
Code, `--init` also registers these:

| I want to... | Use |
|--------------|-----|
| Improve a section and see the full diagnosis | `/paper:revise` |
| Make a quick, conservative edit with a short report | `/paper:quick` |
| Get advice without a rewrite | `/paper:feedback` |
| Fix sentence-level issues after the argument is stable | `/paper:polish` |
| Revise an entire paper in controlled stages | `/paper:loop` |

The complete command list is:

| Command | What it does |
|---------|--------------|
| `/paper:revise <section>` | Full diagnose-then-rewrite pass. |
| `/paper:quick <passage>` | Conservative rewrite with up to three change bullets. |
| `/paper:feedback <section>` | Diagnosis only, no rewrite. |
| `/paper:clarify <section>` | Make the section clearer to a non-specialist. |
| `/paper:human <section>` | Narrative spine plus AI-tell scrub: read human, not LLM. |
| `/paper:polish <section>` | Sentence-level copyediting only, no restructuring. |
| `/paper:rebut <comments + section>` | Edit only the paragraphs reviewers flagged. |
| `/paper:triage <decision letter>` | Severity-ranked comment table and suggested order of work. |
| `/paper:letter` | Draft or improve the response-to-reviewers letter. |
| `/paper:read <paper>` | Whole-paper cold read: where a reader stops following, plus a dispatch list. |
| `/paper:consistency <paper>` | Cross-section drift and stale-summary check. |
| `/paper:loop <paper>` | Plan and drive a whole-paper edit, section by section, pausing at each author checkpoint. |

To register the commands in every project instead of one repo, run `install.sh --commands`.

## Companion skills

Blue Pencil edits prose but does not execute analyses or retrieve literature.
Install these separately when you need those capabilities:

- [`facts-and-figures`](https://github.com/ipeirotis/facts-and-figures) verifies reported
  numbers against a repository's analysis pipeline, regenerates figures from
  unchanged data, and runs analyses explicitly specified by the author.
- [`citation-needed`](https://github.com/ipeirotis/citation-needed) retrieves and
  reads sources to audit citations and identify prior-work leads.

The skills are independent: installing Blue Pencil does not install or invoke
either companion.

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

Commands installed by `--init` are project-local copies. Follow the v2 upgrade
step near the Quickstart once in every previously initialized paper repo.
Running `--update` from inside a paper repo refreshes that repo automatically,
but it cannot safely discover other paper repositories on your machine.

Pinning to a release that predates the bundled commands removes the registered
command sets for compatibility and remembers your opt-in. The pinned checkout's
own `install.sh` is that older release's and cannot restore them, so return via
the curl one-liner (it always runs the current installer), or run `--commands`
(and `--init` in each initialized paper repo) after updating; the downgrade
prints this same note.

If you installed this under its old name, `paper-revision-editor`, running any `install.sh` mode once migrates the install in place; usage is unchanged.

## For maintainers

`make bump VERSION=x.y.z` keeps `VERSION`, `SKILL.md`, and the README badge in lockstep; `make test` runs the same checks as CI. See `scripts/README.md` for the release steps.

## License

MIT. See `LICENSE`.
