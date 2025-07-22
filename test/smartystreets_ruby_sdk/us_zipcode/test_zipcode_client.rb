require_relative '../../test_helper'
require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_zipcode/client'
require './lib/smartystreets_ruby_sdk/us_zipcode/lookup'
require './lib/smartystreets_ruby_sdk/exceptions'
require './lib/smartystreets_ruby_sdk/response'
require_relative '../../mocks/request_capturing_sender'
require_relative '../../mocks/fake_serializer'
require_relative '../../mocks/mock_sender'
require_relative '../../mocks/fake_deserializer'
require_relative '../../mocks/mock_exception_sender'


class TestZipcodeClient < Minitest::Test
  Batch = SmartyStreets::Batch
  Client = SmartyStreets::USZipcode::Client
  Lookup = SmartyStreets::USZipcode::Lookup
  Result = SmartyStreets::USZipcode::Result
  Response = SmartyStreets::Response

  def test_empty_batch_not_sent
    sender = RequestCapturingSender.new
    client = Client.new(sender, nil)

    client.send_batch(Batch.new)

    assert_nil(sender.request)
  end

  def test_successfully_sends_populated_lookup
    expected_parameters = {
        'city' => '1',
        'state' => '2',
        'zipcode' => '3'
    }
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new(expected_parameters)
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1', '2', '3')

    client.send_lookup(lookup)

    assert_equal(expected_parameters, sender.request.parameters)
  end

  def test_successfully_sends_batch
    expected_payload = 'Hello, World!'
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new(expected_payload)
    client = Client.new(sender, serializer)
    batch = Batch.new
    batch.add(Lookup.new)
    batch.add(Lookup.new)

    client.send_batch(batch)

    assert_equal(expected_payload, sender.request.payload)
  end

  def test_deserialize_called_with_response_body
    response = Response.new('Hello, World!', 0)
    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new(nil)
    client = Client.new(sender, deserializer)

    client.send_lookup(Lookup.new)

    assert_equal(response.payload, deserializer.input)
  end

  def test_results_correctly_assigned_to_corresponding_lookup
    raw_results = [{'input_index' => 0}, {'input_index' => 1}]

    expected_results = [Result.new(raw_results[0]), Result.new(raw_results[1])]
    batch = Batch.new
    batch.add(Lookup.new)
    batch.add(Lookup.new)
    sender = MockSender.new(Response.new('[]', '0'))
    deserializer = FakeDeserializer.new(raw_results)
    client = Client.new(sender, deserializer)

    client.send_batch(batch)

    assert_equal(expected_results[0].input_index, batch[0].result.input_index)
    assert_equal(expected_results[1].input_index, batch[1].result.input_index)
  end

  def test_raises_exception_when_response_has_error
    exception = SmartyStreets::BadCredentialsError
    client = Client.new(MockExceptionSender.new(exception), FakeSerializer.new(nil))

    assert_raises exception do
      client.send_lookup(Lookup.new)
    end
  end
end