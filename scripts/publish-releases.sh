#!/usr/bin/env bash
# Publish a GitHub Release for every version documented in CHANGELOG.md.
#
# Why this exists: the repo automates cutting a version (bump-version.sh
# updates VERSION, SKILL.md, and the README badge) but nothing published the
# matching GitHub Release, so the two drifted. Tags v1.23.0-v1.33.0 existed
# with no Release, and versions 1.16.1-1.22.0 had a CHANGELOG entry with no
# tag at all. This script reconciles tags and Releases back to the CHANGELOG.
#
# What it does, per version, oldest first, and idempotently:
#   1. If no git tag exists, create an annotated tag at that version's release
#      commit (the first-parent merge on main where VERSION became that value)
#      and push it. Versions with no known commit are skipped with a warning.
#   2. If no GitHub Release exists, create one from the version's CHANGELOG
#      section as the release notes.
# A version that already has both a tag and a Release is left untouched.
#
# Requires: git, gh (GitHub CLI) authenticated with a token that can push tags
# and create releases (contents: write). Run from a full clone of the repo.
#
# Usage:
#   scripts/publish-releases.sh              # reconcile everything
#   scripts/publish-releases.sh --dry-run    # print actions, change nothing
#   scripts/publish-releases.sh 1.20.0 ...   # only the named versions
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHANGELOG="$ROOT/CHANGELOG.md"
REPO="ipeirotis/paper-revision-editor"

# Release commit for versions that were never tagged. Each SHA is the
# first-parent merge on main where VERSION transitioned to that value.
# Tagged versions are absent here on purpose: their existing tag is used.
declare -A COMMIT=(
  [1.16.1]=efcc1b9
  [1.17.0]=6f95afd
  [1.17.1]=28a4008
  [1.18.0]=d0b6d8e
  [1.18.1]=71c8c78
  [1.19.0]=94c456e
  [1.20.0]=99467ec
  [1.21.0]=2e47e7e
  [1.22.0]=d5c7278
)

dry_run=0
requested=()
for arg in "$@"; do
  case "$arg" in
    --dry-run) dry_run=1 ;;
    -h|--help) sed -n '2,30p' "$0"; exit 0 ;;
    -*) echo "Unknown option: $arg" >&2; exit 1 ;;
    *)  requested+=("$arg") ;;
  esac
done

command -v gh >/dev/null || { echo "ERROR: gh (GitHub CLI) is required." >&2; exit 1; }

# All versions in the CHANGELOG, oldest first (reverse of file order).
mapfile -t all_versions < <(
  grep -oE '^## \[[0-9]+\.[0-9]+\.[0-9]+\]' "$CHANGELOG" \
    | sed -E 's/^## \[([0-9.]+)\]/\1/' | tac
)

versions=("${all_versions[@]}")
if [ "${#requested[@]}" -gt 0 ]; then
  versions=("${requested[@]}")
fi

# Print a version's CHANGELOG section (without its header line) on stdout.
changelog_notes() {
  awk -v v="$1" '
    $0 ~ "^## \\[" v "\\]( |$|])" { f=1; next }
    f && /^## \[/ { exit }
    f { print }
  ' "$CHANGELOG" | sed '1{/^$/d}'
}

run() {
  if [ "$dry_run" -eq 1 ]; then
    echo "  DRY-RUN: $*"
  else
    "$@"
  fi
}

created_tags=0 created_releases=0 skipped=0

for v in "${versions[@]}"; do
  tag="v$v"
  echo "== $tag =="

  # 1. Ensure the tag exists locally and on the remote.
  if ! git -C "$ROOT" rev-parse -q --verify "refs/tags/$tag" >/dev/null; then
    sha="${COMMIT[$v]:-}"
    if [ -z "$sha" ]; then
      echo "  WARN: no tag and no known release commit for $v; skipping." >&2
      skipped=$((skipped + 1))
      continue
    fi
    run git -C "$ROOT" tag -a "$tag" -m "$tag" "$sha"
    created_tags=$((created_tags + 1))
  fi
  # Push the tag if the remote does not have it yet.
  if ! git -C "$ROOT" ls-remote --exit-code --tags origin "$tag" >/dev/null 2>&1; then
    run git -C "$ROOT" push origin "$tag"
  fi

  # 2. Create the GitHub Release if it does not exist.
  if gh release view "$tag" --repo "$REPO" >/dev/null 2>&1; then
    echo "  release exists; leaving as is."
    continue
  fi
  notes="$(changelog_notes "$v")"
  if [ -z "$notes" ]; then
    echo "  WARN: no CHANGELOG section for $v; skipping release." >&2
    skipped=$((skipped + 1))
    continue
  fi
  if [ "$dry_run" -eq 1 ]; then
    echo "  DRY-RUN: gh release create $tag --title $tag --notes (from CHANGELOG)"
  else
    printf '%s\n' "$notes" | gh release create "$tag" \
      --repo "$REPO" --title "$tag" --notes-file -
  fi
  created_releases=$((created_releases + 1))
done

echo
echo "Done. Tags created: $created_tags, releases created: $created_releases, skipped: $skipped."
