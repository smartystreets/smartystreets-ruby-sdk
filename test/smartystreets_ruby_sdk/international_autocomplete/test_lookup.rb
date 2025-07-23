# frozen_string_literal: true

require_relative '../../test_helper'
require 'minitest/autorun'
require 'smartystreets_ruby_sdk/international_autocomplete/lookup'

class InternationalAutocompleteLookupTest < Minitest::Test
  Lookup = SmartyStreets::InternationalAutocomplete::Lookup

  def test_initialize_defaults
    lookup = Lookup.new
    assert_equal [], lookup.result
    assert_nil lookup.search
    assert_nil lookup.address_id
    assert_nil lookup.country
    assert_nil lookup.max_results
    assert_nil lookup.locality
    assert_nil lookup.postal_code
    assert_equal({}, lookup.custom_param_hash)
  end

  def test_initialize_with_arguments
    lookup = Lookup.new('search', 'addrid', 'US', 5, 'local', '90210', { 'foo' => 'bar' })
    assert_equal 'search', lookup.search
    assert_equal 'addrid', lookup.address_id
    assert_equal 'US', lookup.country
    assert_equal 5, lookup.max_results
    assert_equal 'local', lookup.locality
    assert_equal '90210', lookup.postal_code
    assert_equal({ 'foo' => 'bar' }, lookup.custom_param_hash)
  end

  def test_add_custom_parameter
    lookup = Lookup.new
    lookup.add_custom_parameter('foo', 'bar')
    assert_equal 'bar', lookup.custom_param_hash['foo']
    lookup.add_custom_parameter('baz', 'qux')
    assert_equal 'qux', lookup.custom_param_hash['baz']
  end

  def test_custom_param_hash_is_independent
    l1 = Lookup.new
    l2 = Lookup.new
    l1.add_custom_parameter('a', 1)
    l2.add_custom_parameter('b', 2)
    assert_equal({ 'a' => 1 }, l1.custom_param_hash)
    assert_equal({ 'b' => 2 }, l2.custom_param_hash)
  end
end
