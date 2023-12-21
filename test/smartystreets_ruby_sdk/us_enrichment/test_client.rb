require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/exceptions'
require './test/mocks/request_capturing_sender'
require './test/mocks/fake_serializer'
require './test/mocks/fake_deserializer'
require './test/mocks/mock_sender'
require './test/mocks/mock_exception_sender'
require './lib/smartystreets_ruby_sdk/us_enrichment/client'

class TestStreetClient < Minitest::Test

  def test_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    client.send_property_financial_lookup("xxx")
    assert_equal("/xxx/property/financial", sender.request.url_prefix)

    client.send_property_principal_lookup("123")
    assert_equal("/123/property/principal", sender.request.url_prefix)
  end
end