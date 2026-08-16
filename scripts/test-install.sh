#!/usr/bin/env bash
# Hermetic tests for install.sh's highest-churn logic: command registration,
# the install manifest, refresh (stale-drop and pickup), uninstall, and the
# git-update drift path. Every recent install.sh fix has landed in exactly this
# logic, and none of it had coverage; this is that coverage.
#
# The suite is self-contained. It runs each scenario in a throwaway sandbox with
# HOME and BLUE_PENCIL_HOME pointed inside it, so it never touches the
# developer's real ~/.claude, ~/.agents, or managed clone. It drives install.sh
# from this checkout (never a network clone), and the one git-update test builds
# a local origin so it needs no network either.
#
# Depends only on git, bash, and coreutils, like the other scripts/ helpers.

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
INSTALL="$REPO_ROOT/install.sh"
MANIFEST_REL=".blue-pencil-manifest"
COMMANDS_MARKER_REL=".blue-pencil-commands-registered"

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
  HOME="$home" BLUE_PENCIL_HOME="$home/.cache-clone" \
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
  assert_file "$ctx/commands/paper/quick.md" "init: quick command registered"
  assert_file "$ctx/agents/paper-reviser.md" "init: reviser subagent registered"
  assert_file "$ctx/$MANIFEST_REL" "init: manifest written"
  assert_file "$ctx/$COMMANDS_MARKER_REL" "init: project registration marker written"
  assert_grep "$ctx/$MANIFEST_REL" "commands/paper/loop.md" "init: manifest lists a command"
  assert_grep "$ctx/$MANIFEST_REL" "agents/paper-reviser.md" "init: manifest lists a subagent"

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
  assert_symlink "$sb/.agents/skills/blue-pencil" "commands: agents skill symlink created"
  assert_symlink "$sb/.claude/skills/blue-pencil" "commands: claude skill symlink created"
  assert_file "$ctx/commands/paper/loop.md" "commands: loop command registered globally"
  assert_file "$ctx/commands/paper/quick.md" "commands: quick command registered globally"
  assert_file "$ctx/agents/paper-reviser.md" "commands: reviser subagent registered globally"
  assert_file "$ctx/$MANIFEST_REL" "commands: manifest written"

  # A user's own command in the paper: namespace must survive uninstall.
  printf '# mine\n' > "$ctx/commands/paper/mine.md"

  run_installer "$sb" --uninstall

  assert_no_path "$sb/.agents/skills/blue-pencil" "uninstall: agents skill symlink removed"
  assert_no_path "$sb/.claude/skills/blue-pencil" "uninstall: claude skill symlink removed"
  assert_no_file "$ctx/commands/paper/loop.md" "uninstall: managed command removed"
  assert_no_file "$ctx/agents/paper-reviser.md" "uninstall: managed subagent removed"
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
  local sb up clone paper; sb="$(mktemp -d)"; up="$sb/upstream"; clone="$sb/clone"; paper="$sb/paper"
  git clone -q "$REPO_ROOT" "$up" 2>/dev/null
  # git clone sees committed state only; overlay the installer and new command
  # under test so this scenario exercises the current working tree.
  cp "$REPO_ROOT/install.sh" "$up/install.sh"
  cp "$REPO_ROOT/.claude/commands/paper/quick.md" "$up/.claude/commands/paper/quick.md"
  git -C "$up" add install.sh .claude/commands/paper/quick.md
  if ! git -C "$up" diff --cached --quiet; then
    git -C "$up" -c user.email=t@example.com -c user.name=test commit -q -m "fixture current installer"
  fi
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

  # Model the stale project-local state left after the first update was executed
  # by the old v2 script. A subsequent invocation of the v3 updater from that
  # paper repo must refresh the copied set.
  git init -q "$paper"
  mkdir -p "$paper/.claude/commands/paper"
  printf '# stale analyst command\n' > "$paper/.claude/commands/paper/verify-numbers.md"
  printf 'commands/paper/verify-numbers.md\n' > "$paper/.claude/$MANIFEST_REL"

  # Advance upstream by one commit that adds a new command.
  printf '# upstream extra\n' > "$up/.claude/commands/paper/zzz-upstream.md"
  git -C "$up" add .claude/commands/paper/zzz-upstream.md
  git -C "$up" -c user.email=t@example.com -c user.name=test commit -q -m "add upstream command"

  ( cd "$paper" && HOME="$sb" BLUE_PENCIL_HOME="$sb/.cache-clone" bash "$clone/install.sh" --update >/dev/null 2>&1 )

  assert_file "$clone/.claude/commands/paper/zzz-upstream.md" "update: clone fast-forwarded to upstream"
  assert_file "$ctx/commands/paper/zzz-upstream.md" "update: refreshed commands include the new one"
  assert_file "$ctx/commands/paper/mine.md" "update: user's own command preserved across update"
  assert_no_file "$paper/.claude/commands/paper/verify-numbers.md" "update: project-local stale command removed"
  assert_file "$paper/.claude/commands/paper/quick.md" "update: project-local commands refreshed"

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
  mkdir -p "$sb/.agents/skills/blue-pencil" "$sb/.claude/skills/blue-pencil"
  printf 'not ours\n' > "$sb/.claude/skills/blue-pencil/SKILL.md"

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
# A paper-meta.md carrying all four context fields is migrated verbatim into a
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
# A paper-meta.md missing the operational fields must not short-circuit the scaffold: it
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

