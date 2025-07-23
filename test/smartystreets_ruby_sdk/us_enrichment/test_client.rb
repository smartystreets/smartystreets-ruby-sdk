# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../test_helper'
require_relative '../../../lib/smartystreets_ruby_sdk/exceptions'
require_relative '../../mocks/fake_serializer'
require_relative '../../mocks/fake_deserializer'
require_relative '../../mocks/mock_sender'
require_relative '../../mocks/mock_exception_sender'
require_relative '../../mocks/request_capturing_sender'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/client'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/lookup'

module SmartyStreets
  module USEnrichment
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
        # Return a structure that works for all tested response types
        [
          {
            # For Property::Financial::Response and Principal::Response
            'assessed_value' => 123,
            'first_floor_sqft' => 456,
            # For GeoReference::Response
            'geo_id' => 'GEO123',
            # For Secondary::Response
            'root_address' => {},
            # For Secondary::Count::Response
            'count' => 1
          }
        ]
      end
    end

    class FakeResponse
      attr_reader :payload, :error, :header

      def initialize(payload = nil, error = nil, header = {})
        @payload = payload
        @error = error
        @header = header
      end
    end

    class TestClient < Minitest::Test
      def setup
        @serializer = FakeSerializer.new
        @response = FakeResponse.new('{}', nil, { 'etag' => 'ETAG' })
        @sender = FakeSender.new(@response)
        @client = Client.new(@sender, @serializer)
      end

      def test_send_property_financial_lookup_with_string
        lookup = 'foo'
        serializer = Class.new do
          def deserialize(_)
            [{ 'attributes' => { 'assessed_value' => 123 } }]
          end
        end.new
        USEnrichment::Property::Financial::Lookup.stub(:new,
                                                       OpenStruct.new(data_set: 'property', data_sub_set: 'financial', custom_param_hash: {}, smarty_key: nil, etag: nil,
                                                                      freeform: nil, street: nil, city: nil, state: nil, zipcode: nil)) do
          @sender = FakeSender.new(FakeResponse.new(nil, nil, { 'etag' => 'ETAG' }))
          @client = Client.new(@sender, serializer)
          assert @client.send_property_financial_lookup(lookup)
        end
      end

      def test_send_property_principal_lookup_with_string
        lookup = 'foo'
        serializer = Class.new do
          def deserialize(_)
            [{ 'attributes' => { 'first_floor_sqft' => 456 } }]
          end
        end.new
        USEnrichment::Property::Principal::Lookup.stub(:new,
                                                       OpenStruct.new(data_set: 'property', data_sub_set: 'principal', custom_param_hash: {}, smarty_key: nil, etag: nil,
                                                                      freeform: nil, street: nil, city: nil, state: nil, zipcode: nil)) do
          @sender = FakeSender.new(FakeResponse.new(nil, nil, { 'etag' => 'ETAG' }))
          @client = Client.new(@sender, serializer)
          assert @client.send_property_principal_lookup(lookup)
        end
      end

      def test_send_geo_reference_lookup_with_string
        lookup = 'foo'
        serializer = Class.new do
          def deserialize(_)
            [{
              'attributes' => {
                'geo_id' => 'GEO123',
                'census_block' => {},
                'census_county_division' => {},
                'census_tract' => {},
                'core_based_stat_area' => {},
                'place' => {}
              }
            }]
          end
        end.new
        USEnrichment::GeoReference::Lookup.stub(:new,
                                                OpenStruct.new(data_set: 'geo-reference', data_sub_set: nil, custom_param_hash: {}, smarty_key: nil, etag: nil,
                                                               freeform: nil, street: nil, city: nil, state: nil, zipcode: nil)) do
          @sender = FakeSender.new(FakeResponse.new(nil, nil, { 'etag' => 'ETAG' }))
          @client = Client.new(@sender, serializer)
          assert @client.send_geo_reference_lookup(lookup)
        end
      end

      def test_send_secondary_lookup_with_string
        lookup = 'foo'
        serializer = Class.new do
          def deserialize(_)
            [{ 'root_address' => {}, 'secondaries' => [] }]
          end
        end.new
        USEnrichment::Secondary::Lookup.stub(:new,
                                             OpenStruct.new(data_set: 'secondary', data_sub_set: nil, custom_param_hash: {}, smarty_key: nil, etag: nil,
                                                            freeform: nil, street: nil, city: nil, state: nil, zipcode: nil)) do
          @sender = FakeSender.new(FakeResponse.new(nil, nil, { 'etag' => 'ETAG' }))
          @client = Client.new(@sender, serializer)
          assert @client.send_secondary_lookup(lookup)
        end
      end

      def test_send_secondary_count_lookup_with_string
        lookup = 'foo'
        USEnrichment::Secondary::Count::Lookup.stub(:new,
                                                    OpenStruct.new(data_set: 'secondary', data_sub_set: 'count', custom_param_hash: {}, smarty_key: nil, etag: nil,
                                                                   freeform: nil, street: nil, city: nil, state: nil, zipcode: nil)) do
          assert @client.send_secondary_count_lookup(lookup)
        end
      end

      def test_send_generic_lookup_with_string
        lookup = 'foo'
        USEnrichment::Lookup.stub(:new,
                                  OpenStruct.new(data_set: 'foo', data_sub_set: 'bar', custom_param_hash: {}, smarty_key: nil, etag: nil, freeform: nil,
                                                 street: nil, city: nil, state: nil, zipcode: nil)) do
          assert @client.send_generic_lookup(lookup, 'foo', 'bar')
        end
      end

      def test_send_raises_on_error
        sender = FakeSender.new(FakeResponse.new('{}', 'boom', {}))
        client = Client.new(sender, @serializer)
        lookup = OpenStruct.new(data_set: 'property', data_sub_set: 'financial', custom_param_hash: {},
                                smarty_key: nil, etag: nil, freeform: nil, street: nil, city: nil, state: nil, zipcode: nil)
        assert_raises RuntimeError do
          client.__send(lookup)
        end
      end
    end
  end
