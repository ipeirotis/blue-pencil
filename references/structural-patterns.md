# Structural patterns

Section-by-section deep guidance. Load this when the section-specific lens in SKILL.md is not enough for the section at hand, when an abstract or rebuttal needs more than the one-liner, or when an author asks why a given section is failing.

Sections below mirror the section list in SKILL.md's "Section-specific lens", plus Abstract (which SKILL.md does not enumerate) and Rebuttal letters and grant proposals (which appear in academic revision work).

## Abstracts

An abstract is a complete miniature of the paper, not a teaser. Following Mensh and Kording, an abstract should contain, in order:

1. **Context** (1-2 sentences). What field is this, and what is the broad question? Pitched to the broadest plausible reader of the venue.
2. **Gap** (1-2 sentences). What specifically is missing or wrong in the current state of knowledge?
3. **Contribution** (1 sentence, often starting with "Here we"). What this paper does. Use an active verb.
4. **Evidence** (2-4 sentences). The strongest pieces of support, with numbers where possible.
5. **Implications** (1-2 sentences). Why this matters for the reader's community.

Common pathologies:

- **Front-loaded context.** Four sentences of background before the gap appears. Abstract readers will quit. The gap should arrive by sentence three.
- **Buried contribution.** The contribution is in the last sentence or, worse, implicit. Readers should not have to infer what the paper claims.
- **Vague evidence.** "We show that the method works well." How well? Compared to what? Numbers belong in abstracts when they exist.
- **Missing implications.** The abstract ends with "We discuss implications." This is a placeholder, not implications. State the implication.

Diagnostic: can a reader who reads only the abstract correctly summarize the paper's contribution to a colleague? If not, the abstract is failing its job.

## Introductions

An introduction has more degrees of freedom than an abstract, but the same load-bearing structure. The classic funnel (Mensh and Kording, adapted):

1. **Broad context.** What is the field? What does it care about? Two or three paragraphs at most.
2. **Specific gap.** What is missing or wrong? This is where the work is justified. One to two paragraphs.
3. **Contribution paragraph.** What this paper does, what it shows, why it matters. Often introduced with "In this paper, we" or "Here, we". This paragraph should come no later than the bottom of page 1 in a typical conference paper; in a journal article, by the end of the second page.
4. **Preview of structure** (optional and often skippable). "The remainder of this paper is organized as follows." Many venues now treat this as boilerplate; consider whether it serves the reader.

McEnerney's test for introductions: has the reader, by the end of the introduction, been told (1) what specific community of readers this is for, (2) what is at stake for them, (3) why this is hard, and (4) what the paper claims? If not, the introduction is writer-centered, not reader-centered.

Common pathologies:

- **The textbook opening.** "X is a fundamental problem in field Y." Almost every paper in your field starts this way. The opening sentence is wasted. Start with something specific.
- **The literature dump.** Pages of "Smith (2018) showed... Jones (2019) extended... Lee (2020) proposed..." with no organizing claim. Related work belongs in its own section. The introduction needs the reader to feel the gap, not survey the field.
- **The everything-but-the-contribution paragraph.** A long paragraph that gestures at the contribution without stating it. Often signals that the author has not yet decided what the contribution is.
- **Hedged contribution.** "We hope to shed some light on the question of whether..." If you cannot state the contribution as a claim, the paper is not ready.

## Related work

Related work has two failure modes: the annotated bibliography and the strategic non-engagement.

**The annotated bibliography failure:** paragraph after paragraph of "Author X did this. Author Y did that. Author Z did the other." There is no organizing claim. The reader cannot tell which work is most relevant, which is contradicted, which is built on. The paper is just demonstrating that the author has read things.

**The strategic non-engagement failure:** related work that conspicuously omits the work the paper most needs to address, or mentions it in one sentence buried at the end of a paragraph. Reviewers notice this.

The fix: organize related work by *position*, not by *person*. Each subsection or paragraph should articulate a position (a methodological approach, a theoretical framing, an empirical claim) and place the cited works within it. The paper's relationship to each position should be explicit: which position does this paper extend, contradict, synthesize, or sidestep?

A useful test: would the related work section make sense if all the citations were removed? If yes, the section has structure. If no, it is just a list of works.

## Methodology

Methods sections have different conventions across fields (a computer science methods section looks nothing like a biology one), but a few patterns hold:

- **Reproducibility first.** A reader trying to replicate should be able to. Specify the dataset, the preprocessing, the model, the hyperparameters, the evaluation, the environment. When details cannot fit, point to an appendix or repository.
- **Justify the choices that matter.** "We used a learning rate of 1e-4" is fine if standard. "We used a learning rate of 1e-4 because..." is needed when the choice is unusual.
- **Match the level of abstraction to the contribution.** If the contribution is methodological, methods need detail. If the contribution is empirical, methods can be compressed (with full detail in an appendix).

