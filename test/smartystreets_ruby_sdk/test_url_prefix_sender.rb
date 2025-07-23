require_relative '../test_helper'
require_relative '../../lib/smartystreets_ruby_sdk/url_prefix_sender'
require_relative '../../lib/smartystreets_ruby_sdk/request'
require_relative '../../lib/smartystreets_ruby_sdk/response'
require_relative '../mocks/mock_sender'

class TestURLPrefixSender < Minitest::Test
  def test_request_url_present
    inner = MockSender.new(SmartyStreets::Response.new(nil, 123))
    request = SmartyStreets::Request.new
    request.url_components = '/jimbo'
    sender = SmartyStreets::URLPrefixSender.new('http://mysite.com/lookup', inner)

    sender.send(request)

    assert_equal('http://mysite.com/lookup/jimbo', request.url_prefix)
  end

  def test_request_url_not_present
    inner = MockSender.new(SmartyStreets::Response.new(nil, 123))
    request = SmartyStreets::Request.new
    sender = SmartyStreets::URLPrefixSender.new('http://mysite.com/lookup', inner)

    sender.send(request)

    assert_equal('http://mysite.com/lookup', request.url_prefix)
  end

  def test_multiple_sends
    inner = MockSender.new(SmartyStreets::Response.new(nil, 123))
    request = SmartyStreets::Request.new
    request.url_components = '/jimbo'
    sender = SmartyStreets::URLPrefixSender.new('http://mysite.com/lookup', inner)

    sender.send(request)
    sender.send(request)

    assert_equal('http://mysite.com/lookup/jimbo', request.url_prefix)
  end
end
