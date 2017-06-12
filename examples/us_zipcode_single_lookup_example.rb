require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/client_builder'
require 'smartystreets_ruby_sdk/us_zipcode/lookup'

class UsZipcodeSingleLookupExample
  def run
    auth_id = ENV['SMARTY_AUTH_ID'] # We recommend storing your keys in environment variables.
    auth_token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)

    client = SmartyStreets::ClientBuilder.new(credentials).build_us_zipcode_api_client

    lookup = SmartyStreets::USZipcode::Lookup.new
    lookup.city = 'Mountain View'
    lookup.state = 'California'

    begin
      client.send_lookup(lookup)
    rescue SmartyError => err
      puts err
      return
    end

    result = lookup.result
    zipcodes = result.zipcodes
    cities = result.cities

    cities.each do |city|
      puts "\nCity: #{city.city}"
      puts "State: #{city.state}"
      puts "Mailable City: #{city.mailable_city}"
    end

    zipcodes.each do |zipcode|
      puts "\nZIP Code: #{zipcode.zipcode}"
      puts "Latitude: #{zipcode.latitude}"
      puts "Longitude: #{zipcode.longitude}"
    end
  end
end

example = UsZipcodeSingleLookupExample.new
example.run