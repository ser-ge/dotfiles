STOW_PACKAGES := $(shell ls -d */ | sed 's|/||' | grep -Ev '^(scripts|bootstrap_scratch)$$' | tr '\n' ' ')

.PHONY: up down refresh bootstrap packages packages-cleanup docker docker-build docker-run docker-test help

help:           ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | awk -F'##' '{printf "  %-16s %s\n", $$1, $$2}'

up:             ## Stow all packages into HOME
	stow --stow $(STOW_PACKAGES)

down:           ## Remove all stow symlinks from HOME
	stow --delete $(STOW_PACKAGES)

refresh:        ## Re-stow all packages (useful after adding files)
	stow --restow $(STOW_PACKAGES)

bootstrap:      ## Install tools and stow configs (runs bootstrap.sh)
	bash bootstrap.sh

packages:       ## Re-sync packages on a running machine (no stow)
	bash bootstrap.sh --skip-stow

packages-cleanup: ## Remove Brewfile packages no longer listed (macOS only)
	brew bundle cleanup --force

# ── Docker ───────────────────────────────────────────────────────────────────

docker:         ## Dev shell: repo mounted at /dotfiles, iterate on bootstrap.sh
	docker run -it --rm -v "$(shell pwd)":/dotfiles -w /dotfiles debian:latest bash

docker-build:   ## Build the baked image (layered for optimal caching)
	docker build -t dotfiles .

docker-run:     ## Run the baked image (interactive fish shell)
	docker run -it --rm dotfiles

docker-test:    ## Smoke-test bootstrap.sh in a clean Debian container
	docker run --rm -v "$(shell pwd)":/dotfiles -w /dotfiles debian:latest \
		bash /dotfiles/bootstrap.sh --skip-stow
