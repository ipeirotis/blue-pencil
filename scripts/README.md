# scripts/

Helper scripts for the `paper-revision-editor` skill. None of these are required for the skill to function: the skill is the SKILL.md file plus the `references/` directory, and any Agent-Skills-compatible tool will pick them up once installed.

## Files

### `update.sh`

Legacy updater for users who installed by copying files into `.claude/skills/paper-revision-editor/` (the pre-v1.7 install pattern). Fetches new file contents over HTTPS, compares versions, and commits the update.

If you installed via the v1.7+ symlink path (`./install.sh` at the repo root), do not use this script. Update by running `git pull` inside the repository clone; every linked tool sees the new content immediately.

Usage:

```bash
curl -sSL https://raw.githubusercontent.com/ipeirotis/paper-revision-editor/main/scripts/update.sh | bash
```

## Why no install script here

The cross-tool installer lives at the repo root as `install.sh`, not under `scripts/`. Keeping it at the root preserves the `curl | bash` convention people expect from the README, and it serves as the entrypoint the `Makefile` shells into. See the root `install.sh` and `Makefile` for the install logic.
