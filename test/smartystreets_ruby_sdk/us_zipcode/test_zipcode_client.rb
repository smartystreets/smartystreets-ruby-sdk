require './lib/smartystreets_ruby_sdk/us_zipcode/client'
require './lib/smartystreets_ruby_sdk/us_zipcode/lookup'


class TestZipcodeClient < Minitest::Test

  def test_empty_batch_not_sent
    sender = RequestCapturingSender.new
    client = USZipcode::Client.new(sender, nil)

    client.send_batch(Batch.new)

    assert_nil(sender.request)
  end

  def test_successfully_sends_batch
    expected_payload = 'Hello, World!'
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new(expected_payload)
    client = USZipcode::Client.new(sender, serializer)
    batch = Batch.new
    batch.add(USZipcode::Lookup.new)
    batch.add(USZipcode::Lookup.new)

    client.send_batch(batch)

    assert_equal(expected_payload, sender.request.payload)
  end

  def test_deserialize_called_with_response_body
    response = Response.new('Hello, World!', 0)
    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new(nil)
    client = USZipcode::Client.new(sender, deserializer)

    client.send_lookup(USZipcode::Lookup.new)

    assert_equal(response.payload, deserializer.input)
  end

  def test_results_correctly_assigned_to_corresponding_lookup
    raw_results = [{'input_index' => 0}, {'input_index' => 1}]

    expected_results = [USZipcode::Result.new(raw_results[0]), USZipcode::Result.new(raw_results[1])]
    batch = Batch.new
    batch.add(USZipcode::Lookup.new)
    batch.add(USZipcode::Lookup.new)
    sender = MockSender.new(Response.new('[]', '0'))
    deserializer = FakeDeserializer.new(raw_results)
    client = USZipcode::Client.new(sender, deserializer)

    client.send_batch(batch)

    assert_equal(expected_results[0].input_index, batch[0].result.input_index)
    assert_equal(expected_results[1].input_index, batch[1].result.input_index)
  end

  def test_raises_exception_when_response_has_error
    exception = BadCredentialsError
    client = USZipcode::Client.new(MockExceptionSender.new(exception), FakeSerializer.new(nil))

    assert_raises exception do
      client.send_lookup(USZipcode::Lookup.new)
    end
  end
end