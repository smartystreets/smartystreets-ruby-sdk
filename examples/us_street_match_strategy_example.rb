require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/basic_auth_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/batch'
require '../lib/smartystreets_ruby_sdk/us_street/lookup'
require '../lib/smartystreets_ruby_sdk/us_street/match_type'

class USStreetLookupsWithMatchStrategyExample
  Lookup = SmartyStreets::USStreet::Lookup
  MatchType = SmartyStreets::USStreet::MatchType

  def run
    # We recommend storing your secret keys in environment variables instead---it's safer!
    id = ENV['SMARTY_AUTH_ID']
    token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::BasicAuthCredentials.new(id, token)
    client = SmartyStreets::ClientBuilder.new(credentials).build_us_street_api_client

    # Each address is run through all three match strategies so you can compare how
    # 'strict', 'enhanced', and 'invalid' each handle a valid, an invalid, and an
    # ambiguous address.
    #   - strict:   only returns candidates that are valid, mailable addresses.
    #   - enhanced: returns a more comprehensive dataset (requires a US Core or Rooftop license).
    #   - invalid:  most permissive; always returns at least one candidate (a best-guess standardization).
    # Documentation for input fields: https://smartystreets.com/docs/cloud/us-street-api
    addresses = [
      ['valid (real, deliverable)',    '1600 Amphitheatre Pkwy', 'Mountain View', 'CA', '94043'],
      ['invalid (no such address)',    '9999 W 1150 S',          'Provo',         'UT', '84601'],
      ['ambiguous (missing ZIP/unit)', '1 Rosedale St',          'Baltimore',     'MD', '']
    ]
    strategies = [MatchType::STRICT, MatchType::ENHANCED, MatchType::INVALID]

    batch = SmartyStreets::Batch.new
    cases = [] # parallel metadata for each lookup, in the order they are added to the batch

    addresses.each do |label, street, city, state, zipcode|
      strategies.each do |strategy|
        lookup = Lookup.new
        lookup.street = street
        lookup.city = city
        lookup.state = state
        lookup.zipcode = zipcode
        lookup.match = strategy
        lookup.candidates = 10 # allow ambiguous addresses to return more than one match
        batch.add(lookup)
        cases << [label, "#{street}, #{city}, #{state}", strategy]
      end
    end

    begin
      client.send_batch(batch)
    rescue SmartyStreets::SmartyError => err
      puts err
      return
    end

    last_address = nil
    batch.each_with_index do |lookup, i|
      label, address_display, strategy = cases[i]

      unless address_display == last_address
        puts "\n" + ('=' * 70)
        puts " Address: #{address_display}  [#{label}]"
        puts('=' * 70)
        last_address = address_display
      end

      candidates = lookup.result
      puts "\n--- '#{strategy}' strategy ---"

      if candidates.empty?
        puts '  0 candidates - no match returned under this strategy.'
        next
      end

      puts "  #{candidates.length} candidate(s):"
      candidates.each do |candidate|
        puts "    [#{candidate.candidate_index}] #{candidate.delivery_line_1}  #{candidate.last_line}"
      end
    end
  end
end

USStreetLookupsWithMatchStrategyExample.new.run
