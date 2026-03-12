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
    lookup.max_results = 7
    lookup.max_group_results = 50
    lookup.geolocation = true
    lookup.locality = '3'
    lookup.postal_code = '4'
    lookup.address_id = "5"

    client.send(lookup)

    assert_equal('1', sender.request.parameters['search'])
    assert_equal('2', sender.request.parameters['country'])
    assert_equal('7', sender.request.parameters['max_results'])
    assert_equal('50', sender.request.parameters['max_group_results'])
    assert_equal('on', sender.request.parameters['geolocation'])
    assert_equal('3', sender.request.parameters['include_only_locality'])
    assert_equal('4', sender.request.parameters['include_only_postal_code'])
    assert_equal('/5', sender.request.url_components)

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
    expected_result = { 'candidates' => [{ 'street' => '2' }]}

    sender = MockSender.new(Response.new('{[]}', 0))
    deserializer = FakeDeserializer.new(expected_result)
    client = Client.new(sender, deserializer)

    client.send(lookup)

    assert_equal('2', lookup.result[0].street)
  end

  def test_sending_lookup_with_custom_max_group_results
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.country = '2'
    lookup.max_group_results = 50

    client.send(lookup)

    assert_equal('50', sender.request.parameters['max_group_results'])
  end

  def test_sending_lookup_with_geolocation
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.country = '2'
    lookup.geolocation = true

    client.send(lookup)

    assert_equal('on', sender.request.parameters['geolocation'])
  end

  def test_default_max_group_results
    lookup = Lookup.new('1')

    assert_equal(100, lookup.max_group_results)
  end

  def test_default_geolocation_is_false
    lookup = Lookup.new('1')

    assert_equal(false, lookup.geolocation)
  end

  def test_geolocation_not_included_when_false
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.country = '2'

    client.send(lookup)

    assert_nil(sender.request.parameters['geolocation'])
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