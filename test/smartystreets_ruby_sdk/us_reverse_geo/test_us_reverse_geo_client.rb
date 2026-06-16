require 'minitest/autorun'
require_relative '../../../lib/smartystreets_ruby_sdk/us_reverse_geo'
require_relative '../../../lib/smartystreets_ruby_sdk/exceptions'
require_relative '../../../lib/smartystreets_ruby_sdk/response'

class TestUSReverseGeoClient < Minitest::Test
  Client = SmartyStreets::USReverseGeo::Client
  Lookup = SmartyStreets::USReverseGeo::Lookup
  SourceType = SmartyStreets::USReverseGeo::SourceType
  Response = SmartyStreets::Response

  def test_sending_single_fully_populated_lookup
    sender = RequestCapturingSender.new
    serializer = FakeDeserializer.new({"results"=>[{}]})
    client = Client.new(sender, serializer)
    lookup = Lookup.new(44.888888888, -111.111111111, "")

    client.send(lookup)

    assert_equal('44.88888889', sender.request.parameters['latitude'])
    assert_equal('-111.11111111', sender.request.parameters['longitude'])
  end

  def test_source_omitted_when_not_set
    sender = RequestCapturingSender.new
    serializer = FakeDeserializer.new({"results"=>[{}]})
    client = Client.new(sender, serializer)

    client.send(Lookup.new(44.888888888, -111.111111111))

    assert_nil(sender.request.parameters['source'])
  end

  def test_source_all_sent_as_all
    sender = RequestCapturingSender.new
    serializer = FakeDeserializer.new({"results"=>[{}]})
    client = Client.new(sender, serializer)

    client.send(Lookup.new(44.888888888, -111.111111111, SourceType::ALL))

    assert_equal('all', sender.request.parameters['source'])
  end

  def test_source_postal_sent_as_postal
    sender = RequestCapturingSender.new
    serializer = FakeDeserializer.new({"results"=>[{}]})
    client = Client.new(sender, serializer)

    client.send(Lookup.new(44.888888888, -111.111111111, SourceType::POSTAL))

    assert_equal('postal', sender.request.parameters['source'])
  end

  def test_deserialize_called_with_response_body
    response = Response.new('Hello, World!', 0)

    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new({"results"=>[{}]})
    client = Client.new(sender, deserializer)

    client.send(Lookup.new('1', '2', ''))

    assert_equal(response.payload, deserializer.input)
  end
end