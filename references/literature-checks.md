# Literature checks: verifying citations and scanning novelty

Load this for the scholar lane's retrieval pass: when the user asks whether a
cited work actually says what the manuscript claims, whether a stated
contribution is genuinely novel, or which source settles an uncited "it is
well known that" claim, or when a `/paper:scholar` dispatch names it.

**Gate condition.** This pass runs only when the environment grants literature
retrieval, a tool that fetches and reads the actual source text (web fetch and
web search, or an equivalent retrieval surface). When retrieval is missing, do
not fake the pass: say so, assert nothing about what any source contains, and
route the question to `Author questions` with a note that literature access
would settle it. That degraded answer is the editor lane's existing behavior,
and it is correct: without retrieval a citation check is memory, and a
memory-cited source is fabrication.

This pass verifies citations and reports novelty leads; it never rewrites the
manuscript's claims on its own conclusion. Its two capabilities ship in one
order, citation verification before novelty scan, because a novelty claim can
only be judged against sources you have actually read.

## Where this lane sits under the master rule

The skill's master rule (never assert unverified substance) has a retrieval
branch: a citation is verified when you retrieved and read the source in this
session, with the passage that supports the use quoted. This lane is that
branch, and nothing else. The only sources it may assert anything about are the
ones it fetched and read in front of you; a citation you recall, a venue or year
you remember, or a "prior work exists" claim from model knowledge is unverified
substance, exactly as it is for the editor. A citation from memory is treated as
fabricated.

## The protocol

Run the steps in order. Do not reorder them: the claim inventory is pinned
before the first search, which is what keeps the search a verification instead
of a hunt for a convenient result.

### 1. Inventory the claims to check

Before any search or fetch, list every claim in the requested scope with its
location, split into two groups:

- **Cited claims**: each sentence that attributes a finding, method, or fact to
  a source ("X et al. show Y", "following the approach of Z"), with its citation
  key and the exact wording of what the manuscript says the source supports.
- **Contribution and novelty claims**: each sentence that asserts the paper is
  first, novel, or unlike prior work ("we are the first to", "no prior work
  addresses"), and each uncited "it is well known that" or "prior work has
  shown" claim that names no source.

The inventory must be complete before you fetch a single source, so what you
read can never reshape which claims get checked. Do not add claims to the list
because a search surfaced them, and do not drop a claim because verifying it
looks hard: an unverifiable claim is a reported outcome, not a skipped one.

### 2. Verify each citation

For every cited claim, retrieve and read the actual source (fetch the paper, its
abstract, or the specific section that would carry the claim). Judge whether the
source supports the sentence as written, and classify each as one of:

- **supported**: the source states what the manuscript attributes to it; quote
  the passage that supports it
- **unsupported**: the source does not say this, says something weaker, or says
  the opposite; quote what it does say and describe the gap
- **unverifiable**: the source could not be retrieved (paywalled, not found,
  ambiguous key), or the passage that would settle it was not reachable; say why

Retrieved, not remembered: cite only sources you fetched and read in this
session, with title, venue, year, and the supporting passage. Never fill a gap
from what you recall a paper says.

### 3. Scan novelty and fill gaps

For each contribution or novelty claim, search for prior or overlapping work and
report leads, not verdicts. A lead names the candidate work and points the
author at what to read ("Doe (2023) appears to address the same problem in a
different setting; read sections 3-4"); it never concludes that the paper is or
is not novel. For an uncited "well known" claim, search for the source that
would support it and offer it as a candidate citation with the passage attached.
When a search returns nothing on point, say so: absence of a found overlap is a
lead too, and it is not proof the claim is novel.

### 4. Report

Return the four-section output per the reporting conventions below. Proposed
citation additions and recalibrated claims, where you have them, go in `Revised
text` as clearly marked candidate edits with their retrieved source attached;
the author decides what enters the paper.

## Integrity norms

- **Retrieved, not remembered.** Every source you report on was fetched and read
  in this session, with title, venue, year, and the specific passage that bears
  on the use. A citation from model memory is treated as fabricated, and a
  novelty judgment from model knowledge is not a finding.
- **Leads, not verdicts.** A novelty scan returns candidates for the author to
  judge ("X (2023) appears to do Y; read sections 3-4"), never a ruling on the
  paper's contribution. Never rewrite the manuscript's novelty claim on your own
  conclusion: propose the recalibrated claim and cite the evidence, and let the
  author decide whether the overlap is real.
- **Additions are flagged.** A new or changed citation enters the text only as a
  proposed edit with the retrieved source attached, honoring the existing rule
  that citation changes are the author's decision. Never silently insert a key or
  alter an existing one.
- **A recalibrated claim changes the paper.** When the author accepts a novelty
  correction or a new citation, the same claim may echo in the abstract,
  introduction, and discussion: recommend `/paper:consistency` over the whole
  paper after the corrections land, and say so in the report.

## Reporting conventions

- Return the skill's strict four-section output. Where you propose no edit, the
  `Revised text` block reads `No edit proposed.`; where you do, it carries the
  candidate citation additions and recalibrated claims, each marked as a
  proposal with its retrieved source (title, venue, year, passage), and nothing
  woven silently into an existing sentence. `Change rationale` carries the
  retrieval log (each source fetched, with title, venue, year, and the passage
  read) instead of change lines, with no word-count line.
- The Diagnosis carries the findings, grouped citation verification first
  (supported, then unsupported, then unverifiable), then novelty leads. Every
  row names its manuscript location; unsupported rows quote what the source
  actually says; novelty rows name the candidate work and what to read. The
  seven-item Diagnosis cap does not apply: this is a whole-scope
  diagnosis-primary pass, and exhaustiveness is its value.
- `Author questions` carries one item per unsupported citation (does the source
  support this, or should the claim change?), per unverifiable source (which
  work does this key point to?), and per novelty lead the author must judge (does
  this prior work overlap enough to recalibrate the claim?). Every item ends with
  a question mark.
