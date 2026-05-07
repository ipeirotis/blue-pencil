#!/bin/bash
# Install paper-revision-editor skill into the current repo.
# Usage:
#   curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash
#   curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/v1.0.0/install.sh | REF=v1.0.0 bash
#
# REF defaults to "main". Set REF=<tag> to pin the installed content to a
# release tag. The REF used to fetch this script and the REF used to fetch
# skill content are independent; pass REF=<tag> to pin the content.
set -e

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "ERROR: Not inside a git repository. Run this from your repo root." >&2
  exit 1
fi

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

REF="${REF:-main}"
BASE_URL="https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/${REF}"
SKILL_NAME="paper-revision-editor"
DEST=".claude/skills/${SKILL_NAME}"

mkdir -p "$DEST/references"

FILES="
  SKILL.md
  VERSION
  references/sentence-cohesion.md
  references/ai-tells-to-avoid.md
"

for FILE in $FILES; do
  curl -fsSL "$BASE_URL/$FILE" -o "$DEST/$FILE"
done

if [ -f "$DEST/VERSION" ]; then
  INSTALLED_VERSION=$(tr -d '[:space:]' < "$DEST/VERSION")
else
  INSTALLED_VERSION=$(grep -m1 '^version:' "$DEST/SKILL.md" 2>/dev/null | awk '{print $2}')
fi
INSTALLED_VERSION="${INSTALLED_VERSION:-unknown}"

# Interactive paper-context prompt.
# Detect interactivity by actually opening /dev/tty on FD 3. A readable
# /dev/tty inode does not guarantee `read </dev/tty` will succeed: in CI
# and `curl ... | bash` without a controlling terminal the open fails
# with ENXIO, and with `set -e` that would abort the install.
INTERACTIVE=0
if [ -t 0 ]; then
  INTERACTIVE=1
elif exec 3</dev/tty 2>/dev/null; then
  INTERACTIVE=1
fi

prompt_for_context() {
  [ "$INTERACTIVE" = "1" ]
}

read_field() {
  local prompt="$1"
  local var
  printf "  %s: " "$prompt" >&2
  if [ -t 0 ]; then
    read -r var
  else
    read -r var <&3
  fi
  printf '%s' "$var"
}

CLAUDE_MD="CLAUDE.md"
ADDED_CONTEXT=0

if grep -q "<paper_context>" "$CLAUDE_MD" 2>/dev/null; then
  echo ""
  echo "CLAUDE.md already contains a <paper_context> block. Skipping prompt."
elif prompt_for_context; then
  echo ""
  echo "Set up paper context (used by the skill on every revision)."
  echo "Press Enter to skip a field; you can edit CLAUDE.md later."
  echo ""
  TARGET_VENUE=$(read_field "Target venue (e.g. Information Systems Research)")
  AUDIENCE=$(read_field "Primary audience (e.g. empirical IS researchers)")
  CORE_THESIS=$(read_field "Core thesis (1-2 sentences)")
  echo "  Revision stage options: first draft | response to reviewers | final polish" >&2
  REVISION_STAGE=$(read_field "Revision stage")

  {
    if [ -s "$CLAUDE_MD" ]; then echo ""; fi
    echo "# Paper context"
    echo ""
    echo "<paper_context>"
    echo "target_venue: ${TARGET_VENUE:-[fill in]}"
    echo "audience: ${AUDIENCE:-[fill in]}"
    echo "core_thesis: ${CORE_THESIS:-[fill in]}"
    echo "revision_stage: ${REVISION_STAGE:-first draft}"
    echo "</paper_context>"
    echo ""
    echo "# Editing conventions"
    echo ""
    echo "- No em-dashes anywhere in the manuscript."
    echo "- Avoid: Furthermore, Moreover, Crucially, Importantly, Notably, Ultimately, Delving."
    echo "- Avoid: \"It's worth noting\", \"That said\"."
  } >> "$CLAUDE_MD"

  ADDED_CONTEXT=1
  echo ""
  echo "Wrote <paper_context> block to ${CLAUDE_MD}."
else
  echo ""
  echo "Non-interactive install. Add a <paper_context> block to ${CLAUDE_MD} manually before running the skill."
fi

# Close the tty FD if we opened it.
if [ "$INTERACTIVE" = "1" ] && [ ! -t 0 ]; then
  exec 3<&- 2>/dev/null || true
fi

git add "$DEST"
[ "$ADDED_CONTEXT" = "1" ] && git add "$CLAUDE_MD"
git commit -m "Add paper-revision-editor skill v${INSTALLED_VERSION}"

echo ""
echo "paper-revision-editor v${INSTALLED_VERSION} installed in $DEST"
echo ""
echo "Next:"
echo "  Open a section file and ask Claude to revise it."
echo ""
echo "To check for updates later:"
echo "  curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/update.sh | bash"
