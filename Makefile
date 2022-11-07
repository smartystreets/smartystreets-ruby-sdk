#!/usr/bin/make -f

VERSION_FILE  := lib/smartystreets_ruby_sdk/version.rb

clean:
	rm -f *.gem
	git checkout "$(VERSION_FILE)"

test:
	rake test

dependencies:
	gem install minitest

package: clean dependencies test
	sed -i "s/0\.0\.0/${VERSION}/g" "$(VERSION_FILE)" \
		&& gem build *.gemspec && git checkout "$(VERSION_FILE)"

publish: package
	mkdir -p .gem
	touch .gem/credentials
	sudo chmod 0600 /root/.gem/credentials
	printf -- "---\n:rubygems_api_key: ${{secrets.GEM_HOST_API_KEY}}\n" > .gem/credentials
	gem push *.gem

.PHONY: clean test dependencies package publish
