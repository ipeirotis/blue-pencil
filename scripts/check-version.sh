#!/usr/bin/env bash
# Verify the version string is identical in VERSION, SKILL.md, README.md, and
# the latest CHANGELOG.md entry. Exits non-zero on any drift. Used by CI and
# `make check-version`.
#
# Pass --no-changelog to skip the CHANGELOG check. bump-version.sh uses this,
# because it bumps the three version sites before the matching CHANGELOG entry
# has been written.
set -euo pipefail

check_changelog=1
for arg in "$@"; do
  case "$arg" in
    --no-changelog) check_changelog=0 ;;
    *) echo "Unknown argument: $arg (try --no-changelog)" >&2; exit 1 ;;
  esac
done

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

version_file="$(tr -d '[:space:]' < "$ROOT/VERSION")"
skill_version="$(grep -E '^[[:space:]]*version:[[:space:]]*"' "$ROOT/SKILL.md" \
  | head -1 | sed -E 's/.*"([^"]+)".*/\1/')"
readme_version="$(grep -oE 'badge/version-[0-9]+\.[0-9]+\.[0-9]+' "$ROOT/README.md" \
  | head -1 | sed -E 's#badge/version-##')"
changelog_version="$(grep -oE '^## \[[0-9]+\.[0-9]+\.[0-9]+\]' "$ROOT/CHANGELOG.md" \
  | head -1 | sed -E 's/^## \[([0-9.]+)\]/\1/')"

printf 'VERSION file     : %s\n' "$version_file"
printf 'SKILL.md         : %s\n' "$skill_version"
printf 'README badge     : %s\n' "$readme_version"
if [ "$check_changelog" -eq 1 ]; then
  printf 'CHANGELOG latest : %s\n' "$changelog_version"
fi

if [ -z "$version_file" ] || [ -z "$skill_version" ] || [ -z "$readme_version" ]; then
  echo "ERROR: could not read one or more version strings." >&2
  exit 1
fi

if [ "$version_file" != "$skill_version" ] || [ "$version_file" != "$readme_version" ]; then
  echo "ERROR: version strings disagree. Reconcile with: make bump VERSION=$version_file" >&2
  exit 1
fi

if [ "$check_changelog" -eq 1 ]; then
  if [ -z "$changelog_version" ]; then
    echo "ERROR: could not read the latest version from CHANGELOG.md." >&2
    exit 1
  fi
  if [ "$version_file" != "$changelog_version" ]; then
    echo "ERROR: the latest CHANGELOG.md entry ($changelog_version) does not match VERSION ($version_file)." >&2
    echo "Add a '## [$version_file]' section to the top of CHANGELOG.md." >&2
    exit 1
  fi
  echo "OK: VERSION, SKILL.md, README, and CHANGELOG all report $version_file"
else
  echo "OK: VERSION, SKILL.md, and README all report $version_file"
fi