end

class TestStreetClient < Minitest::Test
  def test_financial_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.street = 'street'
    lookup.city = 'city'
    lookup.state = 'state'
    lookup.zipcode = 'zipcode'
    freeform_lookup.freeform = 'street city state zipcode'

    client.send_property_financial_lookup('123')
    assert_equal('/123/property/financial', sender.request.url_components)

    client.send_property_financial_lookup(lookup)
    assert_equal('/search/property/financial', sender.request.url_components)
    assert_equal('street', sender.request.parameters['street'])
    assert_equal('city', sender.request.parameters['city'])
    assert_equal('state', sender.request.parameters['state'])
    assert_equal('zipcode', sender.request.parameters['zipcode'])

    client.send_property_financial_lookup(freeform_lookup)
    assert_equal('/search/property/financial', sender.request.url_components)
    assert_equal('street city state zipcode', sender.request.parameters['freeform'])
  end

  def test_financial_etag_present
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.street = 'street'
    lookup.city = 'city'
    lookup.state = 'state'
    lookup.zipcode = 'zipcode'
    lookup.etag = 'etag'

    client.send_property_financial_lookup(lookup)
    assert_equal('etag', sender.request.header['ETAG'])
  end

  def test_principal_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.street = 'street'
    lookup.city = 'city'
    lookup.state = 'state'
    lookup.zipcode = 'zipcode'
    freeform_lookup.freeform = 'street city state zipcode'

    client.send_property_principal_lookup('123')
    assert_equal('/123/property/principal', sender.request.url_components)

    client.send_property_principal_lookup(lookup)
    assert_equal('/search/property/principal', sender.request.url_components)
    assert_equal('street', sender.request.parameters['street'])
    assert_equal('city', sender.request.parameters['city'])
    assert_equal('state', sender.request.parameters['state'])
    assert_equal('zipcode', sender.request.parameters['zipcode'])

    client.send_property_principal_lookup(freeform_lookup)
    assert_equal('/search/property/principal', sender.request.url_components)
    assert_equal('street city state zipcode', sender.request.parameters['freeform'])
  end

  def test_principal_etag_present
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.street = 'street'
    lookup.city = 'city'
    lookup.state = 'state'
    lookup.zipcode = 'zipcode'
    lookup.etag = 'etag'

    client.send_property_principal_lookup(lookup)
    assert_equal('etag', sender.request.header['ETAG'])
  end

  def test_geo_reference_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.street = 'street'
    lookup.city = 'city'
    lookup.state = 'state'
    lookup.zipcode = 'zipcode'
    freeform_lookup.freeform = 'street city state zipcode'

    client.send_geo_reference_lookup('123')
    assert_equal('/123/geo-reference', sender.request.url_components)

    client.send_geo_reference_lookup(lookup)
    assert_equal('/search/geo-reference', sender.request.url_components)
    assert_equal('street', sender.request.parameters['street'])
    assert_equal('city', sender.request.parameters['city'])
    assert_equal('state', sender.request.parameters['state'])
    assert_equal('zipcode', sender.request.parameters['zipcode'])

    client.send_geo_reference_lookup(freeform_lookup)
    assert_equal('/search/geo-reference', sender.request.url_components)
    assert_equal('street city state zipcode', sender.request.parameters['freeform'])
  end

  def test_geo_reference_etag_present
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.street = 'street'
    lookup.city = 'city'
    lookup.state = 'state'
    lookup.zipcode = 'zipcode'
    lookup.etag = 'etag'

    client.send_geo_reference_lookup(lookup)
    assert_equal('etag', sender.request.header['ETAG'])
  end

  def test_secondary_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.street = 'street'
    lookup.city = 'city'
    lookup.state = 'state'
    lookup.zipcode = 'zipcode'
    freeform_lookup.freeform = 'street city state zipcode'

    client.send_secondary_lookup('123')
    assert_equal('/123/secondary', sender.request.url_components)

    client.send_secondary_lookup(lookup)
    assert_equal('/search/secondary', sender.request.url_components)
    assert_equal('street', sender.request.parameters['street'])
    assert_equal('city', sender.request.parameters['city'])
    assert_equal('state', sender.request.parameters['state'])
    assert_equal('zipcode', sender.request.parameters['zipcode'])

    client.send_secondary_lookup(freeform_lookup)
    assert_equal('/search/secondary', sender.request.url_components)
    assert_equal('street city state zipcode', sender.request.parameters['freeform'])
  end

  def test_secondary_etag_present
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.street = 'street'
    lookup.city = 'city'
    lookup.state = 'state'
    lookup.zipcode = 'zipcode'
    lookup.etag = 'etag'

    client.send_secondary_lookup(lookup)
    assert_equal('etag', sender.request.header['ETAG'])
  end

  def test_secondary_count_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.street = 'street'
    lookup.city = 'city'
    lookup.state = 'state'
    lookup.zipcode = 'zipcode'
    freeform_lookup.freeform = 'street city state zipcode'

    client.send_secondary_count_lookup('123')
    assert_equal('/123/secondary/count', sender.request.url_components)

    client.send_secondary_count_lookup(lookup)
    assert_equal('/search/secondary/count', sender.request.url_components)
    assert_equal('street', sender.request.parameters['street'])
    assert_equal('city', sender.request.parameters['city'])
    assert_equal('state', sender.request.parameters['state'])
    assert_equal('zipcode', sender.request.parameters['zipcode'])

    client.send_secondary_count_lookup(freeform_lookup)
    assert_equal('/search/secondary/count', sender.request.url_components)
    assert_equal('street city state zipcode', sender.request.parameters['freeform'])
  end
end
