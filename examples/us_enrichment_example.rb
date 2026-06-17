require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/basic_auth_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_enrichment/lookup'

class USEnrichmentAddressExample
  # SmartyKey used for the non-property datasets. The property example uses a
  # separate key because its address happens to have rich financial history.
  SHARED_SMARTY_KEY = '325023201'

  def run
    id = ENV['SMARTY_AUTH_ID']
    token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::BasicAuthCredentials.new(id, token)

    # The appropriate license values to be used for your subscriptions
    # can be found on the Subscriptions page of the account dashboard.
    # https://www.smartystreets.com/docs/cloud/licensing
    #
    # To try with a proxy, add this method call at the end of the chain
    #   with_proxy('localhost', 8080, 'proxyUser', 'proxyPassword')
    @client = SmartyStreets::ClientBuilder.new(credentials).
      build_us_enrichment_api_client

    property_principal_example
    geo_reference_example
    secondary_example
    secondary_count_example
  end

  # ---------- property / principal ----------
  def property_principal_example
    banner 'property / principal'

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.smarty_key = '87844267'
    lookup.street = '56 Union Ave'
    lookup.city = 'Somerville'
    lookup.state = 'NJ'
    lookup.zipcode = '08876'
    lookup.features = 'financial'
    # lookup.request_etag = 'AUBAGDQDAIGQYCYC'
    # lookup.add_custom_parameter('parameter', 'value')

    results = invoke { @client.send_property_principal_lookup(lookup) }
    return if results.nil? || results.empty?

    response = results[0]
    attrs = response.attributes
    puts "Smarty Key: #{response.smarty_key}"
    puts "Data Set: #{response.data_set_name}/#{response.data_subset_name}"
    puts "ETag: #{lookup.response_etag}"
    puts
    puts 'Property Address:'
    puts "  Full Address: #{attrs.property_address_full}"
    puts "  City: #{attrs.property_address_city}, #{attrs.property_address_state} #{attrs.property_address_zipcode}"
    puts "Owner: #{attrs.owner_full_name}"
    puts "Year Built: #{attrs.year_built}  Building Sqft: #{attrs.building_sqft}"
    puts "Assessed Value: #{attrs.assessed_value}  Total Market Value: #{attrs.total_market_value}"
    unless attrs.financial_history.nil? || attrs.financial_history.empty?
      puts "Financial History entries: #{attrs.financial_history.length}"
    end
  end

  # ---------- geo-reference ----------
  def geo_reference_example
    banner 'geo-reference'

    lookup = SmartyStreets::USEnrichment::Lookup.new(SHARED_SMARTY_KEY)
    results = invoke { @client.send_geo_reference_lookup(lookup) }
    return if results.nil? || results.empty?

    response = results[0]
    attrs = response.attributes
    puts "Smarty Key: #{response.smarty_key}"
    puts "Data Set: #{response.data_set_name} (version: #{response.data_set_version})"
    puts "Matched Address: #{response.matched_address}"
    puts "ETag: #{lookup.response_etag}"
    puts
    print_object('Census Block', attrs.census_block)
    print_object('Census County Division', attrs.census_county_division)
    print_object('Census Tract', attrs.census_tract)
    print_object('Core Based Stat Area', attrs.core_based_stat_area)
    print_object('Place', attrs.place)
  end

  # ---------- secondary ----------
  def secondary_example
    banner 'secondary'

    lookup = SmartyStreets::USEnrichment::Lookup.new(SHARED_SMARTY_KEY)
    results = invoke { @client.send_secondary_lookup(lookup) }
    return if results.nil? || results.empty?

    response = results[0]
    puts "Smarty Key: #{response.smarty_key}"
    puts "Matched Address: #{response.matched_address}"
    puts "ETag: #{lookup.response_etag}"
    puts
    print_object('Root Address', response.root_address)

    unless response.aliases.nil? || response.aliases.empty?
      puts "\nAliases (#{response.aliases.length}):"
      response.aliases.each_with_index { |a, i| puts "  [#{i}] #{one_liner(a)}" }
    end

    unless response.secondaries.nil? || response.secondaries.empty?
      puts "\nSecondaries (#{response.secondaries.length}):"
      response.secondaries.first(5).each_with_index { |s, i| puts "  [#{i}] #{one_liner(s)}" }
      puts "  ...#{response.secondaries.length - 5} more" if response.secondaries.length > 5
    end
  end

  # ---------- secondary / count ----------
  def secondary_count_example
    banner 'secondary / count'

    lookup = SmartyStreets::USEnrichment::Lookup.new(SHARED_SMARTY_KEY)
    results = invoke { @client.send_secondary_count_lookup(lookup) }
    return if results.nil? || results.empty?

    response = results[0]
    puts "Smarty Key: #{response.smarty_key}"
    puts "Matched Address: #{response.matched_address}"
    puts "Count: #{response.count}"
    puts "ETag: #{lookup.response_etag}"
  end

  # ---------- helpers ----------
  def banner(title)
    puts
    puts "=== #{title} ==="
  end

  def invoke
    yield
  rescue SmartyStreets::SmartyError => err
    puts "  Lookup failed: #{err.class}: #{err.message}"
    nil
  end

  def print_object(label, obj)
    puts "#{label}:"
    if obj.nil?
      puts '  (none)'
      return
    end
    obj.instance_variables.each do |var|
      value = obj.instance_variable_get(var)
      next if value.nil?
      puts "  #{var.to_s.delete('@')}: #{value}"
    end
  end

  def one_liner(obj)
    obj.instance_variables.filter do |var|
      value = obj.instance_variable_get(var)
      "#{var.to_s.delete('@')}=#{value}" unless value.nil?
    end.join(' ')
  end
end

USEnrichmentAddressExample.new.run
