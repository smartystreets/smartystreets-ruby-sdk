require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/batch'
require '../lib/smartystreets_ruby_sdk/us_street/lookup'
require '../lib/smartystreets_ruby_sdk/us_street/match_type'

class USStreetMultipleAddressExample
  Lookup = SmartyStreets::USStreet::Lookup

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

    client = SmartyStreets::ClientBuilder.new(credentials).build_us_street_api_client
    batch = SmartyStreets::Batch.new

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-street-api

    batch.add(Lookup.new)
    batch[0].input_id = '8675309' # Optional ID from your system
    batch[0].addressee = 'John Doe'
    batch[0].street = '1600 amphitheatre parkway'
    batch[0].street2 = 'second star to the right'
    batch[0].secondary = 'APT 2'
    batch[0].urbanization = '' # Only applies to Puerto Rico addresses
    batch[0].lastline = 'Mountain view, California'
    batch[0].zipcode = '21229'
    batch[0].candidates = 3
    batch[0].match = SmartyStreets::USStreet::MatchType::INVALID # "invalid" is the most permissive match,
    # this will always return at least one result even if the address is invalid.
    # Refer to the documentation for additional Match Strategy options.

    # batch[0].add_custom_parameter('parameter', 'value')

    batch.add(Lookup.new('1 Rosedale, Baltimore, Maryland')) # Freeform addresses work too.
    batch[1].candidates = 10 # Allows up to ten possible matches to be returned (default is 1).

    batch.add(Lookup.new('123 Bogus Street, Pretend Lake, Oklahoma'))

    batch.add(Lookup.new)
    batch[3].street = '1 Infinite Loop'
    batch[3].zipcode = '95014' # You can just input the street and ZIP if you want.

    begin
      client.send_batch(batch)
    rescue SmartyStreets::SmartyError => e
      puts e
      return
    end

    batch.each_with_index do |lookup, i|
      candidates = lookup.result

      if candidates.empty?
        puts "Address #{i} is invalid.\n\n"
        next
      end

      puts "Address #{i} has at least one candidate.\n If the match parameter is set to STRICT, the address is valid.\n Otherwise, check the Analysis output fields to see if the address is valid."

      candidates.each do |candidate|
        components = candidate.components
        metadata = candidate.metadata

        puts "\nCandidate #{candidate.candidate_index} : "
        puts "Input ID: #{candidate.input_id}"
        puts "Delivery line 1: #{candidate.delivery_line_1}"
        puts "Last line:       #{candidate.last_line}"
        puts "ZIP Code:        #{components.zipcode}-#{components.plus4_code}"
        puts "County:          #{metadata.county_name}"
        puts "Latitude:        #{metadata.latitude}"
        puts "Longitude:       #{metadata.longitude}"
        puts
      end
    end
  end
end

USStreetMultipleAddressExample.new.run
