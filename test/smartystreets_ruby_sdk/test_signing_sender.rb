require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/static_credentials'
require './lib/smartystreets_ruby_sdk/shared_credentials'
require './lib/smartystreets_ruby_sdk/signing_sender'

class TestSigningSender < Minitest::Test
  def setup
    @inner = MockSender.new(Smartystreets::Response.new('Test payload', '200'))
    @request = Smartystreets::Request.new
  end

  def test_successful_signing_with_static_credentials
    @credentials = Smartystreets::StaticCredentials.new('testID', 'testToken')
    @sender = Smartystreets::SigningSender.new(@credentials, @inner)

    @sender.send(@request)

    assert_equal('testID', @request.parameters['auth-id'])
    assert_equal('testToken', @request.parameters['auth-token'])
  end

  def test_successful_signing_with_shared_credentials
    @credentials = Smartystreets::SharedCredentials.new('testID', 'https://test.host.com')
    @sender = Smartystreets::SigningSender.new(@credentials, @inner)

    @sender.send(@request)

    assert_equal('testID', @request.parameters['auth-id'])
    assert_equal('https://test.host.com', @request.referer)
  end
end
