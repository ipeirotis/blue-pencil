#!/usr/bin/env bash
# Bump the skill version in lockstep across VERSION, SKILL.md, and README.md,
# so the three never drift. Validates semver and self-checks with
# check-version.sh. Does not touch CHANGELOG.md or create a git tag; it prints
# those as the next manual steps.
#
# Usage: scripts/bump-version.sh <new-version>   (e.g. 1.15.0)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

new="${1:-}"
if [ -z "$new" ]; then
  echo "Usage: $0 <new-version>  (e.g. 1.15.0)" >&2
  exit 1
fi
if ! printf '%s' "$new" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
  echo "ERROR: '$new' is not a semver x.y.z string." >&2
  exit 1
fi

old="$(tr -d '[:space:]' < "$ROOT/VERSION")"
if [ "$old" = "$new" ]; then
  echo "Version already $new; nothing to do."
  exit 0
fi

# Escape dots so the old value is matched literally inside the sed patterns.
old_re="${old//./\\.}"

printf '%s\n' "$new" > "$ROOT/VERSION"

tmp="$(mktemp)"
sed -E "s/(^[[:space:]]*version:[[:space:]]*\")${old_re}(\")/\1${new}\2/" \
  "$ROOT/SKILL.md" > "$tmp" && mv "$tmp" "$ROOT/SKILL.md"

tmp="$(mktemp)"
sed "s#badge/version-${old_re}-#badge/version-${new}-#" \
  "$ROOT/README.md" > "$tmp" && mv "$tmp" "$ROOT/README.md"

echo "Bumped $old -> $new in VERSION, SKILL.md, README.md."
# Skip the CHANGELOG check: its "## [$new]" entry is written in the next step.
"$ROOT/scripts/check-version.sh" --no-changelog >/dev/null

cat <<NEXT

Next steps:
  1. Add a "## [$new]" section to CHANGELOG.md.
  2. Commit, then tag the release:
       git tag -a "v$new" -m "v$new" && git push origin "v$new"
     A pushed tag lets users pin with: install.sh --ref "v$new"
NEXT
