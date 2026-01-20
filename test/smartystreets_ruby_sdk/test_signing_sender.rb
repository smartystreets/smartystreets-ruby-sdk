require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/basic_auth_credentials'
require './lib/smartystreets_ruby_sdk/static_credentials'
require './lib/smartystreets_ruby_sdk/shared_credentials'
require './lib/smartystreets_ruby_sdk/signing_sender'
require_relative '../../lib/smartystreets_ruby_sdk/request'
require_relative '../../lib/smartystreets_ruby_sdk/response'
require_relative '../mocks/mock_sender'

class TestSigningSender < Minitest::Test
  BasicAuthCredentials = SmartyStreets::BasicAuthCredentials
  SharedCredentials = SmartyStreets::SharedCredentials
  SigningSender = SmartyStreets::SigningSender
  StaticCredentials = SmartyStreets::StaticCredentials

  def setup
    @inner = MockSender.new(SmartyStreets::Response.new('Test payload', '200'))
    @request = SmartyStreets::Request.new
  end

  def test_successful_signing_with_static_credentials
    @credentials = StaticCredentials.new('testID', 'testToken')
    @sender = SigningSender.new(@credentials, @inner)

    @sender.send(@request)

    assert_equal('testID', @request.parameters['auth-id'])
    assert_equal('testToken', @request.parameters['auth-token'])
  end

  def test_successful_signing_with_shared_credentials
    @credentials = SharedCredentials.new('testID', 'https://test.host.com')
    @sender = SigningSender.new(@credentials, @inner)

    @sender.send(@request)

    assert_equal('testID', @request.parameters['key'])
    assert_equal('https://test.host.com', @request.referer)
  end

  def test_successful_signing_with_basic_auth_credentials
    @credentials = BasicAuthCredentials.new('testID', 'testToken')
    @sender = SigningSender.new(@credentials, @inner)

    @sender.send(@request)

    assert_equal('testID', @request.auth_id)
    assert_equal('testToken', @request.auth_token)
  end
end