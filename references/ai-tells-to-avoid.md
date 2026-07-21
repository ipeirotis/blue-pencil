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
- significant (except where it means statistically significant)
- crucial (the adjective; "Crucially" as a transition is also banned)

Edit move: delete the adjective and reread the sentence. If the substance survives, leave it deleted. If the sentence collapses, the underlying claim was weak; flag in Author questions rather than restoring the adjective.

## More filler adjectives

These join the promotional list above. Each has a legitimate technical use; the ban is on the decorative use. Apply the same test: delete the word, reread, and leave it deleted if the substance survives.

- comprehensive (legitimate only when the coverage is literally exhaustive: "a comprehensive survey of all 412 papers")
- holistic, multifaceted (almost always decorative; name the facets instead)
- nuanced (show the nuance; do not label a claim as nuanced)
- key, central, vital, pivotal (as in "a key insight", "a vital factor"; usually deletable, or replace with the specific reason the thing matters)
- rich, deep, powerful, vast (as generic intensifiers)
- seamless, streamlined (rarely true; describe what actually happens)

## Importance-signaling verbs

These verbs tell the reader that something matters instead of showing why. They are the verb form of the promotional adjectives.

- underscores, highlights, emphasizes (when the object is "the importance of" or "the need for")
- showcases, demonstrates the importance of, speaks to
- "plays a [key / central / crucial / vital / pivotal] role in"

Edit move: replace the signal with the mechanism. "X underscores the importance of Y" becomes "X fails whenever Y is absent", or whatever the concrete relationship is. If you cannot name the mechanism, the sentence was asserting importance it had not earned; flag it in Author questions.

Exception: "highlights" is fine in its literal sense ("Figure 2 highlights the outlier region in red").

## Banned framing phrases

- "We show that...": replace with the result itself. "We show that X improves accuracy by 12 points" becomes "X improves accuracy by 12 points."
- "It is well known that...": if it is well known, say it; if it is not, cite it.
- "In this paper, we propose..." in any sentence after the contribution paragraph: repeating the frame signals the paper is still selling instead of doing.

McCloskey on economists and Dijkstra on computer scientists both argued that rhetoric which announces its own importance signals weak content.

## Em-dashes

Do not use em-dashes in this manuscript. (The em-dash character itself is intentionally not printed here; replace any instance with one of the following.) The em-dash has become an LLM tell because models reach for it as a default when the right move is one of:

- A comma, when the parenthetical is short and tight
- Parentheses, when the aside is genuinely separable
- A colon, when the second clause expands or specifies the first
- Two sentences, when both halves can stand alone

Every em-dash in a draft should be replaced with one of these alternatives.

## Inflated noun phrases and dead metaphors

- "the landscape of X", "the X landscape", "the realm of", "the world of", "the sphere of"
- "a myriad of", "a plethora of", "a wide array of", "a host of", "a wealth of" (replace with a count or with "many")
- "rich tapestry", "tapestry of", "mosaic of"
- "the intersection of X and Y" (fine when two literatures genuinely meet; decorative when it just means "X and Y")
- "paradigm shift", "game-changer", "sea change", "watershed moment"
- "in today's [fast-paced / data-driven / increasingly digital] world" and other scene-setting openers

Edit move: replace with the plain count, the specific object, or nothing. "A myriad of factors" becomes "four factors" when you can name four, and gets cut when you cannot.

## Template sentence shapes

LLM prose falls into a few rhetorical molds. Used once, deliberately, any of these is fine; as a reflex they flatten the writing.

- The false-modesty antithesis: "It is not just about X, it is about Y." / "This is not merely X; it is Y."
- The range-gesture opener: "From X to Y, [sweeping claim]."
- "Not only ... but also ..." more than once in a section.
- "Firstly, Secondly, Thirdly" for a list meant to be remembered. Name the items instead (see `references/edit-checks.md`, check 7).
- The decorative triad: three parallel items where two would do or a real list is needed (see the rule-of-three note below).

## Other LLM tells to watch for

- Triadic constructions for their own sake ("clear, concise, and compelling"; "robust, reliable, and reproducible"). Real prose uses triads when three is the right number, not as decoration.
- Hedged confidence ("This may potentially suggest that..."). Pick a confidence level and own it. In an abstract, introduction, or contribution paragraph, run the zone-scoped hedge lexicon in `references/precision-budget.md` (may, might, could, suggest, potentially, arguably, generally, typically, in many cases, to some extent) and classify each hit as epistemic keeper, deferrable scope, or filler; these words are not banned, they are wrong only at the wrong altitude, so never blanket-delete them.
- Empty meta-commentary ("This paragraph discusses..."). Just discuss.
- Aphoristic closers ("In the end, the data speaks for itself."). Endings should land specific points, not gesture at universal truths.
- "Navigate" as a metaphor for any non-trivial activity. People navigate ships and websites. They do not "navigate the literature on labor markets".
- "Leverage" or "utilize" (and "utilizes", "utilizing") as a verb when "use" would do.
- "Robust" as a generic positive descriptor. Robust to what?

