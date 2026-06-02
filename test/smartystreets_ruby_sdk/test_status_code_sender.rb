require 'minitest/autorun'
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
    expected_exception = SmartyStreets::BadCredentialsError.new("These credentials are no good")
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"1\", \"message\": \"These credentials are no good\"}]}", '401', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("These credentials are no good", response.error.message)
  end

  def test_bad_credentials_error_fallback_for_401
    expected_exception = SmartyStreets::BadCredentialsError.new(SmartyStreets::BAD_CREDENTIALS)
    inner = MockSender.new(Response.new(nil, '401', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal(SmartyStreets::BAD_CREDENTIALS, response.error.message)
  end

  def test_payment_required_error_given_for_402
    expected_exception = SmartyStreets::PaymentRequiredError.new("Pay up please")
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"2\", \"message\": \"Pay up please\"}]}", '402', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("Pay up please", response.error.message)
  end

  def test_payment_required_error_fallback_for_402
    expected_exception = SmartyStreets::PaymentRequiredError.new(SmartyStreets::PAYMENT_REQUIRED)
    inner = MockSender.new(Response.new(nil, '402', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal(SmartyStreets::PAYMENT_REQUIRED, response.error.message)
  end

  def test_request_entity_too_large_error_given_for_413
    expected_exception = SmartyStreets::RequestEntityTooLargeError.new("That is way too big")
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"3\", \"message\": \"That is way too big\"}]}", '413', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("That is way too big", response.error.message)
  end

  def test_request_entity_too_large_error_fallback_for_413
    expected_exception = SmartyStreets::RequestEntityTooLargeError.new(SmartyStreets::REQUEST_ENTITY_TOO_LARGE)
    inner = MockSender.new(Response.new(nil, '413', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal(SmartyStreets::REQUEST_ENTITY_TOO_LARGE, response.error.message)
  end

  def test_bad_request_error_given_for_400
    expected_exception = SmartyStreets::BadRequestError.new("Your request was malformed")
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"4\", \"message\": \"Your request was malformed\"}]}", '400', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("Your request was malformed", response.error.message)
  end

  def test_bad_request_error_fallback_for_400
    expected_exception = SmartyStreets::BadRequestError.new(SmartyStreets::BAD_REQUEST)
    inner = MockSender.new(Response.new(nil, '400', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal(SmartyStreets::BAD_REQUEST, response.error.message)
  end

  def test_unprocessable_entity_error_given_for_422
    expected_exception = SmartyStreets::UnprocessableEntityError.new("Missing some fields")
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"5\", \"message\": \"Missing some fields\"}]}", '422', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("Missing some fields", response.error.message)
  end

  def test_unprocessable_entity_error_fallback_for_422
    expected_exception = SmartyStreets::UnprocessableEntityError.new(SmartyStreets::UNPROCESSABLE_ENTITY)
    inner = MockSender.new(Response.new(nil, '422', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal(SmartyStreets::UNPROCESSABLE_ENTITY, response.error.message)
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
    expected_exception = SmartyStreets::TooManyRequestsError.new("Big Bad")
    expected_response = Response.new("{\"errors\": [{\"id\":\"45\", \"message\": \"Big Bad\"}]}", '429', nil, expected_exception)
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"45\", \"message\": \"Big Bad\"}]}", '429', nil, expected_exception))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_429_payload_empty_parse
    expected_exception = SmartyStreets::TooManyRequestsError.new(SmartyStreets::TOO_MANY_REQUESTS)
    expected_response = Response.new("{\"errors\": []}", '429', nil, expected_exception)
    inner = MockSender.new(Response.new("{\"errors\": []}", '429', nil, expected_exception))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_429_payload_multiple_errors
    expected_exception = SmartyStreets::TooManyRequestsError.new("Big Bad Big Bad")
    expected_response = Response.new("{\"errors\": [{\"id\":\"45\", \"message\": \"Big Bad\"}, {\"id\":\"45\", \"message\": \"Big Bad\"}]}", '429', nil, expected_exception)
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"45\", \"message\": \"Big Bad\"}, {\"id\":\"45\", \"message\": \"Big Bad\"}]}", '429', nil, expected_exception))
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

  def test_not_modified_info_carries_response_etag
    inner = MockSender.new(Response.new(nil, '304', {'etag' => 'server-refreshed-etag'}, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_instance_of(SmartyStreets::NotModifiedInfo, response.error)
    assert_equal('server-refreshed-etag', response.error.response_etag)
  end

  def test_not_modified_info_response_etag_is_case_insensitive
    inner = MockSender.new(Response.new(nil, '304', {'ETag' => 'server-refreshed-etag'}, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_instance_of(SmartyStreets::NotModifiedInfo, response.error)
    assert_equal('server-refreshed-etag', response.error.response_etag)
  end

  def test_not_modified_info_response_etag_nil_when_header_absent
    inner = MockSender.new(Response.new(nil, '304', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_instance_of(SmartyStreets::NotModifiedInfo, response.error)
    assert_nil(response.error.response_etag)
  end
end
