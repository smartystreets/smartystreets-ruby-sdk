require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/us_street/client_builder'
require 'smartystreets_ruby_sdk/us_street/lookup'

class USStreetSingleAddressExample
  def run
    auth_id = ENV['SMARTY_AUTH_ID'] # We recommend storing your keys in environment variables
    auth_token = ENV['SMARTY_AUTH_TOKEN']
    credentials = StaticCredentials.new(auth_id, auth_token)

    client = USStreet::ClientBuilder.new(credentials).build

    lookup = USStreet::Lookup.new
    lookup.street = '1600 Amphitheatre Pkwy'
    lookup.city = 'Mountain View'
    lookup.state = 'CA'

    begin
      client.send_lookup(lookup)
    rescue SmartyException => err
      puts err
      return
    end

    result = lookup.result

    if result == nil
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