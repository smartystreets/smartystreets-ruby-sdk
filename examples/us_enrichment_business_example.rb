require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/basic_auth_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_enrichment/lookup'

class USEnrichmentBusinessExample
  def run
    id = ENV['SMARTY_AUTH_ID']
    token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::BasicAuthCredentials.new(id, token)

    client = SmartyStreets::ClientBuilder.new(credentials).build_us_enrichment_api_client

    smarty_key = "1962995076"

    begin
      summary_results = client.send_business_lookup(smarty_key)
    rescue SmartyStreets::SmartyError => err
      puts err
      return
    end

    if summary_results.nil? || summary_results.empty?
      puts "No response returned for SmartyKey #{smarty_key}"
      return
    end

    summary = summary_results[0]
    if summary.businesses.nil? || summary.businesses.empty?
      puts "SmartyKey #{smarty_key} has no business tenants"
      return
    end

    puts "Summary results for SmartyKey: #{smarty_key}"
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

example = USEnrichmentBusinessExample.new
example.run
