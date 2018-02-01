require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/exceptions'
require './test/mocks/request_capturing_sender'
require './test/mocks/fake_serializer'
require './test/mocks/fake_deserializer'
require './test/mocks/mock_sender'
require './test/mocks/mock_exception_sender'
require './lib/smartystreets_ruby_sdk/us_street/client'
require './lib/smartystreets_ruby_sdk/us_street/candidate'
require './lib/smartystreets_ruby_sdk/us_street/match_type'
require './lib/smartystreets_ruby_sdk/response'

class TestStreetClient < Minitest::Test
  Lookup = SmartyStreets::USStreet::Lookup
  Candidate = SmartyStreets::USStreet::Candidate
  Client = SmartyStreets::USStreet::Client
  Batch = SmartyStreets::Batch
  Response = SmartyStreets::Response

  def test_freeform_assigned_to_street_field
    lookup = Lookup.new('freeform address')

    assert_equal('freeform address', lookup.street)
  end

  def test_send_populated_lookup
    sender = RequestCapturingSender.new
    expected_parameters = {
        'street' => '2',
        'street2' => '3',
        'secondary' => '4',
        'city' => '5',
        'state' => '6',
        'zipcode' => '7',
        'lastline' => '8',
        'addressee' => '9',
        'urbanization' => '10',
        'candidates' => '11',
        'match' => SmartyStreets::USStreet::MatchType::INVALID
    }
    serializer = FakeSerializer.new(expected_parameters)
    client = Client.new(sender, serializer)
    lookup = Lookup.new
    lookup.input_id = '1'
    lookup.street = '2'
    lookup.street2 = '3'
    lookup.secondary = '4'
    lookup.city = '5'
    lookup.state = '6'
    lookup.zipcode = '7'
    lookup.lastline = '8'
    lookup.addressee = '9'
    lookup.urbanization = '10'
    lookup.candidates = '11'
    lookup.match = SmartyStreets::USStreet::MatchType::INVALID

    client.send_lookup(lookup)

    assert_equal(expected_parameters, sender.request.parameters)
  end

  def test_empty_batch_not_sent
    sender = RequestCapturingSender.new
    client = Client.new(sender, nil)

    client.send_batch(Batch.new)

    assert_nil(sender.request)
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

  def test_candidates_correctly_assigned_to_corresponding_lookup
    candidate0 = {'input_index' => 0, 'candidate_index' => 0, 'addressee' => 'Mister 0'}
    candidate1 = {'input_index' => 1, 'candidate_index' => 0, 'addressee' => 'Mister 1'}
    candidate2 = {'input_index' => 1, 'candidate_index' => 1, 'addressee' => 'Mister 2'}
    raw_candidates = [candidate0, candidate1, candidate2]

    expected_candidates = [Candidate.new(candidate0), Candidate.new(candidate1), Candidate.new(candidate2)]
    batch = Batch.new
    batch.add(Lookup.new)
    batch.add(Lookup.new)
    sender = MockSender.new(Response.new('[]', 0))
    deserializer = FakeDeserializer.new(raw_candidates)
    client = Client.new(sender, deserializer)

    client.send_batch(batch)

    assert_equal(expected_candidates[0].addressee, batch.get_by_index(0).result[0].addressee)
    assert_equal(expected_candidates[1].addressee, batch.get_by_index(1).result[0].addressee)
    assert_equal(expected_candidates[2].addressee, batch.get_by_index(1).result[1].addressee)
  end

  def test_raises_exception_when_response_has_error
    exception = SmartyStreets::BadCredentialsError
    client = Client.new(MockExceptionSender.new(exception), FakeSerializer.new(nil))

    assert_raises exception do
      client.send_lookup(Lookup.new)
    end
  end
end