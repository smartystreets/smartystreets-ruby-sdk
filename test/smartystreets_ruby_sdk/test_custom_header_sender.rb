require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/custom_header_sender'
require_relative '../../lib/smartystreets_ruby_sdk/response'
require_relative '../../lib/smartystreets_ruby_sdk/request'

class TestCustomHeaderSender < Minitest::Test
  def test_all_custom_headers_are_added_to_the_request
    headers = {}
    headers['A'] = %w(1 2)
    headers['B'] = ['1']
    mock_response = SmartyStreets::Response.new('Testing', '123')
    inner = MockSender.new(mock_response)
    sender = SmartyStreets::CustomHeaderSender.new(inner, headers)
    request = SmartyStreets::Request.new

    response = sender.send(request)

    assert_equal('Testing', response.payload)
    assert_equal('123', response.status_code)
    assert_equal(2, request.headers.length)
    assert_equal(%w(1 2), request.headers['A'])
    assert_equal(['1'], request.headers['B'])
  end
end