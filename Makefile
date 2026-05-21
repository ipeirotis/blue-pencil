# Makefile for paper-revision-editor.
#
# Cross-tool install targets. Each target shells out to install.sh, which is
# the source of truth for path resolution and symlink logic. The Makefile
# exists so users can type the same command across tools.

SHELL := /usr/bin/env bash
INSTALL := ./install.sh

.PHONY: help check install install-all \
        install-claude install-codex install-openclaw install-cursor install-gemini install-copilot \
        uninstall uninstall-all \
        uninstall-claude uninstall-codex uninstall-openclaw uninstall-cursor uninstall-gemini uninstall-copilot

help:
	@echo "paper-revision-editor: cross-tool install targets"
	@echo
	@echo "Install:"
	@echo "  make check            Detect which agents are installed on this machine"
	@echo "  make install-all      Install for every detected agent (default)"
	@echo "  make install-claude   Symlink into ~/.claude/skills/paper-revision-editor"
	@echo "  make install-codex    Symlink into ~/.codex/skills/paper-revision-editor"
	@echo "  make install-openclaw Symlink into ~/.openclaw/skills/paper-revision-editor"
	@echo "  make install-cursor   Symlink into \$$PWD/.cursor/skills/paper-revision-editor"
	@echo "  make install-gemini   Symlink into ~/.gemini/skills/paper-revision-editor"
	@echo "  make install-copilot  Symlink into ~/.config/github-copilot/skills/paper-revision-editor"
	@echo
	@echo "Uninstall: every install-X has a matching uninstall-X."
	@echo
	@echo "Set FORCE=1 to install even when a tool is not detected."
	@echo "Set FORCE_COPY=1 to copy files instead of symlinking."

check:
	@$(INSTALL) --check

install: install-all
install-all:
	@$(INSTALL)

install-claude:
	@$(INSTALL) claude

install-codex:
	@$(INSTALL) codex

install-openclaw:
	@$(INSTALL) openclaw

install-cursor:
	@$(INSTALL) cursor

install-gemini:
	@$(INSTALL) gemini

install-copilot:
	@$(INSTALL) copilot

uninstall: uninstall-all
uninstall-all:
	@$(INSTALL) --uninstall

uninstall-claude:
	@$(INSTALL) --uninstall claude

uninstall-codex:
	@$(INSTALL) --uninstall codex

uninstall-openclaw:
	@$(INSTALL) --uninstall openclaw

uninstall-cursor:
	@$(INSTALL) --uninstall cursor

uninstall-gemini:
	@$(INSTALL) --uninstall gemini

uninstall-copilot:
	@$(INSTALL) --uninstall copilot
