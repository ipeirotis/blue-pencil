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
#   ./install.sh --init       # scaffold AGENTS.md and register paper: commands in the current paper repo
#   ./install.sh --commands   # register paper: commands and the paper subagents for all projects (~/.claude)
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
# Hidden manifest, written under a `.claude/` tree, recording exactly which command
# and agent files this installer placed there (paths relative to that `.claude/`).
# Refresh and uninstall act only on listed files, so a user's own files in the
# paper: namespace, or an older manual copy we never recorded, are never touched.
# Not a *.md file, so Claude Code's command scan ignores it.
MANIFEST_REL=".paper-revision-editor-manifest"
# A small marker recording that the global command set is *registered* for this
# HOME, kept separate from the manifest so a temporary downgrade (a --ref that
# ships no command files) can remove the incompatible commands while remembering
# that the user opted in. A later --update back to a ref that ships commands then
# restores them, instead of leaving /paper:* absent as if --uninstall had run.
# Cleared only by --uninstall. Not a *.md file, so Claude Code's scan ignores it.
COMMANDS_MARKER_REL=".paper-revision-editor-commands-registered"
# Git ref (tag, branch, or commit) to install or update to. An explicit value
# (here or via --ref) is "sticky": it is honored on install and reinstall and
# is preserved across a plain --update. Without one, the clone stays on
# whatever it already tracks, defaulting to main only when there is no signal.
REF="${PAPER_REVISION_EDITOR_REF:-main}"
if [ -n "${PAPER_REVISION_EDITOR_REF:-}" ]; then
  REF_EXPLICIT=1
else
  REF_EXPLICIT=0
fi

# Where to read templates and where the symlinks should point. If install.sh
# is running from inside a real clone, prefer that. Otherwise use CACHE_DIR
# (the curl|bash path), cloning if needed.
# `pwd -P` resolves symlinks to the physical clone. This matters when the script
# is launched through an install symlink (e.g. ~/.claude/skills/<name>/install.sh):
# without it, src would be the symlink path, which is also a relink target, so
# ensure_skill_linked would remove that target and recreate it pointing at
# itself, breaking the skill link and hiding the bundled command files.
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
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
  install.sh --init       Scaffold AGENTS.md and register paper: commands in the current paper repo
  install.sh --commands   Register paper: commands and the paper subagents for all projects (~/.claude)
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
    # A non-empty, non-git directory here is anomalous: the normal flow only ever
    # puts a git clone at $CACHE_DIR. Since the path is a documented override
    # (PAPER_REVISION_EDITOR_HOME), a typo or a reused directory could point it at
    # unrelated files, so refuse rather than delete it.
    echo "ERROR: $CACHE_DIR exists but is not a git clone of $SKILL_NAME." >&2
    echo "       Refusing to remove it, as it may contain unrelated files." >&2
    echo "       Delete it yourself, or set PAPER_REVISION_EDITOR_HOME to an empty or new path, then re-run." >&2
    exit 1
  else
    echo "Cloning $REPO_URL into $CACHE_DIR" >&2
    mkdir -p "$(dirname "$CACHE_DIR")"
    git clone --quiet "$REPO_URL" "$CACHE_DIR" >&2
  fi
}

# Fetch and move <repo> onto <ref>: fast-forward for a branch, or a detached
# checkout for a tag or commit. Used by install (explicit --ref) and update.
sync_to_ref() {
  local repo="$1" ref="$2"
  git -C "$repo" fetch --quiet --tags origin
  if git -C "$repo" show-ref --verify --quiet "refs/remotes/origin/$ref"; then
    git -C "$repo" checkout --quiet "$ref"
    git -C "$repo" merge --ff-only --quiet "origin/$ref" \
      || { echo "ERROR: cannot fast-forward $ref; the clone has local changes." >&2; exit 1; }
  else
    git -C "$repo" checkout --quiet "$ref" \
      || { echo "ERROR: ref '$ref' not found." >&2; exit 1; }
  fi
}

