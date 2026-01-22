require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/basic_auth_credentials'
require_relative '../../lib/smartystreets_ruby_sdk/request'

class TestBasicAuthCredentials < Minitest::Test
  BasicAuthCredentials = SmartyStreets::BasicAuthCredentials

  def test_new_with_valid_credentials
    cred = BasicAuthCredentials.new('testID', 'testToken')

    assert_equal('testID', cred.instance_variable_get(:@auth_id))
    assert_equal('testToken', cred.instance_variable_get(:@auth_token))
  end

  def test_new_with_empty_auth_id
    assert_raises(ArgumentError) { BasicAuthCredentials.new('', 'testToken') }
  end

  def test_new_with_empty_auth_token
    assert_raises(ArgumentError) { BasicAuthCredentials.new('testID', '') }
  end

  def test_new_with_both_empty
    assert_raises(ArgumentError) { BasicAuthCredentials.new('', '') }
  end

  def test_new_with_nil_auth_id
    assert_raises(ArgumentError) { BasicAuthCredentials.new(nil, 'testToken') }
  end

  def test_new_with_nil_auth_token
    assert_raises(ArgumentError) { BasicAuthCredentials.new('testID', nil) }
  end

  def test_new_with_special_characters
    cred = BasicAuthCredentials.new('test@id#123', 'token!@#$%^&*()')

    assert_equal('test@id#123', cred.instance_variable_get(:@auth_id))
    assert_equal('token!@#$%^&*()', cred.instance_variable_get(:@auth_token))
  end

  def test_sign_sets_basic_auth
    cred = BasicAuthCredentials.new('myID', 'myToken')
    request = SmartyStreets::Request.new

    cred.sign(request)

    assert_equal(['myID', 'myToken'], request.basic_auth)
  end

  def test_sign_with_password_containing_colon
    cred = BasicAuthCredentials.new('validUserID', 'password:with:colons')
    request = SmartyStreets::Request.new

    cred.sign(request)

    assert_equal(['validUserID', 'password:with:colons'], request.basic_auth)
  end

  def test_sign_with_special_characters
    cred = BasicAuthCredentials.new('user@domain.com', 'p@ssw0rd!')
    request = SmartyStreets::Request.new

    cred.sign(request)

    assert_equal(['user@domain.com', 'p@ssw0rd!'], request.basic_auth)
  end

  def test_sign_with_unicode_characters
    cred = BasicAuthCredentials.new('用户', '密码')
    request = SmartyStreets::Request.new

    cred.sign(request)

    assert_equal(['用户', '密码'], request.basic_auth)
  end

  def test_sign_overwrites_existing_basic_auth
    cred = BasicAuthCredentials.new('newID', 'newToken')
    request = SmartyStreets::Request.new
    request.basic_auth = ['oldID', 'oldToken']

    cred.sign(request)

    assert_equal(['newID', 'newToken'], request.basic_auth)
  end
end