# --- Scenario 9: a partial AGENTS.md block is reported, not falsely accepted ---
# When AGENTS.md already holds a closed block that is missing operational fields,
# --init must not claim success (the skill stops on the missing fields) nor strip
# the block (it holds real values the user wrote). It names the gaps, preserves
# the existing values, and adds no duplicate block. Runs without a tty: this path
# returns before the interactive scaffold.
test_partial_agents_block() {
  local sb repo; sb="$(mktemp -d)"; repo="$sb/paper"
  mkdir -p "$repo"
  git -C "$repo" init -q
  cat > "$repo/AGENTS.md" <<'DOC'
# AGENTS.md

<paper_context>
target_venue: Nature
</paper_context>
DOC
  # Capture output and exit status: the meaningful signals here are the gap-naming
  # message and a non-zero exit (so a gating workflow does not treat the repo as
  # ready). This path never reaches read_field, so no setsid/tty handling is needed.
  local out rc
  out="$(cd "$repo" && HOME="$sb" BLUE_PENCIL_HOME="$sb/.cache-clone" \
    bash "$INSTALL" --init </dev/null 2>&1)"
  rc=$?

  if [ "$rc" -ne 0 ]; then ok; else no "partial-agents: --init should exit non-zero on incomplete context"; fi
  case "$out" in
    *"missing operational field"*) ok ;;
    *) no "partial-agents: --init should name the missing fields" ;;
  esac
  case "$out" in
    *audience*) ok ;;
    *) no "partial-agents: message should list the absent field names" ;;
  esac
  assert_grep "$repo/AGENTS.md" "target_venue: Nature" "partial-agents: existing value preserved"
  assert_no_grep "$repo/AGENTS.md" "[fill in]" "partial-agents: not overwritten with placeholders"
  assert_count "$repo/AGENTS.md" "<paper_context>" "1" "partial-agents: no duplicate block appended"
  assert_file "$repo/.claude/commands/paper/loop.md" "partial-agents: commands still registered"

  rm -rf "$sb"
}

# --- Scenario: optional venue and thesis do not block initialization ---------
# Audience and revision stage are the operational context. A closed block with
# those two fields is already usable even when venue and thesis are omitted.
test_operational_context_only() {
  local sb repo; sb="$(mktemp -d)"; repo="$sb/paper"
  mkdir -p "$repo"
  git -C "$repo" init -q
  cat > "$repo/AGENTS.md" <<'DOC'
# AGENTS.md

<paper_context>
audience: empirical researchers
revision_stage: final polish
</paper_context>
DOC

  ( cd "$repo" && run_installer "$sb" --init )

  assert_count "$repo/AGENTS.md" "<paper_context>" "1" "operational-context: existing block accepted"
  assert_no_grep "$repo/AGENTS.md" "target_venue:" "operational-context: optional venue not injected"
  assert_no_grep "$repo/AGENTS.md" "core_thesis:" "operational-context: optional thesis not injected"
  assert_file "$repo/.claude/commands/paper/quick.md" "operational-context: commands registered"

  rm -rf "$sb"
}

