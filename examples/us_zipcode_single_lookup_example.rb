require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_zipcode/lookup'

class UsZipcodeSingleLookupExample
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

    client = SmartyStreets::ClientBuilder.new(credentials).build_us_zipcode_api_client

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-zipcode-api

    lookup = SmartyStreets::USZipcode::Lookup.new
    lookup.input_id = 'dfc33cb6-829e-4fea-aa1b-b6d6580f0817'  # Optional ID from your system
    lookup.city = 'Mountain View'
    lookup.state = 'California'
    lookup.zipcode = '94043'

    begin
      client.send_lookup(lookup)
    rescue SmartyStreets::SmartyError => err
      puts err
      return
    end

    result = lookup.result
    zipcodes = result.zipcodes
    cities = result.cities

    puts "Input ID: #{result.input_id}"

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