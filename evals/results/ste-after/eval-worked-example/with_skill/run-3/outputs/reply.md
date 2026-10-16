## 1. Diagnosis

Assumed context: none. All four `paper_context` fields are present. Triage was preset: direct rewrite, whole supplied unit, first-draft aggressiveness.

**Voice tics**
- "we" for the authors' own actions.
- Author-year citations in parentheses at sentence end, with no comma before the year.
- A colon that introduces a consequence ("platform design: managers should...").
- "The question of whether..." framing, with an explicit calibration of the novelty claim ("to the best of our knowledge").
- A two-paragraph move: prior literature and gap, then data, finding, and implication.

**Reader map:** The reader starts with a working knowledge of online platforms and some of the review-sales literature. They must learn that who writes a review changes how much that review moves sales. They should leave with two ideas: identity matters beyond the star rating, and platforms can act on that.

**Jargon:** "Reviewer identity" is never defined (which attributes?), and "reviewer credentials" appears later. The manuscript doesn't define either, so this goes to the author questions.

**Buried lede:** The finding is the second sentence of P2, after generic setup. The paper's contrast ("identity, not just the rating") is never stated, though the text holds both halves of it.

**Concrete anchor:** The 5-9% per star figure is the only measured consequence in the passage. It is the baseline against which "identity matters" would register, but the paper's own effect has no size or outcome stated.

1. **[P1, sentence 1]** The opening is a textbook sentence. It never mentions reviews, so the reader doesn't feel the gap until sentence 4. I didn't reorder, because a structural move here is your call. One option is to open on the review-sales finding and let the platform sentence follow, if it is needed at all.
2. **[P1 to P2, spine]** The spine is present but sits under stock connectives. In ABT form: platforms changed purchasing and reviews move sales (5-9% per star), but whether reviewer identity matters is unexamined, therefore we test it on 1.2 million reviews and find that it does. The turn ("Crucially, however") and the additions ("Moreover", "Furthermore") are carried by banned transitions, not by the content. The memorable idea (the core thesis, "identity, not just the rating") is missing from the text.
3. **[P2, sentence 2]** The headline finding has no outcome and no size: "a significant effect" on what, and how large next to the 5-9% rating effect? "Significant" can also be read as either statistical or substantive. I couldn't repair this from the page.
4. **[P1, sentence 4]** The sentence holds its core open with an interposed adverbial ("remains, to the best of our knowledge, somewhat underexplored in the existing literature"). It also stacks two hedges. The hedge census found three hits:
   - "to the best of our knowledge": an epistemic hedge on the novelty claim, kept.
   - "somewhat": a scope degree on "underexplored", kept.
   - "should consider": a recommendation, not a hedge on a finding.

   The first two are one more hedge than the one-per-claim rule allows, and I left that call to you.
5. **[P1, sentences 2 and 3]** A nominalization with a passive ("an investigation... was conducted by several researchers") hides the actors. A comma splice joins "reviews matter" and the 5-9% claim. "Furthermore" and "Moreover" are banned, and the second sentence ends on a citation instead of the claim.
6. **[P2]** The sentence has throat-clearing ("It should be noted that"), banned promotional adjectives ("novel", "important"), "leverage", "comprising of", and a "results of our analysis demonstrate" frame. "This finding has important implications" announces significance without showing it.
7. **[P1, P2]** The referents "these studies" and "this relationship" lacked a noun in the source. "These studies" pointed at "researchers", and "this relationship" crossed a paragraph break.

## 2. Revised text

```
The proliferation of online platforms has transformed how consumers make purchasing decisions. Several studies have examined the relationship between online reviews and sales (Chevalier and Mayzlin 2006; Forman et al. 2008; Dellarocas 2003). These studies found that reviews matter: a one-star increase leads to a 5-9% increase in revenue. Yet to our knowledge, the question of whether reviewer identity affects this relationship remains somewhat underexplored.

To investigate this question, we use a dataset of 1.2 million reviews. In these data, reviewer identity significantly affects the relationship between reviews and sales. Platform managers should therefore consider highlighting reviewer credentials.
```

Added bridges: None.

## 3. Change rationale

Word count: about 140 to about 100 (-30%).

References loaded: principles.md, edit-checks.md, structural-patterns.md, exposition.md, altitude.md, precision-budget.md, narrative-spine.md, reader-pleasure.md, sentence-patterns.md, subtraction.md, ai-tells-to-avoid.md, copyediting.md. Every pass in the per-section sweep was kept, because the section is an introduction at first draft. `cold-read.md` and `consistency-checks.md` belong to the whole-paper passes and were not loaded. Altitude found no statistical machinery, interval, or preemptive caveat to relocate.

