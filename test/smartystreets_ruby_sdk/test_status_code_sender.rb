# frozen_string_literal: true

require_relative '../test_helper'
require './lib/smartystreets_ruby_sdk/exceptions'
require './lib/smartystreets_ruby_sdk/errors'
require './lib/smartystreets_ruby_sdk/status_code_sender'
require './lib/smartystreets_ruby_sdk/request'

class TestStatusCodeSender < Minitest::Test
  StatusCodeSender = SmartyStreets::StatusCodeSender
  Response = SmartyStreets::Response
  Request = SmartyStreets::Request

  def test_no_error_given_for_200
    inner = MockSender.new(Response.new(nil, '200', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_nil(response.error, 'Should be nil')
  end

  def test_bad_credentials_error_given_for_401
    expected_exception = SmartyStreets::BadCredentialsError.new(SmartyStreets::BAD_CREDENTIALS)
    expected_response = Response.new(nil, '401', nil, expected_exception)
    inner = MockSender.new(Response.new(nil, '401', nil, expected_exception))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_payment_required_error_given_for_402
    expected_exception = SmartyStreets::PaymentRequiredError.new(SmartyStreets::PAYMENT_REQUIRED)
    expected_response = Response.new(nil, '402', nil, expected_exception)
    inner = MockSender.new(Response.new(nil, '402', nil, expected_exception))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_request_entity_too_large_error_given_for_413
    expected_exception = SmartyStreets::RequestEntityTooLargeError.new(SmartyStreets::REQUEST_ENTITY_TOO_LARGE)
    expected_response = Response.new(nil, '413', nil, expected_exception)
    inner = MockSender.new(Response.new(nil, '413', nil, expected_exception))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_bad_request_error_given_for_400
    expected_exception = SmartyStreets::BadRequestError.new(SmartyStreets::BAD_REQUEST)
    expected_response = Response.new(nil, '400', nil, expected_exception)
    inner = MockSender.new(Response.new(nil, '400', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_unprocessable_entity_error_given_for_422
    expected_exception = SmartyStreets::UnprocessableEntityError.new(SmartyStreets::UNPROCESSABLE_ENTITY)
    expected_response = Response.new(nil, '422', nil, expected_exception)
    inner = MockSender.new(Response.new(nil, '422', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_too_many_requests_error_given_for_429
    expected_exception = SmartyStreets::TooManyRequestsError.new(SmartyStreets::TOO_MANY_REQUESTS)
    expected_response = Response.new(nil, '429', nil, expected_exception)
    inner = MockSender.new(Response.new(nil, '429', nil, expected_exception))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_429_payload_parse
    expected_exception = SmartyStreets::TooManyRequestsError.new('Big Bad')
    expected_response = Response.new('{"errors": [{"id":"45", "message": "Big Bad"}]}', '429', nil,
                                     expected_exception)
    inner = MockSender.new(Response.new('{"errors": [{"id":"45", "message": "Big Bad"}]}', '429', nil,
                                        expected_exception))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_429_payload_empty_parse
    expected_exception = SmartyStreets::TooManyRequestsError.new(SmartyStreets::TOO_MANY_REQUESTS)
    expected_response = Response.new('{"errors": []}', '429', nil, expected_exception)
    inner = MockSender.new(Response.new('{"errors": []}', '429', nil, expected_exception))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_429_payload_multiple_errors
    expected_exception = SmartyStreets::TooManyRequestsError.new('Big Bad Big Bad')
    expected_response = Response.new(
      '{"errors": [{"id":"45", "message": "Big Bad"}, {"id":"45", "message": "Big Bad"}]}', '429', nil, expected_exception
    )
    inner = MockSender.new(Response.new(
                             '{"errors": [{"id":"45", "message": "Big Bad"}, {"id":"45", "message": "Big Bad"}]}', '429', nil, expected_exception
                           ))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_internal_server_error_given_for_500
    expected_exception = SmartyStreets::InternalServerError.new(SmartyStreets::INTERNAL_SERVER_ERROR)
    expected_response = Response.new(nil, '500', nil, expected_exception)
    inner = MockSender.new(Response.new(nil, '500', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_service_unavailable_error_given_for_503
    expected_exception = SmartyStreets::ServiceUnavailableError.new(SmartyStreets::SERVICE_UNAVAILABLE)
    expected_response = Response.new(nil, '503', nil, expected_exception)
    inner = MockSender.new(Response.new(nil, '503', nil, expected_exception))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end
end