# --- Scenario: a stale skill shadowing a good link at higher priority ---------
# The subagents resolve ~/.claude/skills before ~/.agents/skills. If a refused
# unmanaged dir with a foreign SKILL.md sits at ~/.claude/skills while ~/.agents
# links fine, /paper:* still loads the stale ~/.claude one. --commands must fail
# (not count the lower-priority good link as usable) and register nothing.
test_shadowed_link() {
  local sb; sb="$(mktemp -d)"
  # Refused, higher-priority target carrying a foreign skill; no VERSION, not a
  # symlink, so link_one refuses it. ~/.agents is left free to link successfully.
  mkdir -p "$sb/.claude/skills/blue-pencil"
  printf 'stale, not ours\n' > "$sb/.claude/skills/blue-pencil/SKILL.md"

  if run_installer "$sb" --commands; then
    no "shadowed: --commands should fail when a stale skill shadows the good link"
  else
    ok
  fi
  assert_no_file "$sb/.claude/commands/paper/loop.md" "shadowed: no commands registered under a shadowed link"
  assert_no_file "$sb/.claude/$MANIFEST_REL" "shadowed: no manifest written under a shadowed link"

  rm -rf "$sb"
}

# --- Scenario: --init refuses an AGENTS.md with multiple context blocks --------
# The skill uses only the first block, so multiple blocks are ambiguous. --init
# must not silently validate/migrate the wrong one; it fails non-zero and leaves
# the file untouched for the user to consolidate.
test_multi_block_agents() {
  local sb repo; sb="$(mktemp -d)"; repo="$sb/paper"
  mkdir -p "$repo"
  git -C "$repo" init -q
  cat > "$repo/AGENTS.md" <<'DOC'
# AGENTS.md

<paper_context>
</paper_context>

<paper_context>
target_venue: SecondBlock
audience: y
core_thesis: z
revision_stage: final polish
</paper_context>
DOC
  local rc
  ( cd "$repo" && HOME="$sb" BLUE_PENCIL_HOME="$sb/.cache-clone" \
    bash "$INSTALL" --init </dev/null >/dev/null 2>&1 )
  rc=$?

  if [ "$rc" -ne 0 ]; then ok; else no "multi-block: --init should exit non-zero on multiple context blocks"; fi
  assert_count "$repo/AGENTS.md" "<paper_context>" "2" "multi-block: file left untouched (both blocks intact)"
  assert_grep "$repo/AGENTS.md" "target_venue: SecondBlock" "multi-block: existing values preserved"

  rm -rf "$sb"
}

