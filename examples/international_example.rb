require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/client_builder'
require 'smartystreets_ruby_sdk/international_street/lookup'

class InternationalExample
  Lookup = SmartyStreets::InternationalStreet::Lookup

  def run
    auth_id = ENV['SMARTY_AUTH_ID'] # We recommend storing your keys in environment variables
    auth_token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)
    client = SmartyStreets::ClientBuilder.new(credentials).build_international_street_api_client

    lookup = Lookup.new("Rua Padre Antonio D'Angelo 121 Casa Verde, Sao Paulo", 'Brazil')
    lookup.geocode = true # Must be expressly set to get latitude and longitude.

    candidates = client.send(lookup) # The candidates are also stored in the lookup's 'result' field.

    first_candidate = candidates[0]
    puts "Address is #{first_candidate.analysis.verification_status}"
    puts "Address precision: #{first_candidate.analysis.address_precision}\n\n"
    puts "First Line: #{first_candidate.address1}"
    puts "Second Line: #{first_candidate.address2}"
    puts "Third Line: #{first_candidate.address3}"
    puts "Fourth Line: #{first_candidate.address4}"
    puts "Latitude: #{first_candidate.metadata.latitude}"
    puts "Longitude: #{first_candidate.metadata.longitude}"
  end
end

InternationalExample.new.run
