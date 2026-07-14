#!/usr/bin/env bash
# Hermetic tests for install.sh's highest-churn logic: command registration,
# the install manifest, refresh (stale-drop and pickup), uninstall, and the
# git-update drift path. Every recent install.sh fix has landed in exactly this
# logic, and none of it had coverage; this is that coverage.
#
# The suite is self-contained. It runs each scenario in a throwaway sandbox with
# HOME and PAPER_REVISION_EDITOR_HOME pointed inside it, so it never touches the
# developer's real ~/.claude, ~/.agents, or managed clone. It drives install.sh
# from this checkout (never a network clone), and the one git-update test builds
# a local origin so it needs no network either.
#
# Depends only on git, bash, and coreutils, like the other scripts/ helpers.

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
INSTALL="$REPO_ROOT/install.sh"
MANIFEST_REL=".paper-revision-editor-manifest"

pass=0
fail=0

ok() { pass=$((pass + 1)); }
no() { fail=$((fail + 1)); printf '  FAIL: %s\n' "$1" >&2; }

assert_file()    { if [ -f "$1" ]; then ok; else no "$2 (expected file: $1)"; fi; }
assert_no_file() { if [ ! -e "$1" ]; then ok; else no "$2 (unexpected file: $1)"; fi; }
assert_symlink() { if [ -L "$1" ]; then ok; else no "$2 (expected symlink: $1)"; fi; }
assert_no_path() { if [ ! -e "$1" ] && [ ! -L "$1" ]; then ok; else no "$2 (path still present: $1)"; fi; }
assert_grep()    { if grep -qF -- "$2" "$1" 2>/dev/null; then ok; else no "$3 (missing '$2' in $1)"; fi; }
assert_no_grep() { if grep -qF -- "$2" "$1" 2>/dev/null; then no "$3 (unexpected '$2' in $1)"; else ok; fi; }

# Run an install.sh non-interactively inside a sandbox HOME. `read_field` reads
# from /dev/tty when stdin is not a terminal, so on a developer machine with a
# controlling terminal `--init` would block; setsid detaches it, making the read
# return empty (the skipped-field path). In CI there is no terminal and the
# redirect alone suffices. Output is discarded; callers assert on the filesystem.
SETSID=""
command -v setsid >/dev/null 2>&1 && SETSID="setsid"
run_from() { # home, install_path, args...
  local home="$1" script="$2"; shift 2
  # $SETSID is intentionally word-split: it is "setsid" or empty (no wrapper).
  # shellcheck disable=SC2086
  HOME="$home" PAPER_REVISION_EDITOR_HOME="$home/.cache-clone" \
    $SETSID bash "$script" "$@" </dev/null >/dev/null 2>&1
}
run_installer() { local home="$1"; shift; run_from "$home" "$INSTALL" "$@"; }

# --- Scenario 1: --init in a fresh temp git repo -----------------------------
# Fields left blank write [fill in] (not the old `first draft` default); the
# paper: commands, the subagents, and the manifest are registered in the repo.
test_init() {
  local sb repo; sb="$(mktemp -d)"; repo="$sb/paper"
  mkdir -p "$repo"
  git -C "$repo" init -q
  ( cd "$repo" && run_installer "$sb" --init )

  local ctx="$repo/.claude"
  assert_file "$repo/AGENTS.md" "init: AGENTS.md scaffolded"
  assert_grep "$repo/AGENTS.md" "<paper_context>" "init: paper_context block written"
  assert_grep "$repo/AGENTS.md" "revision_stage: [fill in]" "init: skipped stage writes [fill in]"
  assert_no_grep "$repo/AGENTS.md" "revision_stage: first draft" "init: no stale first-draft default"
  assert_file "$repo/CLAUDE.md" "init: CLAUDE.md bridge written"
  assert_file "$ctx/commands/paper/loop.md" "init: loop command registered"
  assert_file "$ctx/commands/paper/verify-numbers.md" "init: verify-numbers command registered"
  assert_file "$ctx/commands/paper/figures.md" "init: figures command registered"
  assert_file "$ctx/commands/paper/analyze.md" "init: analyze command registered"
  assert_file "$ctx/agents/paper-reviser.md" "init: reviser subagent registered"
  assert_file "$ctx/agents/paper-analyst.md" "init: analyst subagent registered"
  assert_file "$ctx/agents/paper-scholar.md" "init: scholar subagent registered"
  assert_file "$ctx/$MANIFEST_REL" "init: manifest written"
  assert_grep "$ctx/$MANIFEST_REL" "commands/paper/loop.md" "init: manifest lists a command"
  assert_grep "$ctx/$MANIFEST_REL" "agents/paper-analyst.md" "init: manifest lists a subagent"

  rm -rf "$sb"
}

