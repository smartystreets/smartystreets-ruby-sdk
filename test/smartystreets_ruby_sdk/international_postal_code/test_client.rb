require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/international_postal_code/client'
require './lib/smartystreets_ruby_sdk/international_postal_code/lookup'
require './lib/smartystreets_ruby_sdk/international_postal_code/language_mode'
require './test/mocks/request_capturing_sender'
require './test/mocks/mock_sender'
require './test/mocks/fake_serializer'
require './test/mocks/fake_deserializer'
require './lib/smartystreets_ruby_sdk/response'

class TestInternationalPostalCodeClient < Minitest::Test
  Client = SmartyStreets::InternationalPostalCode::Client
  Lookup = SmartyStreets::InternationalPostalCode::Lookup
  LanguageMode = SmartyStreets::InternationalPostalCode::LanguageMode
  Response = SmartyStreets::Response

  def test_sending_fully_populated_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    lookup = Lookup.new
    lookup.input_id = '1'
    lookup.country = 'CAN'
    lookup.locality = 'Toronto'
    lookup.administrative_area = 'ON'
    lookup.postal_code = 'ABC DEF'
    lookup.language = LanguageMode::NATIVE
    lookup.max_results = 25

    client.send_lookup(lookup)

    assert_equal('1', sender.request.parameters['input_id'])
    assert_equal('CAN', sender.request.parameters['country'])
    assert_equal('Toronto', sender.request.parameters['locality'])
    assert_equal('ON', sender.request.parameters['administrative_area'])
    assert_equal('ABC DEF', sender.request.parameters['postal_code'])
    assert_equal('native', sender.request.parameters['language'])
    assert_equal('25', sender.request.parameters['max_results'])
  end

  def test_language_and_max_results_omitted_when_unset
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    client.send_lookup(Lookup.new)

    assert_nil(sender.request.parameters['language'])
    assert_nil(sender.request.parameters['max_results'])
  end

  def test_sending_language_latin
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new
    lookup.language = LanguageMode::LATIN

    client.send_lookup(lookup)

    assert_equal('latin', sender.request.parameters['language'])
  end

  def test_sending_mixed_case_language_value
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new
    lookup.language = 'NATIVE'

    client.send_lookup(lookup)

    assert_equal('native', sender.request.parameters['language'])
  end

  def test_max_results_omitted_when_zero
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new
    lookup.max_results = 0

    client.send_lookup(lookup)

    assert_nil(sender.request.parameters['max_results'])
  end

  def test_sending_max_results
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new
    lookup.max_results = 7

    client.send_lookup(lookup)

    assert_equal('7', sender.request.parameters['max_results'])
  end

  def test_thoroughfare_deserialized
    sender = MockSender.new(Response.new('[]', 0))
    deserializer = FakeDeserializer.new([{ 'thoroughfare' => 'Main St' }])
    client = Client.new(sender, deserializer)
    lookup = Lookup.new

    client.send_lookup(lookup)

    assert_equal('Main St', lookup.results[0].thoroughfare)
  end

  def test_deserialize_called_with_response_body_and_results_assigned
    response = Response.new('[{"postal_code":"7"}]', 0)

    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new([{ 'postal_code' => '7' }])
    client = Client.new(sender, deserializer)

    lookup = Lookup.new
    results = client.send_lookup(lookup)

    assert_equal response.payload, deserializer.input
    assert_equal '7', lookup.results[0].postal_code
    assert_equal '7', results[0].postal_code
  end

  def test_rejects_nil_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    assert_raises(SmartyStreets::SmartyError) do
      client.send_lookup(nil)
    end
  end
end


