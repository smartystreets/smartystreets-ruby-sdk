# frozen_string_literal: true

require_relative '../test_helper'
require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/shared_credentials'
require_relative '../../lib/smartystreets_ruby_sdk/static_credentials'
require_relative '../../lib/smartystreets_ruby_sdk/signing_sender'
require_relative '../../lib/smartystreets_ruby_sdk/request'

class TestAuth < Minitest::Test
  SharedCredentials = SmartyStreets::SharedCredentials
  StaticCredentials = SmartyStreets::StaticCredentials
  SigningSender = SmartyStreets::SigningSender
  Request = SmartyStreets::Request

  class DummySender
    attr_reader :last_request

    def send(request)
      @last_request = request
      'sent!'
    end
  end

  def test_shared_credentials_signs_request
    creds = SharedCredentials.new('id123', 'host.com')
    req = Request.new
    creds.sign(req)
    assert_equal 'id123', req.parameters['key']
    assert_equal 'host.com', req.referer
  end

  def test_static_credentials_signs_request
    creds = StaticCredentials.new('id456', 'token789')
    req = Request.new
    creds.sign(req)
    assert_equal 'id456', req.parameters['auth-id']
    assert_equal 'token789', req.parameters['auth-token']
  end

  def test_signing_sender_delegates_and_signs
    creds = StaticCredentials.new('id', 'token')
    dummy = DummySender.new
    sender = SigningSender.new(creds, dummy)
    req = Request.new
    result = sender.send(req)
    assert_equal 'id', req.parameters['auth-id']
    assert_equal 'token', req.parameters['auth-token']
    assert_equal req, dummy.last_request
    assert_equal 'sent!', result
  end

  def test_signing_sender_with_shared_credentials
    creds = SharedCredentials.new('id', 'host')
    dummy = DummySender.new
    sender = SigningSender.new(creds, dummy)
    req = Request.new
    sender.send(req)
    assert_equal 'id', req.parameters['key']
    assert_equal 'host', req.referer
  end

  def test_signing_sender_chains_multiple
    creds1 = StaticCredentials.new('id1', 'token1')
    creds2 = SharedCredentials.new('id2', 'host2')
    dummy = DummySender.new
    sender = SigningSender.new(creds2, SigningSender.new(creds1, dummy))
    req = Request.new
    sender.send(req)
    assert_equal 'id1', req.parameters['auth-id']
    assert_equal 'token1', req.parameters['auth-token']
    assert_equal 'id2', req.parameters['key']
    assert_equal 'host2', req.referer
  end

  def test_shared_credentials_with_nil_and_empty
    creds = SharedCredentials.new(nil, '')
    req = Request.new
    creds.sign(req)
    assert_nil req.parameters['key']
    assert_equal '', req.referer
  end

  def test_static_credentials_with_non_string_types
    creds = StaticCredentials.new(123, :token)
    req = Request.new
    creds.sign(req)
    assert_equal 123, req.parameters['auth-id']
    assert_equal :token, req.parameters['auth-token']
  end

  def test_signing_sender_with_nil_sender
    creds = StaticCredentials.new('id', 'token')
    assert_raises(TypeError) do
      SigningSender.new(creds, nil).send(Request.new)
    end
  end

  def test_signing_sender_thread_safety
    creds = StaticCredentials.new('id', 'token')
    dummy = DummySender.new
    sender = SigningSender.new(creds, dummy)
    threads = Array.new(10) do
      Thread.new do
        req = Request.new
        sender.send(req)
        assert_equal 'id', req.parameters['auth-id']
        assert_equal 'token', req.parameters['auth-token']
      end
    end
    threads.each(&:join)
  end

  def test_signing_same_request_multiple_times
    creds = StaticCredentials.new('id', 'token')
    req = Request.new
    creds.sign(req)
    creds.sign(req)
    assert_equal 'id', req.parameters['auth-id']
    assert_equal 'token', req.parameters['auth-token']
  end

  def test_signing_request_with_existing_parameters
    creds = StaticCredentials.new('id', 'token')
    req = Request.new
    req.parameters['auth-id'] = 'existing'
    creds.sign(req)
    assert_equal 'id', req.parameters['auth-id']
    assert_equal 'token', req.parameters['auth-token']
  end

  def test_signing_request_with_nil_parameters_hash
    creds = StaticCredentials.new('id', 'token')
    req = Request.new
    req.instance_variable_set(:@parameters, nil)
    assert_raises(NoMethodError) { creds.sign(req) }
  end

  def test_signing_frozen_request
    creds = StaticCredentials.new('id', 'token')
    req = Request.new
    req.parameters.freeze
    assert_raises(FrozenError) { creds.sign(req) }
  end

  def test_signing_sender_with_nil_credentials
    dummy = DummySender.new
    assert_raises(NoMethodError) do
      SigningSender.new(nil, dummy).send(Request.new)
    end
  end

  def test_signing_sender_with_deep_chain
    dummy = DummySender.new
    sender = 10.downto(1).inject(dummy) do |inner, i|
      SigningSender.new(StaticCredentials.new("id#{i}", "token#{i}"), inner)
    end
    req = Request.new
    sender.send(req)
    assert_equal 'id10', req.parameters['auth-id']
    assert_equal 'token10', req.parameters['auth-token']
  end
end
