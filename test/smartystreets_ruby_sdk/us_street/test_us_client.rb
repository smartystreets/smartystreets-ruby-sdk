require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/exceptions'
require './test/mocks/request_capturing_sender'
require './test/mocks/fake_serializer'
require './test/mocks/fake_deserializer'
require './test/mocks/mock_sender'
require './test/mocks/mock_exception_sender'
require './lib/smartystreets_ruby_sdk/us_street/client'
require './lib/smartystreets_ruby_sdk/us_street/candidate'

class TestUSClient < Minitest::Test
  Lookup = Smartystreets::USStreet::Lookup
  Candidate = Smartystreets::USStreet::Candidate
  Client = Smartystreets::USStreet::Client

  def test_freeform_assigned_to_street_field
    lookup = Smartystreets::USStreet::Lookup.new('freeform address')

    assert_equal('freeform address', lookup.street)
  end

  def test_empty_batch_not_sent
    sender = RequestCapturingSender.new
    client = Smartystreets::USStreet::Client.new(sender, nil)

    client.send_batch(Smartystreets::Batch.new)

    assert_nil(sender.request)
  end

  def test_successfully_sends_batch
    expected_payload = 'Hello, World!'
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new(expected_payload)
    client = Smartystreets::USStreet::Client.new(sender, serializer)
    batch = Smartystreets::Batch.new
    batch.add(Smartystreets::USStreet::Lookup.new)
    batch.add(Smartystreets::USStreet::Lookup.new)

    client.send_batch(batch)

    assert_equal(expected_payload, sender.request.payload)
  end

  def test_deserialize_called_with_response_body
    response = Smartystreets::Response.new('Hello, World!', 0)
    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new(nil)
    client = Smartystreets::USStreet::Client.new(sender, deserializer)

    client.send_lookup(Smartystreets::USStreet::Lookup.new)

    assert_equal(response.payload, deserializer.input)
  end

  def test_candidates_correctly_assigned_to_corresponding_lookup
    candidate0 = {'input_index'=> 0, 'candidate_index'=> 0, 'addressee'=> 'Mister 0'}
    candidate1 = {'input_index'=> 1, 'candidate_index'=> 0, 'addressee'=> 'Mister 1'}
    candidate2 = {'input_index'=> 1, 'candidate_index'=> 1, 'addressee'=> 'Mister 2'}
    raw_candidates = [candidate0, candidate1, candidate2]

    expected_candidates = [Candidate.new(candidate0), Candidate.new(candidate1), Candidate.new(candidate2)]
    batch = Smartystreets::Batch.new
    batch.add(Smartystreets::USStreet::Lookup.new)
    batch.add(Smartystreets::USStreet::Lookup.new)
    sender = MockSender.new(Smartystreets::Response.new('[]', 0))
    deserializer = FakeDeserializer.new(raw_candidates)
    client = Smartystreets::USStreet::Client.new(sender, deserializer)

    client.send_batch(batch)

    assert_equal(expected_candidates[0].addressee, batch.get_by_index(0).result[0].addressee)
    assert_equal(expected_candidates[1].addressee, batch.get_by_index(1).result[0].addressee)
    assert_equal(expected_candidates[2].addressee, batch.get_by_index(1).result[1].addressee)
  end

  def test_raises_exception_when_response_has_error
    exception = Smartystreets::BadCredentialsError
    client = Smartystreets::USStreet::Client.new(MockExceptionSender.new(exception), FakeSerializer.new(nil))

    assert_raises exception do
      client.send_lookup(Smartystreets::USStreet::Lookup.new)
    end
  end
end
