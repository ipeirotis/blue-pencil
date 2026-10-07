# TASKS: making Blue Pencil measurable, verifiable, and better

Backlog for the evaluation and hardening effort described in
`docs/spur-2026-blue-pencil-evals.md`. Each task has a deliverable and a
"done when" test so it can be picked up, finished, and reviewed independently.
Tasks are grouped by workstream; the dependency graph and a suggested order sit
at the end. Sizes: S (under a day), M (two to four days), L (a week or more).

Ground rules for the whole effort:

- Every change to `SKILL.md`, `references/`, or `.claude/commands/` ships with
  a before/after benchmark from the same corpus and model. No measurement, no
  merge.
- Deterministic graders outrank LLM judges. A behavior that a script can check
  is checked by a script; judges cover only what scripts cannot.
- The corpus never contains text we lack the right to redistribute (see B1).
- Every recurring failure becomes a regression case, not just a fix.

Labels: `[harness]` `[corpus]` `[grader]` `[judge]` `[analysis]` `[skill]` `[ci]`

---

## A. Eval harness `[harness]`

### A1. Eval case schema and directory layout (S)
Define `evals/` so a case is self-describing: an ordered artifact list in
place of a single input (each artifact with a path, a role such as
`manuscript-root`, `included-section`, `draft-letter`, `reviewer-comments`,
`author-decisions`, or `change-log`, its reading order, and an `editable`
flag, so a section case has one editable artifact while a `/paper:read`,
`/paper:consistency`, or `/paper:loop` case carries a root-plus-includes
graph and a `/paper:letter` case carries an editable draft beside read-only
comments and manuscript files, and an assembly-mode letter case carries no
editable original at all, only the read-only comment set, decisions, change
log, and the revised manuscript the command verifies each claimed change
against (the command file routes every claim to `Author questions` when the
manuscript is absent, so a case without it could never exercise or pass the
grounded-reply path that F2 and D4 grade), since supplying a draft would
send the command down its rewrite path; C1 and C3 align and diff against the
editable artifact where one exists and skip where none does, and on the
draft-letter lane a protected token added to the draft is excepted when it
occurs in any supplied read-only artifact (the manuscript, the reviewer
comments, the author decisions, or the change log), an exception the runner
derives directly from the trusted supplied artifacts by lookup and records
with the artifact the token was found in, so the draft rewrite needs no
provenance annotation of its own (the provenance-line form belongs to the
assembly contract alone, and the full contract the draft lane follows
carries only ordinary change lines, so a compliant rewrite is never
rejected for an annotation no contract asked of it),
since the command requires a claimed change to point to a real manuscript
location and every comment to be covered, so a verified `Section 3` added
to a draft that omitted it, or a reviewer's quoted figure restored from the
comments, is correct, while a token absent from every supplied artifact
still fails; and
C4 knows which file an explicit apply may touch), an optional `turns` script (an ordered list of
author messages and between-turn artifact updates, such as the scripted
context reply in the missing-context case, and for the repeat-round case a
`prior_transcript` fixture: the stored first-round suggestion seeded into
the conversation as history rather than generated live, with the author's
returned file staged as the artifact's initial state, so the evaluated run
is one agent turn graded against the same rejected transformations on every
model and repetition, as B6 specifies; all of it hashed with the rest of
the case so the cache key
covers the interaction), the paper
context as structured fields (`revision_stage`,
`audience`, `target_venue`, `core_thesis`, `style_overrides`), the command or
plain-English prompt, and the expectations. The `<paper_context>` block the
agent sees is rendered from those fields at run time by A2, never stored as a
second copy, so the stage that drives the model and the stage the graders and
reports use are one value. A `context_delivery` field selects `file` (the
default for file-backed cases: the block is rendered into the root context
file the skill reads in production, `AGENTS.md`, `CLAUDE.md`, or
`paper-meta.md`, with a `context_file` field naming which, so a skill version
that breaks the production lookup fails the benchmark instead of being fed
the answer through the prompt; B6 carries precedence cases where two of the
three files are present and the higher-precedence one must win, which needs
a `decoy_context`: a second structured context with deliberately different
field values rendered into the lower-precedence file, kept apart from the
grading context so the graders compare against the expected values and an
agent that read the wrong file produces the decoy's stage and fails), `prompt`
(the block rendered into the prompt, only for the explicitly modeled chat
surface in E5 where no files exist), or `withheld` (no block in any file or
the first turn, the fields kept for grading and for the scripted reply),
which is how the missing-context case in B6 exercises the single ask
without losing the stage
the C4 predicates compare against; a case that carries a hand-written block as well
is rejected by the schema unless it matches the rendered one or is the
declared `decoy_context` of a precedence case. Expectations are split into
`must_not_change` (protected-content inventory, generated by the C1 checker),
`must_flag` (defects a good editor names in the Diagnosis), `must_not_flag`
(defect classes the passage is free of, so a Diagnosis naming one is a false
positive; required on the clean controls C6 uses), `must_not_do` (scope
violations for the stage), `reference_clean` on every B3 injected case (the
clean original the defect was injected into, a grader-only field rather than
an artifact, so it is never staged for the agent and the C6 similarity check
against it cannot be gamed by reading the desired prose), `flagged_paragraphs` on every
response-to-reviewers case that revises a supplied manuscript section, and
forbidden by the schema on a manuscript-free case such as the B6 triage of
reviewer comments without a manuscript, where there are no paragraphs to
index and the command keeps its section mapping unverified until a
manuscript arrives, so no empty or invented mapping can reach C4 as ground
truth (the authoritative mapping from each reviewer
label to the paragraph indices it flags, written by the corpus author, which
C4 compares against instead of trusting the model's own labels, so a model
cannot widen its window by declaring every paragraph flagged, with a
`structural` marker on a label whose comment objects to a flagged
paragraph's organisation, since the stage forbids reorganising only the
paragraphs reviewers did not complain about),
`expected_variants` (one A3 result variant per agent turn, so a scripted
case lists a sequence, for example clarification then full contract for the
missing-context case, derived at validation time from the command, context,
and `turns` script: a plain revision case permits only the full or compact
contract its command names on its single turn, and only the B6 scenarios
permit a clarification, split-and-confirm, decline, or refusal at the turn
where their script expects it, so an ordinary run
that emits a clarification to dodge the contract checks fails C2 on the
variant mismatch; a `/paper:loop` case, whose command runs `clarify` and
`human` conditionally, may repeat them, and stops for a variable set of
`Author questions`, carries instead a set of allowed transitions keyed by
the previous variant, and its `turns` script keys each author reply to the
variant or event it answers (a checkpoint with questions gets a reply that
resolves or defers every question, an apply offer gets a confirmation, a
repeated pass gets the same checkpoint reply) with termination rules (a
recorded maximum of agent turns, and stop on the completion variant), so a
correct run that reaches a checkpoint a fixed sequence did not anticipate
is graded on the transition rather than failed on the index), `damage_mode` (an enum `none`, `localized`, or
`pervasive`, so the runner and C4 select the repair branch or the refusal
branch deterministically rather than inferring it from a missing field),
`artifact_repairs` required when and only when `damage_mode` is `localized`
(the structured oracle mapping each damaged span to its allowed repaired
form, which C4 uses to tell a declared repair from an undeclared rewrite,
and from which the runner derives the occurrence-scoped C1 exceptions for
every protected token a declared repair touches, such as a stray page number
in a header or a mangled token inside a quotation, so a required repair is
not also scored as a protected-content violation while any token change the
oracle does not declare still fails C1),
and `may_return_verbatim` (restraint cases).
Each case also carries `expected_passes`: the sweep passes two labelers (the
corpus author and a second maintainer, labeling independently) judge
applicable under the gates in the sweep table of `SKILL.md`, including
the content gates (unfamiliar machinery, statistical machinery, a clarity
request), which are subjective enough that one annotator's slip would turn
a correct reference read into a benchmark failure; the agreed set is stored,
both labels are kept, and a disagreement tags the disputed entries
`ambiguous` one pass at a time, never the whole case, so the consensus
entries and the references the sweep table of the ref under test marks as
running on every pass (today `principles.md`, `edit-checks.md`,
`structural-patterns.md`, `sentence-patterns.md`, `subtraction.md`,
`ai-tells-to-avoid.md`, and `copyediting.md`, read from the table rather
than hard-coded, so a later table change moves the list) keep gating while
only the disputed pass is excluded,
which is the non-gating path C3 names, so C3 has a ground truth that does not depend
on section type and stage alone, and including the command-owned references outside the sweep
(`cold-read.md` for `/paper:read`, `consistency-checks.md` for
`/paper:consistency`) on a command-driven case, so a required read is never
scored as a phantom pass. On a scripted multi-turn case the field is a
sequence keyed by agent turn and, inside a `/paper:loop` run, by nested
dispatch (section and command), since the cold read, each section rewrite,
the consistency checks, and the final-polish dispatches load different
command-owned and sweep references and two section rewrites can activate
different content gates; C3 correlates each `References loaded:` line with
its own dispatch's trace boundary and expected set, never with one
case-wide set. The label is tied to the sweep table of the skill ref it was
written against (recorded as `expected_passes_ref`); a run of a different
ref, a historical release in G3 or an ablated variant in E4, uses a label
re-derived for that ref's table, or the C3 reference audit is excluded for
that run and the exclusion reported, never scored against the current
table. Align field names with the skill-creator `evals/evals.json` and
`eval_metadata.json` conventions so its viewer and aggregation script work,
and vendor that contract rather than pointing at it: copy the schema
reference, the aggregation script, and the viewer into `evals/tools/` with
the source commit recorded in a `VENDORED.md`, or pin an exact skill-creator
version in `evals/README.md` with the install path, so a fresh clone can
reproduce a passing report. Done when: `evals/README.md` documents the
schema, the vendored or pinned tooling is in place, and two hand-built cases
validate against a JSON schema file.

### A2. Runner: skill version x model x corpus x repetitions (M)
A Python script that runs a chosen git ref of the skill against every case on a
chosen model, N times, through the agent's headless mode (`claude -p` or the
Agent SDK), and stores each raw output with an explicit run status
(`completed`, or an infrastructure error classified as timeout, rate limit,
authentication, provider error, or crashed CLI, with the exit code and the
provider's error payload), the skill SHA, model id, prompt,
timestamp, wall time, token counts, and the agent's tool trace (every `Read`,
`Grep`, `Glob`, `Edit`, and `Write` call with its path and, for a read, the
line or byte range it returned, so a truncated read of a reference's first
screen is distinguishable from a full one, and every command-execution call
with its command line, the bytes supplied on its standard input (the payload
itself, or its digest and length past a recorded size), exit status, and
captured output, so the F7 audit of
`/paper:verify` can establish that the checker ran on the proposed revision
rather than that the agent produced a plausible report or fed the checker an
empty, truncated, or original-text payload, and a failed execution is visible
in the trace; the nested exit status never changes the run status, since the
checker exits nonzero when it finds a protected-content change (as
`scripts/check-protected.sh` does today) and that exit is the evidence a
`/paper:verify` negative case is graded on, so a run stays `completed`
unless the top-level agent or CLI itself failed, and every subagent dispatch or nested
`/paper:*` invocation with the agent or command name, the dispatched prompt,
the returned result, the subagent's own nested tool events, and the
agent-turn boundary it occurred in, so the F7 loop audit can establish from
the trace that each section pass, checkpoint, and consistency check ran,
rather than from a plan that narrates them), captured from the
streaming JSON output so C3 can check which `references/` files were read
rather than which the model says it read, and so C4 can grade a write. Each
run executes in a disposable worktree holding only the agent-visible inputs
(the manuscript artifacts and the rendered context block or prompt), never
the case definition or grader metadata (`must_flag`, `must_not_change`,
`expected_passes`, `flagged_paragraphs`, `reference_clean`), which stay outside the worktree,
and the agent runs inside a filesystem namespace (a container, mount
namespace, or sandbox) that exposes only the staged worktree and the
allowlisted runtime package in the temporary home, since directory
placement alone would not stop `Read`, `Glob`, or a shell command from
traversing an absolute or parent path into a checkout's `evals/`; the runner
asserts the namespace before each run by reading a canary path outside it
from inside and requiring the read to fail, so an agent with `Glob`,
`Read`, or command execution cannot find the answers, with a complete
snapshot of every file taken immediately before and after each agent turn
(not one pair per run: scripted between-turn file updates from the `turns`
script are applied by the runner outside those pairs, so the C4 per-turn
write checks can attribute every change to the agent turn and permission
state it happened under), because the `paper-reviser` agent
exposes `Edit` and `Write` and a model that applies a revision against the
default no-apply rule would otherwise mutate the fixture for every later
repetition. The skill under test is installed in full from the selected ref,
and from nothing else: the runner exports an allowlisted runtime package from
the ref (`SKILL.md`, `references/`, `examples/`, which `SKILL.md` and the
letter command direct the agent to for worked runs and which the production
installer makes available by linking the checkout, with the corollary that
no corpus case may share its input with an installed example: before each
run the runner compares every case artifact against every file under the
installed `examples/` with the A3 aligner (two file-level scores: the share
of the artifact's sentences the aligner matches to a sentence of the example
above its pinned sentence-similarity cutoff, and the reverse share of the
example's sentences matched into the artifact, so a whole ten-sentence
example embedded in a two-hundred-sentence manuscript is caught by the
reverse share rather than diluted to five percent) and refuses to run a case
whose either score against any example exceeds a recorded threshold or
that contains a contiguous run of matched sentences longer than a recorded
length, since
an agent could otherwise read the expected revision, Diagnosis, and
rationale through the skill path and reproduce them, `.claude/commands/paper/`,
`.claude/agents/`, `install.sh` and the `VERSION` file it reads (without
which the provisioning step below could not run), and the executables the
checker needs under `scripts/`, never `evals/`,
`results/`, or any other directory, since the installer links the whole
checkout into the skill path and an agent with `Read` and `Glob` would
otherwise reach the case definitions and expectations through
`~/.claude/skills/blue-pencil/evals/` however clean the worktree is), points
the agent at a temporary agent home (its config directory, selected through
`HOME` or the agent's config-path override), and runs that package's own
`install.sh --commands` against the temporary home, so the skill link,
command prompts, and `paper-reviser` definition all come from the selected
ref and nothing is inherited from the host's global commands or subagents.
The worktree is never the installer's target: `--init` scaffolds `CLAUDE.md`
and migrates a context block from `CLAUDE.md` or `paper-meta.md` into a new
`AGENTS.md`, which would rewrite the A1 precedence and withheld-context
fixtures before the agent sees them. The runner asserts before the first turn
that every staged worktree file is byte-identical to its rendered form and
that the temporary home contains no path under `evals/` or `results/`, and
it records the install manifest with the SHA of each installed component,
since a run that reads the host's current command files while labeled with
an older skill SHA would corrupt the E4 ablations and the G3 historical
reruns. The trace format is adapter-based: one adapter per agent surface
maps its tool names to the canonical read and write events; for a surface
that reads files through command execution rather than a `Read` tool (the
Codex-style condition in E5), the adapter derives canonical reads from the
filesystem audit that already monitors writes (file-open events under the
installed `references/`, `examples/`, and the worktree, from the same
inotify, fanotify, or syscall-level layer), so every command-mediated access
emits a canonical read event whatever the command's form (`awk`, `dd`, a
shell script, or an executable whose path argument is not recoverable from
the command line), and the command line and captured output serve only to
derive the range (from `cat`, `sed -n`, `head`, `tail`, or an interpreter
one-liner and the output's line count); where a command's range cannot be
derived the audited read is recorded as unranged and the
C3 full-read half is reported not applicable for that run rather than
failed, while the C3 converse check still sees the access, so a valid run is
never scored as a skipped reference because of
the surface's tool API and a hidden read is never invisible to it; and a surface
that receives files by injection (the chat condition in E5) records them as
`injected` provenance for the files handed over up front and canonical
reads for the references it obtains through the E5 request protocol, so the
C3 reference audit runs on it in full. Runs
are resumable and cached, keyed
by a hash of the full case definition (prompt, the bytes and declared role
of every artifact the case lists, not only the path that names them, since
an included section, draft letter, comment file, decision list, or change
log edited in place at the same path would otherwise reuse output produced
from the old bytes while the graders inspect the new, the payload of every
scripted between-turn update, the context block, and the expectations),
the skill SHA, the model id, the runner configuration, the
harness's own commit SHA together with a cache-schema version (so a fix to
prompt rendering, worktree setup, trace adapters, or multi-turn handling
invalidates runs the old code produced), the agent runtime version (the
Claude CLI or Agent SDK release, or the equivalent for another surface) and
the provider's immutable model revision behind any mutable model alias, with
reuse disabled when either cannot be resolved, and the repetition index, so an edited case never reuses output generated for its
older definition. An attempt whose status is an infrastructure error is
retried under a fixed policy (a recorded number of attempts with backoff),
is never cached as a result, and is never handed to A3, so a provider
timeout cannot be counted as a model parse failure; attempts that exhaust
the retries are reported as excluded in A4 with their error class, and a
run with more than a recorded share of excluded attempts is marked
incomplete rather than compared. Support scripted multi-turn cases from the `turns` script in A1: when a case
expects the skill to ask first (the missing-context ask in B6), the runner
plays the scripted messages and file updates in order and records every
turn; for the repeat-round case it seeds the conversation with the stored
`prior_transcript` as history (recorded with `fixture` provenance, never as
an agent turn), stages the author's returned file as the initial worktree
state, and runs the single evaluated turn, so the trace, snapshots, and turn
index match the fixture model B6 and C4 grade against. Done when: a baseline run over
the seed corpus (B2) completes unattended, every output is on disk with its
metadata, and editing a case's text invalidates its cached runs.

