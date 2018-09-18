#!/usr/bin/make -f

VERSION_FILE  := lib/smartystreets_ruby_sdk/version.rb
IDENTITY_FILE := ~/.gem/credentials

clean:
	rm -f *.gem
	git checkout "$(VERSION_FILE)"

test:
	rake test

dependencies:
	gem install minitest

package: clean dependencies test
	sed -i "s/0\.0\.0/$(shell tagit -p --dry-run)/g" "$(VERSION_FILE)" \
		&& gem build *.gemspec \
		&& git checkout "$(VERSION_FILE)"

identity:
	test -f $(IDENTITY_FILE) || (mkdir -p $(dir $(IDENTITY_FILE)) \
		&& echo ":rubygems_api_key: $(RUBYGEMS_API_KEY)" > $(IDENTITY_FILE) \
		&& chmod 0600 $(IDENTITY_FILE))

publish: package identity
	gem push *.gem

#####################################################################

workspace:
	docker-compose run sdk /bin/sh

release:
	docker-compose run sdk make publish && tagit -p && git push origin --tags

.PHONY: clean test dependencies package publish identity workspace release
