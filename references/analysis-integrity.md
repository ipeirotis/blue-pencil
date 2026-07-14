# Analysis integrity: the analyst lane

Load this for the analyst lane: when the user asks to check the numbers a
manuscript reports against the repository's own data and analysis code
(`/paper:verify-numbers`), to regenerate a figure with better visual design
from the same data and scripts (`/paper:figures`), or to run a new analysis
the author names, a robustness check, a baseline, a subgroup cut
(`/paper:analyze`). All three are the same lane under the same integrity
norms; they differ only in how much they produce.

**Gate condition.** This lane runs only when both hold: (a) the repository
contains the author's own data and analysis code, a pipeline the author
already wrote, and (b) the environment grants a shell tool to execute it.
The two generative capabilities (figures, new analyses) additionally need a
write tool to author new scripts and render new outputs. When any required
tool or input is missing, do not fake the pass: say which half is missing,
assert nothing about the numbers or figures, and route the question to
`Author questions` with a note that data access (or a shell, or a write
tool) would settle it. That degraded answer is the editor lane's existing
behavior, and it is correct.

The three capabilities ship in rising order of ambition and risk:
verification is pure reading and re-running; figure regeneration re-renders
what the pipeline already produces; a new analysis computes something the
pipeline never ran. The order is not decoration: the generative
capabilities are safe only because the integrity norms below were exercised
first by verification, and an analyst with data access and an instruction to
"strengthen the results" is otherwise a machine for hypothesizing after the
results are known. Never let the two generative capabilities drift into that.

## Where this lane sits under the master rule

The skill's master rule (never assert unverified substance) has a
computation branch: a number is verified when you computed it from the repo's
own data, with the producing command logged. This lane is that branch, and
nothing else. The only numbers and figures it may assert anything about are
the ones the author's own data and code just produced in front of you, with
the producing command logged; a number you remember, estimate, derive by
side calculation, or read off a plot is unverified substance, exactly as it
is for the editor. A regenerated figure asserts nothing new: it must plot the
same values the pipeline produces, only better. A new analysis may assert a
new number, but only one it just computed, logged, and presented as a
proposal the author decides on.

## Capability 1: verify reported numbers

Run the five steps in order. Do not reorder them: the manuscript inventory
and the producing command are both pinned before the first run, which is what
makes the run a verification instead of a search.

### 1. Discover the pipeline

Find how the author produces their results: a `Makefile` target, a
`scripts/` entry point, a notebook run in order, a README instruction. Read
before running. If more than one candidate could be the producing command,
or the pipeline's data input is ambiguous (which file, which snapshot), ask
the author which is canonical instead of trying each: trying each is
specification search. Never write new analysis code, and never modify the
author's code or data; this capability reads and executes, it does not
author.

### 2. Extract the manuscript's numbers

Before any command runs, list every number in the requested scope with its
location: statistics, effect sizes, p-values, sample sizes, percentages,
counts, table cells, and the numbers quoted in the abstract and
introduction. The inventory must be complete before you see a single
pipeline output, so what the pipeline shows you can never shape which
manuscript values get checked. The abstract and introduction matter most:
stale values hide where the text was written first and the pipeline rerun
last.

### 3. State the plan before running

Still before executing anything, write down the exact command or commands
you will run, which entries of the step 2 inventory they should reproduce,
and which output you will read the values from. This is the
no-forking-paths rule at verification scale: the plan is stated once,
before the first run, and the results are reported against it whichever way
they point.

### 4. Run and log

Run the stated commands. Log, for every value you extract: the exact script
and command, the data version, and where in the output the value appears.
The data version is the commit hash only when the working tree is clean;
when the analysis code or data carry uncommitted changes, or the data is
not versioned at all, say so and identify the actual inputs read (for
example by file path and content hash), since a bare commit hash no longer
reproduces the run. Prefer read-only execution. If the pipeline wants
credentials or network access, would take very long, or would write to the
working tree (overwrite outputs, rebuild generated tables or caches in
place), stop and ask before running, or use a read-only or dry-run path
when the pipeline offers one.

### 5. Diff and report

Compare, value by value, and classify each as one of:

- **match**: the manuscript value equals the pipeline output; state the
  rounding tolerance you accepted
- **mismatch**: the pipeline produces a different value; report both, with
  provenance for the recomputed one
- **unverifiable**: no pipeline output corresponds to it, the producing
  command is unclear, or the run failed; say why

## Capability 2: regenerate figures

The repo already holds that figures are primary text, not decoration
(`references/edit-checks.md` check 5). This capability acts on that: it
re-renders a figure with better visual design from the author's own data and
scripts, and proposes it beside the original for the author to choose. It
changes how the data is shown, never which data is shown.

Gate this capability on a named target: the author says which figure, or the
cold read or a reviewer flagged one. Do not sweep the paper re-rendering
every plot uninvited.

1. **Find the figure's own producing script.** Locate the script and data
   that render the current figure, the same way capability 1 discovers the
   pipeline. If you cannot find how the figure is produced, or more than one
   script could produce it, ask; do not reconstruct the plot from the image.
