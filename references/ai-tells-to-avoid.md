# AI Tells and House Style

Patterns to flag and remove. Many of these are LLM-default phrases that signal AI-generated or AI-assisted prose. Others are house style for academic manuscripts.

## Banned transition words

These words and phrases mark text as AI-generated or as lazy academic filler. Remove them and rebuild the transition from the content itself.

- Furthermore
- Moreover
- Crucially
- Importantly
- Notably
- Ultimately
- Delving (and "delve into", "delving into")

## Banned hedging phrases

- "It's worth noting that..."
- "It is important to note that..."
- "That said..."
- "Having said that..."
- "It should be mentioned that..."

If a point is worth making, make it. Do not announce that you are about to make it.

## Banned promotional adjectives

Promotional adjectives perform certainty rather than earning it. If the substance of the sentence survives without the adjective, the adjective was throat-clearing.

- important (the adjective; "Importantly" as a transition is also banned)
- novel
- interesting
- significant — except where it means statistically significant
- crucial (the adjective; "Crucially" as a transition is also banned)

Edit move: delete the adjective and reread the sentence. If the substance survives, leave it deleted. If the sentence collapses, the underlying claim was weak; flag in Author questions rather than restoring the adjective.

## Banned framing phrases

- "We show that..." — replace with the result itself. "We show that X improves accuracy by 12 points" → "X improves accuracy by 12 points."
- "It is well known that..." — if it is well known, say it; if it is not, cite it.
- "In this paper, we propose..." in any sentence after the contribution paragraph — repeating the frame signals the paper is still selling instead of doing.

McCloskey on economists and Dijkstra on computer scientists both argued that rhetoric which announces its own importance signals weak content.

## Em-dashes

Do not use em-dashes (—) in this manuscript. The em-dash has become an LLM tell because models reach for it as a default when the right move is one of:

- A comma, when the parenthetical is short and tight
- Parentheses, when the aside is genuinely separable
- A colon, when the second clause expands or specifies the first
- Two sentences, when both halves can stand alone

Every em-dash in a draft should be replaced with one of these alternatives.

## Other LLM tells to watch for

- Triadic constructions for their own sake ("clear, concise, and compelling"; "robust, reliable, and reproducible"). Real prose uses triads when three is the right number, not as decoration.
- Hedged confidence ("This may potentially suggest that..."). Pick a confidence level and own it.
- Empty meta-commentary ("This paragraph discusses..."). Just discuss.
- Aphoristic closers ("In the end, the data speaks for itself."). Endings should land specific points, not gesture at universal truths.
- "Navigate" as a metaphor for any non-trivial activity. People navigate ships and websites. They do not "navigate the literature on labor markets".
- "Leverage" as a verb when "use" would do.
- "Robust" as a generic positive descriptor. Robust to what?

## Manuscript style preferences

- Technical terms get defined on first use, including acronyms. Reuse the same term consistently; do not introduce synonyms for variety.
- Citations go inside the sentence, not at the end of a paragraph as a wall: "Smith (2020) showed X. Building on this, Jones (2022) extended Y." not "X has been shown, and Y has been extended (Smith, 2020; Jones, 2022)."

## Diagnostic checklist

Before approving any revised passage, scan for:

- [ ] Any em-dashes? Replace.
- [ ] Any banned transition words? Rebuild the transition.
- [ ] Any banned hedging phrases? Cut.
- [ ] Any banned promotional adjectives ("important", "novel", "interesting", "significant", "crucial")? Delete; verify the substance survives.
- [ ] "We show that..." or "It is well known that..." frames? Replace with the claim itself.
- [ ] "Navigate" or "leverage" used as throat-clearing? Replace with simpler verb.
- [ ] Triads that exist only for rhythm? Cut to two or expand to a real list.
- [ ] Topic sentence in the first two sentences of the paragraph? If not, restructure.