# --- Scenario 10: registration survives a downgrade round trip -----------------
# A ref that ships no paper: commands removes the global set (and its manifest),
# but the registration marker must persist so a later update onto a ref that
# ships commands restores them, rather than treating the downgrade as an opt-out.
# The downgraded ref is a genuinely old release: its install.sh is a stub with
# none of the restore logic, not the current tree minus a directory. So the
# downgrade run (still executed by current code) must name the way back, and the
# restoring update must go through a current installer, the curl one-liner path
# the notice prescribes, exercised here by feeding the working-tree installer to
# bash on stdin with the managed clone as its cache.
test_downgrade_marker() {
  local sb up clone paper; sb="$(mktemp -d)"; up="$sb/upstream"; clone="$sb/clone"; paper="$sb/paper"
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
  git init -q "$paper"
  mkdir -p "$paper/.claude/commands/paper"
  cp "$up/.claude/commands/paper/loop.md" "$paper/.claude/commands/paper/loop.md"
  printf 'commands/paper/loop.md\n' > "$paper/.claude/$MANIFEST_REL"
  : > "$paper/.claude/$COMMANDS_MARKER_REL"

  # Downgrade: upstream drops the bundled commands entirely, and its installer
  # is an old stub with no marker or project-refresh logic, like a real
  # pre-commands release. The removal itself still runs in current code (the
  # invoked install.sh was read before the sync swapped the file).
  git -C "$up" rm -q -r .claude/commands/paper
  printf '#!/usr/bin/env bash\necho "old installer: no restore logic"\n' > "$up/install.sh"
  printf '1.14.0\n' > "$up/VERSION"
  git -C "$up" add install.sh VERSION
  git -C "$up" -c user.email=t@example.com -c user.name=test commit -q -m "drop bundled commands"
  # Tag the old release for the install-mode pin phase below.
  git -C "$up" tag v1.14.0
  local down_out
  down_out="$(cd "$paper" && HOME="$sb" BLUE_PENCIL_HOME="$sb/.cache-clone" bash "$clone/install.sh" --update </dev/null 2>&1)"

  case "$down_out" in
    *"predates the command restore"*) ok ;;
    *) no "downgrade: removal names the explicit way back" ;;
  esac
  assert_grep "$clone/VERSION" "1.14.0" "downgrade: clone checked out the old release"
  assert_no_file "$ctx/commands/paper/loop.md" "downgrade: incompatible command removed"
  assert_no_file "$ctx/$MANIFEST_REL" "downgrade: manifest dropped with the commands"
  assert_file "$ctx/$COMMANDS_MARKER_REL" "downgrade: marker kept across the downgrade"
  assert_no_file "$paper/.claude/commands/paper/loop.md" "downgrade: project-local incompatible command removed"
  assert_no_file "$paper/.claude/$MANIFEST_REL" "downgrade: project-local manifest dropped"
  assert_file "$paper/.claude/$COMMANDS_MARKER_REL" "downgrade: project-local marker kept"

  # Upgrade back: upstream restores the commands; the marker must drive a
  # refresh. Run it the way the downgrade notice prescribes: through a current
  # installer (the curl one-liner path, emulated by feeding the working-tree
  # install.sh to bash on stdin) with the managed clone as its cache. The
  # clone's own install.sh is the old stub at this point, which is the point:
  # only a current installer knows to read the markers and restore the sets.
  git -C "$up" -c user.email=t@example.com -c user.name=test revert --no-edit HEAD >/dev/null 2>&1
  ( cd "$paper" && HOME="$sb" BLUE_PENCIL_HOME="$clone" bash -s -- --update < "$REPO_ROOT/install.sh" >/dev/null 2>&1 )

  assert_file "$ctx/commands/paper/loop.md" "downgrade: commands restored on upgrade via marker"
  assert_file "$ctx/$MANIFEST_REL" "downgrade: manifest rewritten on restore"
  assert_file "$paper/.claude/commands/paper/loop.md" "downgrade: project-local commands restored via marker"
  assert_file "$paper/.claude/$MANIFEST_REL" "downgrade: project-local manifest restored"

  # The documented `--ref vX.Y.Z` pin runs as MODE=install, not update, and a
  # tag pin detaches the clone so the old ref stays sticky. Downgrade again
  # through exactly that path (a current installer on stdin pinning the old
  # tag) and assert the same cleanup and notice fire; then recover the way the
  # notice prescribes, a current installer told an explicit newer ref.
  local pin_out
  pin_out="$(cd "$paper" && HOME="$sb" BLUE_PENCIL_HOME="$clone" bash -s -- --ref v1.14.0 < "$REPO_ROOT/install.sh" 2>&1)"

  case "$pin_out" in
    *"predates the command restore"*) ok ;;
    *) no "ref-pin: install-mode downgrade names the way back" ;;
  esac
  case "$pin_out" in
    *"--update --ref main"*) ok ;;
    *) no "ref-pin: notice carries an explicit newer ref" ;;
  esac
  assert_grep "$clone/VERSION" "1.14.0" "ref-pin: clone pinned to the old tag"
  assert_no_file "$ctx/commands/paper/loop.md" "ref-pin: global command removed by install-mode pin"
  assert_no_file "$paper/.claude/commands/paper/loop.md" "ref-pin: project-local command removed by install-mode pin"
  assert_file "$ctx/$COMMANDS_MARKER_REL" "ref-pin: global marker kept"
  assert_file "$paper/.claude/$COMMANDS_MARKER_REL" "ref-pin: project-local marker kept"

  ( cd "$paper" && HOME="$sb" BLUE_PENCIL_HOME="$clone" bash -s -- --update --ref test-marker < "$REPO_ROOT/install.sh" >/dev/null 2>&1 )

  assert_file "$ctx/commands/paper/loop.md" "ref-pin: commands restored with an explicit newer ref"
  assert_file "$paper/.claude/commands/paper/loop.md" "ref-pin: project-local commands restored with an explicit newer ref"

  rm -rf "$sb"
}

