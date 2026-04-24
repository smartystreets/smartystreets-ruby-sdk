require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/basic_auth_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_enrichment/lookup'

class USEnrichmentEtagExample
  def run
    id = ENV['SMARTY_AUTH_ID']
    token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::BasicAuthCredentials.new(id, token)

    @client = SmartyStreets::ClientBuilder.new(credentials).build_us_enrichment_api_client
    smarty_key = "1962995076"

    business_id = exercise_summary_etag(smarty_key)
    return if business_id.nil?

    exercise_detail_etag(business_id)
  end

  def exercise_summary_etag(smarty_key)
    puts "=== Business.Summary ETag round trip ==="

    first = SmartyStreets::USEnrichment::Lookup.new(smarty_key, 'business')
    begin
      initial_results = @client.send_business_lookup(first)
    rescue SmartyStreets::SmartyError => err
      puts "  Initial Summary call failed: #{err.message}"
      return nil
    end
    captured_etag = first.response_etag
    puts "  Call 1 (no Etag): captured Etag=#{display(captured_etag)}, results=#{initial_results.nil? ? 0 : initial_results.length}"

    if captured_etag.nil? || captured_etag.empty?
      puts "  Server did not return an Etag header; skipping conditional calls."
      return first_business_id(initial_results)
    end

    second = SmartyStreets::USEnrichment::Lookup.new(smarty_key, 'business')
    second.request_etag = captured_etag
    begin
      @client.send_business_lookup(second)
      puts "  Call 2 (matching Etag): 200 - server did NOT honor the conditional. Etag=#{display(second.response_etag)}"
    rescue SmartyStreets::NotModifiedInfo => ex
      puts "  Call 2 (matching Etag): 304 NotModifiedInfo - caller treats this as cache-valid. Refreshed Etag=#{display(ex.response_etag)}"
    rescue SmartyStreets::SmartyError => err
      puts "  Call 2 unexpected failure: #{err.class}: #{err.message}"
      return nil
    end

    third = SmartyStreets::USEnrichment::Lookup.new(smarty_key, 'business')
    third.request_etag = captured_etag + "X"
    begin
      @client.send_business_lookup(third)
      puts "  Call 3 (mutated Etag): 200 as expected. Etag=#{display(third.response_etag)}"
    rescue SmartyStreets::NotModifiedInfo
      puts "  Call 3 (mutated Etag): 304 - UNEXPECTED. Server treated a different Etag as matching."
    rescue SmartyStreets::SmartyError => err
      puts "  Call 3 unexpected failure: #{err.class}: #{err.message}"
    end

    first_business_id(initial_results)
  end

  def exercise_detail_etag(business_id)
    puts
    puts "=== Business.Detail ETag round trip (businessId: #{business_id}) ==="

    first = SmartyStreets::USEnrichment::BusinessDetailLookup.new(business_id)
    begin
      initial_result = @client.send_business_detail_lookup(first)
    rescue SmartyStreets::SmartyError => err
      puts "  Initial Detail call failed: #{err.message}"
      return
    end
    captured_etag = first.response_etag
    puts "  Call 1 (no Etag): captured Etag=#{display(captured_etag)}, businessId=#{initial_result ? initial_result.business_id : '<nil>'}"

    if captured_etag.nil? || captured_etag.empty?
      puts "  Server did not return an Etag header; skipping conditional calls."
      return
    end

    second = SmartyStreets::USEnrichment::BusinessDetailLookup.new(business_id)
    second.request_etag = captured_etag
    begin
      @client.send_business_detail_lookup(second)
      puts "  Call 2 (matching Etag): 200 - server did NOT honor the conditional. Etag=#{display(second.response_etag)}"
    rescue SmartyStreets::NotModifiedInfo => ex
      puts "  Call 2 (matching Etag): 304 NotModifiedInfo - caller treats this as cache-valid. Refreshed Etag=#{display(ex.response_etag)}"
    rescue SmartyStreets::SmartyError => err
      puts "  Call 2 unexpected failure: #{err.class}: #{err.message}"
      return
    end

    third = SmartyStreets::USEnrichment::BusinessDetailLookup.new(business_id)
    third.request_etag = captured_etag + "X"
    begin
      @client.send_business_detail_lookup(third)
      puts "  Call 3 (mutated Etag): 200 as expected. Etag=#{display(third.response_etag)}"
    rescue SmartyStreets::NotModifiedInfo
      puts "  Call 3 (mutated Etag): 304 - UNEXPECTED. Server treated a different Etag as matching."
    rescue SmartyStreets::SmartyError => err
      puts "  Call 3 unexpected failure: #{err.class}: #{err.message}"
    end
  end

  def first_business_id(summary_results)
    return nil if summary_results.nil? || summary_results.empty?
    first = summary_results[0]
    return nil if first.businesses.nil? || first.businesses.empty?
    first.businesses[0].business_id
  end

  def display(value)
    value.nil? || value.empty? ? "<none>" : value
  end
end

example = USEnrichmentEtagExample.new
example.run
