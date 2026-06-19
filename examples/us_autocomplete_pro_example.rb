require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/basic_auth_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_autocomplete_pro/lookup'
require '../lib/smartystreets_ruby_sdk/us_autocomplete_pro/source_type'

class USAutocompleteProExample
  Lookup = SmartyStreets::USAutocompletePro::Lookup
  SourceType = SmartyStreets::USAutocompletePro::SourceType

  def run
    # key = 'Your SmartyStreets Auth Key here'
    # referer = 'Your host name here'
    # We recommend storing your secret keys in environment variables instead---it's safer!
    # key = ENV['SMARTY_AUTH_WEB']
    # referer = ENV['SMARTY_AUTH_REFERER']
    # credentials = SmartyStreets::SharedCredentials.new(key, referer)

    id = ENV['SMARTY_AUTH_ID']
    token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::BasicAuthCredentials.new(id, token)

    client = SmartyStreets::ClientBuilder.new(credentials).build_us_autocomplete_pro_api_client

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-autocomplete-api

    lookup = Lookup.new('1042 W Center')
    lookup.add_city_filter('Denver,Aurora,CO')
    lookup.add_city_filter('Orem,UT')
    lookup.max_results = 5
    lookup.prefer_ratio = 3
    lookup.source = SourceType::ALL

    # lookup.add_custom_parameter('parameter', 'value')

    suggestions = client.send(lookup) # The client will also return the suggestions directly

    puts
    puts '*** Result with some filters ***'
    puts

    suggestions.each do |suggestion|
      puts "#{suggestion.street_line} #{suggestion.city}, #{suggestion.state}"
    end

  end
end

USAutocompleteProExample.new.run

