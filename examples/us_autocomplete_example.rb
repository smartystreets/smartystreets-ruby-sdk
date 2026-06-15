require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/basic_auth_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_autocomplete/lookup'

# This example is for US Autocomplete (V2). It has the same name as a previous product
# which has been deprecated since 2022, which we refer to as US Autocomplete Basic.
# If you are still using US Autocomplete Basic, this SDK will not work.
class USAutocompleteExample
  Lookup = SmartyStreets::USAutocomplete::Lookup

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

    client = SmartyStreets::ClientBuilder.new(credentials).build_us_autocomplete_api_client

    # Documentation for input fields can be found at:
    # https://www.smarty.com/docs/apis/us-autocomplete-v2/reference#http-request-input-fields

    lookup = Lookup.new('1042 W Center')
    lookup.add_city_filter('Denver,Aurora,CO')
    lookup.add_city_filter('Orem,UT')
    lookup.max_results = 5
    lookup.prefer_ratio = 3
    lookup.source = "all"

    # lookup.add_custom_parameter('parameter', 'value')

    suggestions = client.send(lookup) # The client will also return the suggestions directly

    puts
    puts '*** Result with some filters ***'
    puts

    entry_id = nil
    suggestions.each do |suggestion|
      puts "#{suggestion.street_line} #{suggestion.city}, #{suggestion.state}"
      entry_id = suggestion.entry_id if suggestion.entry_id && !suggestion.entry_id.empty?
    end

    # Expand the secondaries of a result that has an entry_id by passing it back as the selected address.
    if entry_id && !entry_id.empty?
      lookup.selected = entry_id
      suggestions = client.send(lookup)

      puts
      puts '*** Secondaries ***'
      puts

      suggestions.each do |suggestion|
        puts "#{suggestion.street_line} #{suggestion.city}, #{suggestion.state}"
      end
    end
  end
end

USAutocompleteExample.new.run
