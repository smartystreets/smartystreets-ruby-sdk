require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_extract/client'
require './lib/smartystreets_ruby_sdk/us_extract/lookup'
require './lib/smartystreets_ruby_sdk/us_street/candidate'
require './test/mocks/request_capturing_sender'
require './test/mocks/fake_serializer'
require './test/mocks/fake_deserializer'
require './test/mocks/mock_sender'
require './test/mocks/mock_exception_sender'

class TestExtractClient < Minitest::Test
  Lookup = USExtract::Lookup
  Candidate = USStreet::Candidate
  Client = USExtract::Client

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

    client.send(lookup)

    request = capturing_sender.request
    assert_equal('true', request.parameters['html'])
    assert_equal('true', request.parameters['aggressive'])
    assert_equal('true', request.parameters['addr_line_breaks'])
    assert_equal('2', request.parameters['addr_per_line'])
  end

  def test_reject_blank_lookup
    capturing_sender = RequestCapturingSender.new
    sender = URLPrefixSender.new('http://localhost/', capturing_sender)
    serializer = FakeSerializer.new(nil)
    client = Client.new(sender, serializer)

    assert_raises(SmartyException) do
      client.send(Lookup.new)
    end
  end

  # def test_deserialize_called_with_response_body(self):
  #     response = Response('Hello, World!', 0)
  # sender = MockSender(response)
  # deserializer = FakeDeserializer({})
  # client = Client(sender, deserializer)
  #
  # client.send(Lookup('Hello, World!'))
  #
  # self.assertEqual(response.payload, deserializer.input)
  #
  # def test_result_correctly_assigned_to_corresponding_lookup(self):
  #     raw_result = {"meta": {}, "addresses": [{"text": "Hello, World!"}]}
  # expected_result = Result(raw_result)
  # lookup = Lookup('Hello, World!')
  # sender = MockSender(Response('[]', 0))
  # deserializer = FakeDeserializer(raw_result)
  # client = Client(sender, deserializer)
  #
  # client.send(lookup)
  #
  # self.assertEqual(expected_result.addresses[0].text, lookup.result.addresses[0].text)
  #
  # def test_content_type_set_correctly(self):
  #     sender = RequestCapturingSender()
  # serializer = FakeSerializer(None)
  # client = Client(sender, serializer)
  # lookup = Lookup("Hello, World!")
  #
  # client.send(lookup)
  #
  # self.assertEqual("text/plain", sender.request.content_type)
end