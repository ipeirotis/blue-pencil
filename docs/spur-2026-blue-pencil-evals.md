# SPUR project posting: Evaluating and Hardening an AI Academic Editor

Draft of the Stern Program for Undergraduate Research (SPUR) posting for the
2026-27 academic year. Field labels follow the SPUR submission form. The
previous year's posting (RS000806, Academic Wikidata) is the format reference.

---

**Research Title:** Trust, but Verify: Building an Evaluation Suite for an AI Academic Editor

**Description:**

Blue Pencil (github.com/ipeirotis/blue-pencil) is an open-source "skill" that
turns an AI coding agent (Claude Code, Codex, and similar) into an academic
copy editor. Point it at a section of a paper and it diagnoses what is weak,
rewrites the prose, and logs every change with a reason, while promising never
to silently alter citations, numbers, equations, or the author's voice. It is
used by faculty and PhD students to revise papers before submission.

Today those promises are mostly enforced by the instructions themselves: the
skill asks the model to check its own work, and the repository verifies only a
handful of hand-written example runs with shell scripts. We do not know, with
numbers, how often the editor changes a citation, drifts a reported result,
flattens an author's voice, or "improves" a passage that was already fine. We
want to achieve three goals:

* Build an evaluation suite for the skill. Assemble a corpus of paper sections
  (LaTeX and plain text, several fields, several revision stages) with known
  defects and known protected content, and write graders that score every run:
  deterministic checks for protected content (citation keys, numbers, math,
  cross-references), format checks for the output contract, and LLM-as-judge
  rubrics for the things a script cannot measure (clarity gained, voice
  preserved, AI tells removed). Run the suite across models and across
  versions of the skill, with enough repetitions to report variance, not just a
  single score.

* Make the skill more verifiable. Move guarantees from "the model says it
  checked" to "a program checked." The main deliverable here is a
  reference-implementation checker that diffs protected content between the
  input and the revised text of any run, so an author gets a mechanical list
  of every citation, number, equation, and cross-reference that was added,
  dropped, or changed, instead of reading both versions side by side. The
  check states what it cannot see (a token that kept its value but moved
  between claims) and a sentence-aligned mode covers that case. This
  generalizes the existing CI tripwire from a handful of examples to
  arbitrary manuscripts.

* Make the skill better, guided by the numbers. Use the eval results to find
  where the instructions fail (which passes are skipped, which constraints are
  violated, on which kinds of input) and revise SKILL.md and its reference
  files to fix them, then re-run the suite to show the fix held and nothing
  regressed. Every change to the skill ships with a before/after measurement.

The project sits at the intersection of software engineering, LLM evaluation,
and academic writing. Students will learn how to design evals that resist
gaming, how to measure an LLM system's behavior with statistical care, and how
to ship those measurements as CI checks in a real open-source project used by
researchers. Contributions are public and attributed on GitHub.

**Requires an in-person component:** Yes

**Pre-requisites:** Working knowledge of Python and the command line (bash,
git) is crucial. Comfort reading and writing LaTeX is helpful. Prior experience
calling LLM APIs (Anthropic, OpenAI) is a plus but can be learned in the first
two weeks. An interest in how research papers are written and reviewed matters
more than any particular course.

**Start Semester:** Fall 2026

**Credits Per Semester:** 0.0

**Briefly describe for the student applicants how the supervised instructional
time will be met:** This 10 week SPUR project will be meeting every week for
less than 1.5 hours, either in person or over Zoom, to review eval results,
decide which failures to chase, and plan the next round of changes to the
skill. I expect the student to spend at least 3 hours a week building the
corpus and graders, running experiments, and opening pull requests against the
public repository.

**Faculty Member:** Panos Ipeirotis (pi1@stern.nyu.edu)

**Department Affiliation:** TOPS

**Contact:** Panos Ipeirotis (pi1@stern.nyu.edu)

---

## Notes for the faculty side (not part of the posting)

The task-level backlog with acceptance criteria is in `TASKS.md` at the repo
root. Suggested 10 week arc, one row per meeting:

| Week | Milestone |
|------|-----------|
| 1 | Install the skill, run it on two of the student's own or public papers, read `SKILL.md` and `scripts/check-protected.sh`. |
| 2 | Corpus design: which fields, stages, and defect types; how many sections; how to source them (arXiv LaTeX, permission-cleared drafts). |
| 3 | Corpus v1 (about 30 sections) with per-section ground truth: protected-content inventory plus a hand-written list of the defects an editor should catch. |
| 4 | Deterministic graders: protected content diff and output-format contract, as a Python package with tests. |
| 5 | Harness: run any skill version against the corpus on a chosen model, N repetitions, store raw outputs and grader results. First baseline numbers. |
| 6 | LLM-as-judge rubrics for clarity, voice, and AI tells; calibrate against a small set of human-labelled pairs. |
| 7 | Failure analysis of the baseline: cluster violations by input type and by skill pass. Pick the top three to fix. |
| 8 | Skill revisions with before/after runs; open pull requests. |
| 9 | Second failure round, plus the standalone `check-protected` command an author can run on their own manuscript. |
| 10 | Write-up: eval methodology, results tables with variance, and what changed in the skill. Wire the fast graders into CI. |

Things to decide before posting: whether the corpus can include Stern faculty
drafts under a permission agreement, or stays with public arXiv sources only;
and which model API budget the runs draw on.
