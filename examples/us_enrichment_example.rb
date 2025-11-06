require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_enrichment/lookup'

class USEnrichmentAddressExample
  def run
    # key = 'Your SmartyStreets Auth Key here'
    # referer = 'Your host name here'
    # We recommend storing your secret keys in environment variables instead---it's safer!
    # key = ENV['SMARTY_AUTH_WEB']
    # referer = ENV['SMARTY_AUTH_REFERER']
    # credentials = SmartyStreets::SharedCredentials.new(key, referer)

    id = ENV['SMARTY_AUTH_ID']
    token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::StaticCredentials.new(id, token)

    # The appropriate license values to be used for your subscriptions
    # can be found on the Subscriptions page of the account dashboard.
    # https://www.smartystreets.com/docs/cloud/licensing
    #
    # To try with a proxy, add this method call at the end of the chain
    #   with_proxy('localhost', 8080, 'proxyUser', 'proxyPassword')
    client = SmartyStreets::ClientBuilder.new(credentials).
             build_us_enrichment_api_client
    result = nil

    # Create a new lookup instance to search with address components
    lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.smarty_key = "87844267"
    lookup.street = "56 Union Ave"
    lookup.city = "Somerville"
    lookup.state = "NJ"
    lookup.zipcode = "08876"
    lookup.features = "financial"
    # lookup.etag = "AUBAGDQDAIGQYCYC"

    # lookup.add_custom_parameter('parameter', 'value')

    # Or, create a freeform lookup to search using a single line address
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup.freeform = "56 Union Ave Somerville NJ 08876"

    

    begin
      # Send a lookup with a smarty key using the line below
      # result = client.send_property_principal_lookup("325023201")

      # Uncomment the following lines to perform other types of lookups:
      result = client.send_property_principal_lookup(lookup) # Using address components
      # result = client.send_property_principal_lookup(freeform_lookup) # Using freeform address
       
      # Access the other Enrichment datasets using the below functions. All of these functions can take a lookup or a smartykey
      # result = client.send_property_financial_lookup("325023201")
      # result = client.send_geo_reference_lookup("325023201")
      # result = client.send_risk_lookup("325023201")
      # result = client.send_secondary_lookup("325023201")
      # result = client.send_secondary_count_lookup("325023201")

    rescue SmartyStreets::SmartyError => err
      puts err
      return
    end

    if result.empty?
      puts 'No results. This means the smartykey is not valid.'
      return
    end

    puts "Lookup Successful! Here is the result: "
    puts result[0].inspect
  end
end

example = USEnrichmentAddressExample.new
example.run
