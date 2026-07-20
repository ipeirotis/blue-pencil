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
COMMANDS_MARKER_REL=".paper-revision-editor-commands-registered"

pass=0
fail=0
skipped=0

ok() { pass=$((pass + 1)); }
no() { fail=$((fail + 1)); printf '  FAIL: %s\n' "$1" >&2; }

assert_file()    { if [ -f "$1" ]; then ok; else no "$2 (expected file: $1)"; fi; }
assert_no_file() { if [ ! -e "$1" ]; then ok; else no "$2 (unexpected file: $1)"; fi; }
assert_symlink() { if [ -L "$1" ]; then ok; else no "$2 (expected symlink: $1)"; fi; }
assert_no_path() { if [ ! -e "$1" ] && [ ! -L "$1" ]; then ok; else no "$2 (path still present: $1)"; fi; }
assert_grep()    { if grep -qF -- "$2" "$1" 2>/dev/null; then ok; else no "$3 (missing '$2' in $1)"; fi; }
assert_no_grep() { if grep -qF -- "$2" "$1" 2>/dev/null; then no "$3 (unexpected '$2' in $1)"; else ok; fi; }
# Assert the literal string $2 appears on exactly $3 lines of file $1.
assert_count()   { local n; n="$(grep -cF -- "$2" "$1" 2>/dev/null || true)"; n="${n:-0}"; if [ "$n" = "$3" ]; then ok; else no "$4 (expected $3 of '$2' in $1, got $n)"; fi; }

# Run an install.sh non-interactively inside a sandbox HOME. `read_field` reads
# from /dev/tty when stdin is not a terminal, so on a developer machine with a
# controlling terminal `--init` would block; setsid detaches it, making the read
# return empty (the skipped-field path). In CI there is no terminal and the
# redirect alone suffices. Output is discarded; callers assert on the filesystem.
SETSID=""
command -v setsid >/dev/null 2>&1 && SETSID="setsid"

# Only the --init scenario reaches `read_field`. It opens /dev/tty when stdin is
# not a terminal, so without setsid to detach the controlling terminal, an
# interactive run (e.g. `make test` on a default macOS box) would block waiting
# for field answers on the real terminal. Detect that case and skip --init with a
# message rather than hang. CI and piped runs have no /dev/tty, so they proceed.
can_run_init=1
if [ -z "$SETSID" ] && exec 3</dev/tty 2>/dev/null; then
  exec 3<&-
  can_run_init=0
fi

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
  if [ "$can_run_init" -eq 0 ]; then
    echo "  SKIP: --init (no setsid and an interactive /dev/tty is present; the field prompts would block). Runs in CI and under setsid."
    skipped=$((skipped + 1))
    return
  fi
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
  # In PR CI, actions/checkout leaves the repo in detached HEAD, so a plain clone
  # of it is detached too; install.sh --update would then resolve the clone's ref
  # to a bare SHA instead of a branch and skip the fast-forward. Pin the fixture
  # to a named branch and have the clone track it, so the branch fast-forward path
  # (the one that ships) is what the test exercises.
  git -C "$up" checkout -q -B test-update
  git clone -q --branch test-update "$up" "$clone" 2>/dev/null
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

# --- Scenario 5: --commands refuses to claim success on conflicting targets ---
# When both skill targets are unmanaged dirs (not our symlink/copy) that merely
# happen to contain a SKILL.md, link_one refuses them and no usable link is
# established. --commands must fail and register nothing, rather than count a
# refused dir as a working skill and print success for /paper:* that dead-end.
test_refused_targets() {
  local sb; sb="$(mktemp -d)"
  # Pre-create both targets as plain (non-symlink) dirs. The claude one carries a
  # SKILL.md but no VERSION, so it is neither a symlink nor a prior install:
  # link_one refuses it. Neither is linked to our source.
  mkdir -p "$sb/.agents/skills/paper-revision-editor" "$sb/.claude/skills/paper-revision-editor"
  printf 'not ours\n' > "$sb/.claude/skills/paper-revision-editor/SKILL.md"

  if run_installer "$sb" --commands; then
    no "refused: --commands should exit non-zero when no usable skill link exists"
  else
    ok
  fi
  assert_no_file "$sb/.claude/commands/paper/loop.md" "refused: no commands registered when skill link failed"
  assert_no_file "$sb/.claude/$MANIFEST_REL" "refused: no manifest written when skill link failed"

  rm -rf "$sb"
}

# --- Scenario 6: a complete external context block migrates into AGENTS.md -----
# A paper-meta.md carrying all four required fields is migrated verbatim into a
# freshly created AGENTS.md (no interactive scaffold), as a single block. This
# path never reaches read_field, so it runs even without a usable /dev/tty.
test_migration_complete() {
  local sb repo; sb="$(mktemp -d)"; repo="$sb/paper"
  mkdir -p "$repo"
  git -C "$repo" init -q
  cat > "$repo/paper-meta.md" <<'META'
<paper_context>
target_venue: Nature
audience: general science readers
core_thesis: widgets improve throughput
revision_stage: final polish
</paper_context>
META
  ( cd "$repo" && run_installer "$sb" --init )

  assert_file "$repo/AGENTS.md" "migrate: AGENTS.md created"
  assert_grep "$repo/AGENTS.md" "target_venue: Nature" "migrate: real venue carried over"
  assert_grep "$repo/AGENTS.md" "revision_stage: final polish" "migrate: real stage carried over"
  assert_no_grep "$repo/AGENTS.md" "[REPLACE:" "migrate: no leftover template placeholders"
  assert_count "$repo/AGENTS.md" "<paper_context>" "1" "migrate: exactly one context block"

  rm -rf "$sb"
}

