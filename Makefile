# ============================================================
# Playwright Test Runner — Local GitHub Actions via act
# ============================================================
# Requirements:
#   - Docker running
#   - act installed (brew install act / choco install act-cli)
#   - .secrets.dev / .secrets.staging / .secrets.prod files present
#
# Usage:
#   make dev         → run tests simulating a feature branch PR
#   make staging     → run tests simulating a push to main
#   make prod        → run tests simulating a tag/release
#   make install     → install act + check dependencies
#   make help        → show this help message
# ============================================================

.PHONY: dev staging prod install help

# Default target
.DEFAULT_GOAL := help

# ── Environment secret files ─────────────────────────────────
SECRETS_DEV      := .secrets.dev
SECRETS_STAGING  := .secrets.staging
SECRETS_PROD     := .secrets.prod

# ── Cache directories ─────────────────────────────────────────
NODE_MODULES_CACHE := $(HOME)/.cache/act-node-modules
PLAYWRIGHT_CACHE   := $(HOME)/.cache/ms-playwright

# ── Dev: simulates a PR on a feature branch ──────────────────
dev:
	@echo "▶ Running Playwright tests [dev environment]..."
	@test -f $(SECRETS_DEV) || (echo "✗ Missing $(SECRETS_DEV) — copy .secrets.example and fill in your dev values"; exit 1)
	@mkdir -p $(NODE_MODULES_CACHE) $(PLAYWRIGHT_CACHE)
	act pull_request \
		--secret-file $(SECRETS_DEV) \
		--cache-server-path $(NODE_MODULES_CACHE)

# ── Staging: simulates a push to main/master ─────────────────
staging:
	@echo "▶ Running Playwright tests [staging environment]..."
	@test -f $(SECRETS_STAGING) || (echo "✗ Missing $(SECRETS_STAGING) — copy .secrets.example and fill in your staging values"; exit 1)
	@mkdir -p $(NODE_MODULES_CACHE) $(PLAYWRIGHT_CACHE)
	act push \
		--secret-file $(SECRETS_STAGING) \
		--cache-server-path $(NODE_MODULES_CACHE)

# ── Production: simulates a tag push (e.g. v1.0.0) ───────────
prod:
	@echo "▶ Running Playwright tests [production environment]..."
	@test -f $(SECRETS_PROD) || (echo "✗ Missing $(SECRETS_PROD) — copy .secrets.example and fill in your prod values"; exit 1)
	@mkdir -p $(NODE_MODULES_CACHE) $(PLAYWRIGHT_CACHE)
	act push \
		--secret-file $(SECRETS_PROD) \
		--eventpath .github/events/tag-push.json \
		--cache-server-path $(NODE_MODULES_CACHE)

# ── Install dependencies ──────────────────────────────────────
install:
	@echo "▶ Checking dependencies..."
	@which docker > /dev/null || (echo "✗ Docker not found — install from https://docker.com"; exit 1)
	@which act > /dev/null || (echo "Installing act..." && brew install act)
	@echo "✓ All dependencies ready"

# ── Help ──────────────────────────────────────────────────────
help:
	@echo ""
	@echo "  Playwright Local Test Runner"
	@echo ""
	@echo "  make dev       Run tests against dev     (simulates PR)"
	@echo "  make staging   Run tests against staging (simulates push to main)"
	@echo "  make prod      Run tests against prod    (simulates tag release)"
	@echo "  make install   Check/install act and Docker"
	@echo ""
	@echo "  Secret files required:"
	@echo "    $(SECRETS_DEV)"
	@echo "    $(SECRETS_STAGING)"
	@echo "    $(SECRETS_PROD)"
	@echo ""
