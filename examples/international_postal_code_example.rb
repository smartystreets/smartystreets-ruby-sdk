require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/international_postal_code/lookup'

class InternationalPostalCodeExample
  Lookup = SmartyStreets::InternationalPostalCode::Lookup

  def run
    # We recommend storing your secret keys in environment variables instead---it's safer!
    # key = ENV['SMARTY_AUTH_WEB']
    # referer = ENV['SMARTY_AUTH_REFERER']
    # credentials = SmartyStreets::SharedCredentials.new(key, referer)

    id = ENV['SMARTY_AUTH_ID_DEV']
    token = ENV['SMARTY_AUTH_TOKEN_DEV']
    credentials = SmartyStreets::StaticCredentials.new(id, token)

    client = SmartyStreets::ClientBuilder.new(credentials).with_base_url("https://international-postal-code.api.rivendell.smartyops.net/lookup").build_international_postal_code_api_client

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/international-postal-code-api

    lookup = Lookup.new
    lookup.input_id = 'ID-8675309'
    lookup.locality = 'Sao Paulo'
    lookup.administrative_area = 'SP'
    lookup.country = 'Brazil'
    lookup.postal_code = '02516'

    results = client.send_lookup(lookup)

    puts 'Results:'
    puts
    results.each_with_index do |candidate, c|
      puts "Candidate: #{c}"
      display(candidate.input_id)
      display(candidate.country_iso_3)
      display(candidate.locality)
      display(candidate.dependent_locality)
      display(candidate.double_dependent_locality)
      display(candidate.sub_administrative_area)
      display(candidate.administrative_area)
      display(candidate.super_administrative_area)
      display(candidate.postal_code)
      puts
    end
  end

  def display(value)
    if value && value.length > 0
      puts "  #{value}"
    end
  end
end

InternationalPostalCodeExample.new.run


