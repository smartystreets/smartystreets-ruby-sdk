#!/usr/bin/make -f

tests:
	ruby -Ilib -e 'ARGV.each { |f| require f }' \
		./test/smartystreets_ruby_sdk/test*.rb \
		./test/smartystreets_ruby_sdk/us_street/test*.rb \
		./test/smartystreets_ruby_sdk/us_zipcode/test*.rb \
		./test/smartystreets_ruby_sdk/us_autocomplete/test*.rb \
		./test/smartystreets_ruby_sdk/us_extract/test*.rb \
		./test/smartystreets_ruby_sdk/international_street/test*.rb

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
