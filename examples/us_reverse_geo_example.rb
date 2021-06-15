require 'smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_reverse_geo/lookup'

class USReverseGeoExample
  Lookup = SmartyStreets::USReverseGeo::Lookup

  def run
    auth_id = 'Your SmartyStreets Auth ID here'
    auth_token = 'Your SmartyStreets Auth Token here'

    # We recommend storing your secret keys in environment variables instead---it's safer!
    # auth_id = ENV['SMARTY_AUTH_ID']
    # auth_token = ENV['SMARTY_AUTH_TOKEN']

    credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)

    # The appropriate license values to be used for your subscriptions
    # can be found on the Subscriptions page of the account dashboard.
    # https://www.smartystreets.com/docs/cloud/licensing
    client = SmartyStreets::ClientBuilder.new(credentials).with_licenses(['us-reverse-geocoding-cloud'])
                 .build_us_reverse_geo_api_client

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-reverse-geo-api#http-request-input-fields

    lookup = Lookup.new(40.111111, -111.111111)

    response = client.send(lookup)
    result = response.results[0]

    coordinate = result.coordinate
    puts "Latitude: #{coordinate.latitude}"
    puts "Longitude: #{coordinate.longitude}\n"

    puts "Distance: #{result.distance}\n"

    address = result.address
    puts "Street: #{address.street}"
    puts "City: #{address.city}"
    puts "State Abbreviation: #{address.state_abbreviation}"
    puts "ZIP Code: #{address.zipcode}"
    puts "License: #{coordinate.get_license}"
  end
end

USReverseGeoExample.new.run
