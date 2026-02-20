SHELL := /bin/bash
.DEFAULT_GOAL := help

PREFIX ?= /usr/local
DATADIR ?= $(PREFIX)/share/searxng-cli
BINDIR ?= $(PREFIX)/bin
VERSION ?= dev

TAPES := $(wildcard tapes/*.tape)
GIFS := $(patsubst tapes/%.tape,assets/%.gif,$(TAPES))

.PHONY: help install uninstall render clean

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

install: ## Install to PREFIX (sudo make install)
	install -Dm755 src/searxng.sh $(DESTDIR)$(DATADIR)/searxng.sh
	sed 's|/usr/share/searxng-cli|$(DATADIR)|g' src/searxng.yaml \
		> $(DESTDIR)$(DATADIR)/searxng.yaml.tmp
	mv $(DESTDIR)$(DATADIR)/searxng.yaml.tmp $(DESTDIR)$(DATADIR)/searxng.yaml
	chmod 644 $(DESTDIR)$(DATADIR)/searxng.yaml
	install -Dm644 LICENSE $(DESTDIR)$(PREFIX)/share/licenses/searxng-cli/LICENSE
	install -dm755 $(DESTDIR)$(BINDIR)
	printf '#!/bin/bash\nSEARXNG_CLI_VERSION="$(VERSION)"\nsource $(DATADIR)/searxng.sh\n_searxng "$$@"\n' \
		> $(DESTDIR)$(BINDIR)/searxng
	chmod 755 $(DESTDIR)$(BINDIR)/searxng

uninstall: ## Uninstall (sudo make uninstall)
	rm -f $(DESTDIR)$(BINDIR)/searxng
	rm -rf $(DESTDIR)$(DATADIR)
	rm -rf $(DESTDIR)$(PREFIX)/share/licenses/searxng-cli

render: $(GIFS) ## Render VHS tapes to assets/*.gif (requires: vhs, searxng installed)

assets/%.gif: tapes/%.tape | assets
	@command -v vhs >/dev/null || { echo "error: vhs not found (https://github.com/charmbracelet/vhs)"; exit 1; }
	@command -v searxng >/dev/null || { echo "error: searxng not installed (run: make install)"; exit 1; }
	vhs $<

assets:
	mkdir -p assets

clean: ## Remove rendered assets
	rm -f $(GIFS)
