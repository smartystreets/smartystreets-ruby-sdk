require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/international_autocomplete/lookup'
require '../lib/smartystreets_ruby_sdk/international_autocomplete/client'

class InternationalAutocompleteExample
  Lookup = SmartyStreets::InternationalAutocomplete::Lookup

  def run
    # key = 'Your SmartyStreets Auth Key here'
    # referer = 'Your host name here'
    # We recommend storing your secret keys in environment variables instead---it's safer!
    key = ENV.fetch('SMARTY_AUTH_WEB', nil)
    referer = ENV.fetch('SMARTY_AUTH_REFERER', nil)
    credentials = SmartyStreets::SharedCredentials.new(key, referer)

    # id = ENV['SMARTY_AUTH_ID']
    # token = ENV['SMARTY_AUTH_TOKEN']
    # credentials = SmartyStreets::StaticCredentials.new(id, token)

    client = SmartyStreets::ClientBuilder.new(credentials).build_international_autocomplete_api_client

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-autocomplete-api

    lookup = Lookup.new('Louis')
    lookup.country = 'FRA'
    lookup.locality = 'Paris'

    # lookup.add_custom_parameter('parameter', 'value')

    suggestions = client.send(lookup) # The client will also return the suggestions directly

    puts
    puts '*** Result with some filters ***'
    puts

    suggestions.each do |suggestion|
      if suggestion.address_text
        puts "#{suggestion.entries} #{suggestion.address_text}, #{suggestion.address_id}"
      else
        puts "#{suggestion.street} #{suggestion.locality}, #{suggestion.country_iso3}"
      end
    end
  end
end

InternationalAutocompleteExample.new.run
