# frozen_string_literal: true

require_relative '../../test_helper'
require 'smartystreets_ruby_sdk/us_street/metadata'

module SmartyStreets
  module USStreet
    class TestMetadata < Minitest::Test
      def test_attribute_assignment
        sample = {
          'record_type' => 'S',
          'zip_type' => 'Standard',
          'county_fips' => '12345',
          'county_name' => 'County',
          'carrier_route' => 'C001',
          'congressional_district' => '01',
          'building_default_indicator' => 'Y',
          'rdi' => 'Residential',
          'elot_sequence' => 'A',
          'elot_sort' => 'B',
          'latitude' => 40.0,
          'longitude' => -111.0,
          'precision' => 'Zip9',
          'time_zone' => 'Mountain',
          'utc_offset' => -7,
          'dst' => true,
          'ews_match' => false
        }
        m = Metadata.new(sample)
        assert_equal 'S', m.record_type
        assert_equal 'Standard', m.zip_type
        assert_equal '12345', m.county_fips
        assert_equal 'County', m.county_name
        assert_equal 'C001', m.carrier_route
        assert_equal '01', m.congressional_district
        assert_equal 'Y', m.building_default_indicator
        assert_equal 'Residential', m.rdi
        assert_equal 'A', m.elot_sequence
        assert_equal 'B', m.elot_sort
        assert_equal 40.0, m.latitude
        assert_equal(-111.0, m.longitude)
        assert_equal 'Zip9', m.precision
        assert_equal 'Mountain', m.time_zone
        assert_equal(-7, m.utc_offset)
        assert_equal true, m.obeys_dst
        assert_equal false, m.is_an_ews_match
      end

      def test_missing_keys_are_nil
        m = Metadata.new({})
        assert_nil m.record_type
        assert_nil m.latitude
      end
    end
  end
end
