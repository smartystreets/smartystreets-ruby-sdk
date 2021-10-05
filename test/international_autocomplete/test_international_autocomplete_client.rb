require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/international_autocomplete/client'
require './lib/smartystreets_ruby_sdk/international_autocomplete/lookup'
require './lib/smartystreets_ruby_sdk/response'

class TestInternationalAutocompleteClient < Minitest::Test
  Client = SmartyStreets::InternationalAutocomplete::Client
  Lookup = SmartyStreets::InternationalAutocomplete::Lookup
  Response = SmartyStreets::Response

  def test_sending_prefix_only_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    client.send(Lookup.new('1'))

    assert_equal('1', sender.request.parameters['search'])
  end

  def test_sending_fully_populated_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.country = '2'
    lookup.administrative_area = '3'
    lookup.locality = '4'
    lookup.postal_code = '5'

    client.send(lookup)

    assert_equal('1', sender.request.parameters['search'])
    assert_equal('2', sender.request.parameters['country'])
    assert_equal('3', sender.request.parameters['include_only_administrative_area'])
    assert_equal('4', sender.request.parameters['include_only_locality'])
    assert_equal('5', sender.request.parameters['include_only_postal_code'])

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
    expected_result = [{ 'street' => '2' }]

    sender = MockSender.new(Response.new('{[]}', 0))
    deserializer = FakeDeserializer.new(expected_result)
    client = Client.new(sender, deserializer)

    client.send(lookup)

    assert_equal('2', lookup.result[0].street)
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