# --- Scenario: a pre-rename install migrates onto the blue-pencil identity ----
# An install made under the old paper-revision-editor name (old-name symlinks,
# the clone at the old default location with origin on the old URL, and the
# manifest and marker under the old hidden names) must migrate in place on the
# next installer run: clone moved and its remote retargeted, old symlinks
# dropped, new-name links established, and the manifest carried over so the
# refresh updates previously registered files instead of backing them up as
# .bak. No BLUE_PENCIL_HOME override here: the clone move under test is the
# default-path one, so the sandbox HOME alone isolates it. All local, no
# network (remote set-url never contacts the remote).
test_rename_migration() {
  local sb old_clone; sb="$(mktemp -d)"; old_clone="$sb/.local/share/paper-revision-editor"
  mkdir -p "$sb/.local/share" "$sb/.claude/skills" "$sb/.agents/skills" "$sb/.claude/commands/paper"
  git clone -q "$REPO_ROOT" "$old_clone" 2>/dev/null
  if [ ! -d "$old_clone/.git" ]; then
    no "rename: could not build the old-name clone"
    rm -rf "$sb"; return
  fi
  git -C "$old_clone" remote set-url origin "https://github.com/ipeirotis/paper-revision-editor.git"
  ln -s "$old_clone" "$sb/.claude/skills/paper-revision-editor"
  ln -s "$old_clone" "$sb/.agents/skills/paper-revision-editor"
  # A previously registered command, recorded in the OLD manifest name and
  # differing from the shipped copy: only a migrated manifest lets the refresh
  # update it in place instead of preserving it as a backup.
  printf '# pre-rename copy\n' > "$sb/.claude/commands/paper/loop.md"
  printf 'commands/paper/loop.md\n' > "$sb/.claude/.paper-revision-editor-manifest"
  : > "$sb/.claude/.paper-revision-editor-commands-registered"

  ( HOME="$sb" bash "$INSTALL" --commands </dev/null >/dev/null 2>&1 )

  assert_no_path "$sb/.claude/skills/paper-revision-editor" "rename: old claude symlink removed"
  assert_no_path "$sb/.agents/skills/paper-revision-editor" "rename: old agents symlink removed"
  assert_symlink "$sb/.claude/skills/blue-pencil" "rename: new claude symlink created"
  assert_symlink "$sb/.agents/skills/blue-pencil" "rename: new agents symlink created"
  assert_no_path "$old_clone" "rename: old clone moved away"
  assert_file "$sb/.local/share/blue-pencil/.git/HEAD" "rename: clone lives at the new location"
  local remote
  # Raw config read, not `remote get-url`: get-url applies insteadOf rewrites,
  # so on a machine with such rules it would not report the stored URL.
  remote="$(git -C "$sb/.local/share/blue-pencil" config --get remote.origin.url 2>/dev/null)"
  if [ "$remote" = "https://github.com/ipeirotis/blue-pencil.git" ]; then ok; else no "rename: clone remote retargeted (got: $remote)"; fi
  assert_no_file "$sb/.claude/.paper-revision-editor-manifest" "rename: old manifest name gone"
  assert_file "$sb/.claude/$MANIFEST_REL" "rename: manifest carried to the new name"
  assert_no_file "$sb/.claude/.paper-revision-editor-commands-registered" "rename: old marker name gone"
  assert_file "$sb/.claude/$COMMANDS_MARKER_REL" "rename: marker carried to the new name"
  assert_no_file "$sb/.claude/commands/paper/loop.md.bak" "rename: managed file refreshed without a backup"
  assert_no_grep "$sb/.claude/commands/paper/loop.md" "pre-rename copy" "rename: managed file updated in place"

  rm -rf "$sb"
}

