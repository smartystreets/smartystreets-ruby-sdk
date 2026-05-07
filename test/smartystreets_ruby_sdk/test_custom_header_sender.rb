require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/custom_header_sender'
require_relative '../../lib/smartystreets_ruby_sdk/response'
require_relative '../../lib/smartystreets_ruby_sdk/request'
require_relative '../../lib/smartystreets_ruby_sdk/shared_credentials'
require_relative '../mocks/mock_sender'

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
    assert_equal(2, request.header.length)
    assert_equal(%w(1 2), request.header['A'])
    assert_equal(['1'], request.header['B'])
  end

  def test_appended_headers_are_joined_with_separator
    mock_response = SmartyStreets::Response.new('Testing', '123')
    inner = MockSender.new(mock_response)
    sender = SmartyStreets::CustomHeaderSender.new(
      inner,
      { 'User-Agent' => %w(base-value custom-value) },
      { 'User-Agent' => ' ' }
    )
    request = SmartyStreets::Request.new

    sender.send(request)

    assert_equal('base-value custom-value', request.header['User-Agent'])
  end

  def test_send_forwards_smarty_request_with_upstream_state_intact
    mock_response = SmartyStreets::Response.new('', '200')
    inner = MockSender.new(mock_response)
    sender = SmartyStreets::CustomHeaderSender.new(inner, { 'X-Test' => ['value'] })
    request = SmartyStreets::Request.new
    request.url_prefix = 'http://localhost'
    SmartyStreets::SharedCredentials.new('shared-id', 'https://example.com').sign(request)

    sender.send(request)

    assert_same(request, inner.request)
    assert_equal('https://example.com', request.referer)
    assert_equal('shared-id', request.parameters['key'])
    assert_equal(['value'], request.header['X-Test'])
  end
end
