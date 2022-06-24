require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/client_builder'
require 'smartystreets_ruby_sdk/batch'
require 'smartystreets_ruby_sdk/us_street/lookup'

class USStreetMultipleAddressExample
  Lookup = SmartyStreets::USStreet::Lookup

  def run
    # auth_id = 'Your SmartyStreets Auth ID here'
    # auth_token = 'Your SmartyStreets Auth Token here'

    # We recommend storing your secret keys in environment variables instead---it's safer!
    auth_id = ENV['SMARTY_AUTH_ID']
    auth_token = ENV['SMARTY_AUTH_TOKEN']

    credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)

    # The appropriate license values to be used for your subscriptions
    # can be found on the Subscriptions page of the account dashboard.
    # https://www.smartystreets.com/docs/cloud/licensing
    client = SmartyStreets::ClientBuilder.new(credentials).with_licenses(['us-core-cloud'])
                 .build_us_street_api_client
    batch = SmartyStreets::Batch.new

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-street-api

    batch.add(Lookup.new)
    batch[0].input_id = '8675309'  # Optional ID from your system
    batch[0].addressee = 'John Doe'
    batch[0].street = '1600 amphitheatre parkway'
    batch[0].street2 = 'second star to the right'
    batch[0].secondary = 'APT 2'
    batch[0].urbanization = ''  # Only applies to Puerto Rico addresses
    batch[0].lastline = 'Mountain view, California'
    batch[0].zipcode = '21229'
    batch[0].candidates = 3
    batch[0].match = Lookup.INVALID # "invalid" is the most permissive match,
                                      # this will always return at least one result even if the address is invalid.
                                      # Refer to the documentation for additional Match Strategy options.

    batch.add(Lookup.new('1 Rosedale, Baltimore, Maryland')) # Freeform addresses work too.
    batch[1].candidates = 10 # Allows up to ten possible matches to be returned (default is 1).

    batch.add(Lookup.new('123 Bogus Street, Pretend Lake, Oklahoma'))

    batch.add(Lookup.new)
    batch[3].street = '1 Infinite Loop'
    batch[3].zipcode = '95014' # You can just input the street and ZIP if you want.

    begin
      client.send_batch(batch)
    rescue SmartyStreets::SmartyError => err
      puts err
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