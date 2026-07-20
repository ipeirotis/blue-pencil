# Altitude

Load this when a passage carries detail its section does not want: an abstract or introduction clogged with statistical machinery, a topic sentence that opens on a caveat, a summary paragraph stacking secondary numbers, or a high-level claim trailing its own confidence interval. The Subtraction reference (`references/subtraction.md`) decides whether a unit earns its place at all; this file decides which section a unit that does earn its place belongs in. The two questions are independent: a caveat can be load-bearing, so the keep-test keeps it, and still sit three sections too high, so the altitude test moves it.

## The altitude of a passage

Every passage sits at an altitude, and detail has a home. High-altitude text (the abstract, section openers, topic sentences, the contribution paragraph) states findings and claims. Low-altitude text (Methods, Results, the body of a section) carries the machinery that supports each finding: the model class, the estimator, specification sweeps, confidence intervals, design caveats, single-source limitations. Obtuse prose is almost always detail that floated up out of its home section. The reader meets the inferential apparatus before they have any reason to want it, and the claim it was built to support is buried inside it.

The fix is not to compress the detail. It is to move it down to the section that wants it. A clause pitched three sections below its passage is a relocation, not a word cut: send it home, note the move in `Change rationale`, and when the move would cross the requested scope, raise it in `Author questions` instead of performing it. Moving a numerical or statistical clause still trips the numerical-claim constraint, so flag it there as well.

## Three directives

**Report the finding, not the machinery.** Above the Results section, a result is direction plus magnitude plus one significance marker. Everything that produced the number, the model class, the level at which inference runs, robustness across specifications, and the confidence interval, stays in Results.

Too high (abstract): "a mixed-effects model on log completion time, with inference at the participant level where treatment was assigned, estimates a 31% reduction per query (p = 0.03, 95% CI 4% to 51%); the raw-scale estimate of 212 s is borderline across inferential specifications (p = 0.04 to 0.07)."

At altitude: "users took about 31% less time (p = 0.03)." The model, the inference level, the specification sweep, and the interval are the Results section's job; the abstract needs the direction, the magnitude, and one marker that the effect held. Simplify the wording, never the estimand: a 31% cut in completion time is not a 31% gain in speed (the throughput change is larger), so keep the quantity the source actually measured. Recasting one into the other changes a numerical claim and trips the numerical-claim constraint.

**Send each caveat to its home section.** A design qualification belongs in Methods; a single-annotator or sample-size limitation belongs in Limitations. Never voice a caveat at the moment you first state the claim it qualifies. The reader has not yet grasped the claim, so the hedge lands as noise, and a preemptive limitation reads as apology where a well-placed one would read as competence. Relocation is not deletion, though: a caveat is content (constraint 6). Move it only when its home section already carries it, or is in scope for you to place it there. When you cannot confirm that (the destination is outside the requested unit, or the manuscript states the caveat nowhere else), the abstract's caveat is the only visible scope signal, so raise the move in `Author questions` rather than cutting the signal and letting the claim broaden.

Too high (abstract): "each transcript coded by a single annotator"; "each task carried a hint that disambiguated its phrasing for both arms, so our results describe performance under disambiguated task framing."

At altitude: move the disambiguation design to Methods and the single-coder limitation to Limitations, once you confirm each is stated (or can be stated) there. If neither is, and the abstract is the only place the scope appears, keep it or flag the relocation in `Author questions`; the abstract's external-validity claims must not widen silently.

**Keep one number per claim; send the rest down.** A confidence interval, a range, or a secondary p-value stacked onto a single headline figure is a Results move, not an abstract one: state the point estimate and one marker, and the precision rides down into the body.

A derived or combined metric is different, and the keep-test decides it before the altitude test moves it: ask whether the number changes the conclusion the reader draws at this altitude. Correct-answers-per-hour is derived from the two headline findings, but in a speed-versus-accuracy study it can be the combined endpoint that answers the paper's question (did the speed gain produce more correct work?); when it is, it is load-bearing and stays, derived or not. Send it down only when the headline findings already carry that conclusion on their own.

Too high (abstract): "an 18-point deficit (p = 0.08) whose 95% confidence interval runs from a 39-point deficit to rough parity."

At altitude: "an 18-point deficit (p = 0.08)." The interval is a second statistic on the same claim and belongs in Results; the point estimate and one marker carry the finding at abstract altitude.

## The altitude test

For any sentence that reads dense, ask: what is this sentence's altitude, and does every clause in it belong at that altitude? A clause pitched below the passage is the edit, and the edit is to move it, not to compress it.

The altitude test composes with two neighbours. The keep-test (`references/subtraction.md`) asks whether a clause survives at all; the altitude test asks where the survivor belongs. And a finding stated once does not get clearer by being restated in fresh words: the restatement, including the "here is what it means" echo that adds no new claim, is a cut under the say-it-once rule in `references/subtraction.md`, not a relocation.

## The load-bearing sentence is the plainest

The sentence carrying a passage's main point should be the easiest sentence in it to parse, not the hardest. When the takeaway is the most nested, most clause-laden sentence in the paragraph, the reader works hardest exactly where they can least afford to. Keep the closing claim of an abstract or section short, with a concrete subject, an active verb, and no stacked subordinate clauses; push the qualifications into a following sentence. The sentence-level pattern, with a before-and-after, is "The buried thesis" in `references/sentence-patterns.md`.