# The ref to act on. An explicit --ref (or env) wins. Otherwise stay on
# whatever <repo> already tracks, so a pinned tag or commit survives a plain
# update; fall back to main when there is no clone or no better signal.
resolve_ref() {
  local repo="$1"
  if [ "$REF_EXPLICIT" -eq 1 ]; then
    echo "$REF"
    return
  fi
  if [ -d "$repo/.git" ]; then
    local branch tag sha
    # Prefer the tracked branch. A clone on a branch wants that branch's latest,
    # even when its current tip happens to sit on a tagged release commit (a fresh
    # default install made right after a release). Only fall back to an exact tag
    # when HEAD is detached, which is how an explicit --ref pin to a tag or commit
    # is checked out, so such pins still survive a plain update. (Checking the tag
    # first would freeze an on-branch clone at a coincidental release tag and copy
    # a stale command set, or never update.)
    branch="$(git -C "$repo" symbolic-ref --short -q HEAD 2>/dev/null || true)"
    if [ -n "$branch" ]; then echo "$branch"; return; fi
    tag="$(git -C "$repo" describe --tags --exact-match 2>/dev/null || true)"
    if [ -n "$tag" ]; then echo "$tag"; return; fi
    sha="$(git -C "$repo" rev-parse --verify -q HEAD 2>/dev/null || true)"
    if [ -n "$sha" ]; then echo "$sha"; return; fi
  fi
  echo "main"
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
  # If the destination already IS the source, there is nothing to do. This guards
  # the case where the installer runs from a copy-mode install at the target path
  # itself (e.g. ~/.claude/skills/<name>/install.sh, the ln -s fallback): without
  # it, the prior-copy-install branch below would delete the source and recreate a
  # self-referential link, corrupting the install. -ef also covers a symlink that
  # already points at src.
  if [ -e "$dest" ] && [ "$src" -ef "$dest" ]; then
    echo "  already in place: $dest"
    return 0
  fi
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

# Link the skill into the standard targets. The copied commands and agent load
# the skill from ~/.claude/skills (or ~/.agents/skills), so any path that
# registers commands must make sure the skill itself is present first, or
# /paper:* names would resolve to nothing. Idempotent (link_one is a no-op when
# the link already exists).
# Targets that the most recent ensure_skill_linked run actually linked or copied
# to the source (link_one returned success). any_skill_link_usable reads this so
# it counts only targets this run established, never a pre-existing conflicting
# path we refused to touch. Declared here so `set -u` never sees it unset.
LINKED_TARGETS=()

ensure_skill_linked() {
  local src="$1" dest failures=0
  LINKED_TARGETS=()
  for dest in "${TARGETS[@]}"; do
    # Attempt every target without aborting mid-loop, so a conflict on one (e.g.
    # an unmanaged ~/.agents dir from another tool) does not prevent linking the
    # other, the one Claude Code needs. link_one prints an explanatory error for a
    # conflicting target. Return non-zero if any target failed, so callers that
    # require a full link (install/update) report it instead of claiming success,
    # while command-registration callers can tolerate a partial link.
    if link_one "$src" "$dest"; then
      LINKED_TARGETS+=("$dest")
    else
      failures=$((failures + 1))
    fi
  done
  [ "$failures" -eq 0 ]
}

# True when at least one target this run linked/copied has a reachable SKILL.md.
# ensure_skill_linked tolerates a partial link, but a command registration that
# leaves *no* usable link would resolve /paper:* to a skill that is not there,
# dead-ending every invocation. Callers that must guarantee the skill loads check
# this before reporting success. It considers only LINKED_TARGETS, so a target
# that link_one *refused* (an unmanaged dir that merely happens to contain a
# SKILL.md we never linked to our source) is not mistaken for a working install.
any_skill_link_usable() {
  local dest
  [ "${#LINKED_TARGETS[@]}" -gt 0 ] || return 1
  for dest in "${LINKED_TARGETS[@]}"; do
    [ -e "$dest/SKILL.md" ] && return 0
  done
  return 1
}

# True when <file> holds a *complete* <paper_context> block: opening and closing
# tags with at least one key: value field between them. A bare mention (a TODO
# naming the tag) or an unterminated opening tag is not complete, so callers fall
# through to scaffolding rather than trusting (or copying to EOF from) an
# unusable block. Used both to decide whether an AGENTS.md already has context
# and whether a CLAUDE.md/paper-meta.md block is migratable.
file_has_complete_context() {
  local block
  block="$(sed -n '/<paper_context>/,/<\/paper_context>/p' "$1")"
  # sed only emits output once the opening tag matches; without a closing tag the
  # block runs to EOF and carries no </paper_context>, so this rejects it.
  printf '%s\n' "$block" | grep -q '</paper_context>' || return 1
  # Reject a well-formed but empty block (tags with no key: value fields).
  printf '%s\n' "$block" | grep -Eq '^[[:space:]]*[A-Za-z_]+:'
}

# True when <file> holds a closed <paper_context> block carrying *all four*
# required fields (target_venue, audience, core_thesis, revision_stage). Stricter
# than file_has_complete_context, which accepts a single key: this gate decides
# whether a CLAUDE.md/paper-meta.md is worth migrating into AGENTS.md. Migrating a
# partial source (e.g. a hand-written paper-meta.md with only target_venue) would
# make --init report success while the skill immediately stops for the missing
# fields, so a partial source falls through to the interactive scaffold instead.
file_has_all_context_fields() {
  local block key
  block="$(sed -n '/<paper_context>/,/<\/paper_context>/p' "$1")"
  printf '%s\n' "$block" | grep -q '</paper_context>' || return 1
  for key in target_venue audience core_thesis revision_stage; do
    printf '%s\n' "$block" | grep -Eq "^[[:space:]]*${key}:[[:space:]]*[^[:space:]]" || return 1
  done
}

# Remove a closed <paper_context> block from <file> in place. Used before
# scaffolding or migrating into an AGENTS.md that already holds an incomplete
# block: the skill reads the *first* <paper_context> it finds, so appending a
# second one would leave invocations stopping on the broken first block. Only
# excises a properly closed block; an unterminated opening tag is left untouched
# (its extent is ambiguous), and callers handle that case separately.
strip_context_block() {
  local file="$1"
  grep -q '</paper_context>' "$file" || return 0
  awk '
    /<paper_context>/            { skip = 1 }
    skip && /<\/paper_context>/  { skip = 0; next }
    skip                         { next }
    { print }
  ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
}

# Locate a repo file that already carries a complete <paper_context> block
# (CLAUDE.md, then paper-meta.md), for migration during --init. Echoes the path;
# empty when none exists. Requires all four fields, so a partial block is not
# migrated over the interactive scaffold.
existing_context_file() {
  local root="$1" f
  for f in "$root/CLAUDE.md" "$root/paper-meta.md"; do
    [ -f "$f" ] && file_has_all_context_fields "$f" && { printf '%s' "$f"; return 0; }
  done
  return 1
}

# An installer path that resolves from any directory. $0 is unreliable: under
# `curl ... | bash` it is "bash", and a relative "./install.sh" stops resolving
# once the user changes into their paper repo. The copy in $src (the managed
# clone or the local checkout) is always reachable by absolute path.
installer_path() {
  echo "$1/install.sh"
}

run_install() {
  local src
  src="$(resolve_source)"
  # An explicit --ref moves the managed clone onto that ref, on first install
  # or reinstall. A local developer clone is linked as-is; we never move
  # someone's own working tree out from under them.
  if [ "$REF_EXPLICIT" -eq 1 ]; then
    if [ "$src" = "$CACHE_DIR" ]; then
      echo "Pinning $src to $REF"
      sync_to_ref "$src" "$REF"
    else
      echo "Note: --ref is ignored when installing from a local clone ($src)." >&2
      echo "      It applies to the managed clone at $CACHE_DIR." >&2
    fi
  else
    # Refresh a pre-existing managed cache so the linked skill, and the install.sh
    # the hint below points at, are current (an old cache may predate --commands).
    ensure_source_current "$src"
  fi
  echo "Installing $SKILL_NAME from $src"
  ensure_skill_linked "$src" \
    || { echo "ERROR: could not link $SKILL_NAME into all targets (see above)." >&2; exit 1; }
  echo
  local installer
  installer="$(installer_path "$src")"
  echo "Done. Run '$installer --check' to verify."
  echo "For Claude Code /paper: slash commands, run '$installer --init' in your paper repo"
  echo "(or '$installer --commands' to enable them in every project)."
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

  local before before_sha ref
  before="$(cat "$src/VERSION" 2>/dev/null || echo unknown)"
  before_sha="$(git -C "$src" rev-parse --short HEAD 2>/dev/null || echo unknown)"
  ref="$(resolve_ref "$src")"

  echo "Updating $src to $ref"
  sync_to_ref "$src" "$ref"

  local after after_sha
  after="$(cat "$src/VERSION" 2>/dev/null || echo unknown)"
  after_sha="$(git -C "$src" rev-parse --short HEAD 2>/dev/null || echo unknown)"

  # Re-link in case symlinks were missing or pointed elsewhere.
  ensure_skill_linked "$src" \
    || { echo "ERROR: could not link $SKILL_NAME into all targets (see above)." >&2; exit 1; }

  # If the global paper: commands were enabled with --commands, refresh them too.
  # The skill symlink alone does not carry command changes, since Claude Code does
  # not read commands from inside the skill; without this, a new or changed command
  # would be missing even though --update reports the skill is current. Skip when
  # the target ref does not ship command files (e.g. pinning an older release),
  # so the documented ref change does not abort half-applied. Gate on the install
  # manifest, not just the directory's existence: a user's own ~/.claude/commands/paper
  # that this installer never registered has no manifest, and a plain skill update
  # must not back up and overwrite their custom paper: commands.
  if [ -f "$HOME/.claude/$MANIFEST_REL" ] || [ -f "$HOME/.claude/$COMMANDS_MARKER_REL" ]; then
    if [ -d "$src/.claude/commands/paper" ]; then
      install_commands "$HOME" "$src"
      # Record the opt-in so a later downgrade-then-upgrade round trip restores
      # the commands even though the intervening downgrade drops the manifest.
      mark_commands_registered "$HOME"
    else
      # The target ref predates the bundled paper: commands (a downgrade or a
      # pin to an older release). Leaving the previously registered global set
      # in place would keep stale /paper:* commands resolving against a skill
      # version that no longer ships their lanes and reference files, so remove
      # the manifested set instead of silently leaving an incompatible one. Keep
      # the registration marker, though: the user never ran --uninstall, so a
      # future --update onto a ref that ships commands must restore them rather
      # than treat this temporary downgrade as an opt-out.
      echo "Target ref ships no paper: commands; removing the previously registered global set (a later update restores it)."
      remove_commands "$HOME"
      mark_commands_registered "$HOME"
    fi
  elif [ -d "$HOME/.claude/commands/paper" ]; then
    # A pre-manifest install: an older installer copied paper: commands here
    # without recording a manifest, so we cannot tell our files from the user's
    # own and must not back up and overwrite them on a plain update. Rather than
    # let those commands drift stale and silent, point the user at the one safe,
    # explicit action that adopts them for automatic refresh going forward.
    echo "Note: found paper: commands in $HOME/.claude/commands/paper with no install manifest."
    echo "      A plain --update leaves them as-is. Run '$(installer_path "$src") --commands'"
    echo "      once to register them for automatic updates (your own paper: files are backed up, not lost)."
  fi

  echo
  if [ "$before_sha" = "$after_sha" ]; then
    echo "Already up to date ($after, ref $ref)."
  else
    echo "Updated $before -> $after (ref $ref)."
  fi
}

# Record that the global command set is registered for this base's .claude tree.
# Written whenever --commands or an --update refresh installs (or intentionally
# holds the opt-in across) the global set, so a downgrade that drops the manifest
# does not read as an uninstall. Idempotent.
mark_commands_registered() {
  local claude_dir="$1/.claude"
  mkdir -p "$claude_dir"
  : > "$claude_dir/$COMMANDS_MARKER_REL"
}

# Remove the global paper: commands and the paper subagents that --commands
# installs under ~/.claude, using the manifest written at install time. Only the
# files we recorded are removed, so a user's own files in the paper/ namespace and
# an older manual copy we never recorded are preserved. The manifest is local, so
# this works even when the clone is gone (e.g. a copy-mode install whose skill dir
# was just unlinked). Project-level copies made by --init live in individual repos
# and are left to the user: uninstall takes no repo argument.
remove_commands() {
  local base="$1"
  local claude_dir="$base/.claude"
  local manifest="$claude_dir/$MANIFEST_REL"
  if [ ! -f "$manifest" ]; then
    if [ -d "$claude_dir/commands/paper" ] || [ -f "$claude_dir/agents/paper-reviser.md" ] || [ -f "$claude_dir/agents/paper-analyst.md" ]; then
      echo "  note: no install manifest at $manifest; leaving global paper: files in place (remove by hand if you copied them yourself)."
    fi
    return 0
  fi
  local p
  while IFS= read -r p; do
    [ -n "$p" ] || continue
    if [ -e "$claude_dir/$p" ]; then
      rm -f "$claude_dir/$p"
      echo "  removed: $claude_dir/$p"
    fi
  done < "$manifest"
  rm -f "$manifest"
  # Drop the paper/ command dir only if nothing unmanaged is left in it.
  rmdir "$claude_dir/commands/paper" 2>/dev/null || true
}

run_uninstall() {
  for dest in "${TARGETS[@]}"; do
    unlink_one "$dest"
  done
  remove_commands "$HOME"
  # An explicit uninstall is a real opt-out, so drop the registration marker too;
  # a later --update must not resurrect the global commands.
  rm -f "$HOME/.claude/$COMMANDS_MARKER_REL"
  echo "Note: paper: commands copied into a repo by --init stay in that repo; remove them there if you want them gone."
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

# Back up a pre-existing file before we overwrite it, but only when it differs
# from what we install and this installer did not record it as managed. A
# hand-written same-named command, or a customized agent, is preserved as .bak on
# first overwrite; our own managed files (listed in the prior manifest) are
# refreshed silently. $3 is the path relative to .claude/; $4 is the prior
# manifest content.
backup_if_unmanaged() {
  local dest="$1" src_file="$2" rel="$3" old_manifest="$4"
  [ -f "$dest" ] || return 0
  cmp -s "$src_file" "$dest" && return 0
  printf '%s\n' "$old_manifest" | grep -qxF -- "$rel" && return 0
  cp "$dest" "$dest.bak"
  echo "  backed up existing $dest -> $dest.bak"
}

# Copy the paper: slash commands and the paper subagents (paper-reviser,
# paper-analyst) out of the skill and into a .claude/ tree. Claude Code
# registers commands from <project>/.claude/commands/ or ~/.claude/commands/
# and subagents from the matching agents/ dirs; it never registers either from
# inside an installed skill directory. So even though the skill ships these
# files, they take effect only once copied here. Idempotent: it refreshes the
# paper/ command set and the agents in place. $1 is the .claude parent (a repo
# root or $HOME); $2 is the skill source dir.
install_commands() {
  local base="$1" src="$2"
  local cmd_src="$src/.claude/commands/paper"
  local agent_src="$src/.claude/agents"
  if [ ! -d "$cmd_src" ]; then
    echo "ERROR: cannot find $cmd_src" >&2
    return 1
  fi
  # If the target tree IS the source (a developer running --init from the skill
  # checkout itself, e.g. `make init` at the repo root), the commands are already
  # in place. Bail out before touching anything, which would otherwise delete the
  # source command files.
  if [ "$base" -ef "$src" ]; then
    echo "  paper: commands already present in $base/.claude (this is the source checkout)"
    return 0
  fi

  local claude_dir="$base/.claude"
  local manifest="$claude_dir/$MANIFEST_REL"

  # Build the list of files this run installs, as paths relative to .claude/.
  local new_list=() f
  for f in "$cmd_src"/*.md; do
    [ -e "$f" ] || continue
    new_list+=("commands/paper/$(basename "$f")")
  done
  for f in "$agent_src"/*.md; do
    [ -e "$f" ] || continue
    new_list+=("agents/$(basename "$f")")
  done

  # Prior manifest content, used both to drop stale managed files and to decide
  # which pre-existing files are ours to overwrite silently.
  local old_manifest=""
  [ -f "$manifest" ] && old_manifest="$(cat "$manifest")"

  # Remove files a previous run installed that are no longer shipped (a command
  # renamed or dropped in a later release). Files not in the manifest (a user's
  # own command, or a manual copy we never recorded) are left untouched, so a
  # refresh never deletes anything this installer did not place.
  if [ -n "$old_manifest" ]; then
    local old
    while IFS= read -r old; do
      [ -n "$old" ] || continue
      printf '%s\n' "${new_list[@]}" | grep -qxF -- "$old" || rm -f "$claude_dir/$old"
    done <<< "$old_manifest"
  fi

  mkdir -p "$claude_dir/commands/paper" "$claude_dir/agents"
  local bn dest
  for f in "$cmd_src"/*.md; do
    [ -e "$f" ] || continue
    bn="$(basename "$f")"
    dest="$claude_dir/commands/paper/$bn"
    backup_if_unmanaged "$dest" "$f" "commands/paper/$bn" "$old_manifest"
    # rm first so a symlinked dest (e.g. a dotfile-managed command linked into
    # .claude) is replaced, not followed and its target overwritten.
    rm -f "$dest"
    cp "$f" "$dest"
  done
  echo "  registered paper: commands -> $claude_dir/commands/paper/"
  local agents_registered=0
  for f in "$agent_src"/*.md; do
    [ -e "$f" ] || continue
    bn="$(basename "$f")"
    dest="$claude_dir/agents/$bn"
    backup_if_unmanaged "$dest" "$f" "agents/$bn" "$old_manifest"
    # rm first so a symlinked dest is replaced, not followed (see commands loop).
    rm -f "$dest"
    cp "$f" "$dest"
    agents_registered=1
  done
  if [ "$agents_registered" -eq 1 ]; then
    echo "  registered paper subagents -> $claude_dir/agents/"
  fi

  # Record exactly what we installed, so refresh and uninstall touch only these.
  printf '%s\n' "${new_list[@]}" > "$manifest"
}

# Best-effort sync of the managed clone to its tracked ref before we copy files
# out of it or point the user at its install.sh. A piped `curl ... | bash` on a
# machine that already has an older cached clone would otherwise leave the cache
# (and its bundled install.sh) stale: command copies would promise /paper:loop
# while loop.md is missing, and the post-install hint would point at a cached
# installer that predates --commands. A local developer checkout (src != CACHE_DIR)
# is never touched, so a developer registers their working-tree commands with no
# network round-trip. The resolved ref is sticky, so a pinned --ref stays pinned.
# Unlike sync_to_ref (used by --update, where a failure is fatal), this never
# aborts the run: an offline machine falls back to whatever is already cached.
ensure_source_current() {
  local src="$1"
  [ "$src" = "$CACHE_DIR" ] || return 0
  [ -d "$src/.git" ] || return 0
  local ref
  ref="$(resolve_ref "$src")"
  echo "Updating managed clone ($src) to $ref"
  if [ "$REF_EXPLICIT" -eq 1 ]; then
    # An explicit --ref must be honored exactly. Failing to reach it is fatal, so
    # we never register a command set from a different (cached) ref than requested.
    sync_to_ref "$src" "$ref"
    return
  fi
  # No explicit pin: best-effort, so an offline machine falls back to the cached
  # clone rather than aborting the run.
  if ! git -C "$src" fetch --quiet --tags origin 2>/dev/null; then
    echo "  warning: could not reach origin (offline?); using the cached clone as-is." >&2
    return 0
  fi
  if git -C "$src" show-ref --verify --quiet "refs/remotes/origin/$ref"; then
    git -C "$src" checkout --quiet "$ref" 2>/dev/null || true
    git -C "$src" merge --ff-only --quiet "origin/$ref" 2>/dev/null \
      || echo "  warning: could not fast-forward $ref; using the cached clone as-is." >&2
  else
    git -C "$src" checkout --quiet "$ref" 2>/dev/null \
      || echo "  warning: ref '$ref' not found on origin; using the cached clone as-is." >&2
  fi
}

run_commands() {
  local src
  src="$(resolve_source)"
  ensure_source_current "$src"
  echo "Registering paper: commands and the paper subagents for all projects (~/.claude)"
  # The agent loads the skill from ~/.claude/skills, so install the skill too;
  # otherwise the commands would resolve but every invocation would dead-end on
  # a missing skill. Idempotent, so running --commands after a normal install is
  # harmless. Tolerate a partial link (e.g. an unmanaged ~/.agents dir): the
  # ~/.claude link is what these commands need, and the commands still get copied.
  ensure_skill_linked "$src" || true
  # But if *no* target got a usable skill link, registering the commands would
  # promise /paper:* while every invocation dead-ends on a missing SKILL.md.
  # Fail loudly instead of reporting a success that does not work.
  if ! any_skill_link_usable; then
    echo "ERROR: no usable $SKILL_NAME skill link in any target (see above); /paper:* would not resolve." >&2
    echo "       Resolve the conflicting path in ~/.claude/skills or ~/.agents/skills and re-run." >&2
    exit 1
  fi
  install_commands "$HOME" "$src"
  mark_commands_registered "$HOME"
  echo
  echo "Done. /paper:loop and the other paper: commands now resolve in every project."
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
  ensure_source_current "$src"

  # The copied agent loads the skill from ~/.claude/skills, so ensure the skill
  # is linked even when --init is run as a standalone mode (curl ... | bash -s --
  # --init, or a clone's install.sh --init) before a normal install. Idempotent,
  # so the common install-then-init flow re-links a no-op. Tolerate a partial link
  # (e.g. an unmanaged ~/.agents dir); the commands still get registered.
  ensure_skill_linked "$src" || true
  # As in run_commands, a total link failure must not scaffold a setup that then
  # dead-ends. --init additionally accepts a skill vendored inside the target
  # repo, since the copied subagents search <repo>/.claude/skills before the two
  # home locations; only fail when neither a home link nor a repo-local skill
  # exists.
  if ! any_skill_link_usable && [ ! -f "$repo_root/.claude/skills/$SKILL_NAME/SKILL.md" ]; then
    echo "ERROR: no usable $SKILL_NAME skill: no link in ~/.claude/skills or ~/.agents/skills, and none vendored at $repo_root/.claude/skills; /paper:* would not resolve." >&2
    echo "       Resolve the conflicting path and re-run." >&2
    exit 1
  fi
  echo "Registering paper: commands in $repo_root/.claude"
  install_commands "$repo_root" "$src"
  echo

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
  if [ -f "$target" ] && file_has_complete_context "$target"; then
    echo "AGENTS.md already contains a <paper_context> block. Skipping scaffolding."
    return 0
  fi

  # AGENTS.md exists but carries no usable context. If it holds an *incomplete*
  # <paper_context> block (e.g. empty tags), we must not leave it and append a
  # second block below: the skill reads the first <paper_context> it finds and
  # would stop on the broken one. Excise a closed-but-incomplete block so the
  # scaffold or migration becomes the only block. An unterminated block (opening
  # tag with no close) cannot be excised safely, so stop and ask for a hand fix
  # rather than emit a file the skill still cannot load.
  if [ -f "$target" ] && grep -q '<paper_context>' "$target"; then
    if grep -q '</paper_context>' "$target"; then
      echo "Replacing an incomplete <paper_context> block already in AGENTS.md."
      strip_context_block "$target"
    else
      echo "ERROR: $target has an unterminated <paper_context> block (opening tag, no </paper_context>)." >&2
      echo "       Fix or remove it by hand, then re-run --init." >&2
      exit 1
    fi
  fi

  # If AGENTS.md carries no context yet but the repo was already configured with
  # a <paper_context> block in CLAUDE.md or paper-meta.md (e.g. by the older
  # installer), migrate that block into AGENTS.md rather than scaffolding a
  # placeholder. The skill reads AGENTS.md before CLAUDE.md, so a placeholder
  # here would shadow the user's real venue, audience, thesis, and stage.
  local ctx_src
  if ctx_src="$(existing_context_file "$repo_root")"; then
    local rel_ctx="${ctx_src#"$repo_root"/}"
    local block
    block="$(sed -n '/<paper_context>/,/<\/paper_context>/p' "$ctx_src")"
    echo "Found an existing <paper_context> block in $rel_ctx; migrating it into AGENTS.md instead of scaffolding placeholders."
    if [ -f "$target" ]; then
      printf '\n%s\n' "$block" >> "$target"
    else
      # template up to (not including) its own <paper_context> line, then the
      # migrated block, then the template after </paper_context>. Avoids awk -v
      # so a block with backslashes or newlines survives verbatim.
      awk '/<paper_context>/{exit} {print}' "$template" > "$target"
      printf '%s\n' "$block" >> "$target"
      awk 'p{print} /<\/paper_context>/{p=1}' "$template" >> "$target"
    fi
    echo "Wrote $target from the existing context in $rel_ctx. Review and edit as needed."
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

  case "$stage" in
    ""|"first draft"|"response to reviewers"|"final polish") : ;;
    *)
      echo "  '$stage' is not a recognized stage; writing it anyway." >&2
      echo "  The skill will ask you to fix it before editing. Valid values:" >&2
      echo "  first draft | response to reviewers | final polish" >&2
      ;;
  esac

  if [ -f "$target" ]; then
    echo "" >> "$target"
    sed -n '/<paper_context>/,/<\/paper_context>/p' "$template" >> "$target"
  else
    cp "$template" "$target"
  fi

  local v_venue="${venue:-[fill in]}"
  local v_audience="${audience:-[fill in]}"
  local v_thesis="${thesis:-[fill in]}"
  local v_stage="${stage:-[fill in]}"

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
    --commands|commands)        MODE="commands" ;;
    --check|-c|check)           MODE="check" ;;
    --version|version)          MODE="version" ;;
    --ref)
      shift
      [ $# -gt 0 ] || { echo "ERROR: --ref requires a value." >&2; exit 1; }
      REF="$1"; REF_EXPLICIT=1
      ;;
    --ref=*)                    REF="${1#--ref=}"; REF_EXPLICIT=1 ;;
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
  commands)  run_commands ;;
  check)     run_check ;;
  version)   run_version ;;
esac