# --- Scenario: a pre-rename paper repo migrates its project-local manifest ----
# A repo initialized by the old paper-revision-editor installer carries its
# manifest and marker under the old hidden names, recording files v3 no longer
# ships. The global rename migration only reaches $HOME/.claude, so both
# project-local paths must carry the repo's own files onto the new names first:
# --init, and the --update refresh run from inside the repo (whose gate reads
# only the new names and would otherwise skip the repo entirely). After either
# path, the stale analyst command recorded in the old manifest is pruned and a
# managed file is refreshed in place, not preserved as a .bak backup.
test_project_manifest_migration() {
  local sb up clone repo1 repo2
  sb="$(mktemp -d)"; up="$sb/upstream"; clone="$sb/clone"; repo1="$sb/paper-init"; repo2="$sb/paper-update"

  # The --init path, driven from the working-tree installer.
  git init -q "$repo1"
  mkdir -p "$repo1/.claude/commands/paper"
  cat > "$repo1/AGENTS.md" <<'DOC'
<paper_context>
audience: empirical researchers
revision_stage: final polish
</paper_context>
DOC
  printf '# stale analyst command\n' > "$repo1/.claude/commands/paper/verify-numbers.md"
  printf '# pre-rename copy\n' > "$repo1/.claude/commands/paper/loop.md"
  printf 'commands/paper/verify-numbers.md\ncommands/paper/loop.md\n' \
    > "$repo1/.claude/.paper-revision-editor-manifest"

  ( cd "$repo1" && run_installer "$sb" --init )

  local ctx1="$repo1/.claude"
  assert_no_file "$ctx1/.paper-revision-editor-manifest" "project-rename: init drops the old manifest name"
  assert_file "$ctx1/$MANIFEST_REL" "project-rename: init carries the manifest to the new name"
  assert_no_file "$ctx1/commands/paper/verify-numbers.md" "project-rename: init prunes the stale analyst command"
  assert_no_file "$ctx1/commands/paper/loop.md.bak" "project-rename: init refreshes the managed file without a backup"
  assert_no_grep "$ctx1/commands/paper/loop.md" "pre-rename copy" "project-rename: init updates the managed file in place"
  assert_no_grep "$ctx1/$MANIFEST_REL" "commands/paper/verify-numbers.md" "project-rename: new manifest drops the pruned command"

  # The --update path, driven from a private clone so the developer checkout is
  # never fetched or fast-forwarded (same pattern as the downgrade scenario).
  mkdir -p "$up"
  git -C "$up" init -q
  cp "$REPO_ROOT/install.sh" "$REPO_ROOT/SKILL.md" "$REPO_ROOT/VERSION" "$up/"
  cp -R "$REPO_ROOT/.claude" "$up/.claude"
  git -C "$up" add -A
  git -C "$up" -c user.email=t@example.com -c user.name=test commit -q -m "baseline"
  git -C "$up" checkout -q -B test-project-rename
  git clone -q --branch test-project-rename "$up" "$clone" 2>/dev/null
  if [ ! -d "$clone/.git" ]; then
    no "project-rename: could not build a local clone"
    rm -rf "$sb"; return
  fi

  git init -q "$repo2"
  mkdir -p "$repo2/.claude/commands/paper"
  printf '# stale analyst command\n' > "$repo2/.claude/commands/paper/verify-numbers.md"
  printf 'commands/paper/verify-numbers.md\n' > "$repo2/.claude/.paper-revision-editor-manifest"
  : > "$repo2/.claude/.paper-revision-editor-commands-registered"

  ( cd "$repo2" && HOME="$sb" BLUE_PENCIL_HOME="$sb/.cache-clone" bash "$clone/install.sh" --update >/dev/null 2>&1 )

  local ctx2="$repo2/.claude"
  assert_no_file "$ctx2/.paper-revision-editor-manifest" "project-rename: update drops the old manifest name"
  assert_file "$ctx2/$MANIFEST_REL" "project-rename: update carries the manifest to the new name"
  assert_no_file "$ctx2/.paper-revision-editor-commands-registered" "project-rename: update drops the old marker name"
  assert_file "$ctx2/$COMMANDS_MARKER_REL" "project-rename: update carries the marker to the new name"
  assert_no_file "$ctx2/commands/paper/verify-numbers.md" "project-rename: update prunes the stale analyst command"
  assert_file "$ctx2/commands/paper/quick.md" "project-rename: update refreshes the project-local commands"

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
test_partial_agents_block
test_operational_context_only
test_shadowed_link
test_multi_block_agents
test_downgrade_marker
test_rename_migration
test_project_manifest_migration

echo
skip_note=""
[ "$skipped" -gt 0 ] && skip_note=", $skipped scenario(s) skipped"
if [ "$fail" -eq 0 ]; then
  echo "install.sh tests OK ($pass checks passed$skip_note)."
else
  echo "install.sh tests FAILED ($fail failed, $pass passed$skip_note)." >&2
  exit 1
fi
