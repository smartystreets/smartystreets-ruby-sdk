# frozen_string_literal: true

require_relative '../../test_helper'
require 'smartystreets_ruby_sdk/us_street/lookup'

module SmartyStreets
  module USStreet
    class TestLookup < Minitest::Test
      def test_constructor_assigns_attributes
        l = Lookup.new('123 Main', 'Apt 4', 'Sec', 'Springfield', 'IL', '62704', 'last', 'addressee', 'urb', 'strict',
                       2, 'id', 'county', 'format')
        assert_equal '123 Main', l.street
        assert_equal 'Apt 4', l.street2
        assert_equal 'Sec', l.secondary
        assert_equal 'Springfield', l.city
        assert_equal 'IL', l.state
        assert_equal '62704', l.zipcode
        assert_equal 'last', l.lastline
        assert_equal 'addressee', l.addressee
        assert_equal 'urb', l.urbanization
        assert_equal 'strict', l.match
        assert_equal 2, l.candidates
        assert_equal 'id', l.input_id
        assert_equal 'county', l.county_source
        assert_equal 'format', l.format
      end

      def test_add_custom_parameter
        l = Lookup.new
        l.add_custom_parameter('foo', 'bar')
        assert_equal 'bar', l.custom_param_hash['foo']
      end

      def test_defaults
        l = Lookup.new
        assert_equal({}, l.custom_param_hash)
        assert_equal [], l.result
      end
    end
  end
end
