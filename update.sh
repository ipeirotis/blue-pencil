#!/bin/bash
# Check for updates to paper-revision-editor and optionally apply them.
# Usage: curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-copyediting-skill/main/update.sh | bash
set -e

REPO_URL="https://raw.githubusercontent.com/ipeirotis/paper-copyediting-skill/main"
DEST=".claude/skills/paper-revision-editor"

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "ERROR: Not inside a git repository. Run this from your repo root." >&2
  exit 1
fi

# Determine installed version
INSTALLED_VERSION=""
if [ -f "$DEST/VERSION" ]; then
  INSTALLED_VERSION=$(tr -d '[:space:]' < "$DEST/VERSION")
elif [ -f "$DEST/SKILL.md" ]; then
  INSTALLED_VERSION=$(grep -m1 '^version:' "$DEST/SKILL.md" 2>/dev/null | awk '{print $2}')
fi

if [ -z "$INSTALLED_VERSION" ]; then
  echo "paper-revision-editor is not installed or has no version info."
  echo "Run the installer instead:"
  echo "  curl -sSL $REPO_URL/install.sh | bash"
  exit 1
fi

echo "Installed version: $INSTALLED_VERSION"

# Fetch latest version
LATEST_VERSION=$(curl -sSL "$REPO_URL/VERSION" | tr -d '[:space:]')
if [ -z "$LATEST_VERSION" ]; then
  echo "ERROR: Could not fetch latest version." >&2
  exit 1
fi

echo "Latest version:    $LATEST_VERSION"

if [ "$INSTALLED_VERSION" = "$LATEST_VERSION" ]; then
  echo ""
  echo "You are up to date."
  exit 0
fi

echo ""
echo "--- Changelog (new entries since $INSTALLED_VERSION) ---"
echo ""

# Fetch and display changelog, showing only entries newer than the installed version
CHANGELOG=$(curl -sSL "$REPO_URL/CHANGELOG.md")
echo "$CHANGELOG" | awk -v installed="$INSTALLED_VERSION" '
  /^## \[/ {
    # Extract version from heading like "## [1.2.0] - 2026-04-01"
    ver = $0
    gsub(/.*\[/, "", ver)
    gsub(/\].*/, "", ver)
    if (ver == installed) { found_installed = 1; next }
    if (!found_installed) { print; next }
  }
  !found_installed { print }
'

echo ""
echo "--- End of changelog ---"
echo ""

# If running interactively, ask for confirmation
if [ -t 0 ]; then
  printf "Update from %s to %s? [y/N] " "$INSTALLED_VERSION" "$LATEST_VERSION"
  read -r REPLY
  if [ "$REPLY" != "y" ] && [ "$REPLY" != "Y" ]; then
    echo "Update cancelled."
    exit 0
  fi
fi

# Perform update
echo "Updating..."
mkdir -p "$DEST/references"

FILES="
  SKILL.md
  VERSION
  references/sentence-cohesion.md
  references/ai-tells-to-avoid.md
"

for FILE in $FILES; do
  curl -sSL "$REPO_URL/$FILE" -o "$DEST/$FILE"
done

git add "$DEST"
git commit -m "Update paper-revision-editor skill to $LATEST_VERSION"

echo ""
echo "Updated paper-revision-editor from $INSTALLED_VERSION to $LATEST_VERSION."
