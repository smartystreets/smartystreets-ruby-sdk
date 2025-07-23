require_relative '../test_helper'
require_relative '../../lib/smartystreets_ruby_sdk/license_sender'
require_relative '../../lib/smartystreets_ruby_sdk/response'
require_relative '../../lib/smartystreets_ruby_sdk/request'
require_relative '../mocks/mock_sender'

class TestLicenseSender < Minitest::Test
  def test_licenses_are_added_to_query
    licenses = %w[test1 test2 test3]
    mock_response = SmartyStreets::Response.new('Testing', '123')
    inner = MockSender.new(mock_response)
    sender = SmartyStreets::LicenseSender.new(inner, licenses)
    request = SmartyStreets::Request.new

    response = sender.send(request)

    assert_equal('Testing', response.payload)
    assert_equal('123', response.status_code)
    assert_equal(1, request.parameters.length)
    assert_equal('test1,test2,test3', request.parameters['license'])
  end

  def test_license_query_not_set
    licenses = %w[]
    mock_response = SmartyStreets::Response.new('Testing', '123')
    inner = MockSender.new(mock_response)
    sender = SmartyStreets::LicenseSender.new(inner, licenses)
    request = SmartyStreets::Request.new

    response = sender.send(request)

    assert_equal('Testing', response.payload)
    assert_equal('123', response.status_code)
    assert_equal(0, request.parameters.length)
  end
end