### A3. Output parser for the two output contracts (M)
Parse a run's text into structured JSON: Diagnosis header lines and numbered
items, the `Revised text` fenced block, the `Added bridges:` line, the
`Word count:` line, the `References loaded:` list, each `before -> after, why`
change line, and each Author question. Handle the compact quick-pass contract
(`Revised text`, `Top changes`, `Author questions`) and feedback-only runs
(`No rewrite requested.`). Several correct outputs are none of these, and the
parser must classify them as their own result variants rather than as
failures: a clarification question (the single context ask), a
split-and-confirm message listing detected sections (whole manuscript
supplied as one file), a decline with a routing suggestion (a quick pass at
`response to reviewers`, and a `/paper:polish` run at that stage, which the
command file has stop and route to `/paper:rebut` with no `Revised text`
block, so C4 can grade the stop rather than the parser failing it), a
source-quality refusal (pervasive extraction
damage: the output asks for a cleaner source and carries no `Revised text`
block), the letter-assembly output of `/paper:letter` (a full four-section
output whose Change rationale opens with an assembled-letter note and carries
provenance lines instead of a word count and change ledger, per the command
file), the staged plan that `/paper:loop` returns from its Step A (a
numbered plan with exactly the parts the command file lists and no
full-contract sections; C2 applies no contract branch to it and routes it to
the F7 plan predicates), the later orchestration turns of a scripted
`/paper:loop` run (a section checkpoint that relays a dispatched pass's
output and asks the author to resolve its questions or confirm an apply, an
apply acknowledgment that reports the file updated and carries no new
revision, a consistency-check relay, and the completion message that
declares the Step G stop condition with each section's convergence; each is
its own variant, C2 applies no contract branch to the wrapper, and F7's loop
predicates grade the wrapper against the dispatch trace and the plan, so a
valid post-plan turn is never a parse failure; the dispatched result a
checkpoint relays is not exempt: the parser extracts each nested returned
result from the A2 dispatch event and classifies and grades it under the
dispatched command's own variant, with C2 and C3 applied to it, before the
outer wrapper is graded, so a loop that relays a malformed contract, an
unreported bridge, or a dishonest change line and pauses correctly still
fails), the checker report that `/paper:verify` returns
once F3 ships it (the machine-computed report relayed with its `Protected
check:` line and no contract sections, its own variant routed to the F7
verify predicates, so a correct report is never a parse failure), and the feedback-only wrapper (the four sections
with `No rewrite requested.` as the revised text) carrying a Diagnosis in a
command-specific shape: the severity-ranked comment table of
`/paper:triage`, which applies even when reviewer comments arrive without a
manuscript, and the whole-paper diagnoses of `/paper:read` and
`/paper:consistency`. Read each command file under `.claude/commands/paper/`
when building the variant's fixture, taking the file from the runtime
package A2 installed for the run's recorded skill SHA rather than from the
evaluation checkout, so a historical rerun in G3 or a before-and-after run
around an F-task that changes a command's output shape is parsed and graded
against the contract that ref actually carried, as F2 already requires for
the inventory line and the word-count convention, and a packaging change
never reads as a behavioral regression; a case whose command file is absent
from the installed package for that ref (the `/paper:verify` case on the
v3.0.0 baseline in a G3 rerun, or a command a later ref removes) is
reported not applicable for that ref in A4 before any run, never executed
and never counted as a parse failure, so historical comparisons survive
commands being added or removed; the command at that ref, not this
list, is the authority on its shape. Only an output matching no variant is
a graded parse failure, never a crash; an output whose variant is not the
entry of the case's `expected_variants` for the current agent-turn index
(or, on a `/paper:loop` case, is not a transition the A1 allowed-transition
set permits from the previous variant or event, since such a case has no
indexed entry and may reach a checkpoint by any allowed path)
parses, and then fails C2 as an unexpected variant transition before any
contract branch runs. A resource request under the E5 chat protocol, for a
reference or a worked example alike, is not
a result turn: the adapter records it as a read event and the harness's
reply as the supplied file, neither advances the agent-turn index, and the
parser never sees it, so a compliant chat run is graded on its final output
rather than failed on an intermediate request. The parser also ships the sentence aligner, with one canonical pinned
configuration used for every gated result (the algorithm, any embedding
model and its version, the match threshold, and the split and merge policy,
recorded in `evals/README.md`; difflib-based by default, with an alternative
aligner allowed only as a separately recorded experimental configuration
that never feeds a gate), that pairs input and revised sentences and marks
unmatched ones; the
C graders and D4 all use this one aligner, so none of them depends on the
judge. Done when: the parser round-trips every worked-result example in
`examples/` (the files carrying a `## Skill output` section, which excludes
the two context templates `AGENTS.md.template` and `CLAUDE.md.template`,
since a context file matches no result variant and must not be accepted as
one), the raw
outputs from A2, and one fixture per variant above, with zero unhandled
exceptions, and the aligner has fixtures for a split, a merge, a move, and
an unmatched addition and deletion.

### A4. Aggregation and report (S)
Produce `benchmark.json` and `benchmark.md` per iteration with, for every
assertion and configuration, the counts of passed, failed, not-applicable
(the assertion does not apply to that case or variant), excluded (an
audit the plan switches off for that run, such as the reference audit on an
ablated or historical ref or an ambiguous label, and an attempt that
exhausted A2's infrastructure retries, reported with its error class, as A2
specifies), and incomplete (never an attempt-level state: at result level,
the D4 meaning assertion on a run with any inconclusive substantive
addition; at configuration level, a configuration whose share of such runs
crossed D4's coverage gate or whose excluded share of attempts crossed A2's
recorded threshold), and a pass rate whose
denominator is the applicable cases only, so a skipped check is never
counted as a pass or as a failure; incomplete results are listed per
assertion with their reason, reported in the pass rate's denominator as
neither pass nor fail (the rate is shown with and without them), and the E3
decision rule and the G1 slow-tier gate fail a configuration whose
incomplete share of an assertion's applicable cases exceeds the same
recorded threshold, since a rising incomplete share hides regressions as
surely as a falling pass rate shows them; plus mean and standard deviation across
repetitions, time, and tokens,
every one of them reported per model as well as pooled (a regression on one
model must not be cancelled by another model's gain or by an unbalanced run
count),
in the schema `skill-creator/references/schemas.md` expects, plus a per-case
table. Done when: the report renders in the skill-creator viewer and the
Markdown table is readable in a pull request.

---

## B. Corpus `[corpus]`

### B1. Sourcing and licensing policy (S)
Write down what may enter the corpus: arXiv papers whose license permits
redistribution (CC BY, CC0), the maintainers' own papers only when the
maintainer still holds redistribution rights (authorship alone does not
establish that, since copyright or exclusive publication rights may have
passed to a publisher), so such a paper carries either a
redistribution-compatible license or an explicit written grant covering
publication in this corpus, and faculty or
student drafts only under a signed permission note kept alongside the case.
Record source, license, and permission for every artifact of every case in
its metadata, not one triple per case, since a composite case can bundle a
CC-licensed manuscript with confidential reviewer comments, an author
decision file, and a draft letter that each have their own owner and
status; have the A1 schema validate the values per artifact, not only the
presence of the fields: each artifact's license is one of an allowed list,
or its permission field names a grant or note file that exists beside the
case and lists that artifact, so a case-level grant covers only the
artifacts it names. Done
when: `evals/README.md` carries the policy, every artifact of every case has
the three fields, and a case with one artifact under an unlisted license and
no grant naming it fails validation even when its manuscript is CC-licensed.

