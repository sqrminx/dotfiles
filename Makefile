PACKAGES := $(patsubst %/,%,$(wildcard */))

.DEFAULT_GOAL := help
.PHONY: help install update uninstall preview check-stow

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  install     Symlink all packages into ~"
	@echo "  update      Refresh links after adding/removing files (restow)"
	@echo "  uninstall   Remove all symlinks"
	@echo "  preview     Dry-run: print what install would do"
	@echo "  check-stow  Verify GNU Stow is installed"

install: check-stow
	stow $(PACKAGES)

update: check-stow
	stow -R $(PACKAGES)

uninstall: check-stow
	stow -D $(PACKAGES)

preview: check-stow
	stow -nv $(PACKAGES)

check-stow:
	@command -v stow >/dev/null 2>&1 || { \
		echo "GNU Stow not found. Install it with: brew install stow"; \
		exit 1; \
	}
