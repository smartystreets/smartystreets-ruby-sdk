require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_reverse_geo/lookup'

class USReverseGeoExample
  Lookup = SmartyStreets::USReverseGeo::Lookup

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
    client = SmartyStreets::ClientBuilder.new(credentials).with_licenses(['us-reverse-geocoding-cloud'])
                 .build_us_reverse_geo_api_client

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-reverse-geo-api#http-request-input-fields

    lookup = Lookup.new(40.111111, -111.111111)

    # lookup.add_custom_parameter('parameter', 'value')

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