### B2. Seed corpus v1 (L)
About 30 sections covering: fields (economics, information systems, CS,
statistics, a lab science), section types (abstract, introduction, related
work, methods, results, discussion, conclusion), formats (LaTeX, Markdown with
pandoc citations, pasted plain text), and stages (`first draft`,
`response to reviewers`, `final polish`). Each case carries a hand-written
`must_flag` list of the defects a careful editor should name, and a generated
`must_not_change` inventory. Done when: 30 cases validate against A1, two
maintainers have reviewed each `must_flag` list, and every `expected_passes`
set carries its two independent labels.

### B3. Defect-injected cases (M)
Take clean, well-edited sections and inject one known defect per case so recall
is measurable: an AI tell from `references/ai-tells-to-avoid.md`, a buried lede,
a hedge stack in an abstract, a term used before definition, machinery before
motive, an em-dash, a left-branching preamble, uniform sentence length. Keep
the clean original as the reference, in the grader-only `reference_clean`
field of A1 rather than as an artifact, so A2 keeps it outside the
disposable worktree with the other grader metadata. That field is graded
against, never run, so each injected case also gets a runnable sibling
clean-control case whose editable artifact is the clean original, carrying
`must_not_flag` for the injected class and `may_return_verbatim`, linked to
the injected case by id; C6's negative controls run on those siblings. Done when: each class in the input-prose defect taxonomy has at least three
injected cases, where the taxonomy is the preflight checklist's prose defects
only (tells, buried lede, hedge stack, undefined term before first use,
machinery before motive, em-dash, left-branching preamble, uniform sentence
length, interrupted clause core, nominalisation, missing paragraph payoff,
and the rest of the catalogue in `references/exposition.md` and
`references/sentence-patterns.md`) and is enumerated in `evals/README.md`;
the preflight's output and run invariants (protected content unchanged,
scope respected, bridges reported, gaps in `Author questions`) cannot be
injected into a clean section and are covered by grader fixtures in C1
through C4 instead. The injection is recorded in the case metadata so a
grader can check whether it was found and fixed.

### B4. Protected-content trap cases (M)
Sections dense with the things the skill must not touch, including near-miss
traps the current tripwire is designed to catch: `\citep[see][p. 4]{key}` with
optional arguments, `[-@key]` pandoc forms, `Table 4` next to `Table 5`,
ranges like `5-9%`, `6 points` versus `6 percent`, custom macros with prose
arguments, `\caption{}` text (editable) inside a `figure` (opaque), tabular
line breaks, `%` comment lines, direct quotes with an em-dash inside them,
spelled-out cardinals (`two-stage`). Done when: every extraction class listed
in the header of `scripts/check-protected.sh` has at least two trap cases and
every known limit listed there has one case that documents it.

### B5. Restraint cases (S)
Sections that are already good and should come back verbatim, with the
Diagnosis saying so (the judgment modeled in `examples/restraint-example.md`,
which itself logs one safe mechanical fix, `out of domain` to
`out-of-domain`; B5 cases are chosen to need no fix at all, and each
carries an empty `permitted_fixes` list, while the example carries its one
fix so the C5 predicate can grade both). Include
a "trap" where the prose is good but unusual in voice, to test whether the
skill flattens a distinctive style. Done when: eight cases, each reviewed by
two maintainers who agree no edit is needed.

