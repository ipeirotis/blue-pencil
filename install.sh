#!/usr/bin/env bash
# Cross-tool installer for the paper-revision-editor skill.
#
# Default behaviour: install into ~/.agents/skills/paper-revision-editor (the
# cross-tool standard read by Zed, Goose, Codex, Gemini CLI, OpenCode, Cline,
# and other Agent-Skills-compatible tools), plus the native skills directory
# of every other detected agent.
#
# Usage:
#   ./install.sh                       # install for every detected agent
#   ./install.sh agents                # install only to ~/.agents/skills/ (cross-tool)
#   ./install.sh claude codex gemini   # install for the listed tools
#   ./install.sh --check               # detect tools; do not install
#   ./install.sh --uninstall           # remove every symlink
#   ./install.sh --uninstall claude    # remove for Claude Code only
#   ./install.sh --init                # scaffold AGENTS.md in the current repo
#   ./install.sh --bootstrap           # for curl|bash: clone the repo, then install
#
# Tool keys:
#   agents      ~/.agents/skills/      (cross-tool standard; read by many tools)
#   claude      ~/.claude/skills/
#   codex       ~/.codex/skills/
#   openclaw    ~/.openclaw/skills/
#   cursor      $PWD/.cursor/skills/   (project-scope only)
#   gemini      ~/.gemini/skills/
#   copilot     ~/.config/github-copilot/skills/
#   opencode    ~/.config/opencode/skills/
#   goose       ~/.config/goose/skills/
#   zed         (uses agents only)
#   junie       ~/.junie/skills/
#   cline       ~/.cline/skills/
#   roo         ~/.roo/skills/
#
# Symlinks are used by default so updates to the source repo propagate to every
# installed location. Pass FORCE_COPY=1 to copy files instead. Pass FORCE=1 to
# install for a tool that was not detected.
#
# This script is idempotent. Re-running it is safe.

set -euo pipefail

# When piped via `curl | bash`, BASH_SOURCE[0] is unset. Default to a
# sentinel that will trigger the bootstrap path (no SKILL.md beside it).
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
  SCRIPT_DIR="$(pwd)"
fi
SKILL_NAME="paper-revision-editor"
SOURCE_DIR="$SCRIPT_DIR"
REPO_URL="https://github.com/ipeirotis/paper-revision-editor.git"
CACHE_DIR="${PAPER_REVISION_EDITOR_HOME:-$HOME/.local/share/paper-revision-editor}"

# All tool keys understood by this installer. `agents` is intentionally first
# so install-all hits the cross-tool standard before any tool-specific path.
TOOL_KEYS=(agents claude codex openclaw cursor gemini copilot opencode goose zed junie cline roo)

# --- Detection ---------------------------------------------------------------
# Each detector returns 0 when the tool appears to be installed. `agents` is
# always considered detected: it is the cross-tool destination and does not
# require a specific agent on this machine.

detect_agents()   { return 0; }
detect_claude()   { command -v claude   >/dev/null 2>&1 || [ -d "$HOME/.claude"   ]; }
detect_codex()    { command -v codex    >/dev/null 2>&1 || [ -d "$HOME/.codex"    ]; }
detect_openclaw() { command -v openclaw >/dev/null 2>&1 || [ -d "$HOME/.openclaw" ]; }
detect_cursor() {
  command -v cursor >/dev/null 2>&1 \
    || [ -d "$HOME/.cursor" ] \
    || [ -d "/Applications/Cursor.app" ] \
    || [ -d "$HOME/AppData/Local/Programs/cursor" ]
}
detect_gemini()   { command -v gemini   >/dev/null 2>&1 || [ -d "$HOME/.gemini"   ]; }
detect_copilot() {
  { command -v gh >/dev/null 2>&1 && gh extension list 2>/dev/null | grep -q copilot; } \
    || command -v code >/dev/null 2>&1 \
    || [ -d "$HOME/.config/github-copilot" ]
}
detect_opencode() { command -v opencode >/dev/null 2>&1 || [ -d "$HOME/.config/opencode" ]; }
detect_goose()    { command -v goose    >/dev/null 2>&1 || [ -d "$HOME/.config/goose"    ]; }
detect_zed() {
  command -v zed >/dev/null 2>&1 \
    || [ -d "$HOME/.config/zed" ] \
    || [ -d "$HOME/Library/Application Support/Zed" ] \
    || [ -d "/Applications/Zed.app" ]
}
detect_junie() {
  [ -d "$HOME/.junie" ] \
    || command -v junie >/dev/null 2>&1 \
    || ls -d "$HOME"/.JetBrains* 2>/dev/null | head -n1 | grep -q . \
    || ls -d "$HOME"/Library/Application\ Support/JetBrains 2>/dev/null | head -n1 | grep -q .
}
detect_cline() {
  command -v code >/dev/null 2>&1 \
    || [ -d "$HOME/.cline" ] \
    || [ -d "$HOME/.vscode" ]
}
detect_roo() {
  [ -d "$HOME/.roo" ] \
    || command -v code >/dev/null 2>&1 \
    || [ -d "$HOME/.vscode" ]
}

