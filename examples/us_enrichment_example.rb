require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/basic_auth_credentials'
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
    credentials = SmartyStreets::BasicAuthCredentials.new(id, token)

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

    puts "Lookup Successful! Here is the result:"
    puts

    response = result[0]
    attrs = response.attributes

    puts "Smarty Key: #{response.smarty_key}"
    puts "Data Set: #{response.data_set_name}/#{response.data_subset_name}"
    puts "ETag: #{response.etag}"
    puts

    puts "Property Address:"
    puts "\tFull Address: #{attrs.property_address_full}"
    puts "\tCity: #{attrs.property_address_city}"
    puts "\tState: #{attrs.property_address_state}"
    puts "\tZIP: #{attrs.property_address_zipcode}"
    puts

    puts "Owner:"
    puts "\tName: #{attrs.owner_full_name}"
    puts "\tOccupancy: #{attrs.owner_occupancy_status}"
    puts

    puts "Property Details:"
    puts "\tLand Use: #{attrs.land_use_standard}"
    puts "\tYear Built: #{attrs.year_built}"
    puts "\tBuilding Sqft: #{attrs.building_sqft}"
    puts "\tLot Sqft: #{attrs.lot_sqft}"
    puts "\tAcres: #{attrs.acres}"
    puts "\tBathrooms: #{attrs.bathrooms_total}"
    puts "\tBedrooms: #{attrs.bedrooms}"
    puts "\tStories: #{attrs.stories_number}"
    puts "\tFireplace: #{attrs.fireplace}"
    puts "\tGarage: #{attrs.garage}"
    puts

    puts "Assessment:"
    puts "\tAssessed Value: #{attrs.assessed_value}"
    puts "\tTotal Market Value: #{attrs.total_market_value}"
    puts "\tTax Year: #{attrs.tax_assess_year}"
    puts "\tTax Billed: #{attrs.tax_billed_amount}"
    puts

    puts "Location:"
    puts "\tCounty: #{attrs.situs_county}"
    puts "\tLatitude: #{attrs.latitude}"
    puts "\tLongitude: #{attrs.longitude}"
    puts "\tElevation (ft): #{attrs.elevation_feet}"
    puts

    unless attrs.financial_history.nil? || attrs.financial_history.empty?
      puts "Financial History (#{attrs.financial_history.length} entries):"
      attrs.financial_history.each_with_index do |entry, i|
        puts "\tEntry #{i + 1}:"
        puts "\t\tDocument Type: #{entry.document_type_description}"
        puts "\t\tLender: #{entry.lender_name}"
        puts "\t\tMortgage Amount: #{entry.mortgage_amount}"
        puts "\t\tMortgage Type: #{entry.mortgage_type}"
        puts "\t\tRecording Date: #{entry.mortgage_recording_date}"
      end
    end
  end
end

example = USEnrichmentAddressExample.new
example.run
