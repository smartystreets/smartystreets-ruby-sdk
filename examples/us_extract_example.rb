require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/client_builder'
require 'smartystreets_ruby_sdk/us_extract/lookup'

class USExtractExample
  Lookup = SmartyStreets::USExtract::Lookup

  def run
    auth_id = ENV['SMARTY_AUTH_ID'] # We recommend storing your keys in environment variables
    auth_token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)

    client = SmartyStreets::ClientBuilder.new(credentials).build_us_extract_api_client

    text = "Here is some text.\r\nMy address is 3785 Las Vegs Av." \
           "\r\nLos Vegas, Nevada." \
           "\r\nMeet me at 1 Rosedale Baltimore Maryland, not at 123 Phony Street, Boise Idaho."

    lookup = Lookup.new(text)

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
