require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_zipcode/client'
require './lib/smartystreets_ruby_sdk/us_zipcode/lookup'


class TestZipcodeClient < Minitest::Test

  def test_empty_batch_not_sent
    sender = RequestCapturingSender.new
    client = Smartystreets::USZipcode::Client.new(sender, nil)

    client.send_batch(Smartystreets::Batch.new)

    assert_nil(sender.request)
  end

  def test_successfully_sends_batch
    expected_payload = 'Hello, World!'
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new(expected_payload)
    client = Smartystreets::USZipcode::Client.new(sender, serializer)
    batch = Smartystreets::Batch.new
    batch.add(Smartystreets::USZipcode::Lookup.new)
    batch.add(Smartystreets::USZipcode::Lookup.new)

    client.send_batch(batch)

    assert_equal(expected_payload, sender.request.payload)
  end

  def test_deserialize_called_with_response_body
    response = Smartystreets::Response.new('Hello, World!', 0)
    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new(nil)
    client = Smartystreets::USZipcode::Client.new(sender, deserializer)

    client.send_lookup(Smartystreets::USZipcode::Lookup.new)

    assert_equal(response.payload, deserializer.input)
  end

  def test_results_correctly_assigned_to_corresponding_lookup
    raw_results = [{'input_index' => 0}, {'input_index' => 1}]

    expected_results = [Smartystreets::USZipcode::Result.new(raw_results[0]), Smartystreets::USZipcode::Result.new(raw_results[1])]
    batch = Smartystreets::Batch.new
    batch.add(Smartystreets::USZipcode::Lookup.new)
    batch.add(Smartystreets::USZipcode::Lookup.new)
    sender = MockSender.new(Smartystreets::Response.new('[]', '0'))
    deserializer = FakeDeserializer.new(raw_results)
    client = Smartystreets::USZipcode::Client.new(sender, deserializer)

    client.send_batch(batch)

    assert_equal(expected_results[0].input_index, batch[0].result.input_index)
    assert_equal(expected_results[1].input_index, batch[1].result.input_index)
  end

  def test_raises_exception_when_response_has_error
    exception = Smartystreets::BadCredentialsError
    client = Smartystreets::USZipcode::Client.new(MockExceptionSender.new(exception), FakeSerializer.new(nil))

    assert_raises exception do
      client.send_lookup(Smartystreets::USZipcode::Lookup.new)
    end
  end
end