# --- Per-tool paths ----------------------------------------------------------

path_agents()   { echo "$HOME/.agents/skills/$SKILL_NAME"; }
path_claude()   { echo "$HOME/.claude/skills/$SKILL_NAME"; }
path_codex()    { echo "$HOME/.codex/skills/$SKILL_NAME"; }
path_openclaw() { echo "$HOME/.openclaw/skills/$SKILL_NAME"; }
path_gemini()   { echo "$HOME/.gemini/skills/$SKILL_NAME"; }
path_copilot()  { echo "$HOME/.config/github-copilot/skills/$SKILL_NAME"; }
path_opencode() { echo "$HOME/.config/opencode/skills/$SKILL_NAME"; }
path_goose()    { echo "$HOME/.config/goose/skills/$SKILL_NAME"; }
path_junie()    { echo "$HOME/.junie/skills/$SKILL_NAME"; }
path_cline()    { echo "$HOME/.cline/skills/$SKILL_NAME"; }
path_roo()      { echo "$HOME/.roo/skills/$SKILL_NAME"; }
# Cursor is project-scope only.
path_cursor()   { echo "$PWD/.cursor/skills/$SKILL_NAME"; }
# Zed reads only ~/.agents/skills/ globally, so the `zed` key is an alias for
# the `agents` install. We keep the key so users can type install-zed.
path_zed()      { echo "$HOME/.agents/skills/$SKILL_NAME"; }

human_name() {
  case "$1" in
    agents)   echo "Cross-tool standard (~/.agents/skills/)" ;;
    claude)   echo "Claude Code (~/.claude/skills/)" ;;
    codex)    echo "Codex CLI (~/.codex/skills/; also reads ~/.agents/skills/)" ;;
    openclaw) echo "OpenClaw (~/.openclaw/skills/)" ;;
    gemini)   echo "Gemini CLI (~/.gemini/skills/; also reads ~/.agents/skills/)" ;;
    cursor)   echo "Cursor (\$PWD/.cursor/skills/, project-scope only)" ;;
    copilot)  echo "GitHub Copilot Agent Mode (~/.config/github-copilot/skills/)" ;;
    opencode) echo "OpenCode (~/.config/opencode/skills/; also reads ~/.agents/skills/)" ;;
    goose)    echo "Goose (~/.config/goose/skills/; also reads ~/.agents/skills/)" ;;
    zed)      echo "Zed (reads ~/.agents/skills/ only; covered by agents install)" ;;
    junie)    echo "JetBrains Junie (~/.junie/skills/)" ;;
    cline)    echo "Cline (~/.cline/skills/; reads ~/.agents/skills/ on newer builds)" ;;
    roo)      echo "Roo Code (~/.roo/skills/)" ;;
  esac
}

is_detected() {
  case "$1" in
    agents)   detect_agents ;;
    claude)   detect_claude ;;
    codex)    detect_codex ;;
    openclaw) detect_openclaw ;;
    cursor)   detect_cursor ;;
    gemini)   detect_gemini ;;
    copilot)  detect_copilot ;;
    opencode) detect_opencode ;;
    goose)    detect_goose ;;
    zed)      detect_zed ;;
    junie)    detect_junie ;;
    cline)    detect_cline ;;
    roo)      detect_roo ;;
    *) return 1 ;;
  esac
}

dest_path() {
  case "$1" in
    agents)   path_agents ;;
    claude)   path_claude ;;
    codex)    path_codex ;;
    openclaw) path_openclaw ;;
    cursor)   path_cursor ;;
    gemini)   path_gemini ;;
    copilot)  path_copilot ;;
    opencode) path_opencode ;;
    goose)    path_goose ;;
    zed)      path_zed ;;
    junie)    path_junie ;;
    cline)    path_cline ;;
    roo)      path_roo ;;
  esac
}

