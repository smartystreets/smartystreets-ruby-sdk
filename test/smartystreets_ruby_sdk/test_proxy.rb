require_relative '../test_helper'
require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/proxy'

class TestProxy < Minitest::Test
  Proxy = SmartyStreets::Proxy

  def test_initialize_with_required_arguments
    proxy = Proxy.new('localhost', 8080)
    assert_equal 'localhost', proxy.host
    assert_equal 8080, proxy.port
    assert_nil proxy.username
    assert_nil proxy.password
  end

  def test_initialize_with_all_arguments
    proxy = Proxy.new('proxy.example.com', 3128, 'user', 'pass')
    assert_equal 'proxy.example.com', proxy.host
    assert_equal 3128, proxy.port
    assert_equal 'user', proxy.username
    assert_equal 'pass', proxy.password
  end

  def test_attribute_accessors
    proxy = Proxy.new('host', 1)
    proxy.host = 'newhost'
    proxy.port = 9999
    proxy.username = 'newuser'
    proxy.password = 'newpass'
    assert_equal 'newhost', proxy.host
    assert_equal 9999, proxy.port
    assert_equal 'newuser', proxy.username
    assert_equal 'newpass', proxy.password
  end

  def test_nil_host
    assert_raises(ArgumentError) { Proxy.new(nil, 8080) }
  end

  def test_empty_host
    proxy = Proxy.new('', 8080)
    assert_equal '', proxy.host
  end

  def test_zero_port
    proxy = Proxy.new('localhost', 0)
    assert_equal 0, proxy.port
  end

  def test_negative_port
    proxy = Proxy.new('localhost', -1)
    assert_equal -1, proxy.port
  end

  def test_string_port
    proxy = Proxy.new('localhost', '8080')
    assert_equal '8080', proxy.port
  end

  def test_long_username_and_password
    long_user = 'u' * 1000
    long_pass = 'p' * 1000
    proxy = Proxy.new('host', 1, long_user, long_pass)
    assert_equal long_user, proxy.username
    assert_equal long_pass, proxy.password
  end

  def test_equality_of_two_proxies_with_same_values
    p1 = Proxy.new('host', 1, 'user', 'pass')
    p2 = Proxy.new('host', 1, 'user', 'pass')
    refute_same p1, p2
    assert_equal p1.host, p2.host
    assert_equal p1.port, p2.port
    assert_equal p1.username, p2.username
    assert_equal p1.password, p2.password
  end
end 