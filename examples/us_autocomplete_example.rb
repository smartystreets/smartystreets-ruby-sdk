require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/client_builder'
require 'smartystreets_ruby_sdk/us_autocomplete/lookup'

class USAutocompleteExample
  Lookup = SmartyStreets::USAutocomplete::Lookup

  def run
    auth_id = ENV['SMARTY_AUTH_ID'] # We recommend storing your keys in environment variables
    auth_token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)
    client = SmartyStreets::ClientBuilder.new(credentials).build_us_autocomplete_api_client
    lookup = Lookup.new('4770 Lincoln Ave O')

    client.send(lookup)

    puts '*** Result with no filter ***'
    puts
    lookup.result.each do |suggestion|
      puts suggestion.text
    end

    lookup.add_state_filter('IL')
    lookup.max_suggestions = 5

    suggestions = client.send(lookup) # The client will also return the suggestions directly

    puts
    puts '*** Result with some filters ***'

    suggestions.each do |suggestion|
      puts suggestion.text
    end

  end
end

USAutocompleteExample.new.run
