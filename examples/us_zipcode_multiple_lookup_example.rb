require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/batch'
require '../lib/smartystreets_ruby_sdk/us_zipcode/lookup'

class USZipcodeMultipleLookupExample
  Lookup = SmartyStreets::USZipcode::Lookup

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
    batch = SmartyStreets::Batch.new

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-zipcode-api

    batch.add(Lookup.new)
    batch[0].input_id = '01189998819991197253' # Optional ID from your system
    batch[0].zipcode = '12345' # A Lookup may have a ZIP Code, city and state, or city, state, and ZIP Code

    # batch[0].add_custom_parameter('parameter', 'value')

    batch.add(Lookup.new)
    batch[1].city = 'Phoenix'
    batch[1].state = 'Arizona'

    batch.add(Lookup.new('cupertino', 'CA', '95014')) # You can also set these with arguments


    begin
      client.send_batch(batch)
    rescue SmartyError => err
      puts err
      return
    end

    batch.each_with_index { |lookup, i|
      result = lookup.result
      puts "Lookup #{i}:\n"

      if result.status
        puts "Status: #{result.status}"
        puts "Reason: #{result.reason}"
        next
      end

      cities = result.cities
      puts "#{cities.length} City and State match(es):"

      cities.each { |city|
        puts "City: #{city.city}"
        puts "State: #{city.state}"
        puts "Mailable City: #{city.mailable_city}"
        puts
      }

      zipcodes = result.zipcodes
      puts "#{zipcodes.length} ZIP Code match(es):"

      zipcodes.each { |zipcode|
        puts "ZIP Code: #{zipcode.zipcode}"
        puts "County: #{zipcode.county_name}"
        puts "Latitude: #{zipcode.latitude}"
        puts "Longitude: #{zipcode.longitude}"
        puts
      }

      puts '***********************************'
    }
  end
end

example = USZipcodeMultipleLookupExample.new
example.run