require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_street/lookup'
require '../lib/smartystreets_ruby_sdk/us_street/match_type'

class USStreetSingleAddressExample
  def run
    # key = 'Your SmartyStreets Auth Key here'
    # referer = 'Your host name here'
    # We recommend storing your secret keys in environment variables instead---it's safer!
    key = ENV['SMARTY_AUTH_WEB']
    referer = ENV['SMARTY_AUTH_REFERER']
    credentials = SmartyStreets::SharedCredentials.new(key, referer)

    # id = ENV['SMARTY_AUTH_ID']
    # token = ENV['SMARTY_AUTH_TOKEN']
    # credentials = SmartyStreets::StaticCredentials.new(id, token)

    # The appropriate license values to be used for your subscriptions
    # can be found on the Subscriptions page of the account dashboard.
    # https://www.smartystreets.com/docs/cloud/licensing
    #
    # To try with a proxy, add this method call after with_licences
    #   with_proxy('localhost', 8080, 'proxyUser', 'proxyPassword')
    client = SmartyStreets::ClientBuilder.new(credentials).with_licenses(['us-core-cloud']).
             build_us_street_api_client

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-street-api

    lookup = SmartyStreets::USStreet::Lookup.new
    lookup.input_id = '24601'  # Optional ID from your system
    lookup.addressee = 'John Doe'
    lookup.street = '1600 Amphitheatre Pkwy'
    lookup.street2 = 'closet under the stairs'
    lookup.secondary = 'APT 2'
    lookup.urbanization = ''  # Only applies to Puerto Rico addresses
    lookup.city = 'Mountain View'
    lookup.state = 'CA'
    lookup.zipcode = '21229'
    lookup.candidates = 3
    lookup.county_source = SmartyStreets::USStreet::CountySource::GEOGRAPHIC
    lookup.match = SmartyStreets::USStreet::MatchType::ENHANCED
                                    # "invalid" is the most permissive match,
                                    # this will always return at least one result even if the address is invalid.
                                    # Refer to the documentation for additional Match Strategy options.

    # lookup.add_custom_parameter('parameter', 'value')

    begin
      client.send_lookup(lookup)
    rescue SmartyStreets::SmartyError => err
      puts err
      return
    end

    result = lookup.result

    if result.empty?
      puts 'No candidates. This means the address is not valid.'
      return
    end

    first_candidate = result[0]

    puts "There is at least one candidate.\n If the match parameter is set to STRICT, the address is valid.\n Otherwise, check the Analysis output fields to see if the address is valid.\n"
    puts "Input ID: #{first_candidate.input_id}"
    puts "ZIP Code: #{first_candidate.components.zipcode}"
    puts "County: #{first_candidate.metadata.county_name}"
    puts "Latitude: #{first_candidate.metadata.latitude}"
    puts "Longitude: #{first_candidate.metadata.longitude}"
  end
end

example = USStreetSingleAddressExample.new
example.run