2. **Re-render from the same values.** Author a new plotting script (a new
   file, never an edit to the author's) that reads the same data the original
   reads and produces the same series, then improve only the presentation:
   the design guidance in `references/edit-checks.md` and any visualization
   standard the environment provides. The data path, the transformation, and
   the plotted values stay identical; a regenerated figure that changes a
   number, an axis range that hides points, a smoothing that was not in the
   original, or a series that was not there is a new analysis, not a
   regeneration, and it routes to capability 3 with capability 3's rules.
3. **Verify the re-render against the original.** Before proposing it,
   confirm the new figure plots the same values: same data version, same
   summary statistics behind each mark. Say what you changed (color, scale
   labeling, ordering, gridlines) and confirm what you did not (the values).
4. **Propose side by side.** Present the original and the re-render together,
   with the exact script and command that produced the new one, and let the
   author choose. Never overwrite the author's figure file or figure script.

## Capability 3: run new analyses

This is the lane's most ambitious and most dangerous capability: computing
something the author's pipeline never ran, a robustness check a reviewer
demanded, a baseline the author named, a subgroup cut that would settle an
`Author question`. The no-forking-paths rule below is load-bearing here; an
analysis chosen after seeing what would look good is not evidence.

Gate this capability on an analysis the author (or a reviewer through the
author) has actually named. Never invent the question yourself, and never run
a new analysis to "strengthen the results" on your own initiative.

1. **Pin the specification before running.** Write down, before you execute
   anything, the exact analysis: the outcome, the sample or subgroup, the
   model or test, and what result would count as which answer. State it as
   the author named it. If the specification is ambiguous (which outcome
   definition, which covariates, which subsample), ask; do not choose the
   version that reads best.
2. **Author a new script, run it, log it.** Write a new analysis script (a
   new file, never an edit to the author's code or data), run it, and log the
   script, the command, the data version, and the full output. The script
   must be one the author can rerun with one command to reproduce the number.
3. **Report the whole result, whichever way it points.** Report the analysis
   you pinned in step 1, in full, whether or not it helps the paper. If the
   author named a grid (a robustness sweep across specifications), report the
   whole grid, not the favorable cell. Label anything exploratory as
   exploratory. Never scan specifications, subgroups, or outcome definitions
   for a favorable result, and never present the one cut that worked as if it
   were the analysis that was planned.
4. **Present it as a proposal, never woven in.** A new result enters
   `Revised text` as a clearly marked candidate addition with its full
   provenance, never silently merged into an existing claim or number. The
   author decides what enters the paper, and a result that weakens or
   complicates a claim is reported as plainly as one that supports it.

## Integrity norms

These bind all three capabilities.

- **Provenance or it does not exist.** Every number and figure you produce
  carries the exact script, command, and data version that produced it.
  Nothing enters the report that the author cannot reproduce with one
  command. The data version is the commit hash on a clean tree, and the
  actual inputs read (file path and content hash) when the tree is dirty or
  the data is unversioned.
- **No garden of forking paths.** State the analysis before running it, and
  report the result whichever way it points. Never scan specifications,
  subgroups, or outcome definitions for a favorable result; if the author's
  specification is a grid, report the whole grid. Label exploratory output as
  exploratory. This is the rule that keeps capability 3 from turning data
  access into industrialized HARKing.
- **Read and execute, author only new files.** Never modify or overwrite the
  author's code, data, figures, or manuscript. The verification capability
  writes nothing. The generative capabilities author new files only, a new
  plotting or analysis script and its outputs, in a clearly labeled proposal
  location (a directory the author names, or a `paper-analyst-out/` scratch
  directory); the author's tracked files stay exactly as they were, and a
  proposal is adopted only when the author moves it in.
- **Results and figures are proposals.** A recomputed value, a re-rendered
  figure, and a new result are all proposals, never edits. A mismatch may
  mean the manuscript is right (a different snapshot, an intentional
  rounding, a subsample the text names); a re-render the author may prefer
  the original of; a new result the author may judge out of scope. Present
  both the original and yours with provenance, and let the author decide what
  enters the paper.
- **A changed number changes the paper.** When the author accepts a
  correction, a new result, or a figure that carries a different emphasis,
  the same value or claim may sit in the abstract, introduction, and
  discussion: recommend `/paper:consistency` over the whole paper after the
  changes land, and say so in the report.

## Reporting conventions

- Return the skill's strict four-section output. For the verification
  capability the `Revised text` block reads `No rewrite requested.` (the
  skill's shared diagnosis-only sentinel), and `Change rationale` carries the
  run log (commands executed, data version, run outcome) instead of change
  lines, with no word-count line. For the generative capabilities `Revised
  text` carries the proposals, each a clearly marked candidate (a re-rendered
  figure with its script, or a new result with its number and script), with
  the original alongside and nothing woven silently into an existing claim;
  `Change rationale` still carries the run log, not change lines, with no
  word-count line.
- The Diagnosis carries the findings. For verification, the table grouped
  match, then mismatch, then unverifiable; every row names its manuscript
  location, mismatch rows carry both values and the recomputed value's
  provenance, unverifiable rows carry the reason. For figure regeneration,
  what changed in presentation and the confirmation that the values did not.
  For a new analysis, the pinned specification and the full result. The
  seven-item Diagnosis cap does not apply: this is a whole-paper or
  named-target diagnosis-primary pass, and exhaustiveness is its value.
- `Author questions` carries one item per mismatch (which value is
  correct?), per unverifiable number (where does this value come from?), per
  pipeline or specification ambiguity left unresolved (which command, data
  snapshot, or outcome definition is canonical?), and per proposal the author
  must judge (adopt the re-render, or keep the original? does this new result
  belong in the paper?). Every item ends with a question mark.
