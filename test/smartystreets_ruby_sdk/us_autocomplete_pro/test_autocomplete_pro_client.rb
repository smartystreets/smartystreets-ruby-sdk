require_relative '../../test_helper'
require './lib/smartystreets_ruby_sdk/us_autocomplete_pro/client'
require './lib/smartystreets_ruby_sdk/us_autocomplete_pro/lookup'
require './lib/smartystreets_ruby_sdk/response'
require_relative '../../mocks/mock_sender'
require_relative '../../mocks/request_capturing_sender'
require_relative '../../mocks/fake_serializer'
require_relative '../../mocks/fake_deserializer'

module SmartyStreets
  module USAutocompletePro
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
      def deserialize(_payload)
        { 'suggestions' => [{ 'text' => 'foo' }] }
      end
    end

    class FakeResponse
      attr_reader :payload, :error

      def initialize(payload = nil, error = nil)
        @payload = payload
        @error = error
      end
    end

    class FakeLookup
      attr_accessor :search, :max_results, :city_filter, :state_filter, :zip_filter, :exclude_states, :prefer_cities,
                    :prefer_states, :prefer_zip_codes, :prefer_ratio, :source, :prefer_geolocation, :selected, :custom_param_hash, :result

      def initialize
        @search = 'foo'
        @max_results = 10
        @city_filter = []
        @state_filter = []
        @zip_filter = []
        @exclude_states = []
        @prefer_cities = []
        @prefer_states = []
        @prefer_zip_codes = []
        @prefer_ratio = 1
        @source = nil
        @prefer_geolocation = nil
        @selected = nil
        @custom_param_hash = {}
        @result = nil
      end
    end

    class TestClient < Minitest::Test
      def setup
        @serializer = FakeSerializer.new
        @response = FakeResponse.new('{}', nil)
        @sender = FakeSender.new(@response)
        @client = Client.new(@sender, @serializer)
      end

      def test_send_assigns_suggestions
        lookup = FakeLookup.new
        @client.send(lookup)
        assert lookup.result.first.is_a?(SmartyStreets::USAutocompletePro::Suggestion)
      end

      def test_send_raises_on_missing_search
        lookup = FakeLookup.new
        lookup.search = nil
        assert_raises SmartyStreets::SmartyError do
          @client.send(lookup)
        end
      end

      def test_send_raises_on_error
        sender = FakeSender.new(FakeResponse.new('{}', 'boom'))
        client = Client.new(sender, @serializer)
        lookup = FakeLookup.new
        assert_raises RuntimeError do
          client.send(lookup)
        end
      end
    end
  end
end

class TestAutocompleteProClient < Minitest::Test
  Client = SmartyStreets::USAutocompletePro::Client
  Lookup = SmartyStreets::USAutocompletePro::Lookup
  Response = SmartyStreets::Response

  def test_sending_prefix_only_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    client.send(Lookup.new('1'))

    assert_equal('1', sender.request.parameters['search'])
    assert_nil(sender.request.parameters['max_results'])
    assert_nil(sender.request.parameters['prefer_ratio'])
  end

  def test_sending_fully_populated_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)
    lookup = Lookup.new('1')
    lookup.max_results = 2
    lookup.add_city_filter('3')
    lookup.add_state_filter('4')
    lookup.add_state_filter('4.5')
    lookup.add_zip_filter('5')
    lookup.add_state_exclusion('6')
    lookup.add_preferred_city('7')
    lookup.add_preferred_state('8')
    lookup.add_preferred_zip('9')
    lookup.prefer_ratio = 10
    lookup.prefer_geolocation = SmartyStreets::USAutocompletePro::GeolocationType::CITY
    lookup.source = 'all'

    client.send(lookup)

    assert_equal('1', sender.request.parameters['search'])
    assert_equal('2', sender.request.parameters['max_results'])
    assert_equal('3', sender.request.parameters['include_only_cities'])
    assert_equal('4;4.5', sender.request.parameters['include_only_states'])
    assert_equal('5', sender.request.parameters['include_only_zip_codes'])
    assert_equal('6', sender.request.parameters['exclude_states'])
    assert_equal('7', sender.request.parameters['prefer_cities'])
    assert_equal('8', sender.request.parameters['prefer_states'])
    assert_equal('9', sender.request.parameters['prefer_zip_codes'])
    assert_equal('10', sender.request.parameters['prefer_ratio'])
    assert_equal('none', sender.request.parameters['prefer_geolocation'])
    assert_equal('all', sender.request.parameters['source'])
  end

  def test_deserialize_called_with_response_body
    response = Response.new('Hello, World!', 0)

    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new({})
    client = Client.new(sender, deserializer)

    client.send(Lookup.new('1'))

    assert_equal(response.payload, deserializer.input)
  end

  def test_result_correctly_assigned_to_corresponding_lookup
    lookup = Lookup.new('1')
    expected_result = { 'suggestions' => [{ 'street_line' => '2' }] }

    sender = MockSender.new(Response.new('{[]}', 0))
    deserializer = FakeDeserializer.new(expected_result)
    client = Client.new(sender, deserializer)

    client.send(lookup)

    assert_equal('2', lookup.result[0].street_line)
  end

  def test_rejects_blank_lookup
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    assert_raises(SmartyStreets::SmartyError) do
      client.send(Lookup.new)
    end
  end

  def test_sets_geolocation_as_city_if_no_city_and_zip_filters
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new({})
    client = Client.new(sender, serializer)

    lookup = Lookup.new('1')
    lookup.max_results = 2
    lookup.source = 'all'
    lookup.prefer_geolocation = SmartyStreets::USAutocompletePro::GeolocationType::CITY

    client.send(lookup)

    assert_equal('1', sender.request.parameters['search'])
    assert_equal('2', sender.request.parameters['max_results'])
    assert_equal('city', sender.request.parameters['prefer_geolocation'])
    assert_equal('all', sender.request.parameters['source'])
  end
end