# --- Symlink helpers ---------------------------------------------------------

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
  elif ln -s "$SOURCE_DIR" "$dest" 2>/dev/null; then
    echo "  linked: $dest -> $SOURCE_DIR"
  else
    echo "  symlink failed (Windows without developer mode?); copying instead"
    cp -R "$SOURCE_DIR" "$dest"
    echo "  copied: $dest"
  fi
}

remove_link() {
  local dest="$1"
  if [ -L "$dest" ]; then
    rm "$dest"
    echo "  removed: $dest"
  elif [ -d "$dest" ] && [ "${FORCE:-0}" = "1" ]; then
    rm -rf "$dest"
    echo "  removed (copy): $dest"
  elif [ -e "$dest" ]; then
    echo "  skipped (not a symlink; pass FORCE=1 to remove a copy): $dest"
  else
    echo "  not installed: $dest"
  fi
}

# Track installed destinations to skip duplicates (e.g. zed = agents).
# Uses a delimited string instead of an associative array for bash 3.2
# compatibility (macOS ships bash 3.2).
_INSTALLED_DESTS=""

_dest_already_done() {
  case "$_INSTALLED_DESTS" in
    *"|$1|"*) return 0 ;;
    *) return 1 ;;
  esac
}

_dest_record() {
  _INSTALLED_DESTS="${_INSTALLED_DESTS}|$1|"
}

install_one() {
  local key="$1"
  local dest
  dest="$(dest_path "$key")"

  if _dest_already_done "$dest"; then
    echo "[$key] $(human_name "$key")"
    echo "  alias of a previous target; nothing to do"
    return 0
  fi

  echo "[$key] $(human_name "$key")"
  if ! is_detected "$key" && [ "${FORCE:-0}" != "1" ]; then
    echo "  not detected; skipping. (Use FORCE=1 to install anyway.)"
    return 0
  fi
  if [ "$key" = "cursor" ]; then
    if [ ! -d "$PWD/.git" ] && [ ! -f "$PWD/package.json" ] && [ ! -f "$PWD/pyproject.toml" ]; then
      echo "  Cursor uses project-scope skills only. Current directory does not look like a project root."
      echo "  cd into your project, then run: $0 cursor"
      return 0
    fi
    # Do not install Cursor into the skill repo itself; it should go into the
    # user's paper project. Check by looking for SKILL.md at the repo root.
    if [ -f "$PWD/SKILL.md" ] && grep -q "paper-revision-editor" "$PWD/SKILL.md" 2>/dev/null; then
      echo "  current directory is the skill repo, not a paper project; skipping."
      echo "  cd into your paper project, then run: $0 cursor"
      return 0
    fi
  fi
  if ! ensure_link "$dest"; then
    return 1
  fi
  _dest_record "$dest"
}

uninstall_one() {
  local key="$1"
  local dest
  dest="$(dest_path "$key")"
  echo "[$key] $(human_name "$key")"
  remove_link "$dest"
}

# --- Interactive AGENTS.md scaffolding ---------------------------------------

