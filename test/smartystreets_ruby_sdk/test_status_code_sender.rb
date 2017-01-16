require './lib/smartystreets_ruby_sdk/exceptions'
require './lib/smartystreets_ruby_sdk/errors'
require './lib/smartystreets_ruby_sdk/status_code_sender'
require './lib/smartystreets_ruby_sdk/request'

class TestStatusCodeSender < Minitest::Test
  def test_no_error_given_for_200
    inner = MockSender.new(Response.new(nil, '200', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_nil(response.error, 'Should be nil')
  end

  def test_bad_credentials_error_given_for_401
    expected_response = Response.new(nil, '401', BadCredentialsError.new(BAD_CREDENTIALS))
    inner = MockSender.new(Response.new(nil, '401', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_payment_required_error_given_for_402
    expected_response = Response.new(nil, '402', PaymentRequiredError.new(PAYMENT_REQUIRED))
    inner = MockSender.new(Response.new(nil, '402', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_request_entity_too_large_error_given_for_413
    expected_response = Response.new(nil, '413', RequestEntityTooLargeError.new(REQUEST_ENTITY_TOO_LARGE))
    inner = MockSender.new(Response.new(nil, '413', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_bad_request_error_given_for_400
    expected_response = Response.new(nil, '400', BadRequestError.new(BAD_REQUEST))
    inner = MockSender.new(Response.new(nil, '400', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_too_many_requests_error_given_for_429
    expected_response = Response.new(nil, '429', TooManyRequestsError.new(TOO_MANY_REQUESTS))
    inner = MockSender.new(Response.new(nil, '429', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_internal_server_error_given_for_500
    expected_response = Response.new(nil, '500', InternalServerError.new(INTERNAL_SERVER_ERROR))
    inner = MockSender.new(Response.new(nil, '500', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
  end

  def test_service_unavailable_error_given_for_503
    expected_response = Response.new(nil, '503', ServiceUnavailableError.new(SERVICE_UNAVAILABLE))
    inner = MockSender.new(Response.new(nil, '503', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
  end
end