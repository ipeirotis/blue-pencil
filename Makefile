# Makefile for paper-revision-editor.
#
# Cross-tool install targets. Each target shells out to install.sh, which is
# the source of truth for path resolution, detection, and symlink logic.

SHELL := /usr/bin/env bash
INSTALL := ./install.sh

TOOLS := agents claude codex openclaw cursor gemini copilot opencode goose zed junie cline roo
INSTALL_TARGETS := $(addprefix install-,$(TOOLS))
UNINSTALL_TARGETS := $(addprefix uninstall-,$(TOOLS))

.PHONY: help check init install install-all uninstall uninstall-all \
        $(INSTALL_TARGETS) $(UNINSTALL_TARGETS)

help:
	@echo "paper-revision-editor: cross-tool install targets"
	@echo
	@echo "Primary:"
	@echo "  make install-all      Install for ~/.agents/skills/ plus every detected agent"
	@echo "  make install-agents   Install only to ~/.agents/skills/ (cross-tool standard)"
	@echo "  make check            Detect which agents are installed on this machine"
	@echo "  make init             Scaffold AGENTS.md in the current repo (interactive)"
	@echo
	@echo "Per tool (each has a matching uninstall-X):"
	@echo "  make install-claude   ~/.claude/skills/paper-revision-editor"
	@echo "  make install-codex    ~/.codex/skills/paper-revision-editor"
	@echo "  make install-gemini   ~/.gemini/skills/paper-revision-editor"
	@echo "  make install-openclaw ~/.openclaw/skills/paper-revision-editor"
	@echo "  make install-cursor   \$$PWD/.cursor/skills/paper-revision-editor (run inside paper repo)"
	@echo "  make install-copilot  ~/.config/github-copilot/skills/paper-revision-editor"
	@echo "  make install-opencode ~/.config/opencode/skills/paper-revision-editor"
	@echo "  make install-goose    ~/.config/goose/skills/paper-revision-editor"
	@echo "  make install-zed      alias for install-agents (Zed reads ~/.agents/skills/ only)"
	@echo "  make install-junie    ~/.junie/skills/paper-revision-editor"
	@echo "  make install-cline    ~/.cline/skills/paper-revision-editor"
	@echo "  make install-roo      ~/.roo/skills/paper-revision-editor"
	@echo
	@echo "Set FORCE=1 to install for a tool that was not detected."
	@echo "Set FORCE_COPY=1 to copy files instead of symlinking (useful on Windows)."

check:
	@$(INSTALL) --check

init:
	@$(INSTALL) --init

install: install-all
install-all:
	@$(INSTALL)

uninstall: uninstall-all
uninstall-all:
	@$(INSTALL) --uninstall

# Generate per-tool targets in one rule each.
$(INSTALL_TARGETS):
	@$(INSTALL) $(@:install-%=%)

$(UNINSTALL_TARGETS):
	@$(INSTALL) --uninstall $(@:uninstall-%=%)
