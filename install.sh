#!/usr/bin/env bash
# Cross-tool installer for the paper-revision-editor skill.
#
# Default: install the skill into every SKILL.md-compatible agent detected on
# this machine, by symlinking this repository into each tool's skills directory.
#
# Usage:
#   ./install.sh                       # install for all detected tools
#   ./install.sh claude                # install for Claude Code only
#   ./install.sh claude codex gemini   # install for the listed tools
#   ./install.sh --check               # detect tools; do not install
#   ./install.sh --uninstall           # remove symlinks
#   ./install.sh --uninstall claude    # remove for Claude Code only
#
# Tool keys: claude codex openclaw cursor gemini copilot
#
# Symlinks are used by default so updates to this repo propagate to every
# installed location. Pass FORCE_COPY=1 to copy files instead.
#
# This script is idempotent. Re-running it is safe.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_NAME="paper-revision-editor"
SOURCE_DIR="$SCRIPT_DIR"

# Tool keys understood by this installer.
TOOL_KEYS=(claude codex openclaw cursor gemini copilot)

# Per-tool detection commands or filesystem markers.
detect_claude() {
  command -v claude >/dev/null 2>&1 || [ -d "$HOME/.claude" ]
}
detect_codex() {
  command -v codex >/dev/null 2>&1 || [ -d "$HOME/.codex" ]
}
detect_openclaw() {
  command -v openclaw >/dev/null 2>&1 || [ -d "$HOME/.openclaw" ]
}
detect_cursor() {
  command -v cursor >/dev/null 2>&1 \
    || [ -d "$HOME/.cursor" ] \
    || [ -d "/Applications/Cursor.app" ] \
    || [ -d "$HOME/AppData/Local/Programs/cursor" ]
}
detect_gemini() {
  command -v gemini >/dev/null 2>&1 || [ -d "$HOME/.gemini" ]
}
detect_copilot() {
  command -v gh >/dev/null 2>&1 && gh extension list 2>/dev/null | grep -q copilot \
    || command -v code >/dev/null 2>&1 \
    || [ -d "$HOME/.config/github-copilot" ]
}

# Per-tool install paths.
path_claude()   { echo "$HOME/.claude/skills/$SKILL_NAME"; }
path_codex()    { echo "$HOME/.codex/skills/$SKILL_NAME"; }
path_openclaw() { echo "$HOME/.openclaw/skills/$SKILL_NAME"; }
path_gemini()   { echo "$HOME/.gemini/skills/$SKILL_NAME"; }
path_copilot()  { echo "$HOME/.config/github-copilot/skills/$SKILL_NAME"; }
# Cursor is project-scope only; install into the current working directory if
# it looks like a project root, otherwise warn and skip.
path_cursor()   { echo "$PWD/.cursor/skills/$SKILL_NAME"; }

human_name() {
  case "$1" in
    claude)   echo "Claude Code (~/.claude/skills/)" ;;
    codex)    echo "Codex CLI (~/.codex/skills/)" ;;
    openclaw) echo "OpenClaw (~/.openclaw/skills/)" ;;
    gemini)   echo "Gemini CLI (~/.gemini/skills/)" ;;
    cursor)   echo "Cursor (\$PWD/.cursor/skills/, project-scope only)" ;;
    copilot)  echo "GitHub Copilot Agent Mode (~/.config/github-copilot/skills/)" ;;
  esac
}

is_detected() {
  case "$1" in
    claude)   detect_claude ;;
    codex)    detect_codex ;;
    openclaw) detect_openclaw ;;
    cursor)   detect_cursor ;;
    gemini)   detect_gemini ;;
    copilot)  detect_copilot ;;
    *) return 1 ;;
  esac
}

dest_path() {
  case "$1" in
    claude)   path_claude ;;
    codex)    path_codex ;;
    openclaw) path_openclaw ;;
    cursor)   path_cursor ;;
    gemini)   path_gemini ;;
    copilot)  path_copilot ;;
  esac
}

