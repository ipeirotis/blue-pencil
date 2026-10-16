### 1. Diagnosis

**Assumed context:** None. Audience, stage, venue and thesis all come from `AGENTS.md`. I skipped the venue-specific framing check because I have only the opening, not the whole paper.

**Voice tics, preserved:**
- First-person plural ("we").
- Author-year citations in a closing parenthetical.
- The hedged novelty claim "to the best of our knowledge".
- A formal register with a "however" pivot into the gap.
- A managerial recommendation about platform design.

**Reader map:**
- The reader starts out knowing that online reviews move sales.
- They must learn that reviewer identity is the unexamined factor and that this paper tests it.
- They should leave believing identity matters and platforms should consider surfacing reviewer credentials.

**Findings:**
1. **P1, S1:** The opening is a textbook context sentence wrapped in throat-clearing ("It is important to note that", "fundamentally", "the way in which"). I compressed it. A puzzle-first opening would need content the manuscript doesn't contain.
2. **P1, S2–S3:** "Furthermore" and "Moreover" join what is really one sequence: researchers studied the link, then found a result. S2 buries the researchers in a passive nominalization ("an investigation ... was conducted by"). S3 is a comma splice.
3. **P1, S4:** "Crucially" is a banned transition. The gap claim stacks two hedges ("to the best of our knowledge" and "somewhat"). The term drifts between "identity of reviewers" and "reviewer identity".
4. **P2, S2:** The finding is framed as "The results of our analysis demonstrate that" and names no outcome, direction or magnitude. "Significant" could mean statistical or substantive. The scope marker (your own analysis) must stay so the claim doesn't broaden.
5. **P2, S1:** "Novel" is promotional, "leverage" should be "use", and "comprising of" is ungrammatical. The dataset has no anchor such as source, period or how identity is observed.
6. **P2, S3:** "It should be noted that" and "important implications" announce significance instead of showing the consequence. The step from the finding to "highlighting credentials" is an unstated inference.
7. **Precision census:**
   - "to the best of our knowledge" is an epistemic keeper and stays.
   - "somewhat" is a second hedge on the same claim and is filler.
   - "should consider" is a calibrated recommendation and stays.
   - The spine is intact, so no reordering is needed.

The only measured anchor in the text is the 5–9% per star. There is no comparable figure for identity.

### 2. Revised text

```
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several researchers have investigated the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). They found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, whether reviewer identity affects this relationship remains underexplored in the literature, to the best of our knowledge.

To investigate this question, we use a dataset of 1.2 million reviews. In our analysis, reviewer identity has a significant effect. For platform design, this finding implies that managers should consider highlighting reviewer credentials.
```

### 3. Change rationale

**Word count:** about 140 to about 90 (−35%).

**References loaded:** principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Every pass in the sweep ran. The two whole-paper references (cold-read.md and consistency-checks.md) were not loaded.

- **S1:** "It is important to note that the proliferation ... has fundamentally transformed the way in which consumers make" became "The proliferation ... has transformed how consumers make". This removes a hedging phrase, an intensifier and a wordiness compound, and puts the subject first.
- **S2:** "Furthermore, an investigation ... was conducted by several researchers" became "Several researchers have investigated ...". The researchers are now the subject, the passive nominalization is an active verb, and a banned transition is gone.
- **S3:** "Moreover, these studies found that reviews matter, a one-star ..." became "They found that reviews matter: a one-star ...". A colon fixes the comma splice and the transition is dropped. The tense stays "found".
- **S4:** "Crucially, however, the question of whether the identity of reviewers affects" became "However, whether reviewer identity affects". This removes a banned transition, makes the term consistent with P2, and cuts the nominalized "the question of".
- **Hedges:** "somewhat underexplored in the existing literature" became "underexplored in the literature". Dropping the second hedge leaves "to the best of our knowledge" as the claim's only hedge. I moved it to the end of the sentence so "remains" sits next to its complement.
- **Dataset:** "In order to investigate ... we leverage a novel dataset comprising of 1.2 million reviews" became "To investigate ... we use a dataset of 1.2 million reviews". This drops a promotional adjective, replaces "leverage" with "use", and fixes "comprising of". The number is unchanged.
- **Finding:** "The results of our analysis demonstrate that reviewer identity has a significant effect" became "In our analysis, reviewer identity has a significant effect". The announcing frame is gone, and the scope qualifier stays so the claim doesn't broaden.
- **Implication:** "It should be noted that this finding has important implications for platform design: managers should consider highlighting reviewer credentials" became "For platform design, this finding implies that managers should consider highlighting reviewer credentials". This removes the throat-clearing and states the consequence directly. The colon is gone, so one voice tic is lost, but the colon only served the announcement. "Should consider" is unchanged.
- **Paragraphs:** No reordering or merging. The two-paragraph funnel from context to gap to approach already carries the spine.

### 4. Author questions

- **The 5–9% figure:** Does it come from all three cited studies or only one? Should "leads to" stay causal, or are these associations? I kept the number verbatim but changed the sentence around it, so please confirm the claim and its attribution are unchanged.
- **Terminology:** Which attribute does "reviewer identity" mean, and is "reviewer credentials" the same construct? I kept both terms because they may name different things.
- **"Significant":** Does it mean statistically or substantively significant? What is the effect on (sales, or the rating-to-sales relationship), in which direction, and how large? A magnitude comparable to the 5–9% per star would give the intro a concrete anchor. Is "effect" causal?
- **"Novel":** I deleted it. If novelty is part of your contribution, what is new about the data (source, period, how identity is observed)?
- **"Underexplored":** I cut "somewhat". Is "underexplored" the strength you want, or does some prior work touch identity directly?
- **Results consistency:** Does your Results section state the finding in full, with the same sign and rough magnitude? I can't verify this from the pasted text.
- **Managerial step:** What in your analysis licenses the move from the finding to "highlighting reviewer credentials"? I can't supply a missing bridge here.
- **"Managers":** Does it mean platform managers or sellers?
- **Core thesis:** Your thesis is that identity, not just the rating, shapes how much a review moves sales. The opening never states that contrast. Is it the phrase you want readers to carry away, and where should it appear?