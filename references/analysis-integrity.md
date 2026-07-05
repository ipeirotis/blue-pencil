# Analysis integrity: verifying manuscript numbers

Load this for the analyst lane's verification pass: when the user asks to
check, verify, or reconcile the numbers a manuscript reports against the
repository's own data and analysis code, when a `/paper:verify-numbers`
dispatch names it, or when a stale-number question ("is the 12.4% in the
abstract still what the pipeline produces?") needs settling.

**Gate condition.** This pass runs only when both hold: (a) the repository
contains the author's own data and analysis code, a pipeline the author
already wrote, and (b) the environment grants a shell tool to execute it.
When either is missing, do not fake the pass: say which half is missing,
assert nothing about the numbers, and route the question to `Author
questions` with a note that data access (or a shell) would settle it. That
degraded answer is the editor lane's existing behavior, and it is correct.

This pass verifies; it never edits. It is the analyst lane's first
capability and, for now, its only one: regenerating figures and running new
analyses stay out of scope until their own integrity rules ship. When asked
for them, say so and route the request to `Author questions` as author work.

## Where this lane sits under the master rule

The skill's master rule (never assert unverified substance) has a
computation branch: a number is verified when you computed it from the
repo's own data, with the producing command logged. This lane is that
branch, and nothing else. The only numbers it may assert are the ones the
author's own pipeline just produced in front of you; a number you remember,
estimate, or derive by side calculation is unverified substance, exactly as
it is for the editor.

## The protocol

Run the five steps in order. Do not reorder them: naming the command before
running it is what makes the run a verification instead of a search.

### 1. Discover the pipeline

Find how the author produces their results: a `Makefile` target, a
`scripts/` entry point, a notebook run in order, a README instruction. Read
before running. If more than one candidate could be the producing command,
or the pipeline's data input is ambiguous (which file, which snapshot), ask
the author which is canonical instead of trying each: trying each is
specification search. Never write new analysis code, and never modify the
author's code or data; this lane reads and executes, it does not author.

### 2. State the plan before running

Before executing anything, write down the exact command or commands you
will run, the manuscript numbers they should reproduce (each with its
location), and which output you will read the values from. This is the
no-forking-paths rule at verification scale: the plan is stated once,
before the first run, and the results are reported against it whichever way
they point.

### 3. Run and log

Run the stated commands. Log, for every value you extract: the exact script
and command, the data version (the commit hash, or the data file's identity
when data is not versioned), and where in the output the value appears.
Prefer read-only execution. If the pipeline wants credentials or network
access, would take very long, or would overwrite the author's existing
outputs, stop and ask before running.

### 4. Extract the manuscript's numbers

Independently of the run, list every number in the requested scope with its
location: statistics, effect sizes, p-values, sample sizes, percentages,
counts, table cells, and the numbers quoted in the abstract and
introduction. The abstract and introduction matter most: stale values hide
where the text was written first and the pipeline rerun last.

### 5. Diff and report

Compare, value by value, and classify each as one of:

- **match**: the manuscript value equals the pipeline output; state the
  rounding tolerance you accepted
- **mismatch**: the pipeline produces a different value; report both, with
  provenance for the recomputed one
- **unverifiable**: no pipeline output corresponds to it, the producing
  command is unclear, or the run failed; say why

## Integrity norms

- **Provenance or it does not exist.** Every number you report as
  recomputed carries the exact script, command, and data version that
  produced it. Nothing enters the report that the author cannot reproduce
  with one command.
- **No garden of forking paths.** State the analysis before running it, and
  report the result whichever way it points. Never scan specifications,
  subgroups, or outcome definitions for a favorable result; if the author's
  pipeline runs a grid, report the whole grid. Label exploratory output as
  exploratory.
- **Recomputed values are proposals.** A mismatch never becomes an edit:
  the manuscript may be right (a different data snapshot, an intentional
  rounding, a subsample the text names), so present both values with
  provenance and let the author decide which is correct. The author decides
  what enters the paper.
- **A changed number changes the paper.** When the author accepts a
  correction, the same stale value may sit in the abstract, introduction,
  and discussion: recommend `/paper:consistency` over the whole paper after
  the corrections land, and say so in the report.

## Reporting conventions

- Return the skill's strict four-section output. Verification only: the
  `Revised text` block reads `No rewrite requested.`, and `Change
  rationale` carries the run log (commands executed, data version, run
  outcome) instead of change lines, with no word-count line.
- The Diagnosis carries the verification table, grouped match, then
  mismatch, then unverifiable. Every row names its manuscript location;
  mismatch rows carry both values and the recomputed value's provenance;
  unverifiable rows carry the reason verification failed. The seven-item
  Diagnosis cap does not apply: this is a whole-paper diagnosis-only pass,
  and exhaustiveness is its value.
- `Author questions` carries one item per mismatch (which value is
  correct?), per unverifiable number (where does this value come from?),
  and per pipeline ambiguity left unresolved (which command or data
  snapshot is canonical?). Every item ends with a question mark.
