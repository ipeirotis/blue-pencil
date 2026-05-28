# Makefile for paper-revision-editor.
#
# Thin wrapper over install.sh. install.sh is the source of truth.

SHELL := /usr/bin/env bash
INSTALL := ./install.sh

.PHONY: help install update uninstall init check

help:
	@echo "paper-revision-editor"
	@echo
	@echo "  make install     Install (symlink into ~/.agents/skills/ and ~/.claude/skills/)"
	@echo "  make update      git pull the clone; both targets see the new content"
	@echo "  make uninstall   Remove both symlinks"
	@echo "  make init        Scaffold AGENTS.md in the current paper repo"
	@echo "  make check       Show install state"

install:
	@$(INSTALL)

update:
	@$(INSTALL) --update

uninstall:
	@$(INSTALL) --uninstall

init:
	@$(INSTALL) --init

check:
	@$(INSTALL) --check
