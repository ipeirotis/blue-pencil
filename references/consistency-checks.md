# Whole-paper consistency checks

Load this for any whole-paper cross-section consistency pass: when the user
asks whether the abstract and conclusion still describe the same paper, when a
`/paper:consistency` dispatch names it, or at the validate-globally step of a
whole-paper revision loop. This pass diagnoses; it never rewrites. It lives
here rather than in a command file so every agent that reads the skill gets
it, not only Claude Code.

## The checklist

Check whether the abstract, introduction, contribution claims, methods,
results, discussion, and conclusion describe the same paper, and flag:

- terminology drift (the same construct named differently across sections, or
  one term naming two constructs)
- claim drift and result overstatement (a result reported one way in results
  and a stronger way in the abstract, intro, or discussion)
- inconsistent contribution framing (contributions named or counted
  differently across abstract, intro, and conclusion)
- promise-delivery gaps (claims the intro makes that the body never delivers)
- missing or out-of-order forward references, and figure, table, theorem, or
  result callouts that do not resolve
- citation placeholders left unfilled
- stale summaries (an abstract or intro that previews a paper the body no
  longer matches)

## Reporting conventions

- Diagnosis only. `Revised text` reads `No rewrite requested.`, and `Change
  rationale` carries brief rationale bullets for the top findings instead of
  change lines. This pass never edits protected content; route every
  cross-section conflict that needs an author decision (which wording is
  correct, which result is the true one) to `Author questions`.
- Each finding names the sections in conflict (for example
  `[abstract vs. results]`).
- The seven-item Diagnosis cap does not apply: exhaustiveness is this pass's
  value. Report every finding, grouping findings by type with counts when the
  list grows long.
