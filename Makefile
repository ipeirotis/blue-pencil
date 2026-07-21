# Makefile for blue-pencil.
#
# install.sh is the source of truth for install / update / uninstall.
# The scripts/ helpers back the maintenance targets (lint, check-version, bump).

SHELL := /usr/bin/env bash
INSTALL := ./install.sh

.PHONY: help install update uninstall init check version lint check-version check-examples check-protected test-install bump test

help:
	@echo "blue-pencil"
	@echo
	@echo "User targets:"
	@echo "  make install        Install (symlink into ~/.agents/skills/ and ~/.claude/skills/)"
	@echo "  make update         Update the clone; both targets see the new content"
	@echo "  make uninstall      Remove both symlinks"
	@echo "  make init           Scaffold AGENTS.md in the current paper repo"
	@echo "  make check          Show install state and the tracked ref"
	@echo "  make version        Print the installed version"
	@echo
	@echo "Maintenance targets:"
	@echo "  make lint           Em-dash, frontmatter, and reference-link checks"
	@echo "  make check-version  Assert VERSION, SKILL.md, and README agree"
	@echo "  make check-examples Lock examples/ to the strict output format"
	@echo "  make check-protected Diff protected content between example input and output"
	@echo "  make test-install   Hermetic tests for install.sh (init, commands, refresh, update)"
	@echo "  make bump VERSION=x.y.z   Bump the version in all three sites"
	@echo "  make test           Run check-version, lint, check-examples, check-protected, test-install"

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

version:
	@$(INSTALL) --version

lint:
	@./scripts/lint.sh

check-version:
	@./scripts/check-version.sh

check-examples:
	@./scripts/check-examples.sh

check-protected:
	@./scripts/check-protected.sh

test-install:
	@./scripts/test-install.sh

bump:
	@if [ -z "$(VERSION)" ]; then echo "Usage: make bump VERSION=x.y.z" >&2; exit 1; fi
	@./scripts/bump-version.sh $(VERSION)

test: check-version lint check-examples check-protected test-install
	@echo "All checks passed."