### B6. Stage and scope edge cases (M)
Cases that exercise the rules in `SKILL.md` most likely to be skipped:
two context-precedence cases, one with `AGENTS.md` and `CLAUDE.md` present
and one with `CLAUDE.md` and `paper-meta.md`, each rendering the A1
`decoy_context` with a different stage into the lower-precedence file, so
the output passes only when the higher-precedence file's stage drives it
and a runner or skill that reads the decoy fails on the stage mismatch;
a response-to-reviewers case of at least eight paragraphs where only
paragraphs 2 and 4 are flagged, so paragraphs 6 through 8 sit outside the
flagged-plus-neighbours window and the byte-identity check in C4 has
something to catch; a quick
pass requested at `response to reviewers` (must decline and route to
`/paper:rebut`); a whole manuscript supplied as one file (must split by heading
and confirm, never rewrite in one shot); a pasted section with no
`<paper_context>` (must ask once, then default to `final polish`); reviewer
comments with no manuscript (triage only, classifications marked unverified);
two PDF-extraction cases, one with repairable localized damage (ligatures, a
page header) where the required behavior is an artifact-only repair, and one
marked pervasive where the required behavior is a no-rewrite refusal, so
each C4 branch has a run to grade; a `style_overrides:` line that permits
em-dashes; and a scripted repeat round for the across-rounds rule in
`SKILL.md` (the current file is the author's decision record): the prior
suggestion is a fixed fixture, not a live first turn (a stored first-round
transcript plus the author's returned file with two of its edits reverted
and one reworded, so every model and repetition is graded against the same
rejected transformations rather than against whatever that run happened to
propose), and the case tests only the follow-up turn, which must leave the
author's wording alone; a `/paper:polish` run with the stage stored as
`response to reviewers`, which must stop and route to `/paper:rebut`; and an
explicit-apply case whose prompt asks the skill to apply the revision to the
editable artifact, so the C4 apply predicate has a real run to grade. Done when: each rule above has one case and a matching grader in C4, or in
C2 for the style-override case that C4 delegates there, and both precedence
cases fail when the runner is pointed at the decoy file.

### B7. Trigger set (S)
Twenty to forty prompts labeled should-trigger and should-not-trigger, following
the "When to use" and "When NOT to use" sections of `SKILL.md`, including the
hard negatives (grant text without an explicit ask, typo list only, BibTeX,
"explain nominalization"). Done when: the set is in `evals/triggers.json` and
the skill-creator description-optimization script runs against it.

---

## C. Deterministic graders `[grader]`

### C1. Standalone protected-content checker (L)
Port the logic of `scripts/check-protected.sh` to a Python tool
(`bp-check original.tex revised.tex`) that anyone can run on any manuscript,
not only on `examples/`. A manuscript is often a wrapper whose
`\input{...}` and `\include{...}` graph carries the sections, as the
`/paper:read`, `/paper:consistency`, and `/paper:loop` command files already
state, so the checker follows that graph from each root, pairs the included
files by path relative to their root, decides pass or fail on the multiset
of the whole graph (the union), reports each file pair's delta as relocation
context rather than as token loss, since the base guarantee does not check
placement and an unchanged sentence moved between two in-scope files leaves
the union intact while the claim-local mode is where a move is flagged, and
reports a file present in one graph and missing from the other as a finding
rather than a clean result; a fixture with identical wrappers and a changed
`sections/results.tex` must fail, since a root-only comparison would report
it clean. Same extraction classes, same multiset diff, a
machine-readable report (which class, which token, added or removed), an
exceptions file for author-approved changes, and an `inventory` subcommand that
emits the `must_not_change` block for A1. An exception names a class, the
old and new token, and the specific occurrence (the sentence or line it sits
in, or an ordinal), and exempts that one occurrence only: the shell script
removes an excepted token from both multisets wherever it appears, so one
approved `5` to `6` correction would hide a second, unapproved `5` to `6`
elsewhere. A duplicate-token fixture (several `5`s and `6`s, one approved
change, one unapproved) must fail. The runner feeds the exceptions derived
from a case's `artifact_repairs` in this same occurrence-scoped form, and a
localized-damage fixture whose declared repair touches a protected class
passes C1 and C4 together while the same fixture with one undeclared token
change fails C1. Unit tests: one test per extraction
class, one per known limit in the shell script's header (documenting the limit
or closing it), with one limit that must be closed rather than documented:
the shell script's restriction of manuscript code fences to `~~~` exists only
because `examples/` uses triple backticks as its outer fixture delimiter,
while the tool reads manuscript files directly, so it parses backtick and
tilde fences of any valid length per CommonMark, and a fixture that changes
the contents or indentation of an ordinary triple-backtick block must fail. The shell script stays until CI switches over (G1).
State the guarantee precisely, in the tool's output and its docs: a multiset
diff proves that no protected token was added, dropped, or changed, not that
every token kept its place in the argument (two coefficients swapped between
claims pass, as the shell script's header already notes). Add a claim-local
mode that aligns sentences (the A3 aligner) and diffs protected
tokens per aligned sentence, reporting a token that moved between sentences as
a finding for the author to confirm. State this mode's limit too: two values
swapped within one sentence leave that sentence's multiset unchanged and pass
it, so the guarantee is cross-sentence, and a same-sentence swap fixture
documents the gap until a clause-level alignment closes it. Done when: the Python tool and the shell
script agree on every file in `examples/`, the tool catches every B4 trap marked catchable and fails each
documented-limit case exactly as its documentation says, and the claim-local
mode catches a seeded coefficient swap that the multiset
mode passes.

### C2. Output-contract grader (M)
Port the checks in `scripts/check-examples.sh` to a grader that runs on parsed
A3 output and applies the checks the parsed variant's contract actually
requires. For the full contract: heading order, `Word count:` shape and,
whenever the reported count grew or the recomputed count grew under the
counting convention that matched the reported counts (on a ref before F2,
C3 accepts either reading of prose inside macro arguments, and the two can
disagree in sign when an `\emph{...}` or `\footnote{...}` expands while
ordinary prose shrinks, so growth is judged under the reading the report
followed rather than under whichever reading happened to grow), the
one-line growth justification `SKILL.md` requires, accepted either on the
same `Word count:` line after the percentage or on the next line, since the
contract text says "on the next line" while every golden example and the
contract's own illustrations write it on the same line, so both layouts
pass on a ref before F2 fixes one and the done-when below (every example
passes) stays reachable,
`References loaded:` present, `Added bridges:` present, each in the position
the contract fixes rather than anywhere in the output (`Added bridges:` on
the next nonblank line after the fenced revised block, since every golden
full-contract example separates the closing fence and the bridge line with
a blank line and the contract's "immediately after" means position, not
the absence of a blank line, and the Change
rationale opening with `Word count:`, then the optional growth line, then
`References loaded:` before any change entry, so a bridge line parked under
`Author questions` or a reference line after the ledger fails as malformed),
every quoted
bridge sentence actually in the revised block and added or changed there
rather than carried over verbatim from the input, and the converse gated on
the justification-cue test: an unmatched sentence in the
revised block (no aligned source in the A3 alignment) or an added hunk inside
an aligned pair (`The instrument is valid.` becoming `The instrument is valid
because assignment was random.` still aligns) is expected on the line
when it carries a justification cue (because, since, ensures, guarantees,
holds, is valid, identifies, is exogenous, and a maintained lexicon); an
unmatched sentence without a cue (a new transition, one half of a permitted
first-draft split) is an ordinary insertion that C3 requires in the change
ledger, and its absence from the line must not fail this check, while a
cue-free sentence the model does report on the line is accepted here (a cue
is never required of a reported sentence, since the true bridges D4
recognizes without one must be reportable) and validated by D4, so a correct
output satisfies both graders. A cue hit is a
candidate, not a verdict: the lexicon over-matches ("Since then, the
literature has expanded" is no bridge). The split keeps C2 deterministic:
in the fast tier C2 emits a `bridge-candidate-unreported` finding for each
lexicon hit missing from the line, which is reported but does not gate, and
the gating assertion lives in the judge tier as a D4 check that classifies
every substantive added sentence and added hunk, not only the lexicon hits
("Random assignment makes treatment independent of potential outcomes"
states why identification holds with no cue word), using the lexicon only to
order the candidates for review, and fails the
output only when the judge confirms the candidate states why an assumption,
identification strategy, or validity claim holds and its aligned input did
not already say so; a candidate the judge
rejects clears the finding. The comparison runs in both directions: a run
that adds a confirmed validity argument and prints `Added bridges: None.`
fails the D4 assertion, and a sentence the model lists on the line must
itself receive a positive verdict, so an ordinary transition or copyedit
reported as a bridge, with its superfluous confirmation question, fails as
a false bridge report rather than passing the self-report audit. No editor label
introduced by the model inside the block, compared through the alignment
rather than by set membership: a label occurrence in the output passes only
when its aligned input sentence carries the same label, so a `[P1]`-style
label the input already carried, for a proposition or a participant, stays
where the author put it, while a further `[P1]` the model added as an edit
annotation elsewhere fails even though the token exists in the input, and
the label multiset of the output equals the input's. Every Author question ends with `?`, no banned tell in any paragraph the stage allowed the model
to edit (a verbatim paragraph with a tell is itself a failure at `first
draft`, `final polish`, and quick pass, since the scrub runs over all
editable text; exempt only text the stage forbids editing, which at
`response to reviewers` means the unflagged paragraphs outside the
neighbour window and, inside a neighbour the stage lets the model touch,
the sentences it left unchanged, so the transition or setup sentence
`/paper:rebut` permits is scanned and a tell or em-dash introduced there
fails even though C4 accepts the edit as in scope; anything a `style_overrides:`
line permits, the inside of a direct quotation, which constraint 7 keeps
verbatim and constraint 9 exempts from the em-dash rule, and every
constraint-5 opaque span the skill keeps verbatim: environments with their
`\caption{...}` text carved out first, since constraint 5 makes caption
prose editable even inside an opaque `figure` and the protected-content
extractor already treats it so, so a tell or em-dash introduced in a
caption fails while the rest of the environment stays exempt, `%`
comment lines, code spans and fences, math, and macro arguments that are
not prose), stage-appropriate Diagnosis headers, and at most seven
numbered Diagnosis items on an ordinary section edit (the cap is lifted for
the whole-paper diagnosis-only passes `SKILL.md` exempts and for the
`/paper:triage` feedback variant, whose command file lifts it so that every
reviewer comment gets a table row). For the
compact contract:
exactly `Revised text`, `Top changes`, `Author questions`, at most three
change bullets, `References loaded:` under `Top changes`, every Author
question ending in `?`, no banned tell in any paragraph (quick pass edits
all of them) with the same exemptions as the full branch (a
`style_overrides:` permission, the inside of a direct quotation, and the
constraint-5 opaque spans), no
Diagnosis, no word count, no `Added bridges:`. For the feedback-only wrapper: every full-contract check that still
applies (the four headings, `Added bridges: None.` immediately after the
`No rewrite requested.` block, `References loaded:`, every Author question
ending in `?`), with only the word-count and change-line checks dropped, and
the Diagnosis shape dispatched to the command-specific grader in F7 rather
than the generic stage-header rule: `/paper:read`, `/paper:consistency`, and
`/paper:triage` carry their own whole-paper or whole-letter deliverables
(reading log, colleague test, comment table) in place of `Voice tics:` and
`Reader map:`, as their command files require. For the letter-assembly variant: the full
contract minus the word-count and ordinary change-line checks, with one
provenance line per reply required instead. For a clarification,
split-and-confirm, decline, or source-quality refusal: only the predicates
C4 names for that case.
Requiring the full contract of every output would fail valid quick passes
and edge cases and distort the baseline. Read the `style_overrides:` line of the case's
`<paper_context>` and disable only the checks it names (the em-dash ban, a
listed phrase), so the override case in B6 passes when the skill honors the
override and fails when it does not. Done when: it passes on all `examples/`
and fails on a hand-broken copy of each, and the override fixture passes with
the override and fails without it.

### C3. Self-report honesty graders (M)
Check what the skill says about its own run against what it did:
- `Word count:` within 15 percent or 10 words of the actual counts, whichever
  is larger (the contract rounds to the nearest 10, so `~10` for 14 words is
  honest), computed under the convention the skill's Length budget section
  already states (exclude citation commands, math environments, and LaTeX
  macros), which is ambiguous about prose arguments, so until F2 writes a
  precise convention into the output contract (a deliverable of F2 below,
  keyed to the skill ref under test, so the dual reading applies to a ref
  that lacks the convention and the single reading to one that carries it)
  the grader computes both
  readings (macro arguments excluded wholesale; command syntax excluded but
  prose arguments such as `\emph{...}`, `\footnote{...}`, `\textbf{...}`,
  and sectioning counted as prose) and accepts a report that matches either
  within tolerance, recording which one matched, so the E1 baseline does not
  grade the model against a convention it was never given, and the signed
  percentage is checked in two steps: its direction first, which must agree
  with the direction of the exact counts under the matched convention, and
  with the direction of the reported counts except where the contract's
  rounding to the nearest ten collapses the exact counts to equal displayed
  counts (`101` to `104` reported as `~100 to ~100 (+3%)` is honest, and so
  is `96` to `104` as `~100 to ~100 (+8%)`, so equal displayed counts are
  accepted whenever the exact before and after counts both fall inside the
  range the shared displayed count represents under the ref's rounding
  granularity, rather than by comparing the delta with the
  rounding half-width, and the sign is then checked against the
  exact direction alone) (the bands alone cannot carry this, since for
  exact counts of 100 and 80 the bands 85 to 115 and 68 to 92 contain the
  rising pair 85 to 92, so an interval built from the bands would admit a
  positive percentage for a shrinking passage), and then its magnitude
  against the range the reported counts themselves imply: each reported
  count stands for the range it represents under the ref's rounding
  granularity: the current contract asks for counts "to the nearest ~10
  words" yet demonstrates `~139 to ~86`, and the examples report `~88 to
  ~123`, so on such a ref a reported `~N` stands for `N` plus or minus
  half the granularity whatever its last digit (`~139` for 134 to 144),
  while on a ref whose F2 convention fixes the bins to multiples of ten the
  bin range applies (`~10` for 5 to 14, `~110` for 105 to 114);
  intersected with the accepted exact-count tolerance band, and the
  percentage is recomputed from every direction-matching before and after
  pair inside those two intersections, with the reported value accepted if
  it falls within the resulting interval, so `~100 to ~110 (+45%)` fails
  (its displayed counts imply at most about +20%) while the tolerance bands
  alone would have admitted it, and the
  percentage check inherits the word-count tolerance in its own units
  rather than borrowing a word count as a percentage. That interval is the
  sole magnitude check: a second comparison against the percentage from the
  exact counts would reject an honest rounded report (`14` to `24` reported
  as `~10 to ~20 (+100%)` is honest under the contract's rounding while the
  exact change is about +71%), while a report whose sign contradicts the
  counts (`~100 to ~80 (+25%)`) fails the direction step.
- `References loaded:` equals the `expected_passes` entry from A1 for the
  agent turn or nested dispatch that produced the line, located by its A2
  trace boundary (the labelers' reading of every sweep gate, content gates included, since
  section type and stage alone cannot tell an applicable `exposition.md` read
  from a phantom one), with no skipped pass and no phantom one, and in the
  order the sweep prescribes: the first complete load of each expected sweep
  reference in the trace follows the sweep-table order of the evaluated
  skill ref, since `SKILL.md` makes the sweep an ordered walk with earlier
  passes outranking later ones, so a run that loads `copyediting.md` before
  `principles.md` fails even when it eventually reads and reports every
  expected file (command-owned references outside the sweep are exempt from
  the ordering, and so are the preloads a command file directs up front,
  read from that command file at the evaluated ref: `exposition.md` for
  `/paper:clarify`, `narrative-spine.md` with `ai-tells-to-avoid.md` for
  `/paper:human`, `copyediting.md` with `ai-tells-to-avoid.md` and
  `sentence-patterns.md` for `/paper:polish`, so the ordering is judged over
  the sweep's own loads after those preloads and a compliant command run is
  not failed for obeying its command file). The contract
  lets the line say briefly that a section gated a pass off, so the parser
  separates entries claimed as loaded from entries annotated as gated off,
  the equality check runs over the loaded entries only, and a gated-off entry
  passes only when its file is absent from `expected_passes` and from the
  trace (a file annotated as gated off that the trace shows read, or that
  `expected_passes` requires, fails). Each loaded
  file appears in the A2 trace as canonical reads of that path whose ranges
  together cover the whole file (a bounded read of the first screen does not
  count), and the converse holds: every reference the trace shows accessed
  (any file under `references/`, by canonical read events or by a
  content-returning `Grep` whose matches came from it, which the A2 adapter
  records with the path and the line ranges of the matched content so a
  search is distinguishable from a complete load) appears on the
  line, so a run that loads or greps a gated-off `narrative-spine.md`, or
  every reference, and omits the access from the line fails as an unreported load
  rather than passing on a report that merely matches `expected_passes`,
  since a hidden extra load is a selection failure and would contaminate
  the E4 and E5 comparisons with guidance the case should not receive; the
  audit is not applicable, and reported as such (A4's not-applicable state),
  never as a pass, only on a surface whose reference contents themselves
  were injected without observable reads (a packaging comparison), while the
  matched E5 chat condition, whose manuscript and command prompt are
  injected but whose references arrive through the request protocol as
  canonical reads, keeps the full audit, since the selection behavior it
  records is what the cross-surface comparison measures. The
  claim alone is what this check exists to distrust: a model that skips a
  reference and prints its name anyway must fail here, not pass. Where two
  labelers disagree on an entry of a case's expected set, that entry is
  tagged ambiguous and this check reports but does not gate on it, while
  every consensus entry and every reference the sweep loads on all passes
  keeps gating, so a dispute over `exposition.md` cannot excuse a skipped
  `principles.md`.
- Every `before -> after` change line describes a real edit: after
  whitespace and markup normalization, the `before` span occurs in the input
  and the `after` span occurs in the revised block (a deletion's `after` may
  be empty or the word `removed`, and an insertion's `before` may be empty
  or a parenthesised position sentinel such as `(opening)`, which the golden
  examples already use, in which case the `after` span must occur in the
  revised block and must not occur in the input, so the sentinel cannot
  disguise a rewording as an insertion; the sentinel vocabulary is recorded
  with the parser and the contract documents it), where a span may use the ellipsis
  notation the repository's own golden examples already use (`"Furthermore
  ... Moreover ... Crucially" -> removed`): an ellipsis-separated span
  matches when its pieces occur in the text in that order within one
  paragraph, each piece verbatim after normalization, and the notation is
  written into the output contract by F2 so the agent and the grader agree;
  the two spans occupy corresponding positions in the A3 sentence
  alignment or the same diff hunk, so an entry stitched from an unrelated
  input span and an unrelated output span fails along with a wholly invented
  one. The converse holds for insertions as for deletions on the full
  contract only: every added hunk inside an aligned pair that is not made
  only of insignificant tokens, every added sentence, and every move the
  canonical alignment identifies (a sentence or paragraph relocated
  unchanged, which produces neither an added hunk nor an added sentence and
  which the first-draft stage permits) maps to a change
  line, an added bridge included, since the `Added bridges:` line
  inventories the sentence and triggers its confirmation but carries none
  of the reader-benefit rationale the contract requires of every
  non-trivial change; the bridge line satisfies only the separate
  bridge-reporting assertion, and a clause inserted without a ledger
  entry fails. The compact contract carries at most three free-form
  `Top changes` bullets and no ledger by design ("Removed the
  throat-clearing opener to surface the claim" is a valid bullet with no
  quoted spans), so on a quick pass the coverage checks do not run and the
  span checks apply only to a bullet that quotes a span; each bullet is
  instead grounded by a judge-tier D4 assertion against the actual diff (does
  the bullet describe a change present in the diff?), with the deterministic
  half limited to the bullet count and the `References loaded:` line, and
  the bullets are not required to be exhaustive. Grounding the bullets does
  not enforce the compact contract's own scope, which forbids adding
  explanatory substance, so a compact output also carries a deterministic
  scope assertion that separates explanatory substance from ordinary
  rewording: every unmatched added sentence fails it, and an added hunk
  inside an aligned pair fails it when it is a pure insertion (no deleted
  counterpart in the pair) that introduces a new clause or a noun phrase
  whose head noun is absent from the whole input section after
  lemmatization, or a replacement whose added side introduces such a clause
  or head noun that its deleted side lacked (so `The design was demonstrably
  and clearly valid` becoming `Random assignment makes the design valid`
  fails for the causal explanation it adds at equal length) or whose
  added side carries at least a recorded number of content words more than
  its deleted side after lemmatization; a pure insertion that repairs a
  referent with a noun the input section already uses (`It increased`
  becoming `The estimate increased`), restores a dropped article or
  connective, or names an antecedent is the copyedit the contract permits
  and passes, so `utilize` becoming `use`, a
  reordered clause, or a shortened phrase passes as the sentence-level
  copyedit the contract permits, while `The instrument is valid.` becoming
  `The instrument is valid because assignment was random.` fails, however
  honestly a bullet describes the insertion and however well the manuscript
  supports it, since the quick pass may not add substance at all; a
  positive and a negative fixture for each of those forms ship with the
  grader.
  Its `why` names a
  mechanism
  from the allowed list; "reads better", "smoother", "more concise" alone
  fail.
- On every variant that revises an original text and carries a change
  ledger (never on the feedback-only
  wrapper, the staged plan, or a refusal, whose revised text is a sentinel
  or absent, never on letter assembly, which builds a new letter from
  supplied decisions and carries provenance lines instead of a ledger, and
  never on the compact contract, which has no `Change rationale` and whose
  own rule above exempts it from coverage checks, so a valid quick pass that
  deletes a phrase is graded by the compact scope assertion rather than
  failed for an entry it has no section to hold): every sentence in the original that does not appear in the
  revision (fuzzy match) is accounted for in `Change rationale` (constraint
  6, no silent
  deletion), and so is every deleted hunk inside an aligned sentence pair
  that carries any token outside the insignificant list, as the insertion
  side already requires (a word-level diff of the pair; a hunk made only of tokens on an explicit
  insignificant list, articles and punctuation, is ignored, so a dropped
  `nationally representative` or `(measured at baseline)` needs a ledger
  entry even though it is neither a clause nor a listed qualifier, while a
  hunk containing a token from a semantic-qualifier lexicon such as `not`,
  `may`, `only`, `some`, `often`, or `approximately` always needs coverage
  whatever its size, since one such word can invert or broaden a claim),
  since a qualifier
  removed from a sentence that still aligns is the silent deletion the
  constraint most often means.
- Every `Added bridges:` sentence has a matching Author question, matched in
  two halves: deterministically when a question quotes the bridge sentence
  or a distinctive span of it (a run of consecutive words of a recorded
  minimum length), and otherwise through the sixth D4 assertion (does this
  question ask the author to confirm this bridge?), so a question that
  confirms the bridge in other words is not a miss and a question that
  reuses its keywords for another purpose is not a match.
Done when: each check has a positive and a negative fixture and runs on A2
output.

### C4. Scope and stage graders (M)
- At `response to reviewers`: paragraphs outside the flagged set and their
  immediate neighbours are byte-identical to the input, and paragraph count,
  boundaries, and order are unchanged for every paragraph that neither
  carries a `structural` marker in `flagged_paragraphs` nor is the flagged
  merge partner of one that does, since the stage permits
  sentence-level work inside the window and forbids reorganising the
  paragraphs reviewers did not complain about; a flagged paragraph whose
  marker records a structural complaint may be split or merged with its
  flagged neighbour (whose boundary the merge necessarily changes, so that
  partner is exempt from the boundary check for that merge alone, while an
  unflagged neighbour never is), and then every sentence of the resulting paragraphs
  aligns into the flagged paragraphs' text (no sentence crosses into or out
  of the unflagged set), so splitting an overloaded paragraph a reviewer
  objected to passes while a reorganisation elsewhere fails. On a `/paper:rebut` run the neighbours
  are stricter still, per the command file: a neighbour may change only in
  its transition or setup sentence, and only when a change line maps that
  edit to a reviewer label whose flagged paragraph is adjacent; any other
  changed sentence in a neighbour fails.
- `/paper:polish` at `response to reviewers`: the output stops, asks the
  author to confirm the round is closed or to use `/paper:rebut`, and carries
  no `Revised text` block, no manuscript sentence differing from the input,
  and no `Edit` or `Write` to the manuscript, as the command file requires;
  B6 carries a fixture for this command-and-stage pair alongside the
  `/paper:quick` one.
- At `final polish`, in quick pass, and on every `/paper:polish` run at
  `final polish` or `first draft` (the command applies final-polish
  constraints at `first draft` too): paragraph count and order unchanged,
  and the alignment covers both directions inside each paragraph: every
  output sentence aligns to a sentence of the corresponding input paragraph,
  and every input sentence aligns to at least one output sentence of the
  same paragraph (so a sentence that migrated from the end of P1 to the
  start of P2 fails, a deleted sentence fails, since
  `references/subtraction.md` limits the stage to phrase-level cuts, and an
  em-dash replaced by two sentences inside one paragraph, which the stage
  permits, passes).
- Quick pass at `response to reviewers`: the output declines and names
  `/paper:rebut`, contains no `Revised text` block and no manuscript
  sentence that differs from the input, and the A2 trace shows no `Edit` or
  `Write` to the manuscript.
- Whole manuscript as one file: the output lists detected sections and asks for
  confirmation, contains no `Revised text` block and no manuscript prose beyond the
  detected section headings (no sentence of the response aligns to a
  manuscript sentence, changed or not, so a rewrite emitted as unlabeled
  prose fails too), and the A2 snapshot shows the manuscript file unchanged
  with no `Edit` or `Write` to it in the trace
  (a one-shot rewrite applied to the worktree and then followed by a
  confirmation question is the violation this case exists to catch).
- Missing `<paper_context>`: exactly one clarifying message, then an
  `Assumed context:` line whose values match the skill's conservative
  fallback for that case: `final polish` as the stage when the scripted reply
  carries no restrictive signal (`response to reviewers` when it carries
  reviewer comments), the skill's default reader model as the audience, and
  venue and thesis marked unknown; a line claiming `first draft`, or an empty
  line, fails.
- Reviewer comments with no manuscript: the output is the feedback-only
  four-section wrapper that `.claude/commands/paper/triage.md` requires, with
  `No rewrite requested.` as the revised text, a Diagnosis that is the
  severity-ranked comment table (every comment in exactly one row) followed
  by the order of work, no prose diagnosis or rewrite of manuscript text, and
  every classification that depends on manuscript content marked unverified.
- PDF-extracted text with extraction damage: the output names the damage,
  the Diagnosis is limited to the extraction artifacts and carries no
  prose-quality finding (the skill forbids diagnosing the author's prose from
  damaged text, so a style or structure item fails),
  and the raw revised block equals the input after the input alone is
  normalized by the case's `artifact_repairs` oracle from A1, the mapping
  of each damaged span to its allowed repaired form (so an output that
  leaves the damage in place fails, an undeclared rewrite fails, and each
  declared artifact is separately asserted absent from the revision) (ligature glyphs to their
  letters, hyphenation across a line break rejoined, a listed page header
  removed, merged-column boundaries), so the damaged sentence is as
  constrained as every other and a rewrite riding along with a ligature fix
  fails. When `damage_mode` is `pervasive` the output asks for a cleaner
  source, contains no `Revised text` block, and the A2 snapshot shows the
  source file unchanged with no `Edit` or `Write` to it in the trace.
- Across rounds (the scripted repeat-round case in B6): in the evaluated
  turn, which follows the stored `prior_transcript` fixture, the
  spans the author reverted or reworded (the diff between the stored
  suggestion and the author's returned file, both fixture data) are not
  moved back toward the
  stored suggestion: for each such span the case records the rejected
  transformation (the before and after wording and what the edit did, such
  as strengthening a verb or deleting a hedge), and the second turn fails
  when it re-proposes that transformation on that span under any wording
  ("shows" rejected as "demonstrates" and reoffered as "establishes" fails);
  the check has a deterministic half in C4, which fails when the rejected
  span's stored-suggestion wording reappears verbatim or the author's wording in
  that span is otherwise changed, and a semantic half in the judge tier,
  a D4 assertion that fails a re-proposal of the recorded transformation
  under new wording, while unrelated text in the same sentence (a new typo,
  a separate request) may still change; the reverted edits are not re-proposed
  in the change lines, and the apparent reversion is noted once in `Author
  questions`.
- Apply permission is evaluated per agent turn, not once from the initial
  prompt: the `turns` script records, for each author message, whether it
  grants an apply and to which artifact, and C4 grades each turn against the
  latest author message before it (a scripted `/paper:loop` run starts with
  no apply permission and may grant one for a section at a later checkpoint,
  so a correct write after that grant passes and a write before it fails).
  On a turn whose latest author message explicitly asked to apply the
  revision (the explicit-apply case in B6, or a confirmed section in the
  loop case): the applied region of the editable artifact equals the
  accepted `Revised text` block exactly, which on a full-contract turn is
  the block in that turn's output and on a loop apply-acknowledgment turn
  (the A3 variant with no new revision) is the block of the revision
  accepted at the preceding checkpoint, the latest full-contract output for
  that section before the grant; the region is the whole file for a
  section-per-file artifact and, for a root whose sections live inline (the
  loop command supports both), the target section's range resolved by its
  heading boundaries from the snapshot taken before the turn, never the
  line range recorded in the plan, which is stale once an earlier section's
  apply changed the line count; every byte outside that range is unchanged,
  every other artifact's snapshot
  is unchanged, the trace shows writes to the editable artifact only, the
  `Change rationale` states the file was updated (on the acknowledgment
  variant, the acknowledgment itself states it), and no `Author questions`
  item touches content inside the applied text (the skill forbids applying
  with such a question open), where "touches" is decided in two halves: a
  question that quotes a span or names a paragraph label is located
  deterministically and fails the apply when the span or paragraph lies
  inside the applied region, and a question with no locatable target is
  routed to the fifth D4 assertion (does this question concern content
  inside the applied text?), so an unrelated question never blocks an apply
  on a keyword match and a vague question about the revised passage cannot
  evade a text matcher.
- On every turn whose latest author message did not explicitly ask to apply
  the revision (the default, per the skill's "Where the revision goes"
  rule): the A2 snapshots taken before and after that turn are identical
  as complete file trees (no manuscript file changed, and no file created,
  renamed, or deleted anywhere in the worktree, so a revision written to a
  new path such as `revised.tex` fails as surely as an edit in place), the
  trace carries no `Edit` or `Write` at all, whatever variant the
  response took, and on a surface with command execution no
  command-execution event wrote to the worktree either, which A2 establishes
  by monitoring filesystem writes while each command runs (an overlay mount
  whose upper layer is inspected after every command, or an inotify or
  syscall-level audit recording every create, write, rename, and unlink),
  not only by snapshotting after the command returns, so a script that
  writes a file and restores or deletes it before exiting is caught as
  surely as one that leaves the change behind (the read-only checker
  invocation of F3 is allowlisted by command but is still monitored, so an
  invocation that wrote would fail); scripted between-turn updates
  from the case's `turns` script (a loop case's author-side file updates;
  the repeat-round case has none, since its returned file is the staged
  initial state) are applied by the runner between snapshots and are
  not the agent's writes, so the check compares around agent turns, never
  the initial state against the final one. This is the general form of the write checks named on the decline,
  split-and-confirm, and refusal cases; an otherwise valid full-contract,
  compact, or feedback-only response that also edited the worktree fails.
- The `style_overrides:` case is owned by C2 (the override-aware tell check),
  not duplicated here.
Done when: every B6 case names the grader that owns it, each named predicate
has a positive and a negative fixture, and the baseline run reports a pass
rate for each.

### C5. Restraint grader (S)
On B5 cases and, in the G1 fast tier, on the restraint example: revised
block identical to the input after applying the case's declared
`permitted_fixes` (exact before-and-after pairs, empty on every B5 case and
the single hyphenation fix on `examples/restraint-example.md`, each of which
must also appear as a change line, so an undeclared fix still fails; the
list lives in trusted fixture metadata, the A1 case file for a corpus case
and a sidecar under `evals/fixtures/examples/` for an example, never in
the output under test, since deriving it from the output's own change
ledger would let a broken copy authorise any edit and pass) and
after normalizing only
insignificant wrapping (soft line breaks and runs of spaces inside a
paragraph, and only the trailing whitespace that cannot affect the input
format: in Markdown a two-space line ending or a backslash before the
newline is a hard break and must be preserved, so only a single trailing
space or tab before an ordinary newline is normalized there), while
preserving paragraph boundaries (a collapsed blank line merges two paragraphs
and must fail) and the entire contents of format-sensitive constructs
(`tabular`, `lstlisting`, code fences, `%` comment lines), which are excluded
from every normalization, spaces and line breaks alike, so a changed code
indentation cannot read as verbatim; `Change rationale` states the
passage was
returned verbatim when `permitted_fixes` is empty, and otherwise states
that it was unchanged apart from the declared fixes, each logged as its own
change line, as the restraint example does for its hyphen fix, so the
anchor is never asked to make a false verbatim claim; and the Diagnosis
affirmatively recommends leaving the
passage unchanged, carrying the `no safe improvement available` line the
skill prescribes for each paragraph (or an equivalent explicit no-edit
recommendation) and naming no defect class from the case's `must_not_flag`,
so a run that returns the input verbatim while its Diagnosis lists problems
is not counted as restraint. Also compute the
"churn rate" on every case: fraction of sentences changed, to track over-editing
across skill versions. Done when: churn is a column in the A4 report.

### C6. Defect recall grader (M)
On every case that carries a `must_flag` list, the B2 seed corpus as well as
the B3 injected cases: did the Diagnosis name each expected defect (matched
by paragraph label and a keyword list per defect class, with a small
polarity-aware matcher so that a negated or absent-marking mention such as
"[P2] has no hedge stack" does not count as a finding; positive and negative
fixtures for the matcher), and, where the
revision was in scope, did it remove the defect without destroying the prose
around it (class-specific check: tell absent, definition now precedes first
use, em-dash gone, and so on, plus, on B3 cases, the injection's recorded
anchor region still aligns into the output and the revision stays
within a similarity threshold of B3's retained clean reference over that
region, where each B3 case records the anchor its class needs (one
sentence for a tell, an em-dash, or an undefined term; a sentence set for
a buried lede, machinery before motive, or uniform sentence length; the
paragraph for a missing payoff, which is an absence with no carrying
sentence), so the anti-deletion safeguard has a defined region for every
class rather than a sentence some classes do not have, with the
metric and cutoff (for example a normalized token-edit ratio against the
clean sentence and its neighbours) written down before the baseline run and
boundary fixtures on both sides of the cutoff, so deleting the sentence
does not count as a fix and the cutoff cannot be tuned
after seeing outputs; and for the undefined-term class an explicit
assertion that the term, or the concept it names, still appears in at least
one substantive use after its definition in the revision, since
"definition precedes first use" is vacuously true once every occurrence is
deleted and dropping one or two term tokens can stay inside the similarity
cutoff, so a revision that removes the term instead of defining it fails the
repair check). B3's
injected defects give recall per class on a known ground truth; B2's
hand-reviewed lists give recall on ordinary prose, which is what E1 reports.
Run negative controls alongside: the clean-control sibling cases B3 derives
from each injected case's original (runnable cases, since the grader-only
`reference_clean` field is never staged for the agent and cannot produce a
Diagnosis) and the B5 restraint cases carry `must_not_flag` for every defect class
they are free of, and a Diagnosis item naming such a class on such a case is
a false positive. Report precision (or the false-positive rate) per class
beside recall, so a model that names every class in every Diagnosis fails
rather than scoring perfect recall. Done when: recall and precision per class
and per corpus appear in the A4 report, a seed case whose expected defects
all go unmentioned fails, and an indiscriminate Diagnosis on a clean control
fails.

