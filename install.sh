#!/bin/bash
# Install paper-revision-editor skill into the current repo.
# Usage: curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash
set -e

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "ERROR: Not inside a git repository. Run this from your repo root." >&2
  exit 1
fi

BASE_URL="https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main"
DEST=".claude/skills/paper-revision-editor"

mkdir -p "$DEST/references"

FILES="
  SKILL.md
  VERSION
  references/sentence-cohesion.md
  references/ai-tells-to-avoid.md
"

for FILE in $FILES; do
  curl -sSL "$BASE_URL/$FILE" -o "$DEST/$FILE"
done

# Read the installed version
if [ -f "$DEST/VERSION" ]; then
  INSTALLED_VERSION=$(tr -d '[:space:]' < "$DEST/VERSION")
else
  INSTALLED_VERSION=$(grep -m1 '^version:' "$DEST/SKILL.md" 2>/dev/null | awk '{print $2}')
fi
INSTALLED_VERSION="${INSTALLED_VERSION:-unknown}"

git add "$DEST"
git commit -m "Add paper-revision-editor skill v${INSTALLED_VERSION}"

echo "paper-revision-editor v${INSTALLED_VERSION} installed in $DEST"
echo ""
echo "Next steps:"
echo "  1. Add a <paper_context> block to CLAUDE.md at the repo root with:"
echo "     - target_venue"
echo "     - audience"
echo "     - core_thesis"
echo "     - revision_stage"
echo ""
echo "  2. Open any section file and ask Claude to revise it."
echo ""
echo "To check for updates later, run:"
echo "  curl -sSL ${BASE_URL}/update.sh | bash"
