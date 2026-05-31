# scripts/

Maintenance helpers for the repository. End users never need these; they are
for releasing and for CI. The user-facing installer is `install.sh` at the repo
root, kept there so the documented `curl | bash` URL stays stable.

| Script | Purpose | Run via |
|--------|---------|---------|
| `check-version.sh` | Assert `VERSION`, `SKILL.md` `metadata.version`, and the README badge all match. Exits non-zero on drift. | `make check-version` |
| `bump-version.sh <x.y.z>` | Update all three version strings in lockstep, then self-check. Prints the CHANGELOG and tag steps. | `make bump VERSION=x.y.z` |
| `lint.sh` | Enforce the no-em-dash standing constraint, validate `SKILL.md` frontmatter, and confirm every `references/*.md` the skill loads exists. | `make lint` |

All three are plain bash and depend only on `git`, `grep`, and `sed`, so they
run the same locally and in CI (`.github/workflows/ci.yml`).

## Releasing

1. `make bump VERSION=x.y.z`
2. Add a `## [x.y.z]` section to `CHANGELOG.md`.
3. `make test` (runs `check-version` and `lint`).
4. Commit, then tag: `git tag -a vx.y.z -m vx.y.z && git push origin vx.y.z`.

A pushed tag lets users pin to that release:
`install.sh --ref vx.y.z` (or `PAPER_REVISION_EDITOR_REF=vx.y.z`).