---

## D. LLM-as-judge `[judge]`

### D1. Rubrics for what scripts cannot see (M)
Write judge prompts, one per dimension, each returning a score with a quoted
justification: clarity gained for the reader named in the case's `audience`
field (the skill's default reader model when the field is absent, a
specialist or an undergraduate when the case says so, since a fixed
non-specialist judge would penalize terminology a specialist audience
expects), with an explicit `already clear, no edit warranted` outcome that
scores as a success rather than as zero gain, and the dimension marked not
applicable on a B5 case whose C5 restraint predicate passed, so a correct
verbatim return is never scored below an unnecessary rewrite and the
baseline is not biased toward churn); voice preserved
(would the author recognize this as theirs); meaning preserved per aligned
sentence pair (any technical claim strengthened, weakened, or changed);
diagnosis validity (does each numbered item point at a real problem in the
cited paragraph); AI-tell residue not on the banned list; and emphasis and
framing preserved (constraint 8: the same findings headline, the same
limitations acknowledged with the same weight, the same contribution frame),
judged holistically over the whole section, because a reorder of unchanged
sentences can bury a limitation or promote a secondary result while every
protected token and every aligned pair still passes; its calibration set in
D3 includes seeded reorders of that kind. Done when: rubrics
are in `evals/judges/` and each has been run on five examples with results a
maintainer agrees with.