- **"It is important to note that the proliferation ... has fundamentally transformed the way in which consumers make" -> "The proliferation ... has transformed how consumers make":** removed a banned throat-clearing opener and "important", and compressed "the way in which" to "how". "Fundamentally" is cut because it is an intensifier that rules out no reading.
- **"Furthermore, an investigation ... was conducted by several researchers" -> "Several studies have examined the relationship between online reviews and sales":** put the actors in the subject slot in place of a nominalization plus passive, and removed a banned transition. "Studies" gives the next sentence's "These studies" an identifiable referent.
- **"Moreover, these studies found that reviews matter, a one-star increase leads to..." -> "These studies found that reviews matter: a one-star increase leads to...":** removed a banned transition and repaired the comma splice with a colon (claim, then evidence). The figure and the causal verb are untouched.
- **"Crucially, however, the question ... remains, to the best of our knowledge, somewhat underexplored in the existing literature" -> "Yet to our knowledge, the question of whether reviewer identity affects this relationship remains somewhat underexplored":**
  - A plain "Yet" now carries the turn that "Crucially, however" carried.
  - The adverbial no longer separates "remains" from "underexplored".
  - "Question" is placed so P2's "this question" picks it up.
  - "The identity of reviewers" became "reviewer identity", so the construct has one name throughout.
  - Both hedges are kept as calibration of the novelty claim.
- **"in the existing literature" -> cut:** "underexplored" already means that, and the sentence follows the cited studies.
- **"In order to investigate this question, we leverage a novel dataset comprising of 1.2 million reviews" -> "To investigate this question, we use a dataset of 1.2 million reviews":** "use" replaces the banned "leverage", "To" replaces "In order to", and "of" replaces the ungrammatical "comprising of". "Novel" is removed as a banned promotional adjective (see the author questions).
- **"The results of our analysis demonstrate that reviewer identity has a significant effect" -> "In these data, reviewer identity significantly affects the relationship between reviews and sales":**
  - The finding is now a plain claim with no announcing frame.
  - "In these data" keeps the claim scoped to the dataset, which dropping "demonstrate" would otherwise broaden.
  - "The relationship between reviews and sales" restores a noun for "this relationship", which crossed a paragraph break.
- **"It should be noted that this finding has important implications for platform design: managers should consider highlighting reviewer credentials" -> "Platform managers should therefore consider highlighting reviewer credentials":** cut the throat-clearing and "important", and replaced announced significance with the concrete consequence. "Therefore" states the finding-to-recommendation link that the original colon implied. "Platform" is drawn from "platform design" in the original sentence.
- **P1 sentence 1 as an opener, and the P1/P2 order:** unchanged. Reordering is a structural call for you (see Diagnosis item 1).

## 4. Author questions

- **Numerical claim:** I reshaped the sentence carrying "5-9%" (comma splice to colon; subject now "These studies found that"). The figure and "a one-star increase" are unchanged. Please check it against the sources. Does "these studies" correctly attribute the 5-9% figure to all three cited works, or only to some of them?
- **Causal language:** "Leads to a 5-9% increase" is causal, and I preserved it. Do the cited studies support a causal reading, or should it be "is associated with"?
- **Revenue vs. sales:** The source uses "revenue" for the cited effect, while the question and your thesis speak of "sales". Are these the same construct? Should the 5-9% claim say "sales" or "revenue"?
- **Identity vs. credentials:** "Reviewer identity" (the finding) and "reviewer credentials" (the recommendation) may name different constructs, and the passage defines neither. Which attributes make up "identity"? Are "credentials" a subset the platform can display?
- **Size of the finding:** The finding is stated only as "a significant effect". Is that statistical significance, and on what outcome? Can you state a direction and rough size next to the 5-9% rating effect, so the reader sees how much identity adds?
- **Core thesis:** "Identity, not just the rating" is not stated in this opening. Is this the phrase you want readers to carry away, and where should it appear?
- **Hedge stack:** "to the best of our knowledge" and "somewhat" both qualify the novelty claim. Do you want to keep both, or keep one?
- **"Novel" dataset:** I deleted "novel" from "a novel dataset". If the dataset's novelty is part of the contribution, what makes it new (source, coverage, reviewer information)? That detail should appear in the text, not in an adjective.
- **First sentence:** It never mentions reviews. Does the manuscript explain why the platform shift makes reviews matter, so that sentence can lead into the review-sales studies?
- **"Managers":** Do you mean platform managers, as I assumed, or sellers who manage listings?
- **Structure:** Would you consider opening on the review-sales finding and putting the generic platform sentence second, or removing it? The current first sentence is a textbook opener.