# --- Scenario 2: --commands then --uninstall ---------------------------------
# --commands links the skill and registers the global set; --uninstall removes
# the skill symlinks and every managed file, preserves a user's own paper/ file,
# and drops the manifest.
test_commands_uninstall() {
  local sb; sb="$(mktemp -d)"
  run_installer "$sb" --commands

  local ctx="$sb/.claude"
  assert_symlink "$sb/.agents/skills/paper-revision-editor" "commands: agents skill symlink created"
  assert_symlink "$sb/.claude/skills/paper-revision-editor" "commands: claude skill symlink created"
  assert_file "$ctx/commands/paper/loop.md" "commands: loop command registered globally"
  assert_file "$ctx/agents/paper-analyst.md" "commands: analyst subagent registered globally"
  assert_file "$ctx/$MANIFEST_REL" "commands: manifest written"

  # A user's own command in the paper: namespace must survive uninstall.
  printf '# mine\n' > "$ctx/commands/paper/mine.md"

  run_installer "$sb" --uninstall

  assert_no_path "$sb/.agents/skills/paper-revision-editor" "uninstall: agents skill symlink removed"
  assert_no_path "$sb/.claude/skills/paper-revision-editor" "uninstall: claude skill symlink removed"
  assert_no_file "$ctx/commands/paper/loop.md" "uninstall: managed command removed"
  assert_no_file "$ctx/agents/paper-analyst.md" "uninstall: managed subagent removed"
  assert_no_file "$ctx/$MANIFEST_REL" "uninstall: manifest removed"
  assert_file "$ctx/commands/paper/mine.md" "uninstall: user's own command preserved"

  rm -rf "$sb"
}

# --- Scenario 3: refresh drops stale files and picks up new ones -------------
# Re-running registration from a changed source removes a managed file that is no
# longer shipped, registers a newly shipped one, rewrites the manifest, and never
# touches a user's own unmanaged file. Uses a private copy of the checkout as the
# source so the real repo is untouched; a local source registers with no git.
test_refresh() {
  local sb src; sb="$(mktemp -d)"; src="$sb/src"
  mkdir -p "$src"
  cp "$REPO_ROOT/install.sh" "$REPO_ROOT/SKILL.md" "$REPO_ROOT/VERSION" "$src/"
  cp -R "$REPO_ROOT/.claude" "$src/.claude"

  run_from "$sb" "$src/install.sh" --commands

  local ctx="$sb/.claude"
  assert_file "$ctx/commands/paper/polish.md" "refresh: baseline command registered"
  assert_file "$ctx/$MANIFEST_REL" "refresh: baseline manifest written"

  # A user's own file that must survive the refresh.
  printf '# mine\n' > "$ctx/commands/paper/mine.md"

  # Mutate the source: drop a shipped command, add a new one, then re-register.
  rm -f "$src/.claude/commands/paper/polish.md"
  printf '# extra\n' > "$src/.claude/commands/paper/zzz-extra.md"
  run_from "$sb" "$src/install.sh" --commands

  assert_file "$ctx/commands/paper/zzz-extra.md" "refresh: newly shipped command registered"
  assert_no_file "$ctx/commands/paper/polish.md" "refresh: dropped command removed"
  assert_file "$ctx/commands/paper/mine.md" "refresh: user's own command preserved"
  assert_grep "$ctx/$MANIFEST_REL" "commands/paper/zzz-extra.md" "refresh: manifest lists the new command"
  assert_no_grep "$ctx/$MANIFEST_REL" "commands/paper/polish.md" "refresh: manifest drops the removed command"

  rm -rf "$sb"
}

# --- Scenario 4: --update picks up an upstream change (the git-pull path) -----
# A local origin ahead of the clone: --update fast-forwards the clone and
# refreshes the registered commands, so a command added upstream appears without
# a manual re-register, and a user's own command survives. All local, no network.
test_update_drift() {
  local sb up clone; sb="$(mktemp -d)"; up="$sb/upstream"; clone="$sb/clone"
  git clone -q "$REPO_ROOT" "$up" 2>/dev/null
  git clone -q "$up" "$clone" 2>/dev/null
  if [ ! -d "$clone/.git" ]; then
    no "update: could not build a local clone"
    rm -rf "$sb"; return
  fi

  run_from "$sb" "$clone/install.sh" --commands

  local ctx="$sb/.claude"
  assert_file "$ctx/commands/paper/loop.md" "update: baseline command registered from clone"
  printf '# mine\n' > "$ctx/commands/paper/mine.md"

  # Advance upstream by one commit that adds a new command.
  printf '# upstream extra\n' > "$up/.claude/commands/paper/zzz-upstream.md"
  git -C "$up" add .claude/commands/paper/zzz-upstream.md
  git -C "$up" -c user.email=t@example.com -c user.name=test commit -q -m "add upstream command"

  run_from "$sb" "$clone/install.sh" --update

  assert_file "$clone/.claude/commands/paper/zzz-upstream.md" "update: clone fast-forwarded to upstream"
  assert_file "$ctx/commands/paper/zzz-upstream.md" "update: refreshed commands include the new one"
  assert_file "$ctx/commands/paper/mine.md" "update: user's own command preserved across update"

  rm -rf "$sb"
}

echo "Running install.sh tests..."
test_init
test_commands_uninstall
test_refresh
test_update_drift

echo
if [ "$fail" -eq 0 ]; then
  echo "install.sh tests OK ($pass checks passed)."
else
  echo "install.sh tests FAILED ($fail failed, $pass passed)." >&2
  exit 1
fi