### D2. Blind pairwise protocol (S)
For comparisons, hide what the judge must not know and keep what it must:
for a version-A versus version-B comparison the two candidates are unlabeled
and shown in both orders, and a win counts only when the verdict survives the
swap; for the asymmetric rubrics (meaning preserved, voice preserved, clarity
gained, unsupported addition versus deletion) the source and candidate roles
are always labeled, since swapping them changes the question, and only the
display order and the skill-version identity are randomized. Done when: the
protocol is a function in the harness and position bias is reported per
judge.

### D3. Judge calibration against human labels (M)
Have two people label 40 (original, revised) pairs on the D1 dimensions,
where each labeling record also carries the parsed Diagnosis items with
their paragraph references and the case context, so the diagnosis-validity
dimension has a labelable input (does each numbered item point at a real
problem in the cited paragraph?) rather than a text pair that never shows
the Diagnosis,
measure their agreement with each other first, and adjudicate every
disagreement into one consensus label (recording the pre-adjudication
reliability), so each judge is scored against a single ground truth rather
than against two raters who may disagree. Split the labeled pairs before
anyone looks at judge output: 20 for development, 20 held out and
untouched, with the split stratified so that every D1 dimension has at
least five positive (violation present) and five negative labels in the
held-out half, adding labeled pairs until that holds, since an unstratified
split may leave a dimension such as voice preservation with no violation to
detect and an agreement score that is undefined or vacuous. Compute agreement between each judge and the humans
(Cohen's kappa or Krippendorff's alpha) on the development set; rewrite any
rubric below the agreed threshold against that set only. The threshold is
written into `evals/judges/CALIBRATION.md` before anyone inspects held-out
judge output, so it cannot be set after the fact to clear whatever score the
held-out set produced. A rubric ships only
on its held-out agreement, and a rubric that was rewritten more than twice
needs fresh held-out labels before shipping. Done when: the agreement table
in `evals/judges/CALIBRATION.md` reports development and held-out scores
separately and every shipped rubric clears the threshold on the held-out
set.

