require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/url_prefix_sender'
require_relative '../../lib/smartystreets_ruby_sdk/request'
require_relative '../../lib/smartystreets_ruby_sdk/response'

class TestURLPrefixSender < Minitest::Test
  def test_provided_url_overrides_request_url
    inner = MockSender.new(SmartyStreets::Response.new(nil, 123))
    original = SmartyStreets::Request.new
    original.url_prefix = 'http://www.google.com/the/path/stays'
    override = 'https://smartystreets.com/the/path/is/ignored'
    sender = SmartyStreets::URLPrefixSender.new(override, inner)

    sender.send(original)

    assert_equal(original.url_prefix, override)
  end
end