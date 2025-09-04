SHELL := /bin/bash

# -------- Paths --------
CS := Combined_System
PULL := $(CS)/pull_teams.sh
SNAP := $(CS)/combined/snapshot
SRC  := $(CS)/combined/sources
DEMO := $(CS)/demo

# -------- Phony targets --------
.PHONY: help pull snapshot demo tree clean-snapshot clean-sources clean

help:
	@echo "make pull            - clone/pull team repos & refresh snapshot"
	@echo "make snapshot        - alias for pull"
	@echo "make demo            - show demo artifacts (alert/event/brief)"
	@echo "make tree            - print tree of Combined_System"
	@echo "make clean-snapshot  - remove Combined_System/combined/snapshot"
	@echo "make clean-sources   - remove Combined_System/combined/sources"
	@echo "make clean           - remove snapshot + sources"

# Pull team repos & refresh snapshot
pull snapshot:
	@if [ ! -x "$(PULL)" ]; then echo "ERROR: $(PULL) not found or not executable"; exit 1; fi
	@$(PULL)

# Simple demo helper
demo:
	@echo "== Demo artifacts =="
	@ls -1 $(DEMO)/*.md 2>/dev/null || echo "(none found)"
	@echo
	@echo "Open these in the room and read them like a playbook:"
	@echo "  - $(DEMO)/demo_alert.md"
	@echo "  - $(DEMO)/demo_event.md"
	@echo "  - $(DEMO)/demo_brief.md"

# Visualize current state
tree:
	@echo "== Combined_System layout =="
	@find $(CS) -maxdepth 3 -print | sed 's@^@  @'

# Cleanup
clean-snapshot:
	@rm -rf $(SNAP) && echo "Removed $(SNAP)"

clean-sources:
	@rm -rf $(SRC) && echo "Removed $(SRC)"

clean: clean-snapshot clean-sources

# Inject TEAM_REPOS from sample into pull_teams.sh
.PHONY: set-repos
set-repos:
	@echo "== Setting team repo URLs from Combined_System/TEAM_REPOS.sample =="
	@./Combined_System/set_team_repos.sh
	@echo
	@echo "Current TEAM_REPOS in pull_teams.sh:"
	@grep -A6 '^TEAM_REPOS=' Combined_System/pull_teams.sh || true