### D4. Meaning-preservation judge with sentence alignment (M)
Align original and revised sentences with the A3 aligner. Ask the judge
about every pair whose wording changed (same claim, or not?), about every
sentence the alignment shows moved to a different paragraph or a different
neighbour even when its wording is unchanged (at `first draft` a moved
"This effect is robust" can acquire a new referent, so the judge sees the
sentence in its old and new surroundings and answers whether the claim it
makes changed), and also about
every unmatched sentence, presented with its missing side marked: an added
sentence with no source (possible new substance, constraint 1) and a deleted
sentence with no counterpart (possible dropped qualifier or claim, constraint
6). The unpaired cases are the riskiest and the protected-token and bridge
checks do not cover arbitrary prose claims. Give the judge what it needs to
tell a violation from a legitimate change: the full input section and the
full revised section (so a moved sentence is judged in both contexts), every
other manuscript section the case supplied, and on a letter case every
other authoritative read-only artifact (the reviewer comments, author
decisions, and change log, which A1 lets a draft-letter revision draw on, so
a restored reviewer quotation has retrievable support rather than reading
as inconclusive), or, where that is too long for
the judge's context, retrieved source passages for every unmatched added or
moved sentence and for every substantive added hunk inside an aligned pair
(the hunk notion C2 uses, so a factual clause inserted into an otherwise
aligned sentence is covered), plus, for every changed aligned pair, the old
and new surrounding passages (a recorded window of sentences on each side
in both texts, so a pair beginning `This estimate` is judged with its
antecedent), and for every unmatched deletion the original's surroundings,
since a pair or a deletion judged in isolation produces false violations
and misses on long manuscripts alone, not only for bridges: retrieval runs on each
such sentence's or hunk's content terms (lexical overlap or embedding similarity against every
supplied section) as well as on a bridge's cue words, so a factual sentence
relocated from another section without `because` or another cue is traced
to its source rather than misread as an invention; the outcome of that
search is split in two: a search that completed over every supplied
artifact and found no passage above the retrieval floor is recorded as an
unsupported addition and fails, since an invented sentence is exactly what
finds no support, while `inconclusive` is reserved for a retrieval that did
not complete (an index or embedding failure, a truncated corpus, a timeout)
and so could not have found support that exists, and inconclusive
verdicts are reported separately in A4 and never folded into either side,
and a run with any inconclusive substantive addition is marked incomplete
for the meaning assertion rather than passed, with the additions listed, so
one invented factual sentence beside several supported ones cannot earn a
clean score by retrieving no source; a separate coverage gate on the
configuration (the share of runs marked incomplete this way against a
recorded threshold) decides whether the configuration's meaning results are
usable at all,
the `Added bridges:` line and the matching Author question, and the
`Change rationale` entries (so a deletion the skill logged is judged as
logged, not as silent). A sentence and a blank counterpart alone make the
legitimate-bridge and logged-deletion cases indistinguishable from seeded
violations. Report every pair the judge answers as not the same claim (the verdict, not
the presence of a negation word: a rewording that keeps its negation, such as
"does not differ" becoming "is not different", is the same claim, and a
negation counts against a pair only when the alignment shows it dropped,
introduced without support, or moved so that the claim's polarity changed),
any unsupported addition, and any unaccounted deletion as a constraint
violation with the sentences quoted. The test set carries both kinds of case: seeded violations,
and an equal number of meaning-preserving rewordings, legitimate bridges built
from manuscript material, and deletions logged in the rationale, so a judge
that flags everything cannot pass. The 40 cases are split before any judge output is inspected, under the D3
protocol: 20 for development, where the rubric may be iterated, and 20 held
out and evaluated once after the rubric is frozen. D4 also owns the six
semantic assertions other tasks route to the judge tier, each with its own
input contract, verdict schema, and calibrated fixtures, where the fixture
counts below are the held-out half and an equal development half of the same
composition is built alongside it and split off before any judge output is
inspected, so each rubric is iterated on one half and accepted on the other:
bridge
classification for C2 (input: a candidate span, the aligned input sentence
or deleted side it replaced, and the input section with
the manuscript context the D4 meaning check supplies, never the model's own
`Added bridges:` line, which is the answer under audit and would let the
judge read `None.` as a shortcut and let the calibration fixtures score by
correlating line and label; the harness compares the independent verdict
with the line afterwards; verdict: states newly added justification, meaning
the candidate says why an assumption, identification strategy, or validity
claim holds and its aligned input did not already say so, so a rephrased
existing explanation is not a bridge and the contract's `Added bridges:`
covers newly introduced ones only; fixtures:
ten true bridges, ten cue-word false alarms, and ten rephrasings of an
explanation the input already carried, built without the line), re-proposal detection for
C4 (input: the recorded rejected transformation and the evaluated turn's span;
verdict: re-proposed or not; fixtures: ten re-proposals under new wording
and ten unrelated legitimate edits), and provenance grounding for F2's
letter assembly and for the draft-letter rewrite alike (input: a reply and
the decision, change-log entry, and manuscript location its provenance line
or claim names, with each supplied artifact labeled by role; verdict:
supported or not, where the roles bound what each artifact can support, so
reviewer comments support a restored quotation, author decisions support
the author's stated position, and a claimed manuscript change is supported
only by the supplied manuscript itself or by routing to `Author questions`,
never by the change log alone, since "we added a robustness analysis" must
resolve to a real manuscript location as the command file requires;
fixtures: ten grounded replies and ten invented or
misstated claims, including a change claim the change log asserts but the
manuscript lacks), and F7's draft-rewrite case runs this assertion beside
the full contract, and compact-bullet grounding for C3 (input: one
`Top changes` bullet and the A3 alignment diff between the input and the
revised block; verdict: the bullet describes a change present in the diff
or not, where a bullet that quotes a span must match that span and a
free-form bullet must name a change the diff shows; fixtures: ten grounded
bullets and ten bullets that claim a change the diff does not contain or
misdescribe one it does), and open-question scope for C4's apply check
(input: one `Author questions` item with no quoted span or paragraph label,
the applied text, and the rest of the revised section; verdict: the question
concerns content inside the applied text or not; fixtures: ten questions
about the applied passage in indirect wording and ten about other
paragraphs, the manuscript as a whole, or the author's intent), and bridge
confirmation for C3 (input: one `Added bridges:` sentence and one Author
question that quotes no span of it; verdict: the question asks the author to
confirm that bridge or not; fixtures: ten confirmations in other words and
ten questions that share the bridge's keywords but ask something else). Done when: on the held-out 20 (10 violations, 10
legitimate changes) the frozen meaning rubric misses at most one violation
and flags at most one legitimate change, each of the six additional
assertions clears the same miss and false-flag bounds on its own held-out
fixtures, and all rates are recorded with the rubrics alongside the
development-set rates.

---

## E. Baseline and analysis `[analysis]`

### E1. Baseline benchmark for the current release (M)
Run v3.0.0 on the full corpus, two or three models, five repetitions each,
where "v3.0.0" is an immutable Git ref: the repository's tags stop at the
1.x series while `VERSION` reads 3.0.0, so before this task runs the
maintainers cut a `v3.0.0` tag on the commit that set that version (or
`evals/README.md` records that commit's SHA as the baseline ref), and A2
and G3 resolve the baseline by that tag or SHA, never by the version file's
content. Run
every grader from C and every judge from D whose assertion applies to the
parsed variant: the rewrite dimensions (clarity gain, voice preservation,
sentence-aligned meaning) are reported not applicable on a feedback-only
output, a staged plan, a refusal, a checker report, and letter assembly,
none of which carries an original-to-revision pair, so a correct
`/paper:read` or `/paper:triage` run is never scored as a total deletion,
with the applicability of each judge keyed per variant in A4. Publish
`results/<version>/benchmark.md`. Done when: the report is committed and the
top ten failing assertions are listed with example outputs.

### E2. Failure taxonomy (M)
Cluster every failure from E1 by constraint violated, pass skipped, stage,
section type, format, and model. Write `results/<version>/FAILURES.md` with
one paragraph per cluster, an example, and a hypothesis about which instruction
in `SKILL.md` or `references/` is not doing its job. Done when: each cluster has
a linked F-task or an explicit "won't fix" with a reason.

### E3. Repetition and variance study (S)
Ten repetitions on a stratified case set chosen so that every assertion G1
will gate has at least three applicable cases (B6 alone defines more than
ten distinct scenarios, so the set is larger than ten where coverage needs
it); an assertion with fewer applicable cases is marked ungated, excluded
from the no-regression claim, and listed as such in the report. How stable
are the Diagnosis items, the revised
text, and the grader outcomes? Do not drop cases whose pass/fail flips across
repetitions: that instability is one of the behaviors under study, and a drop
from five passes in ten to one in ten is a regression the gate must see. Gate
instead on the pass-rate delta between skill versions with an uncertainty
bound that respects the clustering: the same cases are repeated and
compared across versions, so repetitions are not independent trials, and
the interval must be a paired, case-clustered one (a paired bootstrap that
resamples cases and then repetitions within each case, or a hierarchical
model with a case effect); an ordinary Newcombe, Wald, or Wilson interval
treats the repetitions as independent and understates the uncertainty, so
none of them is an allowed implementation. Fix the decision rule before the
first gated run and record it with the results: the confidence level (95
percent unless the maintainers set another before any run), the regression
margin per assertion, and the rule that an assertion fails when the upper
bound of the interval on the drop exceeds the margin, so two implementations
reach the same verdict on the same delta. Tag
high-variance cases in their metadata so a reader can see them (a stable
tag only: measured pass rates and intervals live in result artifacts keyed
by skill ref, model, and runner configuration, never in the case file, since
they change across exactly those dimensions and writing them into the case
would change its A2 cache key). Done when: a variance table is in the E1
report, every case has its pass rate and interval in the results for each
configuration it ran under, and the regression gate in G1 uses the interval
rule.

### E4. Instruction ablation (L)
`SKILL.md` is about 65 KB and the references add more. Ablate one section or
one reference at a time (the preflight checklist, the sweep table, a single
pass, the read-cold pass) and rerun the corpus. Ablating a reference means
emptying its instructional content while leaving a resolvable file with the
same name in place, so the sweep's binding "load this file" instructions
still succeed and the measured effect is the guidance's, not a missing
dependency's; a condition that instead removes the file must also remove
every loading gate that names it, consistently, and is reported as a separate
condition. Which instructions change
measured behavior, and which are inert? An ablation that removes a loading gate or a pass changes what the sweep
should load, so each experimental variant carries its own `expected_passes`
derivation (or the C3 reference audit is excluded for that variant and the
exclusion reported), otherwise the intended treatment is scored as a skipped
pass. An ablation measures nothing unless the corpus exercises the block:
each ablated block needs at least one case in the run whose `expected_passes`
or scenario activates it, and a block with no activating case is reported as
unmeasured, never as inert. Done when: an ablation table lists each removed
block with its activating cases and its effect on pass rate, churn, and
judge scores, or marks it unmeasured.

### E5. Cross-agent comparison (M)
Run the same corpus through at least two agents that read the skill (Claude
Code and one other, for example Codex) and one chat surface. Give every
surface the same inputs: the chat condition gets `SKILL.md`, on-demand
access to `references/` through a request protocol (the harness supplies a
reference only when the model names it in a request turn, records that as a
canonical read with the file's full range, and never injects the whole set
or a bundle selected from `expected_passes`, since the first would prime
the model with gated-off guidance before any selection and the second would
tell it which passes apply, and either difference could be mistaken for a
surface effect), the files under `examples/` through the same request
protocol (since `SKILL.md` and the letter command direct agents to the
worked examples and A2 installs them for the agent conditions), together
with a listing request that returns the manifest of `examples/` and
`references/` filenames the agent conditions can `Glob`, recorded as a glob
event, while contents stay on demand, so the chat condition can discover
the same inputs the agents can inspect, the
`paper-reviser` wrapper's rules from `.claude/agents/paper-reviser.md`
prepended to the prompt whenever the agent condition it is matched against
runs under that wrapper, and, for a command-driven case, the
applicable `.claude/commands/paper/*.md` prompt (the decline, table, and
routing rules of `/paper:quick` and `/paper:triage` live there), not
`SKILL.md` alone, since the passes
depend on those files and a divergence caused by a missing input says nothing
about instruction compliance. The same holds for an agent surface without
native resolution of the command files (`install.sh --commands` registers
them under `.claude/`, which Claude Code reads and a second agent such as
Codex does not), so on such a surface the runner expands a `/paper:*`
invocation by prepending the selected command file's body to the case
prompt, recorded as `injected` provenance for that file, and a surface that
receives the prompt this way is still a matched comparison rather than a
packaging one. Each surface gets an A2 trace adapter that
maps its own tool names to the canonical read and write events, and the chat
condition records the manuscript and command files it received up front as
`injected` provenance and each reference supplied on request as a canonical
read, so the full C3 reference audit runs on it; a chat surface that cannot
run the request protocol and must take every reference in its prompt is
reported as a packaging comparison, never as a matched surface comparison;
every other grader
runs unchanged where its assertion can be observed on that surface: an
assertion that requires a tool event the surface does not expose (the
observed `Edit` or `Write` in the B6 explicit-apply case, the trace half of
the per-turn no-write check, the command-execution and nested-dispatch
audits in F7) is reported not applicable on that surface rather than
failed, the matched comparison covers only the assertions applicable on
every compared surface, and the report lists the excluded assertions per
surface, so the comparison measures behavior rather than
instrumentation. If a surface
cannot take the manuscript and command inputs in full, report that run as a
packaging comparison, separately. Hold the model and inference configuration fixed across surfaces wherever a
surface allows it, since two agents on different underlying models would
confound surface with model; where a surface cannot run the same model,
report its result as a model-plus-surface comparison and attribute nothing
to the surface alone. Where does behavior diverge? Done when: divergences on
matched-model runs are listed with the instruction each agent ignores,
feeding F-tasks, and unmatched runs are reported separately.

---

## F. Skill improvements `[skill]`

Every F-task links the E-cluster that motivates it and reports before/after
numbers in its pull request.

### F1. Fix the top three failure clusters from E2 (L)
One pull request per cluster. Change the fewest words in `SKILL.md` or
`references/` that move the metric, and re-run the full corpus to confirm no
regression elsewhere. Done when: the targeted assertion's pass rate improves
with no other assertion regressing under the E3 decision rule, the same
paired, case-clustered confidence interval, per-assertion margin, and
upper-bound test the G1 gate applies, so a pull request and the gate reach
the same verdict on the same run.

### F2. Replace self-attestation with a machine-checkable self-report (M)
The preflight line "No protected content changed" is the model checking itself
(the header of `scripts/check-protected.sh` calls it the known-weak link). Add a
short `Protected inventory:` line to the Change rationale (and, in the
compact contract, under `Top changes` immediately before `References
loaded:`, since a quick pass has no Change rationale and the compact
contract in `SKILL.md` requires `Top changes` to end with the
`References loaded:` line, which stays the terminator so no parser or
example built on the current contract rejects a correct quick pass) that identifies the protected tokens, not
merely their counts: for the same class set C1 extracts (citations, numbers
and number words, math spans, cross-references and prose callouts, macros,
environments, quotes, comment lines, code), the sorted list of tokens the
model found in the input and in its output, written out, with `none` for an
empty class, and bounded for every class whose tokens can be long
(environments, macros with long arguments, code blocks, direct quotations,
and comment lines): there the line carries the token's name, its first few
words and its last few words, its length in lines or words, and its
occurrence index within the class, rather than its body, since
repeating a `tabular` body or a block quotation twice could exhaust the output budget
and truncate the revision, and since a prefix and a length alone collide
when two quotations or code blocks open alike and run to the same length, so
a change to their later contents would leave the summary unchanged; the
summary is stated as identifying the token's position and extent, not its
body, and the body-level comparison of those classes is the
checker's job (a count alone cannot see
`smith2020` becoming `smith2021` or one number replaced by another). The
number of tokens is bounded too, since a quantitative Results section can
carry hundreds of short numbers, keys, and cross-references: a class with
more than a fixed cap of tokens (recorded in the contract) is written as its
input and output counts plus the list of tokens whose occurrence count
differs between input and output, `none` when the multisets agree, and that
list is itself capped at a recorded length: past it the line carries the
first entries in sorted order plus the total number of differing tokens
(`... and 212 more`), so a revision that changed hundreds of numbers cannot
exhaust the output budget and truncate the revision the line exists to
verify, and the complete delta stays the checker's job; C3 verifies the
counts, the listed entries, and the stated total against C1's
recomputation exactly as it verifies the full list. Nothing
on the line may require computation the editor cannot do: the skill's tool
surface is `Read`, `Edit`, `Grep`, and `Glob`, so no hash or digest, only
tokens the model can list by reading. The author compares the two lists at a
glance, and C1 recomputes both lists from the texts so C3 can verify the
model's line (a listed token missing from the text, or a text token missing
from the list, fails). Where the checker is available (the `/paper:verify`
command and the per-section step in `/paper:loop` from F3), it appends its
own machine-computed `Protected check:` line after the model's, so the author
sees the attested and the verified inventories side by side. F2 also
replaces the ambiguous word-count convention in the Length budget section of
`SKILL.md` with a precise one that says, for each LaTeX construct, whether
its prose argument counts (sectioning titles, `\emph{...}`,
`\textbf{...}`, and `\footnote{...}` named explicitly), states it in the
output contract next to `Word count:`, and gives C3 the single reading to
check on every ref that carries it. Done when: the
line is in both output contracts, all `examples/` with a revision carry it,
the word-count convention is in `SKILL.md` and the C3 grader reads it from
the ref under test,
a compact-output fixture carries it under `Top changes`, a feedback-only
output (revised text `No rewrite requested.`, as in `/paper:triage`,
`/paper:read`, and `/paper:consistency`) carries `Protected inventory: not
applicable (no revision).` and C1 and C3 skip the input-versus-revision
comparison for it; the letter-assembly output of `/paper:letter`, which has
a revised block but no original letter, carries a provenance-based form
instead (`Protected inventory: assembled; tokens drawn from <artifact>` per
class, listing the protected tokens the assembled letter uses and the
supplied artifact each came from, plus a `computed` provenance for editorial
counts and structural labels the assembly itself produces, such as the
`two` in "the reviewers' two main concerns" or a reply's own numbering,
which `SKILL.md` places outside the unverified-substance rule, each stated
with what was counted), and C3 verifies that every protected
token in the assembled letter appears in the named artifact, or, for a
`computed` token, that recomputing the stated count over the supplied
artifacts yields it, rather than
diffing the letter against the input bundle, so a legitimate omission is not
reported as a loss and a verified count is not reported as an invention; and because an invented change claim ("we added a
robustness analysis") carries no protected token, each assembled reply is
also grounded by D4's judge against the decision, change-log entry, and
manuscript location its provenance line names, with an unsupported claim
reported as a violation unless the reply routes it to `Author questions` as
the command file requires, C3 verifies the line against C1's recomputation on every
revising output of a skill ref whose output contract carries the line, and
reports the assertion not applicable on a ref whose contract does not (the
v3.0.0 baseline, historical reruns in G3), as the word-count grader already
does for its ref-specific convention, so the before-and-after comparison
reports the inventory as a capability F2 introduced rather than grading the
baseline against a field it was never asked for; and a fixture with a
swapped citation key fails.

### F3. Ship the checker to authors (M)
Add a `/paper:verify <original> <revised>` command (and a step inside
`/paper:loop` after each section) that runs the C1 checker and reports the diff
before the author applies a revision. Before an apply the revised text exists
only in the agent's response, and C4 forbids creating any file on a no-apply
turn, so the path-based form alone cannot serve the loop: the checker also
accepts the revised text on standard input (`bp-check original.tex -`), the
loop step pipes the proposed `Revised text` block through the
command-execution tool without writing it anywhere in the worktree, and the
command file documents both forms (a path for a revision already on disk,
standard input for one still proposed). The F7 audit of this path compares
the standard-input bytes A2 recorded for the execution with the parsed
`Revised text` block of the revision under check, and the grader reruns the
checker itself on that block and compares the two reports, so a run that
executed the checker on the wrong payload fails even when its relayed report
reads clean. When the loop processes a section
that lives inline in a root manuscript, the proposed text is one section
while the root is the whole paper, so the checker also takes a section
selector for the original (`--range <start>:<end>` by line, or `--section
<heading>`), the loop step passes the section's heading, or a range it
re-derives from the current file at check time, never the line range
recorded in the plan, since an accepted revision to an earlier inline
section shifts every later range and a stale slice would report false
protected-token changes or verify unrelated text, and the comparison runs
against that slice alone; without it every
protected token elsewhere in the paper would read as deleted. The skill's own tool surface is read and
edit only, so registering the command is not enough: the command file must
grant a command-execution tool (or dispatch to a subagent that has one), the
installer must install an invocable entry point for the checker and record its
path, and the command must fall back to a clear message when the entry point
is missing. The entry point lives at a stable path inside the runtime
package (`scripts/`, part of the A2 allowlist) and the command file invokes
it through the installed skill link, so both installer modes carry it:
`--init` for a paper repository and `--commands` for a home, which is the
mode A2 uses to provision every isolated run, and an F7 or loop run that saw
no executable would otherwise fall back to the missing-entry-point message
on every run. Done when: `install.sh --init` and `install.sh --commands`
each register the command and install the entry point, `test-install.sh`
covers both modes, an end-to-end test runs
`/paper:verify` on a fixture pair and gets the checker's report back, a
third end-to-end test runs it inside a temporary home provisioned exactly as
A2 provisions one and gets the report rather than the fallback message, and a
second end-to-end test drives the pre-apply loop path, feeding a proposed
revision through standard input and asserting the report comes back with no
file created in the worktree, once against a section-per-file original and
once against an inline-root original with a section selector, where the
report must be clean for an unchanged section and must not list the rest of
the paper as deleted.

### F4. Right-size the instructions from the ablation (M)
Remove or shorten blocks E4 measured as inert (never a block E4 marked
unmeasured: an instruction the corpus does not exercise is unproven, not
dead, and its removal would be certified non-regressing by the same corpus
that never tested it), and move rarely triggered guidance into
`references/` under progressive disclosure. Removal needs equivalence evidence, not an undetected regression: set a
non-inferiority margin per assertion before the run, and delete a block only
when the confidence bound on the pass-rate delta (the E3 interval rule) stays
inside that margin on every assertion the block's activating cases touch.
Done when: each removed block has its non-inferiority result recorded, the
skill is within the margin on the corpus, and the token count of `SKILL.md`
drops.

### F5. Tune triggering from the trigger set (S)
Split B7 into a tuning set and a held-out set before any tuning (or write a
second, blind set of the same size, labeled by someone who did not see the
first), then use the tuning set with the skill-creator description optimizer
to fix false triggers and misses in the frontmatter `description`. Record
the precision and recall thresholds before the held-out set is run or
inspected, as D3 does for judges, and report precision and recall on the
held-out set only. Done when: held-out precision and recall both clear the
pre-recorded thresholds and are recorded with the split.

### F6. Promote recurring failures to examples and CI anchors (S, recurring)
When an F-task fixes a cluster, add one representative case as a new
`examples/*.md` anchor, written on fresh prose rather than copied from a
corpus case (or retire the corpus case the anchor is drawn from, since A2
refuses to run a case whose input matches an installed example and the
ground rules keep recurring failures in the corpus), and an executable
assertion for the fixed behavior: a
grader in C that runs in the fast CI tier over the stored golden output, or a
case in the slow tier's smoke subset. The existing bash checks guard output
shape, protected-token inventories, and mechanical tells only; a buried lede,
a flattened voice, or an invalid Diagnosis item leaves them green. Done when:
each fixed cluster has an anchor example and a CI assertion that fails on the
pre-fix output and passes on the fixed one.

### F7. Per-command output audit (M)
Every `/paper:*` command promises a specific output shape: the twelve that
exist today plus `/paper:verify` once F3 ships it, so this task depends on F3.
Add one case per command to the corpus and a grader for each shape (triage
table columns, dispatch list in `/paper:read`, mapping in `/paper:rebut`,
staged plan in `/paper:loop`, the checker report in `/paper:verify`). The
`/paper:letter` audit needs two cases, since the command has two input
routings and two output contracts: a draft-rewrite case with an editable
draft letter beside the read-only manuscript, graded under the full
contract, and an assembly case with comments, decisions, a change log, and
the revised manuscript and no draft, graded under the assembly variant, so neither branch can stay
broken while the audit passes. The
`/paper:loop` audit needs two cases: the Step A staged plan, and a scripted
multi-turn case whose `turns` script confirms the plan and drives the loop
through its later phases on a short manuscript of at least three sections
(an abstract, an introduction, and one body section, since the Step E
re-run of both front-matter sections after the body cannot be exercised
with fewer) with the
event-keyed replies and allowed-transition set A1 defines for loop cases
(not a fixed turn sequence, which a conditional `clarify` or `human` pass
or a variable question set would desynchronise), grading that the
sections are dispatched in the planned order, that each section pass stops
at its author checkpoint before the next begins, that the consistency check
runs after the body and again after the second front-matter pass, that no
write happens outside an explicitly confirmed apply, that every mandatory
phase of the command file appears in the dispatch trace before the
completion variant is accepted (the Step B whole-paper cold read before any
section pass, the Step E re-run of the abstract and introduction after the
body, the Step E closing `/paper:read` dispatched after the re-validation
and before any Step F dispatch and returning clean under the Step G terms,
since the command file makes that read the exit criterion, and a Step F
final-polish dispatch for every section not on the Step A
skip list), and that the stop
condition is not declared while a planned section is unprocessed; a loop
that returns a valid plan and then skips sections, checkpoints, or any of
those phases fails. Done
when: every command in `.claude/commands/paper/`, enumerated at run time
rather than hard-coded, has a case and a passing grader on the baseline or an
F-task to fix it.

---

## G. CI and process `[ci]`

### G1. Two-tier CI (M)
Fast tier on every push, no API calls: the existing bash checks, plus every
deterministic grader (C1 through C6) run over `examples/`, over stored golden
outputs, and over each grader's own positive and negative fixtures, so a
regression in word-count honesty, stage scope, restraint, or defect recall
fails on the push that introduces it rather than in the next API-backed run.
The assertions split by what they need: output-only assertions run over
`examples/`, which carry scenario text and rendered output and nothing else;
runtime assertions (the C3 full-read audit of `References loaded:`, the C4
write, snapshot, and per-turn permission checks, the F7 dispatch and
execution audits) run over trace-bearing fixtures, meaning stored golden
runs saved with their A2 trace and snapshots and at least one positive and
one negative hand-built trace fixture per runtime assertion, and over
`examples/` they report not applicable, never pass, so the fast tier
enforces every check it claims to anchor rather than skipping the runtime
half silently.
Slow tier nightly and on demand: the runner on the E3 smoke set (the
stratified set that gives every gated assertion at least three applicable
cases, three repetitions, one model), posting the benchmark delta as a workflow
summary and failing the job when any assertion's pass rate drops against the
stored smoke baseline by more than the E3 decision rule allows (the recorded
confidence level, per-assertion margin, and upper-bound test). The baseline
is a run of the baseline skill ref under the same evaluation stack as the
candidate, keyed by the same identities A2 hashes (the content hash of every
smoke case, not its id alone, the repetition count, the model id and
immutable revision, the runner configuration, the grader and judge versions,
and the harness SHA with its cache-schema version), stored and rerun on the
baseline ref whenever any of them differs, since an edited case, a changed
grader, or a harness update under unchanged workflow arguments would
otherwise attribute the suite's change to the skill; the full E1 baseline
is never the comparator, since its case mix, repetitions, and models differ.
So the no-regression
merge policy in the ground rules is enforced by CI rather than by reading a
summary. Done when: `.github/workflows/ci.yml` runs the fast tier, a new
`evals.yml` runs the slow tier with the API key from repository secrets, and
both are green on `main`.

### G2. Regression policy and pull request template (S)
Add `.github/pull_request_template.md` with a required "Benchmark delta"
section for any change to `SKILL.md`, `references/`, or commands, and a
"Regression case added" checkbox. Document the policy in `CONTRIBUTING.md`.
Done when: the template exists and a maintainer has used it once.

### G3. Results history (S)
Keep `results/<version>/benchmark.md` for every release, together with the
full evaluation configuration (corpus version, grader and judge versions,
model ids, repetition count, harness SHA). Scores are comparable only under an
identical suite and model: a new regression case can lower a later score while
the skill improved, and a model change moves it on its own. Present a trend
only across results with matching suite, model, immutable provider model
revision, agent runtime version, runner configuration, grader, judge-rubric,
and harness identifiers, with comparison disabled when an immutable model
revision was not resolvable for either result (a stricter grader, a
retargeted model alias, or a runtime upgrade would otherwise read as a skill
regression), and otherwise rerun the earlier skill refs under the current
evaluation stack through A2 (cheap, since the runner takes a git ref). Add a one-line summary to each `CHANGELOG.md` entry.
Done when: v3.0.0 and the next release both have results directories with
pinned configurations and a comparable pair of scores.

### G4. Documentation (S)
`evals/README.md`: how to add a case, run the harness, read the report, and
add a grader or judge. Done when: a new contributor sets up and runs the smoke
tier from the README alone.

---

## Dependencies and suggested order

```
A1 -> A3 aligner (the canonical pinned sentence aligner, split out first,
since A2's example-leak check needs it before any run) -> A2 -> A3 parser
(whose done-when consumes A2's raw outputs) -> A4
B1 -> B2, B3, B4, B5, B6, B7
C1 extraction core (needs A1, B4) ; C1 claim-local mode (needs A3) -> F2, F3 ; F3 -> F7
G1 (needs A2, C1 through C6, E3 for the interval rule and a stored baseline,
and F7, hence F3, for the dispatch and execution audits and their
trace-bearing fixtures that its fast tier runs; a G1 landed before F7
ships only the C1 through C6 assertions and is labeled partial, never
complete, until the F7 audits are wired in)
C2, C3 (need A3) ; C4 (needs A3, B6) ; C5 (needs A3, B5) ; C6 (needs A3, B3)
(the sentence aligner is part of A3, so no C grader waits on D4 for its
deterministic verdict; the semantic halves of the bridge and across-rounds
checks are D4 assertions in the judge tier, not C-grader dependencies)
D1 (needs A3 for the aligned-pair rubric) -> D2 -> D3 ; D4 (needs A3, and D3 for the held-out protocol)
E1 (needs A4, B2 through B6, C1 through C6, D1 through D4) -> E2, E3 -> F1, F6
E4, E5 (need E1) -> F4
B7 -> F5
G2, G4 anytime after A4 ; G3 (needs E1 for the first results directory and
the next release's benchmark for the second)
```

Suggested order: first month A1, B1, and B4 first, then the C1 extraction
core (which needs B4's traps as its fixtures) alongside B2's prose, with
B2's protected inventories generated once the extraction core lands so B2
can meet its done-when inside the month; second month B3, B5, B6, the A3
aligner, then A2, then the A3 parser,
then C1's claim-local mode and C2 through
C6; third month D1 through D4 and E1. A partial run on B2 alone is useful for
debugging the harness, but it is labeled partial and never reported as the E1
baseline. Nothing in F starts before E1 produces numbers.

## Status

Track status here or mirror each task into a GitHub issue with the label in
brackets. Mark a task done only when its "done when" line is true.

- [ ] A1 - [ ] A2 - [ ] A3 - [ ] A4
- [ ] B1 - [ ] B2 - [ ] B3 - [ ] B4 - [ ] B5 - [ ] B6 - [ ] B7
- [ ] C1 - [ ] C2 - [ ] C3 - [ ] C4 - [ ] C5 - [ ] C6
- [ ] D1 - [ ] D2 - [ ] D3 - [ ] D4
- [ ] E1 - [ ] E2 - [ ] E3 - [ ] E4 - [ ] E5
- [ ] F1 - [ ] F2 - [ ] F3 - [ ] F4 - [ ] F5 - [ ] F6 - [ ] F7
- [ ] G1 - [ ] G2 - [ ] G3 - [ ] G4
