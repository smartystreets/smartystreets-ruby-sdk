require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/basic_auth_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_street/lookup'
require '../lib/smartystreets_ruby_sdk/us_street/match_type'

class USStreetIANATimezoneExample
  def run
    # For client-side requests (browser/mobile), use this code:
    # key = ENV['SMARTY_AUTH_WEB']
    # referer = ENV['SMARTY_AUTH_REFERER']
    # credentials = SmartyStreets::SharedCredentials.new(key, referer)

    # For server-to-server requests, use this code:
    id = ENV['SMARTY_AUTH_ID']
    token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::BasicAuthCredentials.new(id, token)

    client = SmartyStreets::ClientBuilder.new(credentials)
      .with_feature_iana_time_zone()
      .build_us_street_api_client

    lookup = SmartyStreets::USStreet::Lookup.new
    lookup.street = "1 Rosedale"
    lookup.secondary = "APT 2"
    lookup.city = "Baltimore"
    lookup.state = "MD"
    lookup.zipcode = "21229"
    lookup.match = SmartyStreets::USStreet::MatchType::ENHANCED

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

    puts "IANA Time Zone: #{first_candidate.metadata.iana_time_zone}"
    puts "IANA UTC Offset: #{first_candidate.metadata.iana_utc_offset}"
    puts "IANA Obeys DST: #{first_candidate.metadata.iana_obeys_dst}"
  end
end

example = USStreetIANATimezoneExample.new
example.run
