# frozen_string_literal: true

require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_extract/lookup'
require '../lib/smartystreets_ruby_sdk/us_street/match_type'

class USExtractExample
  Lookup = SmartyStreets::USExtract::Lookup

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

    client = SmartyStreets::ClientBuilder.new(credentials).build_us_extract_api_client

    text = "Here is some text.\r\nMy address is 3785 Las Vegas Av." \
           "\r\nLos Vegas, Nevada." \
           "\r\nMeet me at 1 Rosedale Baltimore Maryland, not at 123 Phony Street, Boise Idaho." \
           "\r\nAlso, here's a non-postal that will show up with enhanced match! 808 County Road 408 Brady, Tx. " \
           'is a beautiful place!'

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-extract-api

    lookup = Lookup.new(text)
    lookup.aggressive = true
    lookup.addresses_have_line_breaks = false
    lookup.addresses_per_line = 2
    lookup.match = SmartyStreets::USStreet::MatchType::ENHANCED

    # lookup.add_custom_parameter('parameter', 'value')

    result = client.send(lookup)

    metadata = result.metadata
    puts "Found #{metadata.address_count} addresses."
    puts "#{metadata.verified_count} of them were valid."
    puts

    addresses = result.addresses

    puts "Addresses: \r\n**********************\r\n"
    addresses.each do |address|
      puts "\"#{address.text}\"\n\n"
      puts "Verified? #{address.verified}"
      if address.candidates.any?
        puts("\nMatches:")

        address.candidates.each do |candidate|
          puts candidate.delivery_line_1
          puts candidate.last_line
          puts
        end

      else
        puts
      end

      puts "**********************\n"
    end
  end
end

USExtractExample.new.run
