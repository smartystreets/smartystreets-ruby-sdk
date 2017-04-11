require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/exceptions'
require './lib/smartystreets_ruby_sdk/errors'
require './lib/smartystreets_ruby_sdk/status_code_sender'
require './lib/smartystreets_ruby_sdk/request'

class TestStatusCodeSender < Minitest::Test
  def test_no_error_given_for_200
    inner = MockSender.new(Smartystreets::Response.new(nil, '200', nil))
    sender = Smartystreets::StatusCodeSender.new(inner)

    response = sender.send(Smartystreets::Request.new)

    assert_nil(response.error, 'Should be nil')
  end

  def test_bad_credentials_error_given_for_401
    expected_response = Smartystreets::Response.new(nil, '401', Smartystreets::BadCredentialsError.new(Smartystreets::BAD_CREDENTIALS))
    inner = MockSender.new(Smartystreets::Response.new(nil, '401', nil))
    sender = Smartystreets::StatusCodeSender.new(inner)

    response = sender.send(Smartystreets::Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_payment_required_error_given_for_402
    expected_response = Smartystreets::Response.new(nil, '402', Smartystreets::PaymentRequiredError.new(Smartystreets::PAYMENT_REQUIRED))
    inner = MockSender.new(Smartystreets::Response.new(nil, '402', nil))
    sender = Smartystreets::StatusCodeSender.new(inner)

    response = sender.send(Smartystreets::Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_request_entity_too_large_error_given_for_413
    expected_response = Smartystreets::Response.new(nil, '413', Smartystreets::RequestEntityTooLargeError.new(Smartystreets::REQUEST_ENTITY_TOO_LARGE))
    inner = MockSender.new(Smartystreets::Response.new(nil, '413', nil))
    sender = Smartystreets::StatusCodeSender.new(inner)

    response = sender.send(Smartystreets::Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_bad_request_error_given_for_400
    expected_response = Smartystreets::Response.new(nil, '400', Smartystreets::BadRequestError.new(Smartystreets::BAD_REQUEST))
    inner = MockSender.new(Smartystreets::Response.new(nil, '400', nil))
    sender = Smartystreets::StatusCodeSender.new(inner)

    response = sender.send(Smartystreets::Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_too_many_requests_error_given_for_429
    expected_response = Smartystreets::Response.new(nil, '429', Smartystreets::TooManyRequestsError.new(Smartystreets::TOO_MANY_REQUESTS))
    inner = MockSender.new(Smartystreets::Response.new(nil, '429', nil))
    sender = Smartystreets::StatusCodeSender.new(inner)

    response = sender.send(Smartystreets::Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_internal_server_error_given_for_500
    expected_response = Smartystreets::Response.new(nil, '500', Smartystreets::InternalServerError.new(Smartystreets::INTERNAL_SERVER_ERROR))
    inner = MockSender.new(Smartystreets::Response.new(nil, '500', nil))
    sender = Smartystreets::StatusCodeSender.new(inner)

    response = sender.send(Smartystreets::Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_service_unavailable_error_given_for_503
    expected_response = Smartystreets::Response.new(nil, '503', Smartystreets::ServiceUnavailableError.new(Smartystreets::SERVICE_UNAVAILABLE))
    inner = MockSender.new(Smartystreets::Response.new(nil, '503', nil))
    sender = Smartystreets::StatusCodeSender.new(inner)

    response = sender.send(Smartystreets::Request.new)

    assert_equal(expected_response.error, response.error)
  end
end
