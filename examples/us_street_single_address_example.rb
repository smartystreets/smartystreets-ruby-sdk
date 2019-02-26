require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/client_builder'
require 'smartystreets_ruby_sdk/us_street/lookup'

class USStreetSingleAddressExample
  def run
    auth_id = 'Your SmartyStreets Auth ID here'
    auth_token = 'Your SmartyStreets Auth Token here'

    # We recommend storing your secret keys in environment variables instead---it's safer!
    # auth_id = ENV['SMARTY_AUTH_ID']
    # auth_token = ENV['SMARTY_AUTH_TOKEN']

    credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)

    client = SmartyStreets::ClientBuilder.new(credentials).
                 # with_proxy('localhost', 8080, 'proxyUser', 'proxyPassword'). # Uncomment this line to try it with a proxy
                 build_us_street_api_client

    lookup = SmartyStreets::USStreet::Lookup.new
    lookup.street = '1600 Amphitheatre Pkwy'
    lookup.city = 'Mountain View'
    lookup.state = 'CA'
    lookup.match = SmartyStreets::USStreet::MatchType::INVALID

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

    puts "Address is valid. (There is at least one candidate)\n"
    puts "ZIP Code: #{first_candidate.components.zipcode}"
    puts "County: #{first_candidate.metadata.county_name}"
    puts "Latitude: #{first_candidate.metadata.latitude}"
    puts "Longitude: #{first_candidate.metadata.longitude}"
  end
end

example = USStreetSingleAddressExample.new
example.run