ensure_link() {
  local dest="$1"
  local parent
  parent="$(dirname "$dest")"
  mkdir -p "$parent"

  if [ -L "$dest" ]; then
    local current
    current="$(readlink "$dest")"
    if [ "$current" = "$SOURCE_DIR" ]; then
      echo "  already linked: $dest"
      return 0
    fi
    echo "  replacing stale link: $dest -> $current"
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo "  ERROR: $dest exists and is not a symlink. Refusing to overwrite." >&2
    return 1
  fi

  if [ "${FORCE_COPY:-0}" = "1" ]; then
    cp -R "$SOURCE_DIR" "$dest"
    echo "  copied: $dest"
  else
    ln -s "$SOURCE_DIR" "$dest"
    echo "  linked: $dest -> $SOURCE_DIR"
  fi
}

remove_link() {
  local dest="$1"
  if [ -L "$dest" ]; then
    rm "$dest"
    echo "  removed: $dest"
  elif [ -e "$dest" ]; then
    echo "  skipped (not a symlink): $dest"
  else
    echo "  not installed: $dest"
  fi
}

install_one() {
  local key="$1"
  local dest
  dest="$(dest_path "$key")"
  echo "[$key] $(human_name "$key")"
  if ! is_detected "$key"; then
    echo "  not detected; skipping. (Use FORCE=1 ./install.sh $key to install anyway.)"
    [ "${FORCE:-0}" = "1" ] || return 0
  fi
  if [ "$key" = "cursor" ]; then
    if [ ! -d "$PWD/.git" ] && [ ! -f "$PWD/package.json" ] && [ ! -f "$PWD/pyproject.toml" ]; then
      echo "  Cursor uses project-scope skills only. Current directory does not look like a project root."
      echo "  cd into your project, then run: $0 cursor"
      return 0
    fi
  fi
  ensure_link "$dest"
}

uninstall_one() {
  local key="$1"
  local dest
  dest="$(dest_path "$key")"
  echo "[$key] $(human_name "$key")"
  remove_link "$dest"
}

run_check() {
  echo "Detected tools on this machine:"
  echo
  for key in "${TOOL_KEYS[@]}"; do
    if is_detected "$key"; then
      printf "  %-9s yes  -> %s\n" "$key" "$(dest_path "$key")"
    else
      printf "  %-9s no\n" "$key"
    fi
  done
  echo
  echo "Run ./install.sh to install for every detected tool."
  echo "Run ./install.sh <tool> to install for a specific tool."
}

# --- Main -------------------------------------------------------------------

MODE="install"
ARGS=()
for arg in "$@"; do
  case "$arg" in
    --check|-c|check) MODE="check" ;;
    --uninstall|-u|uninstall) MODE="uninstall" ;;
    --help|-h|help)
      sed -n '2,20p' "$0"
      exit 0
      ;;
    *) ARGS+=("$arg") ;;
  esac
done

if [ "$MODE" = "check" ]; then
  run_check
  exit 0
fi

if [ ${#ARGS[@]} -eq 0 ]; then
  TARGETS=("${TOOL_KEYS[@]}")
else
  TARGETS=("${ARGS[@]}")
fi

# Validate target keys.
for key in "${TARGETS[@]}"; do
  ok=0
  for valid in "${TOOL_KEYS[@]}"; do
    [ "$key" = "$valid" ] && ok=1 && break
  done
  if [ "$ok" -ne 1 ]; then
    echo "ERROR: unknown tool key: $key" >&2
    echo "Valid keys: ${TOOL_KEYS[*]}" >&2
    exit 1
  fi
done

if [ "$MODE" = "uninstall" ]; then
  for key in "${TARGETS[@]}"; do
    uninstall_one "$key"
  done
  exit 0
fi

echo "Installing $SKILL_NAME from $SOURCE_DIR"
echo
for key in "${TARGETS[@]}"; do
  install_one "$key" || true
done
echo
echo "Done. Run './install.sh --check' to see which tools are installed."
