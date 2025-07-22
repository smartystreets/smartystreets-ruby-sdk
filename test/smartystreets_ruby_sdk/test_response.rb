require_relative '../test_helper'
require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/response'

class TestResponse < Minitest::Test
  Response = SmartyStreets::Response

  def test_initialize_with_required_arguments
    resp = Response.new('data', 200)
    assert_equal 'data', resp.payload
    assert_equal 200, resp.status_code
    assert_nil resp.header
    assert_nil resp.error
  end

  def test_initialize_with_all_arguments
    header = { 'X-Test' => '1' }
    error = StandardError.new('fail')
    resp = Response.new('payload', 404, header, error)
    assert_equal 'payload', resp.payload
    assert_equal 404, resp.status_code
    assert_equal header, resp.header
    assert_equal error, resp.error
  end

  def test_attribute_accessors
    resp = Response.new(nil, nil)
    resp.payload = 'foo'
    resp.status_code = 123
    resp.header = { 'A' => 'B' }
    resp.error = 'err'
    assert_equal 'foo', resp.payload
    assert_equal 123, resp.status_code
    assert_equal({ 'A' => 'B' }, resp.header)
    assert_equal 'err', resp.error
  end

  def test_error_can_be_any_object
    resp = Response.new(nil, nil)
    resp.error = 42
    assert_equal 42, resp.error
    resp.error = ['array']
    assert_equal ['array'], resp.error
  end
end 