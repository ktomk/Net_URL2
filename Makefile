PHP ?= php
export PHP_PEAR_PHP_BIN ?= $(PHP)
export PHP_BINARY ?= $(PHP)
COMPOSERCMD ?= $(PHP) "$(shell command -v composer)" -q
export COMPOSER_DISABLE_XDEBUG_WARN ?= 1
export COMPOSER_NO_INTERACTION ?= 1

all:
.PHONY: all clean build dist distclean

vendor/bin/php% : composer.json
	$(COMPOSERCMD) install
	touch -c $@

build-main: vendor/bin/phpunit
	pear version
	$(PHP) $<
	pear run-tests -r tests/

build-composer:
	$(COMPOSERCMD:%-q=%) --version
	$(COMPOSERCMD:%-q=%) validate --strict

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
