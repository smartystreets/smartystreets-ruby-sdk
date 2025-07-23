# frozen_string_literal: true

require_relative '../../test_helper'
require 'smartystreets_ruby_sdk/us_street/components'

module SmartyStreets
  module USStreet
    class TestComponents < Minitest::Test
      def test_attribute_assignment
        sample = {
          'urbanization' => 'URB',
          'primary_number' => '123',
          'street_name' => 'Main',
          'city_name' => 'Springfield',
          'zipcode' => '12345',
          'plus4_code' => '6789'
        }
        c = Components.new(sample)
        assert_equal 'URB', c.urbanization
        assert_equal '123', c.primary_number
        assert_equal 'Main', c.street_name
        assert_equal 'Springfield', c.city_name
        assert_equal '12345', c.zipcode
        assert_equal '6789', c.plus4_code
      end

      def test_missing_keys_are_nil
        c = Components.new({})
        assert_nil c.urbanization
        assert_nil c.zipcode
      end
    end
  end
end
