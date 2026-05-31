#!/usr/bin/env bash
# Install, update, or uninstall the paper-revision-editor skill.
#
# Installs into two locations:
#   ~/.agents/skills/paper-revision-editor   (cross-tool standard)
#   ~/.claude/skills/paper-revision-editor   (Claude Code)
#
# Both are symlinks into a single clone at
# ~/.local/share/paper-revision-editor (override with $PAPER_REVISION_EDITOR_HOME),
# so updates propagate to both targets at once.
#
# Usage:
#   curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash
#   curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash -s -- --update
#   curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/install.sh | bash -s -- --uninstall
#
# Or, from a local clone:
#   ./install.sh              # install
#   ./install.sh --update     # update the clone (every linked tool sees the new content)
#   ./install.sh --uninstall  # remove both symlinks
#   ./install.sh --init       # scaffold AGENTS.md in the current paper repo
#   ./install.sh --check      # show install state
#   ./install.sh --version    # print the installed version
#
# Pin to a tag, branch, or commit (applies to install and update):
#   ./install.sh --ref v1.15.0
#   PAPER_REVISION_EDITOR_REF=v1.15.0 ./install.sh --update

set -euo pipefail

SKILL_NAME="paper-revision-editor"
REPO_URL="https://github.com/ipeirotis/paper-revision-editor.git"
CACHE_DIR="${PAPER_REVISION_EDITOR_HOME:-$HOME/.local/share/paper-revision-editor}"
TARGETS=(
  "$HOME/.agents/skills/$SKILL_NAME"
  "$HOME/.claude/skills/$SKILL_NAME"
)
# Git ref (tag, branch, or commit) to install or update to. Defaults to main.
REF="${PAPER_REVISION_EDITOR_REF:-main}"

# Where to read templates and where the symlinks should point. If install.sh
# is running from inside a real clone, prefer that. Otherwise use CACHE_DIR
# (the curl|bash path), cloning if needed.
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
  SCRIPT_DIR=""
fi

print_help() {
  cat <<'HELP'
paper-revision-editor installer.

Usage:
  install.sh              Install (clones if needed, symlinks both targets)
  install.sh --update     Update the clone (both targets update at once)
  install.sh --uninstall  Remove both symlinks
  install.sh --init       Scaffold AGENTS.md in the current paper repo
  install.sh --check      Show install state and the tracked ref
  install.sh --version    Print the installed version
  install.sh --ref REF    Install or update to a tag, branch, or commit
  install.sh --help       This help

Targets:
  ~/.agents/skills/paper-revision-editor   (cross-tool standard)
  ~/.claude/skills/paper-revision-editor   (Claude Code)

Environment:
  PAPER_REVISION_EDITOR_HOME   Override the clone location
  PAPER_REVISION_EDITOR_REF    Default git ref (same as --ref)
HELP
}

require_git() {
  if ! command -v git >/dev/null 2>&1; then
    echo "ERROR: git is required but was not found on PATH." >&2
    echo "Install git from https://git-scm.com/downloads, then re-run." >&2
    exit 1
  fi
}

ensure_clone() {
  # All status output goes to stderr so this function is safe to call inside
  # $(resolve_source), where stdout is captured into the symlink target path.
  require_git
  if [ -d "$CACHE_DIR/.git" ]; then
    return
  fi
  if [ -d "$CACHE_DIR" ] && [ "$(ls -A "$CACHE_DIR" 2>/dev/null)" ]; then
    echo "Existing non-git directory at $CACHE_DIR; re-cloning." >&2
    local tmpdir
    tmpdir="$(mktemp -d "${CACHE_DIR}.XXXXXX")"
    git clone --quiet "$REPO_URL" "$tmpdir" >&2
    rm -rf "$CACHE_DIR"
    mv "$tmpdir" "$CACHE_DIR"
  else
    echo "Cloning $REPO_URL into $CACHE_DIR" >&2
    mkdir -p "$(dirname "$CACHE_DIR")"
    git clone --quiet "$REPO_URL" "$CACHE_DIR" >&2
  fi
  if [ "$REF" != "main" ]; then
    echo "Checking out $REF" >&2
    git -C "$CACHE_DIR" checkout --quiet "$REF" >&2 \
      || { echo "ERROR: ref '$REF' not found in $REPO_URL." >&2; exit 1; }
  fi
}

# Pick the directory the symlinks should point at. Inside a clone, point at
# that clone (developer workflow). Otherwise point at $CACHE_DIR.
resolve_source() {
  if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/SKILL.md" ]; then
    echo "$SCRIPT_DIR"
  else
    ensure_clone
    echo "$CACHE_DIR"
  fi
}

