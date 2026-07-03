#!/usr/bin/env bash
# Repo lint, pure bash plus git and grep, no external linters required:
#   1. Enforce the no-em-dash / no-en-dash standing constraint on tracked files.
#   2. Validate that SKILL.md frontmatter carries the required fields.
#   3. Confirm every references/*.md and examples/*.md path named in
#      SKILL.md, README.md, the commands, the agent, and the reference and
#      example files themselves actually exists.
# Used by CI and `make lint`.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail=0

# 1. No em-dash (U+2014) or en-dash (U+2013) anywhere in tracked files. The
#    search chars are built from hex byte escapes (UTF-8 e2 80 94 / e2 80 93)
#    so this script stays pure ASCII and never flags itself.
echo "Checking for em-dashes and en-dashes..."
emdash="$(printf '\xe2\x80\x94')"
endash="$(printf '\xe2\x80\x93')"
if hits="$(git grep --untracked -n -F -e "$emdash" -e "$endash" -- . 2>/dev/null)"; then
  echo "ERROR: em-dash or en-dash characters found in tracked files:" >&2
  printf '%s\n' "$hits" >&2
  echo "Replace with a comma, colon, parentheses, or two sentences." >&2
  fail=1
else
  echo "  none found"
fi

# 2. SKILL.md frontmatter must carry these top-level fields.
echo "Checking SKILL.md frontmatter..."
for field in name description license allowed-tools; do
  if ! grep -qE "^${field}:" SKILL.md; then
    echo "ERROR: SKILL.md frontmatter missing '${field}:'." >&2
    fail=1
  fi
done
echo "  done"

# 3. Every references/*.md and examples/*.md path named across the skill
#    surface must exist on disk. Scans SKILL.md, README.md, the command and
#    agent files, and the reference and example files themselves; the check
#    previously covered only SKILL.md-to-references links, so a broken link
#    in a command, the agent, or a cross-reference went unnoticed.
echo "Checking reference and example links resolve..."
missing=0
while IFS= read -r src; do
  while IFS= read -r ref; do
    [ -n "$ref" ] || continue
    if [ ! -f "$ref" ]; then
      echo "ERROR: $src references a missing file: $ref" >&2
      fail=1
      missing=1
    fi
  done < <(grep -oE '(references|examples)/[A-Za-z0-9._-]+\.md(\.template)?' "$src" | sort -u)
done < <({ printf '%s\n' SKILL.md README.md; git ls-files '.claude/commands' '.claude/agents' 'references' 'examples' | grep -E '\.md$'; })
if [ "$missing" -eq 0 ]; then
  echo "  all referenced files exist"
fi

# Orphans (present but never loaded by the skill) are a warning, not a failure.
while IFS= read -r f; do
  if ! grep -qF "$f" SKILL.md; then
    echo "  warning: $f is never loaded by SKILL.md"
  fi
done < <(git ls-files 'references/*.md')

if [ "$fail" -ne 0 ]; then
  echo "Lint failed." >&2
  exit 1
fi
echo "Lint OK."
