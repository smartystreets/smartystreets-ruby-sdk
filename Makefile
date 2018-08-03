#!/usr/bin/make -f

SOURCE_VERSION := 5.5
VERSION_FILE = lib/smartystreets_ruby_sdk/version.rb
CREDENTIALS_FILE = ~/.gem/credentials

clean:
	rm -f *.gem
	git checkout "$(VERSION_FILE)"

tests:
	rake test

package: clean 
	sed -i "s/0\.0\.0/$(shell git describe)/g" "$(VERSION_FILE)"
	gem build *.gemspec
	git checkout "$(VERSION_FILE)"

publish: credentials
	gem push *.gem

credentials:
	mkdir -p "$(dir $(CREDENTIALS_FILE))"
	test -f $(CREDENTIALS_FILE) || echo ":rubygems_api_key: $(RUBYGEMS_API_KEY)" > $(CREDENTIALS_FILE)
	chmod 0600 $(CREDENTIALS_FILE)

dependencies:
	gem install minitest

version:
	$(eval PREFIX := $(SOURCE_VERSION).)
	$(eval CURRENT := $(shell git describe 2>/dev/null))
	$(eval EXPECTED := $(PREFIX)$(shell git tag -l "$(PREFIX)*" | wc -l | xargs expr -1 +))
	$(eval INCREMENTED := $(PREFIX)$(shell git tag -l "$(PREFIX)*" | wc -l | xargs expr 0 +))
	@if [ "$(CURRENT)" != "$(EXPECTED)" ]; then git tag -a "$(INCREMENTED)" -m "" 2>/dev/null || true; fi

####################################################################3

container-test:
	docker-compose run sdk make tests
container-package: version
	docker-compose run sdk make package
container-publish:
	docker-compose run sdk make publish
	git push origin --tags
