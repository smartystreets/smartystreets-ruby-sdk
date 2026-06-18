require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_autocomplete/client'
require './lib/smartystreets_ruby_sdk/us_autocomplete/lookup'
require './lib/smartystreets_ruby_sdk/us_autocomplete/source_type'
require './lib/smartystreets_ruby_sdk/response'

class TestAutocompleteClient < Minitest::Test
  Client = SmartyStreets::USAutocomplete::Client
  Lookup = SmartyStreets::USAutocomplete::Lookup
  SourceType = SmartyStreets::USAutocomplete::SourceType
  Response = SmartyStreets::Response

  def test_sending_search_only_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    client.send(Lookup.new('1'))

    assert_equal('1', sender.request.parameters['search'])
    assert_nil(sender.request.parameters['max_results'])
    assert_nil(sender.request.parameters['prefer_ratio'])
  end

  def test_sending_fully_populated_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.max_results = 2
    lookup.add_city_filter('3')
    lookup.add_state_filter('4')
    lookup.add_state_filter('4.5')
    lookup.add_zip_filter('5')
    lookup.add_state_exclusion('6')
    lookup.add_preferred_city('7')
    lookup.add_preferred_state('8')
    lookup.add_preferred_zip('9')
    lookup.prefer_ratio = 10
    lookup.prefer_geolocation = SmartyStreets::USAutocomplete::GeolocationType::CITY
    lookup.source = SourceType::ALL
    lookup.selected = 'selectedAddress'
    lookup.exclude = 'excludedAddress'

    client.send(lookup)

    assert_equal('1', sender.request.parameters['search'])
    assert_equal('2', sender.request.parameters['max_results'])
    assert_equal('3', sender.request.parameters['include_only_cities'])
    assert_equal('4;4.5', sender.request.parameters['include_only_states'])
    assert_equal('5', sender.request.parameters['include_only_zip_codes'])
    assert_equal('6', sender.request.parameters['exclude_states'])
    assert_equal('7', sender.request.parameters['prefer_cities'])
    assert_equal('8', sender.request.parameters['prefer_states'])
    assert_equal('9', sender.request.parameters['prefer_zip_codes'])
    assert_equal('10', sender.request.parameters['prefer_ratio'])
    assert_equal('none', sender.request.parameters['prefer_geolocation'])
    assert_equal('all', sender.request.parameters['source'])
    assert_equal('selectedAddress', sender.request.parameters['selected'])
    assert_equal('excludedAddress', sender.request.parameters['exclude'])
  end

  def test_sending_exclude
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    lookup = Lookup.new('1')
    lookup.exclude = 'excludedAddress'

    client.send(lookup)

    assert_equal('excludedAddress', sender.request.parameters['exclude'])
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
    expected_result = { 'suggestions' => [{ 'street_line' => '2', 'entry_id' => '3' }] }

    sender = MockSender.new(Response.new('{[]}', 0))
    deserializer = FakeDeserializer.new(expected_result)
    client = Client.new(sender, deserializer)

    client.send(lookup)

    assert_equal('2', lookup.result[0].street_line)
    assert_equal('3', lookup.result[0].entry_id)
  end

  def test_rejects_blank_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    assert_raises(SmartyStreets::SmartyError) do
      client.send(Lookup.new)
    end
  end

  def test_sets_geolocation_as_city_if_no_city_and_zip_filters
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    lookup = Lookup.new('1')
    lookup.max_results = 2
    lookup.source = SourceType::ALL
    lookup.prefer_geolocation = SmartyStreets::USAutocomplete::GeolocationType::CITY

    client.send(lookup)

    assert_equal('1', sender.request.parameters['search'])
    assert_equal('2', sender.request.parameters['max_results'])
    assert_equal('city', sender.request.parameters['prefer_geolocation'])
    assert_equal('all', sender.request.parameters['source'])
  end

  def test_source_omitted_when_not_set
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    client.send(Lookup.new('1'))

    assert_nil(sender.request.parameters['source'])
  end

  def test_source_all_sent_as_all
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.source = SourceType::ALL

    client.send(lookup)

    assert_equal('all', sender.request.parameters['source'])
  end

  def test_source_postal_sent_as_postal
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.source = SourceType::POSTAL

    client.send(lookup)

    assert_equal('postal', sender.request.parameters['source'])
  end
end
