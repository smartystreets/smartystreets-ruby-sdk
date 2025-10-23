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
	&& gem build *.gemspec \
	&& git checkout "$(VERSION_FILE)"

publish: package
	mkdir -p ~/.gem
	touch ~/.gem/credentials
	chmod 0600 ~/.gem/credentials
	printf -- "---\n:rubygems_api_key: ${API_KEY}\n" > ~/.gem/credentials
	gem push *.gem

international_autocomplete_api:
	cd examples && ruby international_autocomplete_example.rb

international_street_api:
	cd examples && ruby international_example.rb

us_autocomplete_pro_api:
	cd examples && ruby us_autocomplete_pro_example.rb

us_enrichment_api:
	cd examples && ruby us_enrichment_example.rb

us_extract_api:
	cd examples && ruby us_extract_example.rb

us_reverse_geo_api:
	cd examples && ruby us_reverse_geo_example.rb

us_street_api:
	cd examples && ruby us_street_single_address_example.rb && ruby us_street_multiple_address_example.rb

us_zipcode_api:
	cd examples && ruby us_zipcode_single_lookup_example.rb && ruby us_zipcode_multiple_lookup_example.rb

examples: international_autocomplete_api international_street_api us_autocomplete_pro_api us_enrichment_api us_extract_api us_reverse_geo_api us_street_api us_zipcode_api

.PHONY: clean test dependencies package publish international_autocomplete_api international_street_api us_autocomplete_pro_api us_enrichment_api us_extract_api us_reverse_geo_api us_street_api us_zipcode_api examples