The most common methods pathology is the **procedural recitation**: a chronological account of what the authors did, in the order they did it, with no structural signal of what matters. Methods should be organized for the reader's understanding, not the author's memory of the project timeline.

## Results

Results sections in scientific papers usually follow a claim-evidence-claim-evidence pattern. Each paragraph should:

1. Open with a claim ("The model outperformed the baseline by 12 points on benchmark X").
2. Present the evidence (numbers, figure references, statistical tests).
3. Connect to the next claim.

Common pathologies:

- **Figure-driven prose.** Each paragraph describes a figure ("Figure 3 shows..."). The figures are leading the writing. Lead with the claim and reference the figure as evidence.
- **Result-by-result chronology.** "First we tried X. Then we tried Y." The reader does not need the chronology; they need the claims, organized for argument.
- **Result-discussion blur.** Results sections that interpret rather than report. Most journals want this clean: results sections report, discussion sections interpret. Some venues (CS conferences) blur the line; know your venue.

## Discussion

The discussion is where the paper does its argumentative work. A useful structure:

1. **Restate the contribution** (1 paragraph). What the paper showed. Without "In conclusion".
2. **Interpret the results** (multiple paragraphs). What do they mean? What do they imply for the community? What did we learn?
3. **Address limitations honestly** (1-2 paragraphs). What this paper does not show. What the data cannot tell us. Where future work is needed.
4. **Point to future work** (1 paragraph). Specific, not generic. "Future work should investigate X under condition Y" is useful; "Future work could explore many directions" is not.
5. **Final paragraph.** The take-away. What you want the reader to remember.

Common pathologies:

- **The discussion-that-is-just-a-summary.** Restates results without interpreting them. Wastes the most important section.
- **The discussion-that-overclaims.** Treats correlational evidence as causal, generalizes from one dataset to all cases, extrapolates from a controlled study to the wild. Catch this yourself before reviewers do.
- **The discussion-without-limitations.** Either there are none stated (implausible) or they are buried in one sentence. Reviewers read this as evasion.
- **The discussion-with-too-many-limitations.** The author hedges everything until the contribution disappears. Limitations should be honest, not abject.

## Conclusion

A conclusion is synthesis, not summary. The reader has just finished the paper; they do not need a recap. They need to know what the take-away is.

A useful structure:

1. **The single most important sentence.** What should the reader carry away?
2. **What this enables.** Implications for the community.
3. **Future directions** (optional). Specific, not generic.

Common pathologies:

- **The summary conclusion.** Restates the abstract. Adds no value.
- **The future-work-dump conclusion.** Lists ten directions the reader should pursue. If everything is interesting, nothing is.
- **The conclusion that introduces new claims.** A conclusion is not the place to introduce a claim the body did not support.

## Rebuttal letters and response-to-reviewer documents

Rebuttals have their own genre conventions, and most authors get them wrong. Use this section when SKILL.md's reviewer-response workflow is invoked.

**Structure that works:**

1. **Opening paragraph (or two):** thank the reviewers, summarize the changes you made at the highest level, and signal where you agreed and where you disagreed (with respect).
2. **Per-reviewer or per-comment responses.** Quote the reviewer's comment in a distinguishing format (italics or a quote block). Respond directly. If you made a change, point to the page and section. If you did not, explain why with evidence.
3. **A change log.** Specific changes, with locations.

**Tone:** respectful but not abject. Reviewers can tell when an author is grateful for engagement vs. when they are performing gratitude. The line is in specifics: thanking a reviewer for "the thoughtful comment about the choice of baseline" is different from thanking them for "their valuable feedback".

**Disagreements:** state them clearly. "We respectfully disagree, for the following reason: ..." is fine. Wishy-washy half-agreements are read as evasion.

**Common pathology:** the rebuttal that promises future changes without making any. Reviewers want to see the change, not the promise.

## Grant proposals

Grant proposals have stronger genre conventions than papers and vary across funding agencies. A few cross-agency principles:

- **The reviewer is a tired, time-constrained domain colleague**, not a specialist in your exact subfield. Write for them.
- **The first page must do most of the work.** Many reviewers form an impression in the first page that everything afterward only modulates. Front-load the contribution, the significance, and the approach.
- **Significance and innovation must be argued, not asserted.** "This is the first work to..." is an assertion. "Existing approaches fail because X, Y, Z, and our approach addresses all three" is an argument.
- **Specific aims are the spine.** They should be specific enough to evaluate and tied together by a clear logic. Vague aims signal a project that does not know what it is.
- **Risk and mitigation belong in the proposal.** Pretending there is no risk reads as either naïve or dishonest. Naming the risks and how you will handle them reads as competent.

Agency-specific structures (NSF's Intellectual Merit / Broader Impacts split; NIH's Specific Aims / Significance / Innovation / Approach; ERC's ground-breaking nature / risk-gain) impose their own architectures, and the proposal should follow them faithfully. Bend the prose to the agency's structure, not the other way around.
