require_relative '../test_helper'
require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/request'

class TestRequest < Minitest::Test
  Request = SmartyStreets::Request

  def test_initialize_defaults
    req = Request.new
    assert_equal({}, req.parameters)
    assert_nil req.payload
    assert_nil req.url_prefix
    assert_nil req.url_components
    assert_nil req.referer
    assert_equal({}, req.header)
    assert_equal 'application/json', req.content_type
  end

  def test_attribute_accessors
    req = Request.new
    req.parameters = { 'foo' => 'bar' }
    req.payload = 'data'
    req.url_prefix = 'http://example.com'
    req.url_components = '/path'
    req.referer = 'referer-value'
    req.header = { 'X-Test' => '1' }
    req.content_type = 'text/plain'
    assert_equal({ 'foo' => 'bar' }, req.parameters)
    assert_equal 'data', req.payload
    assert_equal 'http://example.com', req.url_prefix
    assert_equal '/path', req.url_components
    assert_equal 'referer-value', req.referer
    assert_equal({ 'X-Test' => '1' }, req.header)
    assert_equal 'text/plain', req.content_type
  end

  def test_parameters_can_be_updated
    req = Request.new
    req.parameters['a'] = 1
    req.parameters['b'] = 2
    assert_equal 1, req.parameters['a']
    assert_equal 2, req.parameters['b']
  end

  def test_header_can_be_updated
    req = Request.new
    req.header['A'] = 'B'
    assert_equal 'B', req.header['A']
  end

  def test_content_type_edge_cases
    req = Request.new
    req.content_type = nil
    assert_nil req.content_type
    req.content_type = ''
    assert_equal '', req.content_type
  end
end
