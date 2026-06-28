# Narrative spine

Load this file on a first-draft or whole-section pass, when the user asks to
make a paper tell a story, read like a human wrote it, sound less AI-generated,
or feel more compelling, and whenever the reader-pleasure pass diagnoses airless
prose or list rhythm. It runs alongside `references/reader-pleasure.md`:
reader-pleasure manages local momentum within a paragraph, this file manages the
global through-line across a section. It never outranks the hard constraints in
`SKILL.md`. Any narrative move that needs material the author did not write is an
`Author questions` item, not an edit.

## The cure for LLM-flat prose is spine, not story

LLM prose reads as machine-written less because of any single word than because
it has no through-line. It enumerates true statements, weights them equally, and
announces that they matter. A human author carries one question through the
section: a setup, a tension, a turn, and a payoff. The fix for "this reads like
an LLM wrote it" is to restore that spine.

The fix is structural, not decorative. The instruction "tell a story" tempts a
writer toward hooks, scene-setting, journeys, and dramatized data. Those are
themselves AI tells (`references/ai-tells-to-avoid.md`, "Storytelling tells"),
and adding them makes prose more LLM-like, not less. Add the structure below.
Never add the decoration.

## The ABT spine (And, But, Therefore)

Randy Olson's compression: a section reduces to one sentence of the form
"[setup] and [setup], BUT [tension], THEREFORE [response]." The two ways it
fails name the two ways prose dies.

- **AAA** ("and, and, and"): a flat list of correct statements with no tension.
  This is the LLM default and the most common reason a technically clean paper
  feels machine-written. The tell is a paragraph of equally weighted findings
  ("First... Second... Third...") with no *but*.
- **DHY** ("despite, however, yet"): too many competing tensions stacked up, so
  the reader cannot find the spine.

Edit move: write the section's ABT in one sentence. If there is no *but*, the
section is a list; find the real tension already in the text (a gap, a surprise,
a result that defies the obvious expectation) and build the paragraph around it.
If there are three *buts*, cut to the load-bearing one.

Before (AAA): "We introduce M. M uses components A and B. We evaluate M on
benchmarks X and Y. M improves accuracy by 4 points."

After (ABT): "The standard solution needs component C, which is expensive to run.
M drops C and still matches the baseline within 4 points, so the cost the field
has been paying for C buys little." (The numerical claim stays the author's to
set; see `SKILL.md` constraint 6.)

## OCAR: the arc of the whole

Joshua Schimel's macro-structure: **O**pening (the stable situation and who
cares), **C**hallenge (the gap or tension), **A**ction (what you did),
**R**esolution (what it means). Most LLM-drafted papers are all Action: method,
then results, with no Opening that creates a gap and no Resolution that closes
it. For shorter units use LD (lead, then develop) or LDR (lead, develop,
resolve). Diagnose each section by its arc; a section that is pure Action, with
no Challenge, is where reader attention dies.

## The knowledge gap is the engine

A reader keeps going to close a gap the writer opened. Open by creating the gap,
the question the reader now wants answered, not by announcing the topic ("This
section describes..."). This is the puzzle-first opening of
`references/edit-checks.md`, stated as a narrative requirement. The size of the
gap sets the stakes, so do not open a gap wider than the paper closes.

## Characters and agency

Prose comes alive when sentences have characters performing actions (Williams,
Pinker; see `references/principles.md`). In a paper the characters are the
phenomenon, the method, the data, and the rival explanations. Put them in the
subject slot with active verbs. "The model forgets rare classes" carries more
than "A degradation in performance on rare classes was observed." This is
narrative through concrete agency, not through anthropomorphizing the data into
cuteness; "the data tells a story" is banned.

## Protect the turn

The most valuable narrative element is the turn: the *but*, the surprise, the
result that complicates the easy expectation. The LLM reflex is to smooth it into
a bland generality; the editor's job is the opposite, to surface it and place it
where the reader pauses (the stress position). This is the "useful surprise" of
`references/reader-pleasure.md`, raised to a structural duty.

## Show the stakes; do not announce them

A story makes the reader feel the stakes through consequence. It never says "this
result is important" or "directly useful." Narrative discipline and the anti-hype
rule are the same rule seen from two sides: replace "this is directly useful for
X" with the concrete thing it now lets X do. Announced significance is both an AI
tell and a failure of story.

## Exemplars and transferable techniques

Borrow the move, not the mannerism.

| Exemplar | Transferable technique | What to check in a flat paper |
|---|---|---|
| Olson (ABT) | Compress the section to one and / but / therefore sentence. | Is there a *but*, or only a list of *ands*? |
| Schimel (OCAR) | Give the whole an Opening, Challenge, Action, Resolution. | Is the section all Action, with no Challenge or Resolution? |
| Akerlof, Coase | Open on a puzzle or a market failure the reader can feel. | Does paragraph one open a gap or only name a topic? |
| Schelling, Hirschman | Let a concrete case carry the abstraction, then mark where it stops. | Does the example do argumentative work or just illustrate? |
| Gopen and Swan | Carry the arc sentence to sentence with the given-new chain. | Does each sentence hand the next its subject? |
| McEnerney | Make the stakes belong to a named community, and show why it is hard. | Can the reader say who should care and why this is hard? |

## Anti-patterns

These are narrative gone decorative. Each is catalogued in
`references/ai-tells-to-avoid.md` under "Storytelling tells."

- The manufactured hook ("Imagine a world where...", "Picture this:").
- The cold open or scene-setting stakes ("In an era of...", "As the field
  continues to evolve...").
- The hero's-journey framing of routine work ("our journey began", "we set out
  to explore").
- Anthropomorphized data ("the data tells a story", "the numbers speak for
  themselves").
- The forced analogy that leaks (`references/edit-checks.md`, check 8).
- Stakes dramatized beyond what the paper delivers.

## Safe boundaries and stage

- Use only material already in the paper. If the spine needs a motivating
  example, a stated gap, or stakes the author did not write, raise it in
  `Author questions`; do not invent it.
- `first draft`: may restructure toward OCAR and propose where the Challenge is
  missing. Propose structural cuts and moves; do not fabricate content.
- `response to reviewers`: apply only inside flagged paragraphs and their
  neighbours.
- `final polish`: surface an existing tension in the stress position and tighten
  the ABT of the topic sentences already there; do not reorder paragraphs or add
  arc material.
- Preserve the author's framing, emphasis, and choice of what to claim
  (`SKILL.md` constraint 8).

## Rationale language

Name the structural mechanism in `Change rationale`. Good: "surfaced the tension
the draft buried", "opened the knowledge gap before the machinery", "found the
ABT and cut the AAA list", "put a character in the subject slot", "moved the turn
into the stress position", "replaced announced significance with the concrete
consequence". Bad: "more engaging", "tells a better story", "more narrative",
with no named mechanism.
