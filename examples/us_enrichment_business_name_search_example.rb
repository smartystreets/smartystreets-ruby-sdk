require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/basic_auth_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_enrichment/lookup'

class USEnrichmentBusinessNameSearchExample
  def run
    id = ENV['SMARTY_AUTH_ID']
    token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::BasicAuthCredentials.new(id, token)

    client = SmartyStreets::ClientBuilder.new(credentials).build_us_enrichment_api_client

    business_name = "delta air"

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.business_name = business_name
    lookup.city = "atlanta"

    begin
      summary_results = client.send_business_lookup(lookup)
    rescue SmartyStreets::SmartyError => err
      puts err
      return
    end

    if summary_results.nil? || summary_results.empty?
      puts "No response returned for business-name search"
      return
    end

    summary = summary_results[0]
    if summary.businesses.nil? || summary.businesses.empty?
      puts "No businesses found for this business name search"
      return
    end

    puts "Summary results for BusinessName: #{business_name}"
    summary.businesses.each do |biz|
      puts "  - #{biz.company_name} (ID: #{biz.business_id})"
    end

    first = summary.businesses[0]
    puts
    puts "Fetching details for business: #{first.company_name} (ID: #{first.business_id})"

    begin
      detail_result = client.send_business_detail_lookup(first.business_id)
    rescue SmartyStreets::SmartyError => err
      puts err
      return
    end

    if detail_result.nil?
      puts "No detail result returned"
      return
    end

    puts
    puts "Detail result:"
    puts "  smarty_key: #{detail_result.smarty_key}"
    puts "  data_set_name: #{detail_result.data_set_name}"
    puts "  business_id: #{detail_result.business_id}"
    attrs = detail_result.attributes
    return if attrs.nil?
    attrs.instance_variables.each do |var|
      value = attrs.instance_variable_get(var)
      next if value.nil?
      puts "  #{var.to_s.delete('@')}: #{value}"
    end
  end
end

example = USEnrichmentBusinessNameSearchExample.new
example.run
