require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_street/lookup'
require '../lib/smartystreets_ruby_sdk/us_street/match_type'

class USStreetComponentAnalysisExample
  def run
    # For client-side requests (browser/mobile), use this code:
    # key = ENV['SMARTY_AUTH_WEB']
    # referer = ENV['SMARTY_AUTH_REFERER']
    # credentials = SmartyStreets::SharedCredentials.new(key, referer)

    # For server-to-server requests, use this code:
    id = ENV['SMARTY_AUTH_ID']
    token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::StaticCredentials.new(id, token)

    client = SmartyStreets::ClientBuilder.new(credentials)
      .with_feature_component_analysis() #  To add component analysis feature you need to specify when you create the client.
      .build_us_street_api_client

    lookup = SmartyStreets::USStreet::Lookup.new
    lookup.street = "1 Rosedale"
    lookup.secondary = "APT 2"
    lookup.city = "Baltimore"
    lookup.state = "MD"
    lookup.zipcode = "21229"
    lookup.match = SmartyStreets::USStreet::MatchType::ENHANCED # Enhanced matching is required to return component analysis results.

    begin
      client.send_lookup(lookup)
    rescue SmartyStreets::SmartyError => err
      puts err
      return
    end

    result = lookup.result

    if result.empty?
      return
    end

    first_candidate = result[0]

    # Here is an example of how to access the result of component analysis.
    puts "Primary Number: "
    puts "\tStatus: #{first_candidate.analysis.components.secondary_number.status}"
    puts "\tChange: #{first_candidate.analysis.components.secondary_number.change}"
  end
end

example = USStreetComponentAnalysisExample.new
example.run
