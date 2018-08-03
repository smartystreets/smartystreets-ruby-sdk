#!/usr/bin/make -f

tests:
	rake test

publish-patch:
	@python tag.py patch
	gem build smartystreets_ruby_sdk.gemspec
	gem push smartystreets_ruby_sdk-`git describe`.gem

publish-minor:
	@python tag.py minor
	gem build smartystreets_ruby_sdk.gemspec
	gem push smartystreets_ruby_sdk-`git describe`.gem

publish-major:
	@python tag.py major
	gem build smartystreets_ruby_sdk.gemspec
	gem push smartystreets_ruby_sdk-`git describe`.gem

dependencies:
	gem install minitest
