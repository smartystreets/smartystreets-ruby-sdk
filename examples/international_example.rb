require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/international_street/lookup'

class InternationalExample
  Lookup = SmartyStreets::InternationalStreet::Lookup

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

    # The appropriate license values to be used for your subscriptions
    # can be found on the Subscriptions page of the account dashboard.
    # https://www.smartystreets.com/docs/cloud/licensing
    client = SmartyStreets::ClientBuilder.new(credentials).with_licenses(['international-global-plus-cloud'])
                 .build_international_street_api_client

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/international-street-api

    lookup = Lookup.new()
    lookup.inputId = 'ID-8675309' # Optional ID from your system
    lookup.geocode = true # Must be expressly set to get latitude and longitude.
    lookup.organization = 'John Doe'
    lookup.address1 = "Rua Padre Antonio D'Angelo 121"
    lookup.address2 = 'Casa Verde'
    lookup.locality = 'Sao Paulo'
    lookup.administrative_area = 'SP'
    lookup.country = 'Brazil'
    lookup.postal_code = '02516-050'

    candidates = client.send(lookup) # The candidates are also stored in the lookup's 'result' field.

    first_candidate = candidates[0]
    puts "Input ID: #{first_candidate.input_id}"
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
