PHP ?= php
export PHP_PEAR_PHP_BIN ?= $(PHP)
export PHP_BINARY ?= $(PHP)
COMPOSERCMD ?= $(PHP) "$(shell command -v composer)"
export COMPOSER_DISABLE_XDEBUG_WARN ?= 1
export COMPOSER_NO_INTERACTION ?= 1

all:
.PHONY: all clean build dist distclean

define chronic-composer
@printf 'composer %s\n' "$1"
@$(COMPOSERCMD) --quiet $1 || (printf 'composer %s exited non-zero (%d), retrying non-quietly:\n' "$1" "$$?"; $(COMPOSERCMD) $1)
endef

vendor/bin/php% : composer.json
	$(call chronic-composer,install)
	touch -c $@

build-main: vendor/bin/phpunit
	pear version
	$(PHP) $<
	pear run-tests -r tests/

build-composer:
	$(COMPOSERCMD) --version
	$(call chronic-composer,diagnose)
	$(call chronic-composer,validate --strict)

build: build-main build-composer

all: build
.PHONY: build build-main build-composer

clean:
	rm -f -- $(wildcard .php*)

distclean: clean
	rm -rf -- $(wildcard vendor composer.lock Net_URL2-?.?.?.tgz)

dist:
	pear version
	pear package
