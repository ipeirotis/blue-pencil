# Changelog

All notable changes to paper-revision-editor are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/). Versions use [Semantic Versioning](https://semver.org/).

## [1.22.0] - 2026-06-29

The installer now registers the `paper:` slash commands, closing a gap where `/paper:loop` (and the rest) came back as "Unknown command" on a machine that had the skill installed. Claude Code discovers commands under `.claude/commands/` in a repo or `~/.claude/`, never from inside an installed skill directory, so shipping the command files in the skill was not enough: they had to be copied into one of those trees. Previously that copy was a documented manual step, easy to miss, and a marketplace or symlink install left no obvious source to copy from. The installer now does it.

### Added

- `install.sh`: a `--commands` mode that copies the `paper/` command directory and the `paper-reviser` agent into `~/.claude/`, registering `/paper:loop`, `/paper:revise`, `/paper:feedback`, `/paper:clarify`, `/paper:human`, `/paper:rebut`, `/paper:polish`, and `/paper:consistency` for every project. It also links the skill into the standard targets first (the agent loads the skill from `~/.claude/skills`, so registering commands without the skill would leave names that resolve to nothing), and is idempotent and safe to re-run after an `--update` to pick up new or changed commands.
- `install.sh`: an `install_commands` helper shared by `--init` and `--commands`. It resolves the command and agent files from the skill source (a local clone, or the managed clone the symlinks point at) and refreshes them in place under the target `.claude/` tree.

### Changed

- `install.sh`: `--init` now registers the `paper:` commands and the `paper-reviser` agent in the current paper repo (`<repo>/.claude/`) in addition to scaffolding `AGENTS.md`/`CLAUDE.md`, so a single setup step makes the slash commands resolve. The registration runs even when `AGENTS.md` already has a `<paper_context>` block, and it links the skill first (like `--commands`) so a standalone `--init` before any normal install does not register commands against a missing skill.
- `install.sh`: the script directory now resolves through symlinks (`pwd -P`). Without it, launching the installer through an install symlink (for example `~/.claude/skills/paper-revision-editor/install.sh --commands`) made `src` the symlink path, which is also a relink target, so the skill link was removed and recreated pointing at itself, breaking the skill and hiding the bundled command files.
- `install.sh`: the default `install` now prints a hint pointing at `--init` (this repo) and `--commands` (all projects) so the command-registration step is discoverable instead of buried in the README. The hint uses the installer's absolute path rather than `$0`, which is unusable under `curl ... | bash` (where `$0` is `bash`) or after the user changes into their paper repo (where a relative `./install.sh` no longer resolves).
- `install.sh`: `--uninstall` now also removes the global `paper:` commands and the `paper-reviser` agent that `--commands` installs under `~/.claude`, so uninstall fully reverses the new registration path. Commands copied into a specific repo by `--init` are left in place, since uninstall takes no repo argument.
- `README.md`: the Quickstart, the complete-paper-edit-loop note, and the "Structured slash commands" section now describe `install.sh --init` / `--commands` as the supported way to register the commands (with the manual copy kept as an alternative), and explain why a skill-bundled command file does not register on its own.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.22.0.

### Rationale

The commands existed and were documented, but the path from "skill installed" to "`/paper:loop` works" required a manual copy that most installs never performed, and a marketplace install gave the user no local source to copy from at all. Making the installer perform the copy (per-repo with `--init`, globally with `--commands`) turns a silent failure into a one-command fix, while the skill stays the cross-tool source of truth and the manual copy remains available for anyone who wants it.

## [1.21.0] - 2026-06-28

An outer author loop over the existing single-section passes. Until now every command operated on one section, one pass, one entry point, and an author doing a full edit had to infer the sequencing (which sub-command, in what order, when to repeat, when to stop) from the sub-commands themselves. This release makes the whole-paper loop explicit, on the governing principle "diagnose globally, edit locally, validate globally, then polish conservatively," while keeping the skill the source of truth for every individual edit.

### Added

- `.claude/commands/paper/loop.md`: a `/paper:loop` planner-driver. It emits the staged whole-paper edit plan first (paper-context status, current revision stage and what it permits, detected sections, recommended pass order, the first command to run, and the stop and repeat criteria) and only then walks the loop one section at a time. The plan diagnoses every section (feedback only) before any rewrite, so global thesis or terminology problems surface before a single edit is baked in. The author checkpoint is recurring: every pass (`feedback`, `revise`, `clarify`, `human`) can surface new `Author questions`, and the driver resolves them before the next pass or the next section. It never rewrites the whole paper in one pass: each per-section pass is dispatched to the `paper-reviser` subagent, with `revise` as the default and `clarify` / `human` as targeted second passes run only when the diagnosis calls for them. The abstract and introduction are edited first (to set the spine the body must serve) and again at the end (because they go stale once the body changes); since that rerun lands after the cross-section consistency check, the loop re-runs `/paper:consistency` over the front matter before the sentence-only final polish, which cannot repair fresh drift. It carries the skill's hard constraints (no em-dash, no silent change to numbers, citations, math, claims, or quotes) through every step, and stops at "the remaining edits would be merely different rather than better" rather than rewriting for cosmetic variation.
- `.claude/commands/paper/polish.md`: a `/paper:polish` command for the final, conservative pass. It pins `final polish` constraints (sentence-level copyediting only: word choice, given-new flow, referents, stress position, terminology consistency, abbreviations, units, callouts, punctuation, tense, parallelism, rhythm, and the AI tells allowed at that stage) with no paragraph reordering, no new explanatory content, and no structural cuts. It loads `copyediting.md`, `ai-tells-to-avoid.md`, and `sentence-cohesion.md`, and branches on the stored `revision_stage`: it proceeds at `final polish`, proceeds at `first draft` (final-polish constraints are strictly narrower, so no gate is bypassed), and at `response to reviewers` stops and asks the author to either close out the reviewer round and move the stage to `final polish` or stay in reviewer-response scope with `/paper:rebut`, rather than section-wide copyediting paragraphs that stage protects.
- `.claude/commands/paper/consistency.md`: a `/paper:consistency` whole-paper check, diagnosis only (`Revised text` reads `No rewrite requested.`). When handed a root or wrapper file such as `paper.tex`, it follows `\input` and `\include` recursively and scans sibling section files rather than reading only the wrapper, so no section is missed behind an include. It flags terminology drift, claim drift and result overstatement, inconsistent contribution framing, promise-delivery gaps, missing or unresolved forward references and figure, table, or theorem callouts, unfilled citation placeholders, and stale summaries, and asks whether the abstract, introduction, methods, results, discussion, and conclusion describe the same paper. Each diagnosis item names the sections in conflict; cross-section decisions that need the author go to `Author questions`.
- `README.md`: a new user-facing "Complete paper-edit loop (editing a whole paper)" section that documents the loop as steps 0 to 5 for any agent, so it is followable by hand and not only through Claude Code. It states the stopping rule explicitly (unchanged prose is a valid result; a rewrite that touches every paragraph is suspect).

### Changed

- `README.md`: the `paper:` command table and the Structured-slash-commands prose now list `/paper:polish`, `/paper:consistency`, and `/paper:loop`, and explain that `loop` differs in kind from the section commands (it plans then drives them one section at a time rather than running a single pass). The Quickstart hand-off line and the Files table point at the new loop section and commands.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.21.0.

### Rationale

The skill was strong per section but silent about the loop. Authors had the pieces (diagnose, clarify, revise, humanize, rebut) without a protocol telling them to diagnose the whole paper first, edit one section at a time to convergence, validate across sections, and only then polish. Documenting the loop and adding a command that plans and drives it removes that inference burden and gives the model an explicit stopping rule, while every actual edit stays inside the single-section skill and its safety constraints. `/paper:loop` is deliberately a planner-driver rather than an autonomous whole-paper rewriter, so the author stays in control at each checkpoint; `/paper:polish` and `/paper:consistency` fill the two gaps the loop needs that the command set did not yet expose.

## [1.20.0] - 2026-06-28

A forced-extraction step for the exposition pass. The 1.18.0 exposition pass already set the reader model, the six-rung ladder, and the teaching-benefit rationale vocabulary, but the diagnosis-to-rewrite handoff still let a teaching gap be smoothed over with a thesaurus swap instead of repaired. This release makes the pass extract three things into the `Diagnosis` block before any rewrite is drafted, so the rewrite is structural by construction: it front-loads the buried idea, unpacks the jargon inline, and anchors the abstraction in something already on the page.

### Added

- `references/exposition.md`: a **Forced extraction before the rewrite** section. When the exposition pass surfaces any teaching gap (any ladder or common failure, for example definition debt, compressed inference, machinery before motive, expert-only contrast, abstract stack, concept overload, an unanchored abstraction, or a buried or missing payoff) or the request is to make the section clearer to non-specialists, more educational, more readable, or easier to understand, the editor extracts three grounded handles first: `Jargon to unpack` (one to three terms to define inline, or `none` when the gap is non-terminological), `Buried lede` (the most useful idea the prose suffocates, front-loaded in the rewrite), and `Concrete anchor` (the example, dataset feature, mechanism, figure, or number that makes the abstraction tangible). The section names the educator's lens behind the three: find the single hardest concept for an outsider (jargon and lede locate it), then build the bridge to it (the anchor), and write to teach the reader rather than to prove the author's command of the field.

### Changed

- `SKILL.md`: the Diagnosis output format now adds the three extraction lines (`Jargon to unpack:`, `Buried lede:`, `Concrete anchor:`) whenever the exposition pass surfaces a teaching gap or the request is to make the section clearer to non-specialists, more educational, more readable, or easier to understand. They are placed after `Reader map:` when present, otherwise at the top of the Diagnosis block; each is grounded only in material already in the manuscript, any line may read `none`, and when all three are `none` and the passage clears the restraint checks it is returned verbatim. The step is excluded at `final polish`, where the stage forbids restructuring.
- `examples/exposition-introduction.md`, `examples/exposition-methods.md`, `examples/exposition-results.md`: each Diagnosis now carries the three extraction lines, grounded in the draft each example already contains (cohort-level moderation as the identification source, both never-treated and not-yet-treated staggered controls, the star-rating coefficient as a yardstick without deriving a ratio), so the examples stay valid quality anchors under the new output contract.
- `references/ai-tells-to-avoid.md`: the "leverage" tell and its checklist item now also cover "utilize" / "utilizes" / "utilizing" used where "use" would do.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.20.0.

### Rationale

The exposition pass diagnoses well, but a strong line editor can satisfy a diagnosis item with a smoother sentence that still hides the missing step. Forcing the editor to name the buried lede, the jargon, and the concrete anchor before writing converts the diagnosis into a structural rewrite: there is a specific idea to front-load, a specific term to define, and a specific anchor to reach for, so the rewrite cannot collapse into a polite synonym swap. The three stay inside the existing safety boundary, each must come from material already on the page, and anything the manuscript lacks becomes an `Author questions` item rather than an invented example or definition. The step is scoped to the exposition pass and excluded at `final polish`, so flow-only and final-polish passes keep their lean Diagnosis header.

## [1.19.0] - 2026-06-28

A usability and coverage pass. The skill's behaviour did not change; what changed is how easy it is to invoke deliberately and how well the examples cover the skill's harder-to-get-right modes. Two behaviours that the skill describes at length but never demonstrated, returning strong prose nearly untouched and working a response-to-reviewers edit, now have full worked examples, and a `paper:` slash-command namespace gives Claude Code users predictable one-shot entry points that pre-set the triage.

### Added

- `examples/restraint-example.md`: a full four-section run that returns a strong results passage almost verbatim. It makes the one mechanical fix the text needs, logs the two edits it declined (dropping a load-bearing hedge, collapsing four near-synonyms), and routes a terminology question to `Author questions` rather than silently merging the terms. This is the skill's hardest discipline (an unchanged paragraph is a valid output) and was the one common mode with no example.
- `examples/reviewer-response-example.md`: a full run of the response-to-reviewers workflow. It maps two reviewer comments to paragraphs, edits only the flagged paragraph plus its argument, returns three unflagged paragraphs verbatim despite real stylistic flaws, fixes the comment that can be answered from existing prose, and flags the comment that needs a number the manuscript lacks. Demonstrates that not every reviewer comment yields an edit.
- `.claude/commands/paper/`: a Claude Code slash-command namespace that dispatches to the `paper-reviser` subagent with the triage pre-set, so the skill skips the scope/unit/aggressiveness round-trip. `revise` (full pass), `feedback` (diagnosis only), `clarify` (exposition pass), `human` (narrative spine plus AI-tell scrub), and `rebut` (response-to-reviewers). None override the `revision_stage` in `<paper_context>`. Each `argument-hint` is quoted so YAML reads it as a scalar string, `rebut`'s preset scope allows the immediate-neighbour edits its workflow describes and reads reviewer files passed as path arguments before asking for the text, `clarify` defers to the skill's conditional Diagnosis-header rules instead of forcing a `Reader map:` line, and the README copy instructions name the exact `commands/` and `agents/` destinations Claude Code discovers. The two new examples obey the output contract they anchor: every `Author questions` item ends as a question, and the reviewer-response example states that immediate neighbours stay eligible even though both fixes happened to fit inside the flagged paragraphs. The quickstart notes that the `paper:` slash commands need a one-time copy and are not registered by the standard install, and that `--init` runs inside a git repository (with a copy-the-template fallback for plain folders). The reviewer-response example's P2 rewrite no longer adds an unstated "rather than by category revenue" contrast, so it carries only claims the draft already makes; its Diagnosis keeps to reviewer-labelled items, leaving unflagged stylistic issues to `Change rationale`. `rebut` now tells the user when the stored `revision_stage` is not `response to reviewers` instead of silently overriding it, and the README's command docs reflect that `rebut` is the one command keyed to reviewer-response scope. The output contract and voice-extraction note now state that response-to-reviewers passes skip the `Voice tics:` and `Reader map:` Diagnosis headers (like final-polish passes), because a reviewer-limited edit revises only the flagged paragraphs rather than rewriting the section; the reviewer-response example matches. That example's P2 rewrite also names the badge program as what the platform rolled out, removing a dangling `which` clause that could attach to "category".

### Changed

- `SKILL.md`: the reviewer-response workflow and the restraint section now cross-link their new worked examples; `metadata.version` reports 1.19.0.
- `README.md`: rewritten for newcomers. The top now opens with a plain-language description of what the skill is and who it is for, a "Why use it" section, a "What you can ask for" use-case table with example prompts, a four-section output guide, and a numbered "Quickstart: use it on your own paper" walkthrough. The dense pipeline paragraph moved into a "How it works (under the hood)" section so it is still available without being the first thing a beginner reads. A new "Structured slash commands" subsection documents the `paper:` namespace and how to copy it into another repo or `~/.claude/`; the Files table lists the two new examples and the commands directory; the badge reports 1.19.0.
- `AUDIT.md`: marked as a historical v1.7.0 baseline with a header noting that its listed gaps are resolved, so it no longer reads as an open to-do list.
- `VERSION`: 1.19.0.

### Rationale

The skill had grown deep and well-tested on the cases it demonstrates, but its two most failure-prone disciplines were the two without an anchor. Restraint is the behaviour a capable editor most often gets wrong (the reflex is to find something to change), and the response-to-reviewers stage has scope rules that are easy to violate by "improving" an unflagged paragraph. An example each turns those rules from prose into a checkable artifact, the same role the existing examples play under the lint's quality-anchor intent. The slash commands address a different friction: auto-triggering works, but a deliberate user wants a named, predictable entry point that does not re-ask the triage every time, and mapping each command to one of the skill's real modes keeps them thin dispatchers rather than a second source of behaviour.

## [1.18.1] - 2026-06-28

A small enrichment of the exposition pass shipped in 1.18.0, salvaged from a parallel branch that proposed the same idea before 1.18.0 landed. The bulk of that branch duplicated the exposition pass and is dropped; these three additions did not exist on `main` and earn their place.

### Added

- `references/exposition.md`: an exemplar table (Hamming, Pearl, Knuth, MacKay, Nielsen, Varian, Tufte for figures, Strunk and White for concision), mapping each writer to a transferable technique and a check over the exposition ladder, in the same borrow-the-move-not-the-mannerism format the reader-pleasure and narrative-spine passes already use. A closing note frames notation delay as a special case of "role before name": a symbol is a high-cost object, so carry the idea in named words before introducing the symbol that abbreviates it.

### Changed

- `SKILL.md`: a **Primary objective** statement under the title (maximize reader understanding, not textual polish; treat every revision as an act of teaching), explicitly subordinated to the hard constraints and pointing at the exposition pass as where the objective becomes operational.
- `references/ai-tells-to-avoid.md`: the storytelling-tells section now distinguishes a load-bearing concrete instance from a manufactured hook, so the exposition pass's call for concrete cases and the standing ban on "Imagine a world where..." openers no longer read as contradicting each other. The ban targets the dramatizing frame; the domain case keeps its substance.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.18.1.

### Rationale

While the exposition pass was in review, a separate branch independently proposed a teaching pass with the same core (instance before intuition before formalism, one new idea at a time, concrete over abstract). Rather than merge a second overlapping reference and a colliding 1.18.0, that branch was reset onto the shipped pass and only its non-duplicate parts were kept. The exemplar table fills a real gap: the exposition pass was the one reader-facing pass without an exemplar catalog, and the named writers were the specific communicators the request asked the skill to emulate. The Primary objective statement states at the top what the exposition pass already does, so the teaching aim is visible before any reference is loaded. The hook reconciliation closes a genuine seam: a pass that asks for concrete instances and a style rule that bans "Imagine..." openers needed one sentence to agree on where the line falls.

## [1.18.0] - 2026-06-28

An exposition pass. The skill already made prose flow (reader-pleasure), gave it a spine (narrative-spine), and stripped AI tells, but it had no first-class tool for the property that turns a correct paper into a paper that teaches: whether the reader can acquire the idea with less effort than expected. A paragraph can have a clean ABT spine and a pleasant rhythm and still fail to teach, because it skips the inferential steps the author has internalised. This release promotes the curse-of-knowledge fix from supporting references (principles.md, edit-checks.md) into a first-class editing pass that asks, of every load-bearing paragraph, what mental model the reader has before it and what model they should have after.

### Added

- `references/exposition.md`: the core of the pass. It sets the reader model (intelligent and trained in the broad venue area, but not expert in this paper's exact topic, dataset, method, or frame), a six-rung exposition ladder (question before machinery, role before name, intuition before formalism, one new object at a time, concrete anchor after abstraction, payoff after effort), the common failures with safe-fix and flag-only branches (definition debt, machinery before motive, compressed inference, expert-only contrast, abstract stack), section-specific checks (abstract, introduction, theory, methodology, results, discussion), the memorable-idea check, stage-bound safe boundaries, and teaching-benefit rationale language. It runs after logical-flow and argumentation and before reader-pleasure, narrative-spine, and copyediting.
- `examples/exposition-introduction.md`, `examples/exposition-methods.md`, `examples/exposition-results.md`: three full four-section runs on subtle, common failures rather than caricatures. The introduction assumes the reader already knows the gap (the pass surfaces it and restores the identification bridge); the methods paragraph opens on the estimator (the pass moves the identification logic ahead of the specification); the results paragraph narrates a table (the pass reorders each result into claim, evidence, consequence while carrying every number over verbatim). Each shows a `Reader map:` line and teaching-benefit rationales.

### Changed

- `SKILL.md`: a new **Exposition and reader education** editing principle between Argumentation and Paragraph craft, with the reader ladder, the memorable-idea instruction, a bad/good example, and a load trigger for `references/exposition.md`; a new trigger under "When to use this skill" for making a section clearer to non-specialists, more educational, or easier to understand; the "When NOT" rule on not drafting new sections now carves out short explanatory bridges built from material already in the manuscript while still routing new substance to `Author questions`; the Diagnosis block now opens whole-section and first-draft passes with a `Reader map:` line; the change-rationale reasons add the teaching benefits (restored inference, term defined at first serious use, role before name, question before machinery, concrete anchor, separated concepts, explicit payoff, abstract claim translated to mechanism, exposed contrast); Author questions now lists the teaching gaps (missing definition, intuition, example, mechanism, contrast, why-it-is-hard, takeaway); the preflight checks add a reader-transformation check, a definition-debt check, and a machinery-before-motive check; and the restraint checklist adds definition debt to the verbatim-return bar.
- `references/reader-pleasure.md`: a short addition making delight operational ("a research paper is delightful when the reader feels their understanding growing sentence by sentence") with a six-item checklist and the repeatable-sentence test, cross-linked to the exposition pass.
- `examples/worked-example.md`: the Diagnosis now carries a `Reader map:` line so the worked example stays a valid quality anchor under the new output contract.
- `README.md`: the "What this skill does" pipeline now lists the exposition pass, the constraint summary notes that explanatory bridges use only material already in the manuscript, and the Files table lists the three exposition examples.
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.18.0.

### Rationale

The skill was an excellent line editor and a strong narrative editor, but a strong line edit can smooth over a teaching gap instead of repairing it: smoother prose hides the missing step rather than supplying it. The exposition pass makes that gap visible and assigns it a fix or a flag. The dividing line is the one that keeps the pass safe: surfacing an idea already on the page is editing, supplying an idea the page lacks is drafting, and drafting stays out of scope as an `Author questions` item. The pass also unifies machinery the skill already carried. The curse of knowledge in `principles.md` and the layered-audience and question-before-machinery checks in `edit-checks.md` were supporting references; here they become an enforceable pass with its own ladder, preflight checks, and rationale vocabulary. And it closes the loop with reader-pleasure: pleasure and teaching are the same property seen from two sides, so the delight checklist and the exposition ladder point at the same edits. As with every pass, it is stage-bound: a first draft may add bridges from existing material, a final polish repairs only referents, order, and stress position, and a reviewer response touches only flagged paragraphs and their neighbours.

## [1.17.1] - 2026-06-28

A consistency pass on the dispatcher and the promotional-adjective check, fixing three places where an instruction pulled against the skill's own rules.

### Changed

- `.claude/agents/paper-reviser.md`: add `sentence-cohesion.md` to the reference-trigger list so flow and cohesion requests reach the given-new guidance, and let the skill's triage clarifying question (scope, unit, aggressiveness) be returned before the strict four-section output instead of revising under guessed assumptions.
- `references/edit-checks.md`: rework check 9 so it strips the promotional adjective or frame and applies the keep-test before any deletion, rather than deleting the whole sentence, keeping it consistent with the no-silent-deletion and preserve-emphasis rules.
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.17.1.

## [1.17.0] - 2026-06-28

A narrative pass. The skill already made prose locally pleasurable (reader-pleasure) and stripped sentence-level AI tells, but it had no tool for the property that most separates human-written papers from LLM-drafted ones: a spine. A clean paper can still read as machine-written when it enumerates equally weighted points and announces that they matter. This release adds disciplined narrative structure and, just as important, bans the decorative storytelling that a naive "add a story" instruction produces, because that decoration is itself a top LLM tell.

### Added

- `references/narrative-spine.md`: a guide to the global through-line of a section. It defines the ABT spine (And, But, Therefore) with its two failure modes (AAA list rhythm, the LLM default; DHY tension overload), the OCAR arc (Opening, Challenge, Action, Resolution) with LD and LDR for shorter units, the knowledge gap as the engine that pulls a reader forward, characters and agency in the subject slot, protecting the turn, and showing stakes through consequence instead of announcing them. It carries an exemplar table (Olson, Schimel, Akerlof and Coase, Schelling and Hirschman, Gopen and Swan, McEnerney) mapping each source to a check, an anti-pattern list, stage boundaries, and rationale language. The reader-pleasure pass manages local momentum; this file manages the section-level through-line.
- `references/ai-tells-to-avoid.md`: a "Storytelling tells (decorative narrative)" section that bans manufactured hooks ("Imagine a world where..."), scene-setting stakes openers ("In an era of..."), the journey or quest metaphor for research, anthropomorphized data ("the data tells a story"), and the dramatic reveal ("Enter X."), plus two new diagnostic-checklist lines. This is the half that keeps a narrative pass from making prose more LLM-like instead of less.

### Changed

- `SKILL.md`: a new **Narrative spine** editing principle between Reader experience and Copyediting, with a bad/good example and load triggers; a new trigger under "When to use this skill" for requests to make a paper read like a human wrote it or sound less LLM-like; the style-rules loader now names the storytelling-tell checklist; and the restraint checklist, preflight checks, read-cold pass, and change-rationale reasons now carry narrative items (a findable ABT spine, surfaced tension, stakes shown by consequence, no decorative storytelling tells).
- `README.md`: the "What this skill does" pipeline now lists the narrative-spine pass, and the constraint summary adds "no manufactured hooks or anthropomorphized data".
- `VERSION`, `SKILL.md` `metadata.version`, and the `README.md` badge now report 1.17.0.

### Rationale

The instinct to fix LLM-flat prose by "adding storytelling" is half right and dangerous if taken literally. What reads as machine-written is the absence of a through-line: a setup, a tension, a turn, and a payoff carried by one question. That is structural, and it is what `narrative-spine.md` supplies through the ABT spine and the OCAR arc. The literal reading of "tell a story", by contrast, reaches for hooks, scene-setting, research-as-journey, and data that "tells a story", and those are themselves AI tells; adding them moves prose in the wrong direction. So the two halves ship together: add structure, ban decoration. The structural half also unifies rules the skill already had. Showing stakes through consequence rather than announcing them is the same discipline as the ban on importance-signaling verbs and promotional adjectives, seen from the story side; protecting the turn is the reader-pleasure pass's "useful surprise" raised to a structural duty; and putting characters in the subject slot is the character-action sentence from Williams. The pass is stage-bound: arc restructuring belongs to a first draft, while a final polish only surfaces an existing tension in the stress position and tightens the ABT of topic sentences already present. As with every pass, a narrative move that would need material the author did not write becomes an `Author questions` item, not an edit.

## [1.16.1] - 2026-06-28

A consistency fix in the edit-check pass. The meta-rule on cutting read as a quota ("Default to a 20% cut", "When in doubt about whether to cut, cut"), which pulled against the main skill's rule to cut by the keep-test and never toward a target. On an already-tight section that bias risks removing load-bearing sentences just to approach 80%. The section now frames the 20% as an expectation to test, not a default action.

### Changed

- `references/edit-checks.md`: retitle the "Default to a 20% cut" meta-rule to "Expect roughly a 20% cut, then test for it", and replace "When in doubt about whether to cut, cut" with the keep-test framing from the Subtraction section, so the reference no longer contradicts SKILL.md's length-budget rule that "manufacturing cuts to reach 80% of the original is itself a defect".
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.16.1.

## [1.16.0] - 2026-06-05

A documentation pass that shows the skill working end to end. The repo described the strict four-section output and gave isolated good-and-bad sentence pairs, but it never demonstrated a full run on a realistic draft. The new worked example closes that gap and doubles as a quality anchor: its output honors every constraint, so a reader and the agent both have a concrete reference for what a correct invocation looks like.

### Added

- `examples/worked-example.md`: a complete run of the skill on a flawed first-draft introduction. It shows the paper context, the request, a triage message kept separate from the strict four-section return, the two-paragraph input, and the exact four-section output (Diagnosis with voice tics, Revised text, Change rationale with a word-count line and per-change reasons, Author questions), plus a short note mapping the result back to the skill's rules. The example removes throat-clearing and banned transitions, carries the effect-size claim and sample size ("1.2 million") over word for word, keeps the author's underspecified "significant effect" and the tentative managerial recommendation unchanged while raising the open points as questions, and logs a 38% subtractive cut (visible prose citations counted, since the example uses plain author-year citations rather than LaTeX commands).

### Changed

- `README.md`: a new "See it in action" section points to the worked example, and the Files table lists it.
- `SKILL.md`: the output-format section points to `examples/worked-example.md` for a complete worked example.
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.16.0.

## [1.15.0] - 2026-05-31

A technical pass on installing, updating, and maintaining the skill. The installer now pins to a version, reports what changed on update, and fails early with a clear message when git is missing. A `scripts/` directory plus CI keep the version strings and the no-em-dash rule from drifting.

### Added

- `LICENSE`: the MIT text the README badge and `SKILL.md` already pointed to but the repo was missing.
- `install.sh`: `--ref <tag|branch|commit>` and `PAPER_REVISION_EDITOR_REF` pin a version. The pin is sticky: it is honored on install and reinstall, and a plain `--update` keeps the clone on the pinned tag or commit (pass a new `--ref`, for example `--ref main`, to move off it). Also a `--version` subcommand, a `git` preflight with an actionable message, before-and-after version reporting on `--update`, an `Already up to date` path, and `BROKEN` symlink plus tracked-ref detection in `--check`.
- `scripts/`: `check-version.sh` (assert the version matches in `VERSION`, `SKILL.md`, and the README badge), `bump-version.sh` (update all three in lockstep), and `lint.sh` (em-dash and en-dash scan, frontmatter validation, reference-link resolution), with a `scripts/README.md`.
- `.github/workflows/ci.yml`: shellcheck, the version-consistency check, the lint, and an install smoke test on every push and pull request.

### Changed

- `Makefile`: added `version`, `lint`, `check-version`, `bump`, and `test` targets; the help text now separates user targets from maintenance targets.
- `README.md`: documents version pinning, `--version`, a verify-and-troubleshoot path, and a maintainers section; the Files table lists `LICENSE`, `scripts/`, and the CI workflow.
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.15.0.

### Rationale

The skill installed with one curl line, but a few technical gaps made it harder to trust and maintain: the advertised LICENSE file did not exist, the version lived in three places with nothing guarding against drift, the installer could not pin to a release or say what an update changed, and the no-em-dash standing constraint relied on manual vigilance. The new scripts and CI turn those into checks that run on every change, and the installer improvements make install, update, and verification legible to the user.

## [1.14.0] - 2026-05-30

Three editorial passes that shipped together: a research-paper copyediting pass, a reader-experience pass, and an exemplar-technique pass for pleasurable prose. Copyediting makes grammar and consistency fixes explicit so they protect precision instead of becoming untracked rewrites. The reader-experience pass makes enjoyment operational through orientation, momentum, payoff, rhythm, concrete anchors, and useful surprise. The exemplar pass then names writers whose papers are widely treated as pleasurable to read and extracts the techniques an editor can borrow without imitating their voices.

### Added

- `references/copyediting.md`: a dedicated copyediting guide for research manuscripts. It covers grammar and agreement, punctuation for parsing, parallelism, terminology consistency, abbreviation handling, capitalization, hyphenation, units and symbols, tense and aspect, table and figure callouts, and citation punctuation. It adds a safe-fix / consistency-risk / evidence-risk triage, a consistency inventory, common high-value fixes, a list of items not to normalize silently, and a final copyediting checklist.
- `references/reader-pleasure.md`: a dedicated guide for making research prose a pleasure to read without hype or decorative flourish. It defines a five-part pleasure test, safe edit moves, anti-patterns, stage boundaries, concrete rationale language, and an **Exemplars and transferable techniques** section covering Coase, Akerlof, Schelling, Hirschman, Kleinberg, Roth, Lampson, Brooks, Chetty, Varian, Angrist-Pischke, Dijkstra, and McCloskey, with a table mapping each exemplar to a concrete editing check for ordinary papers.
- `SKILL.md`: explicit **Copyediting** and **Reader experience** editing principles. The copyediting principle carries a before/after example and loads `references/copyediting.md` for copy-edit requests, final-polish passes, and revisions that touch sentence mechanics. The reader-experience principle loads `references/reader-pleasure.md` when the user asks whether prose is enjoyable, compelling, elegant, readable, or a pleasure to read, and uses the exemplar catalog for techniques to borrow, not voices to imitate.

### Changed

- `SKILL.md`: the trigger and non-trigger guidance now distinguishes research-paper copyediting from mechanical typo-only proofreading. Stage controls, restraint checks, preflight, read-cold, change-rationale, and author-question rules now include copyediting concerns (terminology, abbreviations, capitalization, hyphenation, unit notation, tense, punctuation, parallelism) and reader-experience concerns (visible questions, momentum, payoff, rhythm, concrete anchors, restored contrast, unclear reader payoff).
- `README.md`, `SKILL.md` `metadata.version`, and `VERSION` now report 1.14.0.

### Rationale

These passes build on one another. Research-paper copyediting is a precision pass, not a cosmetic one: it names the mechanical consistency checks that matter in manuscripts (terms that drift across a section, abbreviations introduced unevenly, nonparallel contribution lists, tense shifts between prior work and results, unit-format drift, vague table or figure callouts) while preserving the hard boundary around technical claims, citations, numerical values, and author framing. Correct prose can still be airless, so the reader-experience pass makes a paper pleasurable when the reader is oriented, feels forward motion, gets a payoff at the end of paragraphs, receives relief after dense material, and meets useful tension rather than smoothed-over generality. Naming exemplars helps the skill recognize the moves that create that experience (puzzle before literature, question before machinery, named ideas, examples that do argumentative work, figures as the empirical spine, progressive disclosure, exact claims instead of importance signaling), while the technique-not-voice rule prevents pastiche. Pleasure and copyedit moves must name the mechanism they improve; anything that would require adding evidence, changing emphasis, or inventing an example becomes an author question instead of an edit.

Note: earlier drafts of this changelog split this release into 1.12.0 (copyediting) and 1.13.0 (reader experience), but the repository only ever reported 1.14.0, which shipped all three passes. The two entries are consolidated here so the changelog matches the version history and the release tags.

## [1.11.0] - 2026-05-30

A subtractive-editing pass. The skill already defaulted to "shorter is better"; this release gives it a test for *which* units are safe to cut, so the Strunk-and-White instinct does not become a wood chipper.

### Added

- `references/subtraction.md`: a guide to cutting to the story without destructive effects. Separates *compress* (fewer words, same content, near zero-risk) from *delete* (remove a unit, real risk), and gates deletion behind a six-function keep-test: a unit earns its place if it advances the thesis, makes a claim believable, links two ideas, serves a reader the others do not, pre-empts an objection, or sets rhythm. The same six functions are presented as the catalogue of what a naive cut destroys. Adds unit-size scaling (perform word and sentence cuts, propose paragraph and section cuts), the revision-stage interaction, the curse-of-knowledge blind spot (subtraction never finds the missing step), and a worked example that cuts 60% safely and 90% destructively from the same sentence.
- `SKILL.md`: a **Subtraction: cutting to the story** section carrying the compress/delete split, the prior-not-quota rule, the keep-test, and the perform-vs-propose scaling, pointing to `references/subtraction.md` for depth.

### Changed

- `SKILL.md`: the Length-budget preflight now cuts by the keep-test rather than toward a target, and names quota-chasing (manufacturing cuts to reach 80% of the original) as a defect in its own right.
- `SKILL.md` `metadata.version` and `VERSION` bumped to 1.11.0; `README.md` badge updated.

### Rationale

Cutting to the story is the highest-yield edit and the easiest to over-apply. The skill had the subtractive default (the length budget, the 20% cut meta-rule in `edit-checks.md`) but no test for which units are load-bearing, which is exactly where over-cutting does its damage: an editor removes a hedge that was calibration, a transition that carried the thread, a gloss the non-expert needed, or a limitation that pre-empted a reviewer. The keep-test makes "needless" operational, and tying the action to the unit size keeps the human in the loop on anything structural: compression is unconditional, sentence deletion is logged, and paragraph- or section-level cuts are proposed rather than performed. Framing the 80% as a prior rather than a quota closes the specific failure where an editor cuts good tissue out of an already-tight draft to hit a number.

## [1.10.0] - 2026-05-30

A writing-quality pass. Earlier releases (1.7-1.9) reworked packaging and portability; this one sharpens the editorial guidance so the prose the skill produces is better, not just the way the skill ships.

### Added

- `SKILL.md`: a **Paragraph craft** editing principle, inserted between Argumentation and Writing quality. It fills the gap between the section-level "Logical flow" principle and the sentence-level "Writing quality" principle: one idea per paragraph, a topic sentence in the first sentence or two, a coherent topic string across consecutive sentences, and transitions built from the content rather than from a connective bolted on the front. Includes a before/after pair.
- `SKILL.md`: a lateral-edit guard. The editing-principles preamble now states that a passage changes only when the result is clearly better, not merely different, and the `Change rationale` output spec now requires every change's `why` to name a concrete reader benefit (a removed tell, a shorter form, given-new order, a fixed referent, a sharper claim, a corrected stress position). "Reads better" or "smoother" with no named mechanism is not a reason, and the original stays.
- `SKILL.md`: a sentence-rhythm check in the read-cold pass. Uniform sentence length is now named as a tell to fix before returning output.
- `references/ai-tells-to-avoid.md`: four new categories of contemporary tell. **More filler adjectives** (comprehensive, holistic, multifaceted, nuanced, key, central, vital, pivotal, rich, deep, powerful, vast, seamless, streamlined), each with its legitimate technical exception. **Importance-signaling verbs** (underscores, highlights, emphasizes, showcases, "plays a key/central/crucial role in"), with an edit move that swaps the signal for the mechanism. **Inflated noun phrases and dead metaphors** ("the landscape of", "a myriad of", "rich tapestry", "paradigm shift", scene-setting openers). **Template sentence shapes** (the "not just X, it's Y" antithesis, the "From X to Y" opener, repeated "not only ... but also", "Firstly/Secondly" for lists meant to be remembered). The bottom-of-file diagnostic checklist picks up four matching scan items.
- `references/sentence-patterns.md`: an **Overclaiming** entry, the sibling to the existing Hedge-stacking entry, so both sides of confidence miscalibration sit together. Covers causal language on correlational evidence, "proves" versus "is consistent with", universal claims from a bounded test, and "robust" without a referent. Each row flags the gap as an Author question rather than silently weakening the claim. Five high-frequency wordiness compounds added to the search-and-replace table ("the fact that", "in terms of", "a number of", "the way in which", "serves to").

### Changed

- `SKILL.md`: the Argumentation principle now calibrates confidence in both directions, naming overclaiming (causal language on correlational evidence, a universal claim on one dataset, "proves" on "is consistent with") alongside the existing hedge-stacking concern.
- `SKILL.md`: the transition style rule now points at the given-new chain in `references/sentence-cohesion.md` and gives the positive technique (end a sentence on the term the next sentence picks up), where before it gave only the negative rule.
- `README.md`: version badge to 1.10.0; the "what this skill does" summary mentions the new filler-adjective, importance-signaling-verb, and lateral-edit guards.
- `SKILL.md` `metadata.version` and `VERSION` bumped to 1.10.0.

### Rationale

The skill was procedurally complete (context gate, revision stages, reviewer-response branch, constraints, voice extraction, read-cold pass, length budget) but had four gaps that capped the quality of its output. First, nothing forbade a lateral edit, the most common LLM-editor failure mode: swapping a synonym or reshuffling a clause without buying clarity, brevity, or flow. The guard makes "clearly better, not merely different" an enforceable bar at the point where each change is justified. Second, the editing principles jumped from section structure to sentence mechanics with no paragraph layer, so topic sentences, one-idea-per-paragraph, topic strings, and content-based transitions had no home in the always-loaded lens. Third, the AI-tells list predated the current crop of model defaults; the filler adjectives, importance-signaling verbs, inflated noun phrases, and template sentence shapes are what a careful reader now reacts to first, and they were going uncaught. Fourth, calibration was one-sided, catching the hedge-stacker but not the overclaimer, even though overclaiming is the version reviewers punish. Each addition keeps the skill's subtractive ethos: the new tells are deletions, the calibration entries flag rather than rewrite, and the lateral-edit guard reverts to the original by default.

## [1.9.0] - 2026-05-28

### Removed

- Cross-tool detection and per-tool install paths for Codex, Gemini, Cursor, Copilot, OpenClaw, OpenCode, Goose, Zed, Junie, Cline, and Roo. The installer now targets exactly two locations: `~/.agents/skills/paper-revision-editor/` and `~/.claude/skills/paper-revision-editor/`.
- `update.sh` at the repo root and `scripts/update.sh` legacy updater. Update is now `./install.sh --update` (or the equivalent `curl ... | bash -s -- --update`).
- Per-tool `make install-*` and `make uninstall-*` targets.
- `--bootstrap`, `FORCE`, and `FORCE_COPY` flags. The installer always clones to `$PAPER_REVISION_EDITOR_HOME` (default `~/.local/share/paper-revision-editor`) when not running from a clone, and falls back to copy mode automatically when symlink creation fails.

### Changed

- `install.sh` rewritten as a single ~250-line script with five modes: install (default), `--update`, `--uninstall`, `--init`, `--check`. No tool detection, no aliases, no per-tool branching.
- `Makefile` reduced to five targets: `install`, `update`, `uninstall`, `init`, `check`.
- `README.md` rewritten without the cross-tool support matrix, and now documents the simple "ask the agent to install/update" UX.
- `examples/AGENTS.md.template` and `examples/CLAUDE.md.template` reworded to drop the cross-tool tool list.
- SKILL.md `metadata.version` bumped to 1.9.0.

### Rationale

The cross-tool install machinery in v1.7 and v1.8 added detection, aliases, bootstrap, copy fallbacks, force flags, dual update scripts, and an eleven-tool Makefile matrix in service of supporting tools nobody on this project actually uses. The maintained surface is Claude Code plus the `~/.agents/skills/` standard. Stripping the rest cuts `install.sh` roughly in half, removes a redundant `update.sh`, removes the `scripts/` directory, and reduces the README from a support matrix into a five-command quickstart. Install and update are now short enough to fit in a single chat prompt to an agent.

## [1.8.0] - 2026-05-21

### Added

- `~/.agents/skills/` is now the primary install target. This is the cross-tool standard read natively by Zed (which reads only this path), Goose, Codex CLI, Gemini CLI, OpenCode, Cline, and any other Agent-Skills-compatible tool that follows the spec. `make install-all` and `./install.sh` (no args) symlink into `~/.agents/skills/paper-revision-editor` first, then into the native global directory of every other detected agent.
- New install targets: `install-opencode`, `install-goose`, `install-zed` (alias for `install-agents`), `install-junie`, `install-cline`, `install-roo`. Plus matching `uninstall-*` targets and `make install-agents` for cross-tool-only installs.
- `./install.sh --init` (or `make init`) scaffolds `AGENTS.md` in the current paper repo, prompting for venue, audience, thesis, and revision stage and substituting them into the template. Restores the interactive setup that v1.6 had and that v1.7 dropped. Also writes `CLAUDE.md` as a one-line bridge when missing.
- `./install.sh --bootstrap` and automatic `curl | bash` support. When the installer is piped via `curl ... | bash` (no SKILL.md beside the script) it clones the repo into `$PAPER_REVISION_EDITOR_HOME` (default `~/.local/share/paper-revision-editor`) and re-executes from there. Future `git -C` pulls in that location update every linked tool. Restores the one-line install that v1.6 had.
- Installer detection for `opencode`, `goose`, `zed`, `junie`, `cline`, `roo`.
- Installer auto-falls-back to copy mode when symlink creation fails (Windows without developer mode), instead of erroring.
- `FORCE=1` flag to install for a tool that detection missed. Also recognised by `uninstall` to clean up copy-mode installs.
- Same-destination de-duplication: `install-zed` and `install-agents` resolve to the same path, so `install-all` does not double-write.

### Changed

- `install-all` default order now starts with `agents`, ensuring the cross-tool location is always populated.
- Makefile generates per-tool targets from a single list, so adding a tool is one line.
- `README.md` updated with the new support matrix (which tools read `~/.agents/skills/` natively), one-line `curl | bash` quickstart, and the full per-tool target list. Windows note added.
- SKILL.md `metadata.version` bumped to 1.8.0.

### Rationale

After v1.7.0 the installer covered six tools but lost two features the v1.6 install had: the interactive paper-context prompt and the one-line `curl | bash` install. The brief also listed several Agent-Skills tools that v1.7.0 did not target (OpenCode, Goose, Zed, Junie, Cline, Roo Code). v1.8.0 closes both gaps. The bigger conceptual change is leaning into `~/.agents/skills/` as the primary install location: the spec calls for it, the newest tools (Zed) read only that path, and most other Agent-Skills tools (Codex, Gemini, OpenCode, Goose, Cline) read it as an alias. Installing there first means one symlink covers most of the ecosystem, and the per-tool targets exist as compatibility shims for tools that ignore `~/.agents/skills/` (Claude Code, Cursor, Copilot).

## [1.7.0] - 2026-05-21

### Added

- Cross-tool installer at the repo root (`install.sh`) plus a `Makefile` with per-tool targets (`install-claude`, `install-codex`, `install-openclaw`, `install-cursor`, `install-gemini`, `install-copilot`, and the matching `uninstall-*` targets). `make check` detects which agents are present on the current machine. Symlinks are the default so a single `git pull` in the cloned repo updates every installed tool.
- `.claude/agents/paper-reviser.md`: Claude Code subagent that dispatches to the skill in an isolated context. Restricted to `Read, Edit, Glob, Grep, Write` (no `Bash`). The skill remains the source of truth; the subagent is a thin wrapper so the main session sees only the four-section output.
- `examples/AGENTS.md.template`: drop-in `AGENTS.md` for paper repos. Defines `<paper_context>`, editing conventions, and the skill-invocation policy in the cross-tool format read by Claude Code, Codex, Gemini CLI, Cursor, Copilot Agent Mode, OpenCode, Goose, Cline, and Roo Code.
- `examples/CLAUDE.md.template`: one-line bridge that points Claude Code at `AGENTS.md`.
- `scripts/README.md`: documents the helper scripts and explains the v1.7 symlink update path.
- `AUDIT.md`: portability audit captured during this pass.

### Changed

- `SKILL.md` frontmatter is now spec-compliant against the Agent Skills open standard (https://agentskills.io/specification.md). The non-standard `version:` field moves to `metadata.version`. `license: MIT` is set explicitly. `allowed-tools` uses space separation as the spec requires. The `description` is rewritten to 169 characters, under 200, with the strongest trigger phrases first.
- `SKILL.md` body trimmed from 267 lines to under 200. Adds an explicit "When NOT to use this skill" section, an explicit "Constraints (hard rules)" list (no em-dashes, no meaning changes, no invented or removed citations, no silent deletes, preserve LaTeX, flag numerical-claim and figure-reference changes, do not rewrite quoted material, preserve author framing choices), and short good-vs-bad edit examples under "Editing principles". Existing semantics (revision-stage controls, reviewer-response branch, restraint, voice extraction, read-cold pass, length budget, four-section output) preserved.
- `SKILL.md` paper-context gate now reads `AGENTS.md` first (cross-tool standard), then `CLAUDE.md`, then `paper-meta.md`. Previously only `CLAUDE.md` and `paper-meta.md` were considered.
- `README.md` rewritten as a cross-tool guide: support matrix, per-tool install commands, per-repo git-submodule pin pattern, per-tool invocation syntax, and updated update instructions. Drops Claude-Code-only framing.
- `scripts/update.sh` moved from the repo root and re-labelled as the legacy updater for pre-v1.7 copy-based installs.
- `references/ai-tells-to-avoid.md`: em-dashes removed (replaced with alternative punctuation that demonstrates the rule it teaches).

### Removed

- Em-dashes throughout the repository (10 in the old README, 5 in the AI-tells reference). The skill bans em-dashes; the source files now obey their own rule.

### Rationale

The skill was operationally complete but marketed and packaged as a Claude-Code-only product. Every Agent-Skills-compatible tool can read the same `SKILL.md`, so the v1.7.0 pass keeps the skill semantics intact and ships the missing portability layer: a spec-compliant frontmatter, a cross-tool installer, a Makefile, a subagent dispatcher for Claude Code, an `AGENTS.md` template paper repos can drop in, and a submodule pin pattern for camera-ready freeze. The skill body picks up an explicit consolidated constraint list and good-vs-bad edit examples so readers do not need to open the references just to see what the skill enforces.

## [1.6.0] - 2026-05-21

### Added

- `SKILL.md`: a "Restraint: leaving prose unchanged" section. The skill now has an explicit no-edit pathway. A paragraph that clears six checks (topic sentence in the first two sentences, coherent topic string, stress position on the most important word, no banned transitions or AI tells, no nominalization where an active verb belongs, claims-evidence-interpretation distinguishable) is returned verbatim, with `Paragraph N: no safe improvement available` recorded in `Change rationale`. For whole-section requests, only the paragraphs that were actually touched appear in the rationale; a revision that touches every paragraph is flagged as suspect.

- `SKILL.md`: a "Voice extraction: before rewriting" section. Before producing the rewrite, the skill identifies three to five voice tics from the original passage across six common categories (pronoun policy, sentence length distribution, connective vocabulary, citation placement, punctuation tics, lexical preferences) and preserves the tics in the rewrite. Patterns that are problems regardless of authorship (nominalizations, throat-clearing, em-dashes, banned transitions, hedge stacks) are explicitly excluded from voice. When a voice tic conflicts with a style rule in `references/ai-tells-to-avoid.md`, the style rule wins.

### Changed

- `SKILL.md` (version 1.5.0 → 1.6.0): the `Diagnosis` output section now opens with an optional `Voice tics:` line for whole-section rewrites and first-draft passes, listing three to five tics extracted from the original so the author can confirm the read before reading the revised text. The line is skipped for single-paragraph requests and final-polish passes. The example block under `Diagnosis` reflects the new format.

### Rationale

Two claims in the prior skill versions were asserted but never operationalized. First, "preserve voice" lived in the description and in the "What is never edited" list, but the skill had no mechanism for distinguishing voice from generic academic register; preservation drifted toward a vibe. The voice-extraction step makes the operation concrete and visible to the author (via the `Voice tics:` preamble), which both improves preservation and gives the author an early checkpoint to correct misreadings. Second, every prior invocation produced revised text, which trained the model toward action even on paragraphs that already passed the diagnostic lens. The restraint section names a six-check bar for leaving prose alone and treats an unchanged paragraph as a valid rewrite output. The two changes work together: extracting voice up front makes the author's prose legible enough to know when leaving the prose alone is correct.

## [1.5.0] - 2026-05-21

### Added

- `SKILL.md`: a "Read-cold pass on the revised text" preflight sub-section. After producing the rewrite and before returning the four-section output, the skill re-reads the revised text alone and runs three checks on the rewrite in isolation: (1) every `this`, `that`, `it`, `they`, `these`, `those`, and `the [noun]` has an identifiable referent in the revised text alone; (2) the AI-tells diagnostic checklist from `references/ai-tells-to-avoid.md` runs against the output, not against memory of the rules; (3) the rewrite did not introduce new nominalizations, hedge stacks, or noun pile-ups while fixing other problems. Failures are fixed before the output is returned, not flagged as known defects.

- `SKILL.md`: a "Length budget" preflight sub-section. After the read-cold pass, the skill counts words in the original and in the rewrite (excluding citation commands, math environments, and LaTeX macros) and applies three thresholds: shorter needs no justification; within 5% is acceptable only when the original was already tight; longer requires a one-line justification in `Change rationale`. The "Change rationale" output section now opens with a `Word count: <before> → <after> (<signed percent change>).` line.

### Changed

- `SKILL.md` (version 1.4.0 → 1.5.0): the "Change rationale" output spec requires the new word-count line as the first line of the section, with an updated example block showing the format. The feedback-only path omits the word-count line.

### Rationale

Two failure modes recur in LLM-produced academic rewrites and the prior version of the skill had no enforcement against either. First, the rewrite drops antecedents that lived in the original phrasing, producing dangling `this`, `that`, and `the [noun]` references whose referents the reader cannot recover from the revised text alone. The read-cold pass forces a second look at the rewrite in isolation, which is the only condition under which dangling references become visible. Second, LLM rewrites tend to grow rather than shrink the section, accreting hedges and restatements in the name of clarity. Reporting word count before and after makes the bloat measurable; setting "shorter by default" as the expectation prevents the drift. Both checks run on the output, not the input, which is where prior style enforcement lived.

## [1.4.0] - 2026-05-16

### Added

- `references/edit-checks.md`: a pass-level checklist of ten structural and rhetorical edit-checks plus two framing meta-rules. The checks are drawn from writers whose papers are widely cited as a pleasure to read (Coase, Akerlof, Kleinberg, Schelling, Brooks, Lampson, Chetty, Varian, Roth, Hirschman, Dijkstra, McCloskey) and target the load-bearing paragraphs of a section: first paragraph, first paragraph of each subsection, paragraphs that introduce new claims. The ten checks are puzzle-first opening, one named idea per paper, question-before-machinery, working-not-illustrative examples, figures as primary text, progressive disclosure, named items in remembered lists, analogy discipline, promotional-adjective scrub, and standalone introduction-and-conclusion. The two meta-rules are layered audience passes (non-expert, generalist reviewer, technical expert) and default to a 20% cut. Loaded on demand when revising an introduction, abstract, or conclusion, or when the user asks for a holistic pass.

- `references/ai-tells-to-avoid.md`: new "Banned promotional adjectives" and "Banned framing phrases" subsections. The promotional list adds the adjectives `important`, `novel`, `interesting`, `significant` (outside the statistical sense), and `crucial`, with an edit move that tests whether the substance of the sentence survives deletion. The framing list adds the prefaces `We show that...`, `It is well known that...`, and repeated `In this paper, we propose...` after the contribution paragraph. The "Diagnostic checklist" at the bottom of the file picks up two new scan items for promotional adjectives and framing prefaces.

### Changed

- `SKILL.md` (version 1.3.1 → 1.4.0): added one load-on-demand pointer to `references/edit-checks.md` inside the diagnostic-lens preamble. Triggers are introductions, abstracts, conclusions, and holistic-pass requests. No changes to the gate, the revision-stage controls, the reviewer-response workflow, the four-section output format, or the section-specific lens.

- `install.sh` and `update.sh`: file list updated to fetch `references/edit-checks.md`.

- `README.md`: version badge, pinned-install URL example, manual-install snippet, files-created-in-your-repo table, and features-at-a-glance updated to reflect the new edit-checks reference.

### Rationale

The existing structural-patterns reference covers section architecture (what an abstract or introduction should contain) and the sentence-patterns reference covers sentence-level moves. The gap between them is the pass-level rhetorical moves that distinguish papers that are a pleasure to read: puzzle-first openings, one named idea, examples that rule out alternatives rather than illustrate claims, figures that carry the argument, named principles in remembered lists. These moves are mostly diagnostic rather than generative: an editor checks for them, and the failure modes are concrete enough to act on. Keeping them in a separate file lets the skill load them only when the section type calls for them (introductions, abstracts, conclusions, holistic passes) without inflating the always-in-context part of the skill.

## [1.2.1] - 2026-05-15

### Fixed

- Cross-reference paths inside the new reference files (`principles.md`, `sentence-patterns.md`) now use the `references/` prefix to match SKILL.md's convention. Previously they used bare filenames (`structural-patterns.md`, `sentence-cohesion.md`, `ai-tells-to-avoid.md`), which could cause file-not-found lookups in workflows that follow paths literally.

## [1.2.0] - 2026-05-15

### Added

- `references/principles.md`: deeper exposition of the theoretical grounding behind the diagnostic lens. Covers Williams (character-action sentences, old-new flow, stress position), Gopen and Swan (reader-expectation theory), Pinker (curse of knowledge, classic style), McEnerney (writing for readers, not for self), Mensh and Kording (paper architecture), with examples and exceptions. Loaded on demand when an edit needs justification beyond "this reads better".

- `references/sentence-patterns.md`: a named-pattern catalog with before-and-after tables. Covers nominalizations, throat-clearing openings, existential and expletive constructions, noun pile-ups, hedge stacking, misplaced stress, wordiness compounds, vague abstractions, misused connectives, dangling references, and voice issues. Pattern names ("nominalization", "misplaced stress") are usable as labels in the change rationale output. Does not duplicate the banned-transition list in `ai-tells-to-avoid.md`.

- `references/structural-patterns.md`: section-by-section deep guidance for abstracts (Mensh-Kording structure), introductions (the McEnerney test), related work (organize by position, not by person), methodology, results, discussion, conclusion, plus rebuttal letters and grant proposals. Mirrors the section list in SKILL.md's "Section-specific lens" and expands each from a one-liner to a full diagnostic. Loaded on demand.

### Changed

- `SKILL.md`: added three load-on-demand pointers to the new reference files. No changes to the diagnostic lens, the four-section output format, the gate, the revision-stage controls, or the reviewer-response workflow.

- `install.sh` and `update.sh`: file list updated to fetch the three new references.

- `README.md`: features-at-a-glance and files-created-in-your-repo tables updated.

### Rationale

The existing skill is operationally strong (per-paper context, three revision stages, reviewer-response branch, strict output format, explicit voice preservation) but lean on theoretical grounding. The diagnostic lens invokes moves ("old information first, new information last") without attribution or exposition. For maintenance work that's fine; for first-draft work and for cases where the author asks why a move works, having the source material accessible as load-on-demand references is useful. The three additions sit at the same architectural layer as `sentence-cohesion.md` and `ai-tells-to-avoid.md`: depth available when needed, no weight added to the always-in-context part of the skill.

## [1.1.0] - 2026-05-07

### Added
- Stage-aware behavior table: `revision_stage` (`first draft`, `response to reviewers`, `final polish`) now maps to explicit do/don't rules in SKILL.md. Previously the field was documented in the README but had no effect on output.
- Reviewer-response workflow: explicit steps for ingesting reviewer comments, mapping them to paragraphs, labeling diagnosis items with the reviewer concern, and surfacing requests that cannot be addressed from prose alone.
- "What is never edited" section calling out citations, citation commands, cross-references, math environments, custom macros, and LaTeX comments. Closes a gap where preservation rules were only in the README.

### Changed
- Banned words and banned phrases are no longer duplicated in SKILL.md. `references/ai-tells-to-avoid.md` is the single source of truth.
- `references/ai-tells-to-avoid.md` is now author-agnostic. Removed the email-closing style rule, which did not belong in a paper-revision skill.

## [1.0.0] - 2026-05-07

Initial versioned release.

### Included
- SKILL.md with TRIGGER / DO NOT TRIGGER frontmatter for reliable activation
- Diagnostic lens: structural integrity, paragraph craft, reader experience, sentence-level cohesion, claims-evidence discipline
- Section-specific guidance for Introduction, Related Work, Methodology, Results, Discussion, Conclusion
- Style constraints: no em-dashes, no AI transition words, no hedging filler
- Diagnose-then-revise output format with author-question flagging
- references/sentence-cohesion.md: deep treatment of given-new contract, topic strings, stress position, nominalization
- references/ai-tells-to-avoid.md: banned words, banned phrases, em-dash policy, house style
- Per-paper context loaded from CLAUDE.md or paper-meta.md at the repo root
- One-line installer (`install.sh`) and version-aware updater (`update.sh`)
- `REF` environment variable in `install.sh` for pinning skill content to a release tag (e.g. `REF=v1.0.0`); defaults to `main`

[1.16.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.15.0...v1.16.0
[1.15.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.14.0...v1.15.0
[1.14.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.11.0...v1.14.0
[1.11.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.10.0...v1.11.0
[1.10.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.9.0...v1.10.0
[1.9.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.8.0...v1.9.0
[1.8.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.7.0...v1.8.0
[1.7.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.6.0...v1.7.0
[1.6.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.5.0...v1.6.0
[1.5.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.2.1...v1.4.0
[1.2.1]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/ipeirotis/paper-revision-editor/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/ipeirotis/paper-revision-editor/releases/tag/v1.0.0
