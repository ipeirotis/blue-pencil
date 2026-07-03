# scripts/

Maintenance helpers for the repository. End users never need these; they are
for releasing and for CI. The user-facing installer is `install.sh` at the repo
root, kept there so the documented `curl | bash` URL stays stable.

| Script | Purpose | Run via |
|--------|---------|---------|
| `check-version.sh` | Assert `VERSION`, `SKILL.md` `metadata.version`, the README badge, and the latest `CHANGELOG.md` entry all match. Exits non-zero on drift. | `make check-version` |
| `bump-version.sh <x.y.z>` | Update all three version strings in lockstep, then self-check. Prints the CHANGELOG and tag steps. | `make bump VERSION=x.y.z` |
| `lint.sh` | Enforce the no-em-dash standing constraint, validate `SKILL.md` frontmatter, and confirm every `references/*.md` and `examples/*.md` path named in `SKILL.md`, `README.md`, the commands, the agent, and the reference and example files resolves. | `make lint` |
| `check-examples.sh` | Lock `examples/` to the strict output format in `SKILL.md`: heading order, `Word count:` shape, question marks, banned tells in every edited paragraph of the `Revised text` block (paragraphs returned verbatim from the input are exempt), the stage-appropriate Diagnosis headers and extraction lines, the `Added bridges:` line, and the `Reader map:` template. | `make check-examples` |
| `check-protected.sh` | Diff protected content between each example's input block and its `Revised text` block: citation keys (LaTeX including optional arguments, pandoc `@key` in any form, and plain author-year runs including parenthesized forms), cross-reference keys and prose callouts ("Table 4", "Appendix C"), math spans (dollar, `\(...\)`, `\[...\]` even with inner brackets, and whole environments including contents), macros with their arguments including one-character commands (prose-argument macros like `\caption` by name only, honoring the caption carve-out), quoted text (straight, TeX, curly), `%` comment lines, and numbers with their sign, range, percent, and unit-word context. The mechanical version of the skill's "No protected content changed" preflight, with an in-script exceptions list for legitimate flagged changes. | `make check-protected` |

All of these are plain bash and depend only on `git`, `grep`, `awk`, and
`sed`, so they run the same locally and in CI (`.github/workflows/ci.yml`).

## Releasing

1. `make bump VERSION=x.y.z`
2. Add a `## [x.y.z]` section to `CHANGELOG.md`.
3. `make test` (runs `check-version` and `lint`).
4. Commit, then tag: `git tag -a vx.y.z -m vx.y.z && git push origin vx.y.z`.

A pushed tag lets users pin to that release:
`install.sh --ref vx.y.z` (or `PAPER_REVISION_EDITOR_REF=vx.y.z`).
