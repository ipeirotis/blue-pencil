#!/usr/bin/env bash
# Verify the version string is identical in VERSION, SKILL.md, and README.md.
# Exits non-zero on any drift. Used by CI and `make check-version`.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

version_file="$(tr -d '[:space:]' < "$ROOT/VERSION")"
skill_version="$(grep -E '^[[:space:]]*version:[[:space:]]*"' "$ROOT/SKILL.md" \
  | head -1 | sed -E 's/.*"([^"]+)".*/\1/')"
readme_version="$(grep -oE 'badge/version-[0-9]+\.[0-9]+\.[0-9]+' "$ROOT/README.md" \
  | head -1 | sed -E 's#badge/version-##')"

printf 'VERSION file : %s\n' "$version_file"
printf 'SKILL.md     : %s\n' "$skill_version"
printf 'README badge : %s\n' "$readme_version"

if [ -z "$version_file" ] || [ -z "$skill_version" ] || [ -z "$readme_version" ]; then
  echo "ERROR: could not read one or more version strings." >&2
  exit 1
fi

if [ "$version_file" != "$skill_version" ] || [ "$version_file" != "$readme_version" ]; then
  echo "ERROR: version strings disagree. Reconcile with: make bump VERSION=$version_file" >&2
  exit 1
fi

echo "OK: all three report $version_file"
