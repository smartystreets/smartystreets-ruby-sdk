require_relative '../../test_helper'
require 'smartystreets_ruby_sdk/us_street/client'

module SmartyStreets
  module USStreet
    class FakeSender
      attr_reader :last_request, :response

      def initialize(response)
        @response = response
      end

      def send(request)
        @last_request = request
        @response
      end
    end

    class FakeSerializer
      def serialize(_obj)
        'serialized'
      end

      def deserialize(_payload)
        [{ 'input_index' => 0 }]
      end
    end

    class FakeResponse
      attr_reader :payload, :error

      def initialize(payload = nil, error = nil)
        @payload = payload
        @error = error
      end
    end

    class TestClient < Minitest::Test
      def test_send_lookup_delegates_to_send_batch
        sender = FakeSender.new(FakeResponse.new('[]'))
        serializer = FakeSerializer.new
        client = Client.new(sender, serializer)
        lookup = Lookup.new('123 Main St')
        client.send_lookup(lookup)
        assert sender.last_request
      end

      def test_send_batch_empty_batch_does_nothing
        sender = FakeSender.new(FakeResponse.new('[]'))
        serializer = FakeSerializer.new
        client = Client.new(sender, serializer)
        batch = SmartyStreets::Batch.new
        assert_nil client.send_batch(batch)
      end

      def test_send_batch_raises_on_error
        sender = FakeSender.new(FakeResponse.new(nil, 'boom'))
        serializer = FakeSerializer.new
        client = Client.new(sender, serializer)
        batch = SmartyStreets::Batch.new
        batch.add(Lookup.new('123 Main St'))
        assert_raises RuntimeError do
          client.send_batch(batch)
        end
      end

      def test_assign_candidates_to_lookups
        sender = FakeSender.new(FakeResponse.new('[]'))
        serializer = FakeSerializer.new
        client = Client.new(sender, serializer)
        batch = SmartyStreets::Batch.new
        lookup = Lookup.new('123 Main St')
        batch.add(lookup)
        candidates = [{ 'input_index' => 0 }]
        client.assign_candidates_to_lookups(batch, candidates)
        assert_equal 1, lookup.result.size
      end
    end
  end
end
