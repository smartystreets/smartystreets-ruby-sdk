require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/client_builder'
require 'smartystreets_ruby_sdk/us_autocomplete/lookup'

class USAutocompleteExample
  Lookup = SmartyStreets::USAutocomplete::Lookup

  def run
    auth_id = 'Your SmartyStreets Auth ID here'
    auth_token = 'Your SmartyStreets Auth Token here'

    # We recommend storing your secret keys in environment variables instead---it's safer!
    # auth_id = ENV['SMARTY_AUTH_ID']
    # auth_token = ENV['SMARTY_AUTH_TOKEN']

    credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)
    client = SmartyStreets::ClientBuilder.new(credentials).build_us_autocomplete_api_client

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-autocomplete-api

    lookup = Lookup.new('4770 Lincoln Ave O')
    lookup.max_suggestions = 10

    client.send(lookup)

    puts '*** Result with no filter ***'
    puts
    lookup.result.each do |suggestion|
      puts suggestion.text
    end

    lookup.add_city_filter('Ogden')
    lookup.add_state_filter('IL')
    lookup.add_prefer('Ogden, IL')
    lookup.max_suggestions = 5
    lookup.prefer_ratio = 0.333333

    suggestions = client.send(lookup) # The client will also return the suggestions directly

    puts
    puts '*** Result with some filters ***'
    puts

    suggestions.each do |suggestion|
      puts suggestion.text
    end

  end
end

USAutocompleteExample.new.run
