require 'minitest/autorun'
require_relative '../../../lib/smartystreets_ruby_sdk/international_street'
require_relative '../../../lib/smartystreets_ruby_sdk/exceptions'
require_relative '../../../lib/smartystreets_ruby_sdk/response'
require_relative '../../../test/mocks/request_capturing_sender'
require_relative '../../../test/mocks/fake_serializer'
require_relative '../../../test/mocks/fake_deserializer'
require_relative '../../../test/mocks/mock_sender'

class TestInternationalClient < Minitest::Test
  Client = SmartyStreets::InternationalStreet::Client
  Lookup = SmartyStreets::InternationalStreet::Lookup
  Candidate = SmartyStreets::InternationalStreet::Candidate
  LanguageMode = SmartyStreets::InternationalStreet::LanguageMode
  Response = SmartyStreets::Response

  def test_sending_freeform_lookup
    sender = RequestCapturingSender.new
    serializer = FakeDeserializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1', '2')

    client.send_lookup(lookup)

    assert_equal('1', sender.request.parameters['freeform'])
    assert_equal('2', sender.request.parameters['country'])
  end

  def test_sending_single_fully_populated_lookup
    sender = RequestCapturingSender.new
    serializer = FakeDeserializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new
    lookup.input_id = '1234'
    lookup.country = '0'
    lookup.geocode = true
    lookup.language = LanguageMode::NATIVE
    lookup.freeform = '1'
    lookup.address1 = '2'
    lookup.address2 = '3'
    lookup.address3 = '4'
    lookup.address4 = '5'
    lookup.organization = '6'
    lookup.locality = '7'
    lookup.administrative_area = '8'
    lookup.postal_code = '9'
    lookup.features = '10'

    client.send_lookup(lookup)

    assert_equal('1234', sender.request.parameters['input_id'])
    assert_equal('0', sender.request.parameters['country'])
    assert_equal('true', sender.request.parameters['geocode'])
    assert_equal(LanguageMode::NATIVE, sender.request.parameters['language'])
    assert_equal('1', sender.request.parameters['freeform'])
    assert_equal('2', sender.request.parameters['address1'])
    assert_equal('3', sender.request.parameters['address2'])
    assert_equal('4', sender.request.parameters['address3'])
    assert_equal('5', sender.request.parameters['address4'])
    assert_equal('6', sender.request.parameters['organization'])
    assert_equal('7', sender.request.parameters['locality'])
    assert_equal('8', sender.request.parameters['administrative_area'])
    assert_equal('9', sender.request.parameters['postal_code'])
    assert_equal('10', sender.request.parameters['features'])
  end

  def test_nil_lookup_rejected
    sender = MockSender.new(nil)
    client = Client.new(sender, nil)

    assert_raises ArgumentError do
      client.send_lookup(nil)
    end
  end

  def test_empty_lookup_rejected
    sender = MockSender.new(nil)
    client = Client.new(sender, nil)

    assert_raises SmartyStreets::UnprocessableEntityError do
      client.send_lookup(Lookup.new)
    end
  end

  def test_rejects_lookups_with_only_country
    sender = MockSender.new(nil)
    client = Client.new(sender, nil)
    lookup = Lookup.new(nil, '0')

    assert_raises SmartyStreets::UnprocessableEntityError do
      client.send_lookup(lookup)
    end
  end

  def test_accepts_lookups_with_country_and_freeform
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new(nil)
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1', '0')

    client.send_lookup(lookup)
  end

  def test_accepts_lookups_with_country_and_address1
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new(nil)
    client = Client.new(sender, serializer)
    lookup = Lookup.new(nil, '0')
    lookup.address1 = '1'

    client.send_lookup(lookup)
  end

  def test_deserialize_called_with_response_body
    response = Response.new('Hello, World!', 0)

    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new({})
    client = Client.new(sender, deserializer)

    client.send_lookup(Lookup.new('1', '2'))

    assert_equal(response.payload, deserializer.input)
  end

  def test_candidates_correctly_assigned_to_lookup
    raw_candidates = [{ 'address1' => 'street 1' }, { 'address1' => 'street 2' }]
    expected_candidates = [Candidate.new(raw_candidates[0]), Candidate.new(raw_candidates[1])]
    lookup = Lookup.new('1', '2')
    sender = MockSender.new(Response.new('[]', 0))
    deserializer = FakeDeserializer.new(raw_candidates)
    client = Client.new(sender, deserializer)

    client.send_lookup(lookup)

    assert_equal(expected_candidates[0].address1, lookup.result[0].address1)
    assert_equal(expected_candidates[1].address1, lookup.result[1].address1)
  end
end