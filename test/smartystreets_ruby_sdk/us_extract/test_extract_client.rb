require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_extract/client'
require './lib/smartystreets_ruby_sdk/us_extract/lookup'
require './lib/smartystreets_ruby_sdk/us_extract/result'
require './lib/smartystreets_ruby_sdk/us_street/candidate'
require './lib/smartystreets_ruby_sdk/response'
require './lib/smartystreets_ruby_sdk/international_autocomplete/international_geolocation_type'
require './test/mocks/request_capturing_sender'
require './test/mocks/fake_serializer'
require './test/mocks/fake_deserializer'
require './test/mocks/mock_sender'
require './test/mocks/mock_exception_sender'

class TestExtractClient < Minitest::Test
  Lookup = SmartyStreets::USExtract::Lookup
  Candidate = SmartyStreets::USStreet::Candidate
  Client = SmartyStreets::USExtract::Client
  Result = SmartyStreets::USExtract::Result
  URLPrefixSender = SmartyStreets::URLPrefixSender
  Response = SmartyStreets::Response

  def test_sending_body_only_lookup
    capturing_sender = RequestCapturingSender.new
    sender = URLPrefixSender.new('http://localhost/', capturing_sender)
    serializer = FakeSerializer.new(nil)
    client = Client.new(sender, serializer)
    expected_payload = 'Hello, World!'

    client.send(Lookup.new('Hello, World!'))

    assert_equal(expected_payload, capturing_sender.request.payload)
    assert(!capturing_sender.request.parameters.has_key?('html'))
  end

  def test_sending_fully_populated_lookup
    capturing_sender = RequestCapturingSender.new
    sender = URLPrefixSender.new('http://localhost/', capturing_sender)
    serializer = FakeSerializer.new(nil)
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.html = true
    lookup.aggressive = true
    lookup.addresses_have_line_breaks = true
    lookup.addresses_per_line = 2
    lookup.match =  SmartyStreets::USStreet::MatchType::ENHANCED

    client.send(lookup)

    request = capturing_sender.request
    assert_equal('true', request.parameters['html'])
    assert_equal('true', request.parameters['aggressive'])
    assert_equal('true', request.parameters['addr_line_breaks'])
    assert_equal('2', request.parameters['addr_per_line'])
    assert_equal('enhanced', request.parameters['match'])
  end

  def test_match_empty_lookup
    capturing_sender = RequestCapturingSender.new
    sender = URLPrefixSender.new('http://localhost/', capturing_sender)
    serializer = FakeSerializer.new(nil)
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.match =  SmartyStreets::USStreet::MatchType::STRICT

    client.send(lookup)

    request = capturing_sender.request
    assert_equal(nil, request.parameters['match'])
  end

  def test_match_invalid_lookup
    capturing_sender = RequestCapturingSender.new
    sender = URLPrefixSender.new('http://localhost/', capturing_sender)
    serializer = FakeSerializer.new(nil)
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.match =  SmartyStreets::USStreet::MatchType::INVALID

    client.send(lookup)

    request = capturing_sender.request
    assert_equal('invalid', request.parameters['match'])
  end

  def test_reject_blank_lookup
    capturing_sender = RequestCapturingSender.new
    sender = URLPrefixSender.new('http://localhost/', capturing_sender)
    serializer = FakeSerializer.new(nil)
    client = Client.new(sender, serializer)

    assert_raises(SmartyStreets::SmartyError) do
      client.send(Lookup.new)
    end
  end

  def test_deserialize_called_with_response_body
    response = Response.new('Hello, World!', 0)
    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new({})
    client = Client.new(sender, deserializer)

    client.send(Lookup.new('Hello, World!'))

    assert_equal(response.payload, deserializer.input)
  end

  def test_result_correctly_assigned_to_corresponding_lookup
    raw_result = {'meta'=> {}, 'addresses'=> [{'text'=> 'Hello, World!'}]}
    expected_result = Result.new(raw_result)
    lookup = Lookup.new('Hello, World!')
    sender = MockSender.new(Response.new('[]', 0))
    deserializer = FakeDeserializer.new(raw_result)
    client = Client.new(sender, deserializer)

    client.send(lookup)

    assert_equal(expected_result.addresses[0].text, lookup.result.addresses[0].text)
  end

  def test_content_type_set_correctly
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new(nil)
    client = Client.new(sender, serializer)
    lookup = Lookup.new('Hello, World!')

    client.send(lookup)

    assert_equal('text/plain', sender.request.content_type)
  end
end