## Storytelling tells (decorative narrative)

"Tell a story" is sound advice for structure and ruinous advice for surface. The
structural version, a spine built from the ABT, the knowledge gap, and the turn,
lives in `references/narrative-spine.md`. The surface version below is a set of
LLM tells. Banning them is what keeps a narrative pass from making prose more
LLM-like instead of less.

- Manufactured hooks: "Imagine a world where...", "Imagine if...", "Picture
  this:", "Consider the following scenario:".
- Scene-setting stakes openers: "In an era of...", "In today's [fast-paced /
  data-driven] world", "As [field] continues to evolve...", "Now more than ever".
- The journey or quest metaphor for research: "our journey", "we embark", "we
  set out on a quest", "a deep dive into" (see also "navigate" above).
- Anthropomorphized data and results: "the data tells a story", "the numbers
  speak for themselves", "the results reveal their secrets".
- The dramatic reveal: "Enter [X]." as a standalone reveal, "But here is the
  catch:", "Here is the twist:".

Edit move: replace the flourish with the paper's actual question or gap. The
narrative pull should come from structure, never from a bolted-on hook. If a
passage needs a hook to be interesting, the question it is built on is the part
that needs work.

A load-bearing concrete instance is not a hook. The exposition pass
(`references/exposition.md`) and `references/edit-checks.md` check 4 both ask for
a specific case that the formalism generalizes and that carries the intuition. The
ban targets the dramatizing opener that does no work ("Imagine a world where...",
"Consider the following scenario:"), not the domain case itself. Keep the
substance of such an instance and drop the frame in front of it: lead with the
case ("A hiring pipeline screens applicants twice..."), not with an instruction to
imagine one.

## Manuscript style preferences

- Technical terms get defined on first use, including acronyms. Reuse the same term consistently; do not introduce synonyms for variety.
- Citations go inside the sentence, not at the end of a paragraph as a wall: "Smith (2020) showed X. Building on this, Jones (2022) extended Y." not "X has been shown, and Y has been extended (Smith, 2020; Jones, 2022)." For an existing wall, propose the redistribution in `Author questions`; do not perform it, since assigning citations to claims is the author's call.

## Diagnostic checklist

Before approving any revised passage, scan for:

- [ ] Any em-dashes? Replace.
- [ ] Any banned transition words? Rebuild the transition.
- [ ] Any banned hedging phrases? Cut.
- [ ] Any banned promotional adjectives ("important", "novel", "interesting", "significant", "crucial")? Delete; verify the substance survives.
- [ ] Filler adjectives ("comprehensive", "holistic", "nuanced", "key", "seamless")? Delete; verify the substance survives.
- [ ] Importance-signaling verbs ("underscores", "highlights the importance of", "plays a crucial role")? Replace with the mechanism.
- [ ] Inflated noun phrases ("the landscape of", "a myriad of", "rich tapestry")? Replace with a count or the specific object.
- [ ] Template shapes ("not just X but Y", "From X to Y", "Firstly/Secondly")? Rewrite or name the items.
- [ ] "We show that..." or "It is well known that..." frames? Replace with the claim itself.
- [ ] "Leverage" or "utilize" used where "use" would do? Replace with "use".
- [ ] "Navigate" as a metaphor for a non-trivial activity (navigating a literature, navigating uncertainty)? Replace with a plain verb for the actual action.
- [ ] Manufactured hook or scene-setting opener ("Imagine...", "In an era of...")? Replace with the paper's real question.
- [ ] Journey metaphor or anthropomorphized data ("our journey", "the data tells a story")? Cut.
- [ ] Triads that exist only for rhythm? Cut to two or expand to a real list.
- [ ] In an abstract, introduction, or contribution paragraph: hedge-lexicon words (may, might, could, suggest, potentially, arguably, generally, typically, in many cases, to some extent)? Classify per `references/precision-budget.md` (keep, defer with one signpost, or cut as filler); never blanket-delete.
- [ ] Topic sentence in the first two sentences of the paragraph? If not, restructure.
