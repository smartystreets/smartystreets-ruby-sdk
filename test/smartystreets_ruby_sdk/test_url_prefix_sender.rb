require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/url_prefix_sender'

class TestURLPrefixSender < Minitest::Test
  def test_provided_url_overrides_request_url
    inner = MockSender.new(Response.new(nil, 123))
    original = Request.new()
    original.url_prefix = 'http://www.google.com/the/path/stays'
    override = 'https://smartystreets.com/the/path/is/ignored'
    sender = URLPrefixSender.new(override, inner)

    sender.send(original)

    assert_equal(original.url_prefix, override)
  end
end