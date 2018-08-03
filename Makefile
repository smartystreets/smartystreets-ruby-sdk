#!/usr/bin/make -f

SOURCE_VERSION := 5.4
VERSION_FILE = lib/smartystreets_ruby_sdk/version.rb

tests:
	rake test

publish:
	sed -i "s/0\.0\.0/$(shell git describe)/g" "$(VERSION_FILE)"
	@#gem build "smartystreets_ruby_sdk.gemspec"
	@#gem push "smartystreets_ruby_sdk-$(shell git describe).gem"
	git checkout "$(VERSION_FILE)"

dependencies:
	gem install minitest

version:
	$(eval PREFIX := $(SOURCE_VERSION).)
	$(eval CURRENT := $(shell git describe 2>/dev/null))
	$(eval EXPECTED := $(PREFIX)$(shell git tag -l "$(PREFIX)*" | wc -l | xargs expr -1 +))
	$(eval INCREMENTED := $(PREFIX)$(shell git tag -l "$(PREFIX)*" | wc -l | xargs expr 0 +))
	@if [ "$(CURRENT)" != "$(EXPECTED)" ]; then git tag -a "$(INCREMENTED)" -m "" 2>/dev/null || true; fi
