# paper-revision-editor

[![Version](https://img.shields.io/badge/version-1.38.0-blue.svg)](CHANGELOG.md)
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

One honest limit is now smaller than it was. In a plain editing pass the skill
preserves your citations exactly and never opens the sources, so verifying that a
cited work supports its claim stays with you there. Two gated lanes lift that where
the tools exist. Numbers, figures, and analyses: once your repo holds the data and analysis code, the
analyst lane runs it. `/paper:verify-numbers` reruns your own pipeline and diffs its
outputs against every number the manuscript reports; `/paper:figures` re-renders a
named figure with better design from the same data and script, proposed beside the
original; and `/paper:analyze` runs a new analysis you name (a robustness check, a
baseline, a subgroup cut), with the specification pinned before the run and the whole
result reported whichever way it points. All three carry provenance, author only new
files, and never touch your code, data, figures, or manuscript. Citations and novelty:
where the environment grants literature retrieval, the `/paper:scholar` lane fetches
and reads the cited sources, reports each cited claim as supported, unsupported, or
unverifiable, and returns novelty leads for your contribution claims, proposing any
citation change as a flagged candidate. Every lane proposes, never edits; a recomputed
number, a re-rendered figure, a new result, and a citation change are all yours to
decide, and where the tools are missing (no pipeline or shell, no retrieval) the lane
says so instead of pretending to check.

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
| "Tighten our response letter; the reply to R1 sounds defensive." | Recalibrates the letter's tone without conceding your positions, and checks every "we changed X" claim against the manuscript. |
| "Are the numbers in the abstract still what the pipeline produces?" | Reruns your own analysis pipeline and diffs its outputs against the manuscript's numbers, with provenance for every recomputed value (needs your data and code in the repo). |
| "Make Figure 3 carry the result, using the same data." | Re-renders the figure from your own script and data with better design and proposes it beside the original, changing how the data is shown, never which data (needs your data, a shell, and a write tool). |
| "Run the subgroup robustness check reviewer 2 asked for." | Pins the specification you named, runs it, and reports the whole result whichever way it points, as a proposal you decide on (needs your data, a shell, and a write tool). |
| "Does reference 12 support our claim, and is our contribution actually novel?" | Fetches and reads the cited sources, reports each cited claim as supported, unsupported, or unverifiable, and returns novelty leads for you to judge (needs literature retrieval). |

Every run returns the same four labelled sections, so you always know how to read it:

1. **Diagnosis** - a numbered list of what is weak, each tied to a specific paragraph.
2. **Revised text** - the rewrite (or "No rewrite requested." if you asked for feedback only).
3. **Change rationale** - one line per change, each with a concrete reason.
4. **Author questions** - decisions only you can make (an ambiguous claim, a missing number, a term that might mean two things).

Want to see a real one end to end? Read [`examples/worked-example.md`](examples/worked-example.md): a flawed introduction goes in, the four-section output comes back.

**Formats.** LaTeX and pasted plain text are first-class. Writing in Word or
Google Docs? Paste the text in and reapply formatting afterwards: comments,
tracked changes, and fields do not survive the paste, and the skill returns
plain paragraphs you can paste back. Text extracted from a PDF works too, but
suspected OCR damage (broken words, ligature garbage) is flagged and asked
about, never silently copyedited as your prose. Native `.docx` round-tripping
is out of scope.

## Quickstart: use it on your own paper

1. **Install the skill** (one line, needs only `git` and `bash`):

   ```bash
   curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash
   ```

   > **Using claude.ai, Cowork, or another chat surface instead of Claude Code?**
   > You do not need the installer. Attach or paste `SKILL.md` (plus any
   > reference file it names for your task) into the conversation, or add this
   > repo as a skill/knowledge source where your tool supports it, then paste
   > your section and ask as usual. Without an `AGENTS.md`, the skill asks once
   > for your venue, audience, core thesis, and revision stage; if you answer
   > partially or skip the question, it proceeds at the most conservative stage
   > (`final polish`) and opens its Diagnosis with an `Assumed context:` line
   > you can correct.

2. **Tell the editor about your paper.** From your paper's folder, run the setup once:

   ```bash
   cd /path/to/your/paper
   ~/.local/share/paper-revision-editor/install.sh --init
   ```

   It asks four short questions (your target venue, your audience, your paper's main point, and how far along you are: `first draft`, `response to reviewers`, or `final polish`) and saves the answers so the editor tailors its work to your paper. The revision stage matters: a `first draft` may be restructured, while a `final polish` only gets light sentence-level edits. It also registers the Claude Code `/paper:` slash commands in this repo so `/paper:loop`, `/paper:revise`, and the rest resolve.

   `--init` runs inside a git repository (it writes `AGENTS.md` at the repo root). If your paper folder is not a git repo yet, run `git init` first, or skip the script and copy [`examples/AGENTS.md.template`](examples/AGENTS.md.template) to `AGENTS.md` and fill in the four fields by hand. If you would rather not add an `AGENTS.md` at all (for example the folder is not, and will not become, a git repository), put the same `<paper_context>` block in a file named `paper-meta.md` at the paper's root instead: the skill looks for the block in `AGENTS.md`, then `CLAUDE.md`, then `paper-meta.md`, so `paper-meta.md` is the escape hatch for non-git papers.

3. **Ask for a revision.** Open your paper in Claude Code and just say what you want:

   > Revise the introduction in `intro.tex` so it flows better.

   The skill runs automatically, so the plain-English request above needs no extra setup. (Claude Code users also get ready-made commands such as `/paper:revise intro.tex`. Running `--init` in step 2 registers them in this repo; to enable them in every project instead, run `install.sh --commands`. See [Structured slash commands](#structured-slash-commands-claude-code).)

4. **Read the four sections, then decide.** Skim the Diagnosis, compare the Revised text against your original, check the rationale for anything you disagree with, and answer the Author questions. You stay the author; the skill never has the last word on your claims.

The rest of this README covers the complete paper-edit loop, installation options, updating, and the internals.

## Complete paper-edit loop (editing a whole paper)

The Quickstart shows single-section requests. A full edit of a paper is a
*loop*, not a one-shot rewrite, and which sub-command to run, in what order, and
when to stop is not obvious from the commands alone. The governing principle is
**diagnose globally, edit locally, validate globally, then polish
conservatively.** Run the steps below by hand in any agent that reads the skill
(no command setup needed), or, in Claude Code, run `/paper:loop` to have the
agent emit this plan for your paper (with the sections detected and the first
command filled in) and walk it with you, pausing at each author checkpoint.
`/paper:loop` plans and drives the loop; the skill stays the source of truth for
every actual edit.

Note that `/paper:loop` and the other `paper:` slash commands it calls live in
`.claude/commands/`, which Claude Code reads from your repo (or `~/.claude/`),
not from inside the installed skill. Run `install.sh --init` in your paper repo
to register them there, or `install.sh --commands` to register them for every
project; see [Structured slash commands](#structured-slash-commands-claude-code).
Until you do, follow the steps by hand with the plain-English prompts (for
example "give me editorial feedback on `sections/intro.tex`") instead of the
slash commands.

### Step 0: Set context

Run once per paper, and fill in `target_venue`, `audience`, `core_thesis`, and
`revision_stage`:

```bash
~/.local/share/paper-revision-editor/install.sh --init
```

The skill stops rather than guessing when these are missing. `revision_stage` is
the master dial: `first draft` permits restructuring, `response to reviewers`
limits edits to reviewer-flagged paragraphs and their neighbours, and `final
polish` permits only sentence-level changes. If your stage is `response to
reviewers`, do not run this whole-paper loop (it would edit sections the
reviewers accepted); start with `/paper:triage` on the decision letter, then use
`/paper:rebut` per section, and come back to the loop once you move to
`first draft` or `final polish`.

### Step 1: Diagnose before rewriting

Run one whole-paper cold read first, so you understand the global problems
before the agent polishes anything locally:

```text
/paper:read paper.tex
```

The cold read reads the paper front to back, once, as its intended reader, and
returns a reading log (where a venue-competent non-specialist stops following
or stops caring), a colleague test built from quoted manuscript sentences and
compared against your `core_thesis`,
a delight audit, the venue-compliance checks your `target_venue` supports, and
a prioritized dispatch list naming which sections need which passes. It never
rewrites. This replaces the old per-section feedback sweep: stitched
section-by-section feedback never measures whether the paper carries a reader
from title to conclusion, which is exactly what a cold read measures.
(`/paper:feedback` remains the per-section diagnosis inside Step 2's
checkpoint loop and for single-section requests.)

If your repo also holds the data and analysis code that produced the results,
run `/paper:verify-numbers` after the cold read. It reruns your own pipeline
and reports every manuscript number as match, mismatch, or unverifiable, with
the producing command and data version for every recomputed value, so stale
numbers are caught before any prose pass repeats them. It requires a shell
and your pipeline; where either is missing it says so rather than silently
checking nothing.

If the environment grants literature retrieval, run `/paper:scholar` over the
whole manuscript in the same phase, not only the claims the cold read flagged:
the cold read measures reader experience, not citation support, so it cannot
see an unsupported citation on its own. It fetches and reads the cited sources,
reports every cited claim as supported, unsupported, or unverifiable, and
returns leads on prior work that bears on a contribution claim, so an
unsupported citation or an overstated novelty claim is caught before the prose
passes polish it. It requires retrieval; where that is missing it says so
rather than citing from memory. Its citation changes and recalibrated claims
are flagged candidates you apply to the source, never edits the loop performs.

The analyst lane's two generative capabilities are targeted, not whole-paper
sweeps, so they run on demand rather than as a standing loop phase: when the
cold read's dispatch list (or a reviewer) points at a figure that buries its
result, run `/paper:figures <that figure>` to get a re-render from the same
data proposed beside the original; when it names an analysis the paper needs
(a robustness check, a baseline, a subgroup cut), run `/paper:analyze <that
analysis>`. Both propose, never edit, and both need a write tool alongside the
data and shell; where those are missing they say so. Adopt a re-rendered
figure or a new result the same way you adopt a correction: apply it to the
source yourself, then let the closing `/paper:consistency` catch anything the
surrounding text now contradicts.

Answer the `Author questions` these global passes raise, not only the cold
read's: when the verification ran, every mismatch (which value is correct?)
and every unverifiable number is an author decision that must land in the
source before any prose pass repeats the stale value. Then confirm the cold
read's dispatch list before asking for any rewrite. The cold read's questions
flag missing claims, evidence,
examples, mechanisms, definitions, or a thesis mismatch that the skill is not
allowed to resolve by inventing content: the skill's master rule is to never
assert unverified substance, so material the manuscript lacks is a question
for the author, never an edit.

### Step 2: Rewrite section by section

`/paper:revise` is the default and dispatches the complete internal pipeline.
For each section, read all four output blocks (Diagnosis, Revised text, Change
rationale, Author questions). Accept only edits whose rationale names a concrete
reader benefit; reject edits that are merely different. The checkpoint is
recurring: every pass (`revise`, and the `clarify` and `human` passes in Step 3)
can surface new `Author questions`, so stop and resolve them in the source before
the next pass on the section or the move to the next section, since later edits
depend on the answers. Rewrite in this order:

`abstract -> introduction -> results -> methods -> related work -> discussion -> conclusion`

This order is a template for the canonical sections. If your paper has others
(Background, Experiments, Limitations, an Appendix), insert each at its
reading-order position and rewrite it too; do not validate and polish a paper
whose non-canonical sections were never revised.

The abstract and introduction get a first pass here, to set the spine the body
must serve, and a second pass in Step 5, after the body is stable, because they
are compressed views of the whole paper and go stale once the body changes. Do
not rerun them at the end of this order; Step 5 is where the second pass lives.

### Step 3: Use targeted passes only when needed

Reach for these as second passes when the diagnosis points to their specific
problem, not on every section:

- `/paper:clarify <section>` when the reader lacks definitions, intuition,
  motive, inferential bridges, concrete anchors, or paragraph payoff. Repeat
  only until the reader can state the question, the motive, each object's role,
  the evidence, and the payoff, not to make prose smoother.
- `/paper:human <section>` when the section is flat, list-like, or LLM-sounding.
  It adds a setup, tension, turn, and payoff spine, not decoration. Repeat only
  if the section still has no findable turn.
- `/paper:rebut <reviewer comments + section>` for response-to-reviewers work
  only. It edits the reviewer-flagged paragraphs and their immediate neighbours.

### Step 4: Repeat only under clear conditions

Repeat a pass when the author has answered an `Author question`, the section was
substantially restructured, a targeted problem remains (machinery before motive,
missing payoff, list rhythm, terminology drift), or the paper changed enough that
the abstract or introduction is now stale. Do not repeat a pass merely to get a
different rewrite. Unchanged prose is a valid successful result, and a rewrite
that touches every paragraph is suspect.

### Step 5: Validate, then polish

When the body is stable, run a cross-section consistency check, then re-open the
front matter, then polish:

```text
/paper:consistency paper.tex          # whole-paper, no rewrite: drift and stale-summary check
/paper:revise sections/abstract.tex   # front matter reflects the final paper
/paper:revise sections/intro.tex
/paper:consistency paper.tex          # re-check: the front-matter rewrites can introduce fresh drift
/paper:read paper.tex                 # exit criterion: the cold read comes back clean
/paper:polish sections/<each>.tex      # sentence-level only, no restructuring
```

The consistency check runs twice on purpose. The abstract and introduction
rewrites can change contribution wording or result summaries after the first
whole-paper check, and `/paper:polish` is sentence-level only, so it cannot
repair fresh cross-section drift; the second check catches it before polishing.
`/paper:consistency` flags terminology drift, claim drift, inconsistent
contribution framing, result overstatement, unpaid precision debt, missing
forward references, and stale summaries without rewriting. `/paper:polish` applies final-polish
constraints: copyediting, referents, terminology consistency, punctuation,
rhythm, and the AI tells allowed at that stage, with no paragraph reordering or
new content.

The closing `/paper:read` is the loop's exit criterion, and it runs before the
polish because polish is sentence-level only and cannot repair what the read
finds. Stop when the cold read comes back clean (no reading-log break points,
the colleague test matches your `core_thesis`, no must-fix delight or
venue-compliance findings) and its dispatch list asks for nothing beyond the
polish; if it asks for more, feed the flagged sections back into Step 2.
Within any single pass, the stop rule is unchanged: stop when the remaining
edits would be merely different rather than better.

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

Removes both symlinks and the global `paper:` commands and paper subagents that `--commands` installs under `~/.claude`. Commands copied into a specific repo by `--init` stay in that repo (uninstall takes no repo argument); remove them there if you want them gone. The clone at `~/.local/share/paper-revision-editor` is left alone; delete it manually if you want.

## Verify and troubleshoot

```bash
~/.local/share/paper-revision-editor/install.sh --check
```

`--check` lists both targets, flags a `BROKEN` symlink if the clone moved, and prints the clone's version and tracked ref. Common cases:

- `git is required but was not found`: install `git`, then re-run.
- A target shows `(exists, not a symlink)`: either an unmanaged file is in the way, or
  your filesystem does not support symlinks and the installer fell back to copying.
  If `install.sh --check` shows the directory's version matching the clone's, it is a
  healthy copy-mode install and `--update` refreshes it. Only move it aside if you did
  not install it.
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
make init         # scaffold AGENTS.md (runs against the repo you are in; for your
                  # paper, run: cd /path/to/your/paper && /path/to/clone/install.sh --init)
```

## See it in action

Each file in `examples/` is a complete run you can read before trying your own. They double as the skill's quality bar:

- [`worked-example.md`](examples/worked-example.md): the place to start. A flawed first-draft introduction in, the four-section output out, every constraint honored.
- [`exposition-introduction.md`](examples/exposition-introduction.md), [`exposition-methods.md`](examples/exposition-methods.md), [`exposition-results.md`](examples/exposition-results.md): making a section clearer to a non-specialist (restoring a missing gap, moving intuition ahead of machinery, turning a table into a takeaway).
- [`reviewer-response-example.md`](examples/reviewer-response-example.md): a response-to-reviewers run that edits only the flagged paragraphs and flags what it cannot fix.
- [`response-letter-example.md`](examples/response-letter-example.md): the letter lane for the same revision (tone recalibrated without conceding a position, every claimed change checked against the manuscript).
- [`restraint-example.md`](examples/restraint-example.md): strong prose returned almost unchanged, showing the editor declining edits that would be different rather than better.

## Invoking the skill

Any prompt that mentions revising, polishing, copy-editing, tightening, or responding to reviewer comments on a paper section will auto-trigger the skill. Explicit invocation:

- Claude Code: `/paper-revision-editor`, or use the `paper-reviser` subagent under `.claude/agents/`.
- Any other agent reading `~/.agents/skills/`: mention the skill by name or use that agent's slash-command convention.

### Structured slash commands (Claude Code)

For predictable, one-shot invocation, the repo ships a `paper:` command namespace under `.claude/commands/paper/`. The section commands pre-set the triage (scope, unit, focus) so the skill skips the clarifying round-trip, then dispatch to the `paper-reviser` subagent. `revise`, `feedback`, `clarify`, `human`, and `polish` follow or, for `polish`, pin the `revision_stage` in your `<paper_context>`; `rebut` applies response-to-reviewers scope (pasting reviewer comments is itself a trigger in the skill) and tells you if your stored stage says otherwise, and `polish` likewise warns when the stored stage is not `final polish`. `read` is the whole-paper cold read, diagnosis only (no rewrite): it reads the paper front to back as its intended reader and returns the reading log, colleague test, delight audit, venue-compliance findings, and a prioritized dispatch list into the other commands. `consistency` is likewise a whole-paper diagnosis only (no rewrite), and `triage` is also diagnosis-only: it takes the decision letter rather than a section and returns the severity-ranked comment table, section mapping, and order of work that opens a major revision. `letter` closes that round: it drafts or improves the response letter itself under its own license (reply text may restate what the revision did, never promise what the manuscript lacks, and every claimed change must point at a real location). `verify-numbers` is the analyst lane and the one command that does not dispatch to `paper-reviser`: it dispatches to the `paper-analyst` subagent, which reruns your own analysis pipeline and diffs its outputs against the manuscript's numbers, reporting each as match, mismatch, or unverifiable with the producing command and data version. Verification only: it never edits the manuscript, the code, or the data, and it runs only where the repo holds your data and analysis code and the environment grants a shell; anywhere else it reports what is missing instead of improvising a check (protocol in `references/analysis-integrity.md`). `figures` and `analyze` are the analyst lane's two generative capabilities and dispatch to the same `paper-analyst` subagent: `figures` re-renders a named figure with better design from the same data and script and proposes it beside the original (changing how the data is shown, never which data), and `analyze` runs a new analysis you name, pinning the specification before the run and reporting the whole result whichever way it points (the no-forking-paths rule). Both author only new files in a proposal location and never touch your code, data, figures, or manuscript; both additionally need a write tool, and where it or the data is missing they report what is missing instead of improvising (same protocol file). `scholar` is the retrieval-branch companion and dispatches to the `paper-scholar` subagent: it fetches and reads the sources your citations point at, reports each cited claim as supported, unsupported, or unverifiable with the passage quoted, and scans your contribution claims for overlapping prior work, returning leads for you to judge rather than verdicts. Retrieval only: it never edits, a citation change or recalibrated claim is a flagged candidate the author decides on, and it runs only where the environment grants literature retrieval; anywhere else it reports what is missing instead of citing from memory (protocol in `references/literature-checks.md`). `loop` is different in kind: it emits the staged whole-paper plan, then drives it one section at a time, calling the other commands and pausing at each author checkpoint, rather than running a single pass itself. See [the complete paper-edit loop](#complete-paper-edit-loop-editing-a-whole-paper) for the steps it drives.

| Command | What it does |
|---------|--------------|
| `/paper:revise` | Full diagnose-then-rewrite pass, four-section output. |
| `/paper:feedback` | Diagnosis only, no rewrite (`Revised text` reads `No rewrite requested.`). |
| `/paper:clarify` | Exposition pass: make the section clearer to a non-specialist. |
| `/paper:human` | Narrative-spine plus AI-tell scrub: read more human, less LLM. |
| `/paper:rebut` | Response-to-reviewers workflow: map comments, edit only flagged paragraphs. |
| `/paper:triage` | Decision-letter triage (no rewrite): severity-ranked comment table, section mapping, suggested order of work. |
| `/paper:letter` | Draft or improve the response-to-reviewers letter; every claimed change is checked against the manuscript. |
| `/paper:polish` | Final-polish pass: sentence-level copyediting only, no restructuring. |
| `/paper:read` | Whole-paper cold read (no rewrite): reading log, colleague test, delight audit, venue compliance, prioritized dispatch list. |
| `/paper:consistency` | Whole-paper cross-section check (no rewrite): terminology, claim, and contribution drift, stale summaries, unpaid precision debt. |
| `/paper:verify-numbers` | Analyst lane (no edits): reruns your own analysis pipeline and diffs its outputs against the manuscript's numbers, with provenance. Needs your data and code in the repo, and a shell. |
| `/paper:figures` | Analyst lane (proposal only): re-renders a named figure with better design from the same data and script, proposed beside the original. Needs your data and code, a shell, and a write tool. |
| `/paper:analyze` | Analyst lane (proposal only): runs a new analysis you name, specification pinned before the run, whole result reported. Needs your data and code, a shell, and a write tool. |
| `/paper:scholar` | Scholar lane (no edits): fetches and reads your cited sources, reports each cited claim as supported, unsupported, or unverifiable, and returns novelty leads. Needs literature retrieval. |
| `/paper:loop` | Emits the staged whole-paper edit plan and drives it section by section, pausing at each author checkpoint. |

The section commands take a section as an argument (a file path or pasted text), for example `/paper:revise sections/intro.tex`. `/paper:triage` takes the decision letter (pasted or file paths), optionally with the manuscript root. `/paper:read`, `/paper:consistency`, `/paper:verify-numbers`, `/paper:figures`, `/paper:analyze`, `/paper:scholar`, and `/paper:loop` take the manuscript root or a list of section files (`/paper:verify-numbers` optionally adds the pipeline entry point; `/paper:figures` names the figure to regenerate; `/paper:analyze` names the analysis to run; and `/paper:scholar` also accepts a single named contribution or claim to check); `/paper:loop` drives the [complete paper-edit loop](#complete-paper-edit-loop-editing-a-whole-paper) above, opening and closing it with `/paper:read`.

Like the `paper-reviser`, `paper-analyst`, and `paper-scholar` subagents, these commands are Claude-Code conveniences. Claude Code discovers commands under `.claude/commands/` and subagents under `.claude/agents/` (project level), or the same paths under `~/.claude/` (all projects). It never discovers them inside an installed skill directory, so the skill ships the files but they take effect only once copied into one of those trees. The installer does the copy for you: run `install.sh --init` in your paper repo to register them there, or `install.sh --commands` to register them for every project (`~/.claude/`). Both copy the `paper/` command directory and the `agents/` subagent files, and are safe to re-run after an update to pick up new or changed commands. To do it by hand instead, copy the `paper/` directory to `<your-repo>/.claude/commands/paper/` (or `~/.claude/commands/paper/`) and the agent files to the matching `agents/` dir; keep the `paper/` directory name, since it is what produces the `paper:` namespace. The skill itself stays the cross-tool source of truth and needs none of this.

## How it works (under the hood)

When you ask an agent to "revise the introduction" or "respond to reviewer 2", the skill runs a disciplined diagnose-then-revise pipeline: load the paper context, triage the request, apply a section-specific diagnostic lens, run exposition, reader-experience, narrative-spine, and research-paper copyediting passes when prose quality matters, including exemplar-based technique checks, extract voice tics from the original prose, produce a rewrite, run a read-cold pass on the rewrite, check the length budget, and return a strict four-section output (Diagnosis, Revised text, Change rationale, Author questions). The exposition pass makes the paper teach: it repairs missing definitions, skipped inferential steps, and machinery introduced before intuition, using only material already in the manuscript and flagging the rest as questions. Numerical claims, citations, and analytical conclusions are never edited; changes to them come back as questions for you. No em-dashes, no banned transitions, no throat-clearing, no filler adjectives or importance-signaling verbs, no decorative flourish, no manufactured hooks or anthropomorphized data, no explanatory bridge built from anything but material already in the manuscript, and no change that is merely different rather than better.

## Files

| Path | Purpose |
|------|---------|
| `SKILL.md` | The skill itself (frontmatter + instructions) |
| `references/` | Load-on-demand reference material, including reader-experience and research-paper copyediting checks |
| `.claude/agents/paper-reviser.md` | Claude Code subagent that dispatches to the skill (the editor lane) |
| `.claude/agents/paper-analyst.md` | Claude Code subagent for the analyst lane: number verification, figure regeneration, and new analyses against the repo's own data and pipeline (`references/analysis-integrity.md`) |
| `.claude/agents/paper-scholar.md` | Claude Code subagent for the scholar lane: citation verification and novelty scanning against the literature (`references/literature-checks.md`) |
| `.claude/commands/paper/` | Claude Code slash commands: section passes (`/paper:revise`, `/paper:feedback`, `/paper:clarify`, `/paper:human`, `/paper:rebut`, `/paper:polish`), the whole-paper `/paper:read` cold read and `/paper:consistency` check, the `/paper:triage` decision-letter triage, the `/paper:letter` response-letter lane, the `/paper:verify-numbers`, `/paper:figures`, and `/paper:analyze` analyst lane, the `/paper:scholar` scholar lane, and the `/paper:loop` planner-driver |
| `install.sh` | Installer, updater, uninstaller; registers `paper:` commands via `--init` (this repo) or `--commands` (all projects); supports `--ref`, `--version`, `--check` |
| `scripts/` | Maintenance helpers: `check-version.sh`, `bump-version.sh`, `lint.sh` |
| `.github/workflows/ci.yml` | CI: shellcheck, version consistency, lint, install smoke test |
| `Makefile` | Thin wrapper over `install.sh` and `scripts/` |
| `examples/worked-example.md` | A complete run of the skill: flawed draft in, four-section output out |
| `examples/exposition-introduction.md` | Exposition run: an introduction that assumes the reader knows the gap |
| `examples/exposition-methods.md` | Exposition run: a methods paragraph that opens on machinery |
| `examples/exposition-results.md` | Exposition run: a results paragraph that reports numbers but no takeaway |
| `examples/reviewer-response-example.md` | Reviewer-response run: comment mapping, flagged-paragraph-only edits, gaps flagged |
| `examples/response-letter-example.md` | Response-letter run: tone recalibrated, claimed changes verified against the manuscript |
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