link_one() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ]; then
    local current
    current="$(readlink "$dest")"
    if [ "$current" = "$src" ]; then
      echo "  already linked: $dest"
      return 0
    fi
    rm "$dest"
  elif [ -d "$dest" ] && [ -f "$dest/SKILL.md" ] && [ -f "$dest/VERSION" ]; then
    # Prior copy-mode install (the ln -s fallback). Safe to replace.
    rm -rf "$dest"
  elif [ -e "$dest" ]; then
    echo "  ERROR: $dest exists and is not a symlink or a prior install. Refusing to overwrite." >&2
    return 1
  fi
  if ln -s "$src" "$dest" 2>/dev/null; then
    echo "  linked: $dest -> $src"
  else
    echo "  symlink failed; copying instead."
    cp -R "$src" "$dest"
    echo "  copied: $dest"
  fi
}

unlink_one() {
  local dest="$1"
  if [ -L "$dest" ]; then
    rm "$dest"
    echo "  removed: $dest"
  elif [ -d "$dest" ] && [ -f "$dest/SKILL.md" ] && [ -f "$dest/VERSION" ]; then
    rm -rf "$dest"
    echo "  removed (copy-mode install): $dest"
  elif [ -e "$dest" ]; then
    echo "  skipped (not a symlink or prior install; remove manually if intended): $dest"
  else
    echo "  not installed: $dest"
  fi
}

run_install() {
  local src
  src="$(resolve_source)"
  echo "Installing $SKILL_NAME from $src"
  for dest in "${TARGETS[@]}"; do
    link_one "$src" "$dest"
  done
  echo
  echo "Done. Run '$0 --check' to verify."
}

run_update() {
  require_git
  # Update whichever clone the install points at. If we are inside a clone,
  # update that. Otherwise update CACHE_DIR.
  local src
  if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/SKILL.md" ] && [ -d "$SCRIPT_DIR/.git" ]; then
    src="$SCRIPT_DIR"
  else
    ensure_clone
    src="$CACHE_DIR"
  fi

  local before before_sha
  before="$(cat "$src/VERSION" 2>/dev/null || echo unknown)"
  before_sha="$(git -C "$src" rev-parse --short HEAD 2>/dev/null || echo unknown)"

  echo "Updating $src to $REF"
  git -C "$src" fetch --quiet --tags origin
  if git -C "$src" show-ref --verify --quiet "refs/remotes/origin/$REF"; then
    # REF names a branch: move onto it and fast-forward only.
    git -C "$src" checkout --quiet "$REF"
    git -C "$src" merge --ff-only --quiet "origin/$REF" \
      || { echo "ERROR: cannot fast-forward $REF; the clone has local changes." >&2; exit 1; }
  else
    # REF names a tag or commit: check it out directly (detached HEAD).
    git -C "$src" checkout --quiet "$REF" \
      || { echo "ERROR: ref '$REF' not found." >&2; exit 1; }
  fi

  local after after_sha
  after="$(cat "$src/VERSION" 2>/dev/null || echo unknown)"
  after_sha="$(git -C "$src" rev-parse --short HEAD 2>/dev/null || echo unknown)"

  # Re-link in case symlinks were missing or pointed elsewhere.
  for dest in "${TARGETS[@]}"; do
    link_one "$src" "$dest"
  done

  echo
  if [ "$before_sha" = "$after_sha" ]; then
    echo "Already up to date ($after)."
  else
    echo "Updated $before -> $after."
  fi
}

run_uninstall() {
  for dest in "${TARGETS[@]}"; do
    unlink_one "$dest"
  done
}

run_check() {
  echo "Targets:"
  for dest in "${TARGETS[@]}"; do
    if [ -L "$dest" ]; then
      if [ -e "$dest" ]; then
        printf "  %s -> %s\n" "$dest" "$(readlink "$dest")"
      else
        printf "  %s -> %s (BROKEN: target missing)\n" "$dest" "$(readlink "$dest")"
      fi
    elif [ -e "$dest" ]; then
      printf "  %s (exists, not a symlink)\n" "$dest"
    else
      printf "  %s (not installed)\n" "$dest"
    fi
  done
  if [ -d "$CACHE_DIR/.git" ]; then
    local ref
    ref="$(git -C "$CACHE_DIR" describe --tags --exact-match 2>/dev/null \
      || git -C "$CACHE_DIR" symbolic-ref --short -q HEAD 2>/dev/null \
      || git -C "$CACHE_DIR" rev-parse --short HEAD 2>/dev/null || echo unknown)"
    echo
    echo "Clone: $CACHE_DIR ($(cat "$CACHE_DIR/VERSION" 2>/dev/null || echo unknown), ref $ref)"
  fi
}

