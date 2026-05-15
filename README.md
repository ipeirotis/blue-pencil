# paper-revision-editor

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Claude Skill](https://img.shields.io/badge/Claude_Code-Skill-blueviolet.svg)](https://code.claude.com/docs/en/skills)
[![Stage](https://img.shields.io/badge/Use-Academic_writing-orange.svg)](#)

**An editorial workflow for academic papers that diagnoses structural and stylistic problems first, then revises while preserving voice and technical content.**

A skill for [Claude Code on the Web](https://claude.com/product/claude-code) and the Claude Code terminal that turns Claude into a top-tier academic editor. One install per paper repo, and every revision request goes through the same disciplined diagnose-then-revise pipeline instead of a surface-level grammar pass.

---

## Features at a Glance

- **Diagnose-then-revise pipeline** — Claude lists structural problems before touching prose, so you see the reasoning, not just a black-box rewrite
- **Per-paper context** — Reads target venue, audience, thesis, and revision stage from `CLAUDE.md` once per repo
- **Section-specific lens** — Different criteria for Introduction, Related Work, Methodology, Results, Discussion, and Conclusion
- **Author voice preserved** — Empirical claims, numerical results, and analytical conclusions are never altered; only the prose around them
- **Style constraints baked in** — No em-dashes, no AI transition words, no hedging filler
- **Author-question flagging** — Unverifiable claims and logical gaps come back as questions, not guesses
- **Principled grounding on demand** — Williams, Gopen and Swan, Pinker, McEnerney, and Mensh and Kording loaded as a reference file when an edit needs justification beyond "reads better"
- **One-line install** — `curl | bash` and the skill is committed to the paper repo
- **Travels with the repo** — Works in Claude Code on the Web because the skill lives inside `.claude/skills/`

---

## The Problem

LLMs default to surface-level edits when asked to "improve" academic prose. They polish sentences in paragraphs whose purpose is unclear, smooth over arguments that contradict each other, and reach for em-dashes and "Furthermore" as transition glue. The result reads fluent but does not actually improve the paper.

Real editorial work happens in a specific order: structure first, paragraph purpose second, sentence-level cohesion third, surface polish last. This skill enforces that order on every invocation.

## How It Works

**One-time setup per paper repo:**

1. Run the installer from the paper's repo root.
2. The script prompts for target venue, audience, core thesis, and revision stage, writes a `<paper_context>` block to `CLAUDE.md`, copies `SKILL.md` and supporting references into `.claude/skills/paper-revision-editor/`, and commits.

**Every revision after that:**

1. Open a section file or paste a section into chat
2. Ask Claude to revise it (any phrasing the TRIGGER list catches)
3. Claude reads the paper context from `CLAUDE.md`, applies the diagnostic lens, and returns: diagnosis, revised text, change rationale, and any author questions

## Quick Start

```bash
# 1. Install the skill (from your paper's repo root).
#    The installer prompts for target venue, audience, thesis, and revision
#    stage, then writes a <paper_context> block to CLAUDE.md.
curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash

# 2. Tell Claude:
#    "Revise the introduction."

# That's it. Every revision request goes through the diagnose-then-revise pipeline.
```

## Install

**One-liner** (from your paper's repo root):

```bash
curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash
```

The installer prompts you for target venue, audience, core thesis, and revision stage, then writes a `<paper_context>` block to `CLAUDE.md` at the repo root.

**Pinning to a release** (recommended for reproducible installs):

```bash
curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/v1.0.0/install.sh | REF=v1.0.0 bash
```

`REF` defaults to `main`. Pin it to any release tag to install a frozen version of the skill content. Pass the same tag in the URL and in `REF` so the installer and the files it fetches stay in sync.

**Manual install** (if you prefer to see each step):

```bash
# From the repo root. Replace `main` with `v1.0.0` (or any release tag) to pin.
BASE=https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main
DEST=.claude/skills/paper-revision-editor

mkdir -p "$DEST/references"

for FILE in \
  SKILL.md VERSION \
  references/sentence-cohesion.md \
  references/ai-tells-to-avoid.md \
  references/principles.md \
  references/sentence-patterns.md \
  references/structural-patterns.md; do
  curl -sSL "$BASE/$FILE" -o "$DEST/$FILE"
done

git add "$DEST"
git commit -m "Add paper-revision-editor skill"
```

You will then need to add the `<paper_context>` block to `CLAUDE.md` yourself (see below).

**Or** just tell Claude Code on the Web:

> "Clone the paper-revision-editor skill from https://github.com/ipeirotis/paper-revision-editor into `.claude/skills/paper-revision-editor/` in this repo and commit it."

## Updating

Check which version you have and whether a newer one is available:

```bash
curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/update.sh | bash
```

This will:

1. Show your installed version and the latest version
2. Display the changelog entries you would be getting
3. Ask for confirmation before updating

You can also check your installed version at any time: `cat .claude/skills/paper-revision-editor/VERSION`.

## Per-Paper Context (CLAUDE.md)

Add this to `CLAUDE.md` at the root of each paper repo. Claude Code loads `CLAUDE.md` automatically at session start, so the skill always has the paper's context available.

```markdown
# Paper context

<paper_context>
target_venue: Information Systems Research
audience: empirical IS researchers
core_thesis: [1-2 sentences stating the paper's main contribution]
revision_stage: response to reviewers
</paper_context>

# Editing conventions

- No em-dashes anywhere in the manuscript.
- Avoid: Furthermore, Moreover, Crucially, Importantly, Notably, Ultimately, Delving.
- Avoid: "It's worth noting", "That said".
```

The `revision_stage` field changes how aggressive the revision is. A first-draft pass tolerates broad rewriting; a response-to-reviewers pass preserves the structure reviewers already accepted; a final-polish pass leaves structure alone and focuses on sentence-level work.

## Files Created in Your Repo

| File | Purpose | Committed? |
|------|---------|------------|
| `.claude/skills/paper-revision-editor/SKILL.md` | The skill router | Yes |
| `.claude/skills/paper-revision-editor/VERSION` | Installed version | Yes |
| `.claude/skills/paper-revision-editor/references/sentence-cohesion.md` | Deep guidance on flow | Yes |
| `.claude/skills/paper-revision-editor/references/ai-tells-to-avoid.md` | Style constraints | Yes |
| `.claude/skills/paper-revision-editor/references/principles.md` | Williams, Gopen-Swan, Pinker, McEnerney, Mensh-Kording exposition | Yes |
| `.claude/skills/paper-revision-editor/references/sentence-patterns.md` | 12-pattern catalog with before-and-after tables | Yes |
| `.claude/skills/paper-revision-editor/references/structural-patterns.md` | Section-specific deep guidance (abstract, intro, methods, results, discussion, conclusion, rebuttal, grant) | Yes |
| `CLAUDE.md` (paper context) | Venue, thesis, audience, stage | Yes (you create this) |

## What Gets Edited and What Does Not

**Edited:** prose, sentence structure, paragraph organization, transitions, topic sentences, redundancy, hedging, AI tells, em-dashes, banned transition words.

**Not edited:** numerical results, citations, equations, empirical claims, analytical conclusions, author choices about which findings to emphasize.

When the skill is unsure whether a claim is supported, it flags it as a question for the author rather than guessing.

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| Skill doesn't activate when expected | TRIGGER phrase didn't match | Use one of the TRIGGER phrases in `SKILL.md` (e.g., "revise this section", "polish the introduction") |
| Skill activates on non-paper content | Working in a repo with academic-looking prose that isn't a paper | Adjust `CLAUDE.md` to clarify the repo's purpose, or remove `paper_context` |
| Revision rewrites things you didn't want changed | Revision stage set too aggressive | Set `revision_stage: final polish` in `CLAUDE.md` |
| Claude asks for paper context every time | `CLAUDE.md` missing or has no `<paper_context>` block | Add the block (see Per-Paper Context above) |
| Updates not pulling | `VERSION` file out of sync | Run `update.sh` again or do a manual reinstall |

## License

MIT
