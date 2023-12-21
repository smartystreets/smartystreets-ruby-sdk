require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'

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
    begin
      result = client.send_property_financial_lookup("765613032")
    #   result = client.send_property_principal_lookup("765613032")
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