# --- Scenario 7: a partial external block is NOT migrated ----------------------
# A paper-meta.md missing required fields must not short-circuit the scaffold: it
# would leave --init reporting success while the skill immediately stops for the
# missing context. It falls through to the scaffold ([fill in] placeholders).
test_migration_partial() {
  if [ "$can_run_init" -eq 0 ]; then
    echo "  SKIP: --init partial-migration (field prompts would block)."
    skipped=$((skipped + 1))
    return
  fi
  local sb repo; sb="$(mktemp -d)"; repo="$sb/paper"
  mkdir -p "$repo"
  git -C "$repo" init -q
  cat > "$repo/paper-meta.md" <<'META'
<paper_context>
target_venue: Nature
</paper_context>
META
  ( cd "$repo" && run_installer "$sb" --init )

  assert_file "$repo/AGENTS.md" "partial: AGENTS.md scaffolded"
  assert_no_grep "$repo/AGENTS.md" "target_venue: Nature" "partial: partial block not migrated"
  assert_grep "$repo/AGENTS.md" "audience: [fill in]" "partial: scaffold placeholders written instead"

  rm -rf "$sb"
}

# --- Scenario 8: an incomplete AGENTS.md block is replaced, not duplicated -----
# When AGENTS.md already holds an empty <paper_context> block, --init must remove
# it and write a single usable block, not append a second one that the skill
# never reaches. Surrounding content is preserved.
test_incomplete_block_replaced() {
  if [ "$can_run_init" -eq 0 ]; then
    echo "  SKIP: --init incomplete-block (field prompts would block)."
    skipped=$((skipped + 1))
    return
  fi
  local sb repo; sb="$(mktemp -d)"; repo="$sb/paper"
  mkdir -p "$repo"
  git -C "$repo" init -q
  cat > "$repo/AGENTS.md" <<'DOC'
# AGENTS.md

## Paper context

<paper_context>
</paper_context>

## Keep me

sentinel-line
DOC
  ( cd "$repo" && run_installer "$sb" --init )

  assert_count "$repo/AGENTS.md" "<paper_context>" "1" "incomplete: exactly one context block after replace"
  assert_grep "$repo/AGENTS.md" "target_venue:" "incomplete: replacement block has the fields"
  assert_grep "$repo/AGENTS.md" "sentinel-line" "incomplete: surrounding content preserved"

  rm -rf "$sb"
}

# --- Scenario 9: registration survives a downgrade round trip ------------------
# A ref that ships no paper: commands removes the global set (and its manifest),
# but the registration marker must persist so a later --update onto a ref that
# ships commands restores them, rather than treating the downgrade as an opt-out.
test_downgrade_marker() {
  local sb up clone; sb="$(mktemp -d)"; up="$sb/upstream"; clone="$sb/clone"
  # Build the upstream from the working tree (not a clone of REPO_ROOT's commit),
  # so the test exercises the install.sh under edit even before it is committed.
  mkdir -p "$up"
  git -C "$up" init -q
  cp "$REPO_ROOT/install.sh" "$REPO_ROOT/SKILL.md" "$REPO_ROOT/VERSION" "$up/"
  cp -R "$REPO_ROOT/.claude" "$up/.claude"
  git -C "$up" add -A
  git -C "$up" -c user.email=t@example.com -c user.name=test commit -q -m "baseline"
  git -C "$up" checkout -q -B test-marker
  git clone -q --branch test-marker "$up" "$clone" 2>/dev/null
  if [ ! -d "$clone/.git" ]; then
    no "downgrade: could not build a local clone"
    rm -rf "$sb"; return
  fi

  run_from "$sb" "$clone/install.sh" --commands
  local ctx="$sb/.claude"
  assert_file "$ctx/commands/paper/loop.md" "downgrade: baseline command registered"
  assert_file "$ctx/$COMMANDS_MARKER_REL" "downgrade: registration marker written"

  # Downgrade: upstream drops the bundled commands entirely.
  git -C "$up" rm -q -r .claude/commands/paper
  git -C "$up" -c user.email=t@example.com -c user.name=test commit -q -m "drop bundled commands"
  run_from "$sb" "$clone/install.sh" --update

  assert_no_file "$ctx/commands/paper/loop.md" "downgrade: incompatible command removed"
  assert_no_file "$ctx/$MANIFEST_REL" "downgrade: manifest dropped with the commands"
  assert_file "$ctx/$COMMANDS_MARKER_REL" "downgrade: marker kept across the downgrade"

  # Upgrade back: upstream restores the commands; the marker must drive a refresh.
  git -C "$up" -c user.email=t@example.com -c user.name=test revert --no-edit HEAD >/dev/null 2>&1
  run_from "$sb" "$clone/install.sh" --update

  assert_file "$ctx/commands/paper/loop.md" "downgrade: commands restored on upgrade via marker"
  assert_file "$ctx/$MANIFEST_REL" "downgrade: manifest rewritten on restore"

  rm -rf "$sb"
}

echo "Running install.sh tests..."
test_init
test_commands_uninstall
test_refresh
test_update_drift
test_refused_targets
test_migration_complete
test_migration_partial
test_incomplete_block_replaced
test_downgrade_marker

echo
skip_note=""
[ "$skipped" -gt 0 ] && skip_note=", $skipped scenario(s) skipped"
if [ "$fail" -eq 0 ]; then
  echo "install.sh tests OK ($pass checks passed$skip_note)."
else
  echo "install.sh tests FAILED ($fail failed, $pass passed$skip_note)." >&2
  exit 1
fi
