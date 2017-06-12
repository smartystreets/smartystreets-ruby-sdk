require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_autocomplete/client'
require './lib/smartystreets_ruby_sdk/us_autocomplete/lookup'
require './lib/smartystreets_ruby_sdk/response'

class TestAutocompleteClient < Minitest::Test
  Client = SmartyStreets::USAutocomplete::Client
  Lookup = SmartyStreets::USAutocomplete::Lookup
  Response = SmartyStreets::Response

  def test_sending_prefix_only_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    client.send(Lookup.new('1'))

    assert_equal('1', sender.request.parameters['prefix'])
  end

  def test_sending_fully_populated_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.max_suggestions = 2
    lookup.add_city_filter('3')
    lookup.add_state_filter('4')
    lookup.add_state_filter('4.5')
    lookup.add_prefer('5')
    lookup.geolocate_type = SmartyStreets::USAutocomplete::GeolocationType::STATE

    client.send(lookup)

    assert_equal('1', sender.request.parameters['prefix'])
    assert_equal('2', sender.request.parameters['suggestions'])
    assert_equal('3', sender.request.parameters['city_filter'])
    assert_equal('4,4.5', sender.request.parameters['state_filter'])
    assert_equal('5', sender.request.parameters['prefer'])
    assert_equal('true', sender.request.parameters['geolocate'])
    assert_equal('state', sender.request.parameters['geolocate_precision'])
  end

  def test_deserialize_called_with_response_body
    response = Response.new('Hello, World!', 0)

    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new({})
    client = Client.new(sender, deserializer)

    client.send(Lookup.new('1'))

    assert_equal(response.payload, deserializer.input)
  end

  def test_result_correctly_assigned_to_corresponding_lookup
    lookup = Lookup.new('1')
    expected_result = { 'suggestions' => [{ 'text' => '2' }] }

    sender = MockSender.new(Response.new('{[]}', 0))
    deserializer = FakeDeserializer.new(expected_result)
    client = Client.new(sender, deserializer)

    client.send(lookup)

    assert_equal('2', lookup.result[0].text)
  end

  def test_rejects_blank_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    assert_raises(SmartyStreets::SmartyError) do
      client.send(Lookup.new)
    end
  end
end