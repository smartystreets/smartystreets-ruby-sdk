#!/usr/bin/make -f

SOURCE_VERSION := 4.0

tests:
	ruby -Ilib -e 'ARGV.each { |f| require f }' ./test/smartystreets_ruby_sdk/test*.rb ./test/smartystreets_ruby_sdk/us_street/test*.rb ./test/smartystreets_ruby_sdk/us_zipcode/test*.rb

publish: version
	git push origin --tags
	gem build smartystreets_ruby_sdk.gemspec
	gem push smartystreets_ruby_sdk-$(shell git describe).gem
	git checkout lib/smartystreets_ruby_sdk/version.rb

version: tag
	@sed -i -r "s/0\.0\.0/$(shell git describe)/g" lib/smartystreets_ruby_sdk/version.rb

tag:
	$(eval PREFIX := $(SOURCE_VERSION).)
	$(eval CURRENT := $(shell git describe 2>/dev/null))
	$(eval EXPECTED := $(PREFIX)$(shell git tag -l "$(PREFIX)*" | wc -l | xargs expr -1 +))
	$(eval INCREMENTED := $(PREFIX)$(shell git tag -l "$(PREFIX)*" | wc -l | xargs expr 0 +))
	@if [ "$(CURRENT)" != "$(EXPECTED)" ]; then git tag -a "$(INCREMENTED)" -m "" 2>/dev/null || true; fi