run_version() {
  local src=""
  if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/VERSION" ]; then
    src="$SCRIPT_DIR"
  elif [ -f "$CACHE_DIR/VERSION" ]; then
    src="$CACHE_DIR"
  fi
  if [ -n "$src" ]; then
    cat "$src/VERSION"
  else
    echo "not installed" >&2
    return 1
  fi
}

read_field() {
  local prompt="$1" var=""
  printf "  %s: " "$prompt" >&2
  if [ -t 0 ]; then
    read -r var || true
  elif exec 3</dev/tty 2>/dev/null; then
    read -r var <&3 || true
    exec 3<&-
  fi
  printf '%s' "$var"
}

run_init() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "ERROR: --init must run inside a git repository (your paper repo)." >&2
    exit 1
  fi
  local repo_root
  repo_root="$(git rev-parse --show-toplevel)"

  local src
  src="$(resolve_source)"
  local template="$src/examples/AGENTS.md.template"
  local claude_template="$src/examples/CLAUDE.md.template"
  if [ ! -f "$template" ]; then
    echo "ERROR: cannot find $template" >&2
    exit 1
  fi

  if [ ! -f "$repo_root/CLAUDE.md" ] && [ -f "$claude_template" ]; then
    cp "$claude_template" "$repo_root/CLAUDE.md"
    echo "Wrote $repo_root/CLAUDE.md (bridge to AGENTS.md)."
  fi

  local target="$repo_root/AGENTS.md"
  if [ -f "$target" ] && grep -q "<paper_context>" "$target"; then
    echo "AGENTS.md already contains a <paper_context> block. Skipping scaffolding."
    return 0
  fi

  echo "Scaffolding AGENTS.md in $repo_root"
  echo "Press Enter to skip a field; you can edit AGENTS.md later."
  echo

  local venue audience thesis stage
  venue=$(read_field "Target venue (e.g. Information Systems Research)")
  audience=$(read_field "Primary audience (e.g. empirical IS researchers)")
  thesis=$(read_field "Core thesis (1 to 2 sentences)")
  echo "  Revision stage options: first draft | response to reviewers | final polish" >&2
  stage=$(read_field "Revision stage")

  if [ -f "$target" ]; then
    echo "" >> "$target"
    sed -n '/<paper_context>/,/<\/paper_context>/p' "$template" >> "$target"
  else
    cp "$template" "$target"
  fi

  local v_venue="${venue:-[fill in]}"
  local v_audience="${audience:-[fill in]}"
  local v_thesis="${thesis:-[fill in]}"
  local v_stage="${stage:-first draft}"

  awk \
    -v venue="$v_venue" -v audience="$v_audience" \
    -v thesis="$v_thesis" -v stage="$v_stage" '
    function replace(line, val,    i, j) {
      i = index(line, "[REPLACE:")
      if (i == 0) return line
      j = index(substr(line, i), "]")
      if (j == 0) return line
      return substr(line, 1, i - 1) val substr(line, i + j)
    }
    /^target_venue:/   { print replace($0, venue);    next }
    /^audience:/       { print replace($0, audience); next }
    /^core_thesis:/    { print replace($0, thesis);   next }
    /^revision_stage:/ { print replace($0, stage);    next }
    { print }
  ' "$target" > "$target.tmp" && mv "$target.tmp" "$target"

  echo
  echo "Wrote $target. Review and edit as needed."
}

MODE="install"
while [ $# -gt 0 ]; do
  case "$1" in
    --update|update)            MODE="update" ;;
    --uninstall|uninstall)      MODE="uninstall" ;;
    --init|init)                MODE="init" ;;
    --check|-c|check)           MODE="check" ;;
    --version|version)          MODE="version" ;;
    --ref)
      shift
      [ $# -gt 0 ] || { echo "ERROR: --ref requires a value." >&2; exit 1; }
      REF="$1"
      ;;
    --ref=*)                    REF="${1#--ref=}" ;;
    --help|-h|help)             print_help; exit 0 ;;
    *)
      echo "Unknown argument: $1" >&2
      echo "Run with --help for usage." >&2
      exit 1
      ;;
  esac
  shift
done

case "$MODE" in
  install)   run_install ;;
  update)    run_update ;;
  uninstall) run_uninstall ;;
  init)      run_init ;;
  check)     run_check ;;
  version)   run_version ;;
esac
