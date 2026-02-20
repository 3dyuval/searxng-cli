SHELL := /bin/bash
.DEFAULT_GOAL := help

PREFIX ?= /usr/local
DATADIR ?= $(PREFIX)/share/searxng-cli
BINDIR ?= $(PREFIX)/bin
VERSION ?= dev

.PHONY: help install uninstall

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

install: ## Install searxng-cli to PREFIX (default /usr/local)
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

uninstall: ## Remove searxng-cli from PREFIX
	rm -f $(DESTDIR)$(BINDIR)/searxng
	rm -rf $(DESTDIR)$(DATADIR)
	rm -rf $(DESTDIR)$(PREFIX)/share/licenses/searxng-cli
