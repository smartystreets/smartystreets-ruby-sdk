require 'minitest/autorun'
require 'smartystreets_ruby_sdk/international_autocomplete/client'
require 'smartystreets_ruby_sdk/international_autocomplete/lookup'
require 'smartystreets_ruby_sdk/response'
require_relative '../../test_helper'
require_relative '../../../test/mocks/request_capturing_sender'
require_relative '../../../test/mocks/fake_serializer'
require_relative '../../../test/mocks/mock_sender'
require_relative '../../../test/mocks/fake_deserializer'

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
    lookup.locality = '3'
    lookup.postal_code = '4'
    lookup.address_id = '5'

    client.send(lookup)

    assert_equal('1', sender.request.parameters['search'])
    assert_equal('2', sender.request.parameters['country'])
    assert_equal('7', sender.request.parameters['max_results'])
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
    expected_result = { 'candidates' => [{ 'street' => '2' }] }

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

  def test_raises_error_from_sender_response
    error = StandardError.new('fail!')
    response = Response.new('payload', 0, nil, error)
    sender = MockSender.new(response)
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    assert_raises(StandardError) { client.send(lookup) }
  end

  def test_custom_parameters_are_added_to_request
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.custom_param_hash['foo'] = 'bar'
    client.send(lookup)
    assert_equal('bar', sender.request.parameters['foo'])
  end

  def test_convert_suggestions_returns_empty_array_on_nil
    client = Client.new(nil, nil)
    assert_equal [], client.convert_suggestions(nil)
  end

  def test_convert_suggestions_returns_empty_array_on_empty
    client = Client.new(nil, nil)
    assert_equal [], client.convert_suggestions([])
  end

  def test_add_parameter_skips_nil_and_empty
    client = Client.new(nil, nil)
    request = Struct.new(:parameters).new({})
    client.add_parameter(request, 'foo', nil)
    client.add_parameter(request, 'bar', '')
    assert_empty request.parameters
  end

  def test_convert_suggestions_with_multiple_hashes
    client = Client.new(nil, nil)
    hashes = [{ 'street' => 'A' }, { 'street' => 'B' }]
    suggestions = client.convert_suggestions(hashes)
    assert_equal 2, suggestions.size
    assert(suggestions.all? { |s| s.is_a?(SmartyStreets::InternationalAutocomplete::Suggestion) })
    assert_equal 'A', suggestions[0].street
    assert_equal 'B', suggestions[1].street
  end

  def test_address_id_with_special_characters
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('search')
    lookup.address_id = 'id/with special?chars'
    client.send(lookup)
    assert_equal('/id/with special?chars', sender.request.url_components)
  end

  def test_max_results_as_string_and_integer
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('search')
    lookup.max_results = 5
    client.send(lookup)
    assert_equal('5', sender.request.parameters['max_results'])
    lookup.max_results = '7'
    client.send(lookup)
    assert_equal('7', sender.request.parameters['max_results'])
  end

  def test_add_parameter_with_zero_and_false_strings
    client = Client.new(nil, nil)
    request = Struct.new(:parameters).new({})
    client.add_parameter(request, 'zero', '0')
    client.add_parameter(request, 'false', 'false')
    assert_equal '0', request.parameters['zero']
    assert_equal 'false', request.parameters['false']
  end

  def test_convert_suggestions_with_missing_keys
    client = Client.new(nil, nil)
    hashes = [{}]
    suggestions = client.convert_suggestions(hashes)
    assert_equal 1, suggestions.size
    assert suggestions[0].is_a?(SmartyStreets::InternationalAutocomplete::Suggestion)
  end

  def test_send_with_both_search_and_address_id
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({ 'candidates' => [] })
    client = Client.new(sender, serializer)
    lookup = Lookup.new('search')
    lookup.address_id = 'id123'
    client.send(lookup)
    assert_equal('search', sender.request.parameters['search'])
    assert_equal('/id123', sender.request.url_components)
  end

  def test_send_with_only_address_id
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({ 'candidates' => [] })
    client = Client.new(sender, serializer)
    lookup = Lookup.new(nil)
    lookup.address_id = 'idonly'
    client.send(lookup)
    assert_equal('/idonly', sender.request.url_components)
    assert_nil sender.request.parameters['search']
  end

  def test_send_with_only_search
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({ 'candidates' => [] })
    client = Client.new(sender, serializer)
    lookup = Lookup.new('searchonly')
    client.send(lookup)
    assert_equal('searchonly', sender.request.parameters['search'])
    assert_nil sender.request.url_components
  end
end
