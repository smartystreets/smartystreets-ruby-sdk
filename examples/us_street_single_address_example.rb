require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/us_street/client_builder'
require 'smartystreets_ruby_sdk/us_street/lookup'

class USStreetSingleAddressExample
  def run
  auth_id = ENV['SMARTY_AUTH_ID']  # We recommend storing your keys in environment variables
  auth_token = ENV['SMARTY_AUTH_TOKEN']
  credentials = StaticCredentials.new(auth_id, auth_token)

  client = ClientBuilder.new(credentials).build

  lookup = Lookup.new
  lookup.street = "1600 Amphitheatre Pkwy"
  lookup.city = "Mountain View"
  lookup.state = "CA"

  begin
      client.send_lookup(lookup)
  rescue SmartyException => err
    print(err)
    return
  end

  result = lookup.result

  if not result
      print("No candidates. This means the address is not valid.")
  return
  end

  first_candidate = result[0]

  print("Address is valid. (There is at least one candidate)\n")
  print("ZIP Code: " + first_candidate.components.zipcode)
  print("County: " + first_candidate.metadata.county_name)
  print("Latitude: {}".format(first_candidate.metadata.latitude))
  print("Longitude: {}".format(first_candidate.metadata.longitude))
  end
end

example = USStreetSingleAddressExample.new
example.run