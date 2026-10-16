### 1. Diagnosis

Assumed context: none. The audience, revision stage, venue and core thesis all came from `AGENTS.md`.

**Voice tics kept:**
- first-person plural ("we", "our")
- the calibrated novelty hedge ("to the best of our knowledge")
- sentence-initial "however"
- author-year citations at the end of the sentence
- the colon that turns a finding into its consequence

**Reader map:** The reader starts out knowing that reviews relate to sales. They need to learn that reviewer identity affects that relationship. They should leave thinking platforms should surface reviewer credentials.

**Jargon:** "Reviewer identity" and "reviewer credentials" are never defined. Does identity mean real name, expertise, badge or review history? Is "credentials" the same construct? This goes to Author questions.

**Buried lede:** The contribution (does identity change the reviews-sales relationship?) first appears in sentence 4, after three setup sentences.

**Concrete anchor:** "A one-star increase leads to a 5-9% increase in revenue" gives "this relationship" a tangible referent, and the rewrite keeps it in that role.

1. **Opening (P1 S1-S2):** Sentence 1 is a generic scene-setter, and nothing links "online platforms" to "online reviews". I kept it, because cutting it would be a structural choice that belongs to you. One option is to open at the reviews-sales literature instead (see Author questions).
2. **Spine (P1-P2):** The argument is findable: platforms change decisions and reviews matter, but identity is unexamined, so you built a 1.2 million-review dataset. The payoff is thin, though. "Significant effect" gives no direction, magnitude or object. Your core thesis ("identity, not just the rating…") is not stated in the passage, and I did not import it because that would add substance.
3. **Accumulation (P1 S2-S4):** "Furthermore" and "Moreover" join sentences whose real relations are elaboration and contrast. I rebuilt the links from the content.
4. **Hedges (P1 S4):**
   - "To the best of our knowledge" stays as the one hedge on the novelty claim.
   - "Somewhat" is a stacked hedge on "underexplored", which is already soft, so I cut it.
   - "In the existing literature" restates what "underexplored" means, so I cut it.
   - An interposed hedge held the subject-verb gap open.
   - "Crucially" is a banned transition and a promotional adjective.
5. **Splice and terms (P1 S3):** There is a comma splice ("matter, a one-star…"). "Sales" (S2) and "revenue" (S3) may name different constructs.
6. **Precision debt (P2 S2):** The full statement of "significant effect" belongs in Results, which is out of scope here. It is marked unverified, and "significant" is read as statistical.
7. **Sentence level:** The text has throat-clearing ("It is important to note that", "It should be noted that"). It also has a nominalized passive ("an investigation… was conducted"), "the way in which", "In order to", "leverage", "novel", "important" and "comprising of".

### 2. Revised text

```
The proliferation of online platforms has fundamentally transformed how consumers make purchasing decisions. Several researchers have studied the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. However, to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. In this dataset, reviewer identity has a significant effect. This finding has implications for platform design: managers should consider highlighting reviewer credentials.
```

Added bridges: None.

### 3. Change rationale

Word count: about 130 to about 90 (-30%).

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. No pass was skipped. `cold-read.md` and `consistency-checks.md` are whole-paper passes outside this sweep.

- **"It is important to note that the proliferation… the way in which consumers make" → "The proliferation… how consumers make":** Removed throat-clearing, a promotional adjective and a wordy compound, and put the topic in the subject slot. "Fundamentally" stays because it may rule out a milder reading.
- **"Furthermore, an investigation… was conducted by several researchers" → "Several researchers have studied…":** Removed a banned transition and a nominalized passive, and put a character in the subject. The citations are unchanged and in the original order.
- **"Moreover, these studies found that reviews matter, a one-star increase…" → "These studies found that reviews matter: a one-star increase…":** Removed a banned transition and fixed the comma splice. "5-9%" is untouched.
- **"Crucially, however, the question of whether the identity of reviewers affects this relationship remains, to the best of our knowledge, somewhat underexplored in the existing literature" → "However, to the best of our knowledge, whether reviewer identity affects this relationship remains underexplored":**
  - Removed "Crucially" and moved the hedge to the front, which closes the subject-verb gap.
  - "The identity of reviewers" became "reviewer identity", matching the term in P2.
  - The sentence now ends on the gap, in the stress position.
  - "However" stays as your own contrast marker.
- **"Somewhat" cut:** It was a stacked hedge, and "underexplored" already softens the claim. See Author questions.
- **"In the existing literature" cut:** It was filler.
- **"In order to investigate this question, we leverage a novel dataset comprising of 1.2 million reviews" → "To investigate this question, we use a dataset of 1.2 million reviews":** Removed a wordy compound, "leverage", "novel" and the ungrammatical "comprising of". Restoring a claim that the dataset is novel is your call. "1.2 million" is unchanged.
- **"The results of our analysis demonstrate that reviewer identity has a significant effect" → "In this dataset, reviewer identity has a significant effect":** Removed the "demonstrate that" frame. The dataset-scope qualifier keeps the claim from broadening past the data. "Significant" is kept on the assumption that it is statistical.
- **"It should be noted that this finding has important implications" → "This finding has implications":** Removed a hedging phrase and a promotional adjective.
- **Not done:** I did not cut or reorder the opening sentence. I did not redistribute the citations or add any definitions, direction or magnitude, since the manuscript gives no source for them.

### 4. Author questions

- Do all three cited studies report the 5-9% figure, as "these studies found" implies, or does it come from one or two of them?
- Is "a one-star increase leads to a 5-9% increase in revenue" a causal estimate in those studies? Or should it read "is associated with"? I kept your wording.
- Do you want "sales" or "revenue" used throughout, or do they mean different things?
- Does your house style write the range as "5-9%", with an en dash, or as "5 to 9%"? I left it as typed.
- How do online reviews connect to the platform-driven change in purchasing decisions in the opening sentence? Should the introduction open at the reviews-sales literature instead?
- What exactly is "reviewer identity" (real name, expertise, badge, review history)? Is "credentials" the same construct or a subset? Which term should the paper use?
- "Has a significant effect" on what, in which direction, and how large? Is "significant" statistical? Should the introduction add a one-line magnitude, with Results holding the full statement?
- Do you want the introduction to state your core thesis ("identity, not just the rating, shapes how much a review moves sales") as the paper's one memorable idea? The one-star setup already makes room for it.
- Do you accept that "underexplored" plus "to the best of our knowledge" keeps the intended calibration now that "somewhat" and "in the existing literature" are cut?
- You called the dataset "novel", and I removed the word. Should the introduction say what is new about it, for example what identity information it carries?
- Does the finding that identity matters imply that highlighting credentials helps, or does that recommendation rest on a result I can't see here? Is there a one-sentence mechanism for why identity should matter that ISR readers would expect?