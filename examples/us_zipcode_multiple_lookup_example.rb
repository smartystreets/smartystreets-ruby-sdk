require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/us_zipcode/client_builder'
require 'smartystreets_ruby_sdk/us_zipcode/lookup'

class USZipcodeMultipleLookupExample
  def run
    auth_id = ENV['SMARTY_AUTH_ID'] # We recommend storing your keys in environment variables
    auth_token = ENV['SMARTY_AUTH_TOKEN']
    credentials = StaticCredentials.new(auth_id, auth_token)

    client = USZipcode::ClientBuilder.new(credentials).build
    batch = Batch.new

    batch.add(USZipcode::Lookup.new)
    batch[0].zipcode = '12345' # A Lookup may have a ZIP Code, city and state, or city, state, and ZIP Code

    batch.add(USZipcode::Lookup.new)
    batch[1].city = 'Phoenix'
    batch[1].state = 'Arizona'

    batch.add(USZipcode::Lookup.new('cupertino', 'CA', '95014')) # You can also set these with arguments


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
