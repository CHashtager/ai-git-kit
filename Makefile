SHELL := /bin/sh

WORKTREES := worktrees
TOOLS := kmit patchlens gitlab-ai-assistant

.PHONY: help status test build

help:
	@echo "ai-git-kit umbrella commands"
	@echo ""
	@echo "  make status  Show git status for checked-out tools"
	@echo "  make test    Run tests for checked-out Go tools"
	@echo "  make build   Build checked-out Go tools"

status:
	@for tool in $(TOOLS); do \
		if [ -d "$(WORKTREES)/$$tool/.git" ]; then \
			echo "== $$tool =="; \
			git -C "$(WORKTREES)/$$tool" status --short --branch; \
		else \
			echo "== $$tool == not checked out"; \
		fi; \
	done

test:
	@for tool in kmit patchlens; do \
		if [ -f "$(WORKTREES)/$$tool/go.mod" ]; then \
			echo "== $$tool: go test ./... =="; \
			(cd "$(WORKTREES)/$$tool" && go test ./...); \
		else \
			echo "== $$tool == not checked out"; \
		fi; \
	done

build:
	@for tool in kmit patchlens; do \
		if [ -f "$(WORKTREES)/$$tool/go.mod" ]; then \
			echo "== $$tool: make build =="; \
			$(MAKE) -C "$(WORKTREES)/$$tool" build; \
		else \
			echo "== $$tool == not checked out"; \
		fi; \
	done