read_field() {
  local prompt="$1"
  local var=""
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
  local target="$repo_root/AGENTS.md"

  # Always ensure the CLAUDE.md bridge exists, even when AGENTS.md is already
  # configured. Repos that already have AGENTS.md are the exact migration case
  # where Claude-specific loading needs the bridge.
  if [ ! -f "$repo_root/CLAUDE.md" ] && [ -f "$SOURCE_DIR/examples/CLAUDE.md.template" ]; then
    cp "$SOURCE_DIR/examples/CLAUDE.md.template" "$repo_root/CLAUDE.md"
    echo "Wrote $repo_root/CLAUDE.md (bridge to AGENTS.md)."
  fi

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

  local template="$SOURCE_DIR/examples/AGENTS.md.template"
  if [ ! -f "$template" ]; then
    echo "ERROR: cannot find $template" >&2
    exit 1
  fi

  if [ -f "$target" ]; then
    echo "" >> "$target"
    sed -n '/<paper_context>/,/<\/paper_context>/p' "$template" >> "$target"
  else
    cp "$template" "$target"
  fi

  # Substitute placeholders.
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

# --- Bootstrap for `curl | bash` ---------------------------------------------
# When running via `curl ... | bash`, the script has no repo around it. The
# bootstrap path clones the repo into $CACHE_DIR, then re-execs from there.

run_bootstrap() {
  if [ -d "$CACHE_DIR/.git" ]; then
    echo "Updating existing clone at $CACHE_DIR"
    git -C "$CACHE_DIR" pull --quiet --ff-only origin main 2>/dev/null \
      || echo "  (pull skipped; local changes present. Run 'git -C $CACHE_DIR pull' manually.)"
  else
    echo "Cloning $REPO_URL to $CACHE_DIR"
    mkdir -p "$(dirname "$CACHE_DIR")"
    git clone --quiet "$REPO_URL" "$CACHE_DIR"
  fi
  echo
  echo "Running installer from $CACHE_DIR"
  echo
  exec "$CACHE_DIR/install.sh" "$@"
}

# --- Check ------------------------------------------------------------------

run_check() {
  echo "Detected tools on this machine:"
  echo
  for key in "${TOOL_KEYS[@]}"; do
    local dest
    dest="$(dest_path "$key")"
    if is_detected "$key"; then
      printf "  %-9s yes  -> %s\n" "$key" "$dest"
    else
      printf "  %-9s no\n" "$key"
    fi
  done
  echo
  echo "Run ./install.sh to install for the cross-tool location plus every detected tool."
  echo "Run ./install.sh <tool> to install for a specific tool."
}

# --- Main -------------------------------------------------------------------

MODE="install"
ARGS=()
for arg in "$@"; do
  case "$arg" in
    --check|-c|check)             MODE="check" ;;
    --uninstall|-u|uninstall)     MODE="uninstall" ;;
    --init|init)                  MODE="init" ;;
    --bootstrap|bootstrap)        MODE="bootstrap" ;;
    --help|-h|help)
      cat <<'HELPTEXT'
Cross-tool installer for the paper-revision-editor skill.

Usage:
  ./install.sh                       Install for every detected agent
  ./install.sh agents                Install only to ~/.agents/skills/ (cross-tool)
  ./install.sh claude codex gemini   Install for the listed tools
  ./install.sh --check               Detect tools; do not install
  ./install.sh --uninstall           Remove every symlink
  ./install.sh --init                Scaffold AGENTS.md in the current repo
  ./install.sh --bootstrap           Clone the repo, then install

Tool keys: agents claude codex openclaw cursor gemini copilot
           opencode goose zed junie cline roo

Set FORCE=1 to install for a tool that was not detected.
Set FORCE_COPY=1 to copy files instead of symlinking.
HELPTEXT
      exit 0
      ;;
    *) ARGS+=("$arg") ;;
  esac
done

# Build the full argument list for bootstrap re-exec. MODE was parsed out of
# ARGS, so we must re-inject it; otherwise `curl ... | bash -s -- --uninstall`
# silently becomes an install.
_build_bootstrap_args() {
  _BA=()
  # Re-inject MODE, but never --bootstrap itself (the re-exec'd script will
  # already be running from a clone, so it should proceed normally).
  if [ "$MODE" != "install" ] && [ "$MODE" != "bootstrap" ]; then
    _BA+=("--$MODE")
  fi
  _BA+=("${ARGS[@]}")
}

if [ "$MODE" = "bootstrap" ]; then
  _build_bootstrap_args
  run_bootstrap "${_BA[@]}"
fi

# If invoked outside a clone (no SKILL.md beside the script) and not in --check
# or --init mode, fall through to bootstrap so `curl | bash` Just Works.
if [ ! -f "$SOURCE_DIR/SKILL.md" ] && [ "$MODE" != "check" ] && [ "$MODE" != "init" ]; then
  echo "No SKILL.md found beside install.sh; bootstrapping a clone."
  _build_bootstrap_args
  run_bootstrap "${_BA[@]}"
fi

if [ "$MODE" = "check" ]; then
  run_check
  exit 0
fi

if [ "$MODE" = "init" ]; then
  run_init
  exit 0
fi

# Default targets: agents (cross-tool) plus every detected tool.
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
FAILURES=0
for key in "${TARGETS[@]}"; do
  install_one "$key" || FAILURES=$((FAILURES + 1))
done
echo
if [ "$FAILURES" -gt 0 ]; then
  echo "$FAILURES target(s) failed. Review the output above."
  exit 1
fi
echo "Done. Run './install.sh --check' to see which tools are installed."
echo "Run './install.sh --init' inside a paper repo to scaffold AGENTS.md."
