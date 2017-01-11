require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/us_street/client_builder'
require 'smartystreets_ruby_sdk/us_street/lookup'

class USStreetMultipleAddressExample
  def run
    auth_id = ENV['SMARTY_AUTH_ID'] # We recommend storing your keys in environment variables
    auth_token = ENV['SMARTY_AUTH_TOKEN']
    credentials = StaticCredentials.new(auth_id, auth_token)

    client = ClientBuilder.new(credentials).build
    batch = Batch.new

    batch.add(Lookup.new)
    batch[0].street = '1600 amphitheatre parkway'
    batch[0].city = 'Mountain view'
    batch[0].state = 'california'

    batch.add(Lookup.new('1 Rosedale, Baltimore, Maryland')) # Freeform addresses work too.
    batch[1].candidates = 10 # Allows up to ten possible matches to be returned (default is 1).

    batch.add(Lookup.new('123 Bogus Street, Pretend Lake, Oklahoma'))

    batch.add(Lookup.new)
    batch[3].street = '1 Infinite Loop'
    batch[3].zipcode = '95014' # You can just input the street and ZIP if you want.

    begin
      client.send_batch(batch)
    rescue SmartyException => err
      print(err)
      return
    end

    i = 0
    batch.each do |lookup|
      candidates = lookup.result

      if candidates.length == 0
        puts "Address #{i} is invalid.\n\n"
        i += 1
        next
      end

      puts "Address #{i} is valid. (There is at least one candidate)"

      candidates.each do |candidate|
        components = candidate.components
        metadata = candidate.metadata

        puts "\nCandidate #{candidate.candidate_index} : "
        puts "Delivery line 1: #{candidate.delivery_line_1}"
        puts "Last line:       #{candidate.last_line}"
        puts "ZIP Code:        #{components.zipcode}-#{components.plus4_code}"
        puts "County:          #{metadata.county_name}"
        puts "Latitude:        #{metadata.latitude}"
        puts "Longitude:       #{metadata.longitude}"
        puts
      end
      i += 1
    end
  end
end

USStreetMultipleAddressExample.new.run