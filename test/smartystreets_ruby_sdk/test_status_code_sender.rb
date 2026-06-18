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
    expected_exception = SmartyStreets::BadCredentialsError.new("#{SmartyStreets::BAD_CREDENTIALS} Body:")
    inner = MockSender.new(Response.new(nil, '401', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("#{SmartyStreets::BAD_CREDENTIALS} Body:", response.error.message)
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
    expected_exception = SmartyStreets::PaymentRequiredError.new("#{SmartyStreets::PAYMENT_REQUIRED} Body:")
    inner = MockSender.new(Response.new(nil, '402', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("#{SmartyStreets::PAYMENT_REQUIRED} Body:", response.error.message)
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
    expected_exception = SmartyStreets::RequestEntityTooLargeError.new("#{SmartyStreets::REQUEST_ENTITY_TOO_LARGE} Body:")
    inner = MockSender.new(Response.new(nil, '413', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("#{SmartyStreets::REQUEST_ENTITY_TOO_LARGE} Body:", response.error.message)
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
    expected_exception = SmartyStreets::BadRequestError.new("#{SmartyStreets::BAD_REQUEST} Body:")
    inner = MockSender.new(Response.new(nil, '400', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("#{SmartyStreets::BAD_REQUEST} Body:", response.error.message)
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
    expected_exception = SmartyStreets::UnprocessableEntityError.new("#{SmartyStreets::UNPROCESSABLE_ENTITY} Body:")
    inner = MockSender.new(Response.new(nil, '422', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("#{SmartyStreets::UNPROCESSABLE_ENTITY} Body:", response.error.message)
  end

  def test_too_many_requests_error_given_for_429
    expected_exception = SmartyStreets::TooManyRequestsError.new("#{SmartyStreets::TOO_MANY_REQUESTS} Body:")
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
    expected_exception = SmartyStreets::TooManyRequestsError.new("#{SmartyStreets::TOO_MANY_REQUESTS} Body: {\"errors\": []}")
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

  def test_forbidden_error_given_for_403
    expected_exception = SmartyStreets::ForbiddenError.new("No access for you")
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"6\", \"message\": \"No access for you\"}]}", '403', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("No access for you", response.error.message)
  end

  def test_forbidden_error_fallback_for_403
    expected_exception = SmartyStreets::ForbiddenError.new("#{SmartyStreets::FORBIDDEN} Body:")
    inner = MockSender.new(Response.new(nil, '403', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("#{SmartyStreets::FORBIDDEN} Body:", response.error.message)
  end

  def test_request_timeout_error_given_for_408
    expected_exception = SmartyStreets::RequestTimeoutError.new("Way too slow")
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"7\", \"message\": \"Way too slow\"}]}", '408', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("Way too slow", response.error.message)
  end

  def test_request_timeout_error_fallback_for_408
    expected_exception = SmartyStreets::RequestTimeoutError.new("#{SmartyStreets::REQUEST_TIMEOUT} Body:")
    inner = MockSender.new(Response.new(nil, '408', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("#{SmartyStreets::REQUEST_TIMEOUT} Body:", response.error.message)
  end

  def test_internal_server_error_given_for_500
    expected_exception = SmartyStreets::InternalServerError.new("#{SmartyStreets::INTERNAL_SERVER_ERROR} Body:")
    expected_response = Response.new(nil, '500', nil, expected_exception)
    inner = MockSender.new(Response.new(nil, '500', nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_internal_server_error_uses_api_message_for_500
    expected_exception = SmartyStreets::InternalServerError.new("Something broke on our end")
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"8\", \"message\": \"Something broke on our end\"}]}", '500', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("Something broke on our end", response.error.message)
  end

  def test_bad_gateway_error_given_for_502
    expected_exception = SmartyStreets::BadGatewayError.new("#{SmartyStreets::BAD_GATEWAY} Body:")
    inner = MockSender.new(Response.new(nil, '502', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("#{SmartyStreets::BAD_GATEWAY} Body:", response.error.message)
  end

  def test_gateway_timeout_error_given_for_504
    expected_exception = SmartyStreets::GatewayTimeoutError.new("#{SmartyStreets::GATEWAY_TIMEOUT} Body:")
    inner = MockSender.new(Response.new(nil, '504', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("#{SmartyStreets::GATEWAY_TIMEOUT} Body:", response.error.message)
  end

  def test_unexpected_status_code_falls_back_to_standard_message
    expected_exception = SmartyStreets::SmartyError.new('The server returned an unexpected HTTP status code: 418 Body:')
    inner = MockSender.new(Response.new(nil, '418', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal('The server returned an unexpected HTTP status code: 418 Body:', response.error.message)
  end

  def test_unexpected_status_code_uses_api_message
    expected_exception = SmartyStreets::SmartyError.new("API teapot message")
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"9\", \"message\": \"API teapot message\"}]}", '418', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal("API teapot message", response.error.message)
  end

  def test_malformed_payload_falls_back_and_appends_body
    expected_message = "#{SmartyStreets::BAD_CREDENTIALS} Body: not json"
    expected_exception = SmartyStreets::BadCredentialsError.new(expected_message)
    inner = MockSender.new(Response.new("not json", '401', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_exception, response.error)
    assert_equal(expected_message, response.error.message)
  end

  def test_fallback_appends_body_without_messages
    expected_message = "#{SmartyStreets::UNPROCESSABLE_ENTITY} Body: {\"errors\": [{\"id\":\"5\"}]}"
    inner = MockSender.new(Response.new("{\"errors\": [{\"id\":\"5\"}]}", '422', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_message, response.error.message)
  end

  def test_blank_body_yields_empty_body_label
    inner = MockSender.new(Response.new("   ", '422', nil, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal("#{SmartyStreets::UNPROCESSABLE_ENTITY} Body:", response.error.message)
  end

  def test_standard_messages_match_shared_wording
    assert_equal('Not Modified: The requested record has not been modified since the previous request with the Etag value.',
                 SmartyStreets::NOT_MODIFIED)
    assert_equal('Bad Request (Malformed Payload): A GET request lacked a required field or the request body of a POST request contained malformed JSON.',
                 SmartyStreets::BAD_REQUEST)
    assert_equal('Forbidden: The request contained valid data and was understood by the server, but the server is refusing action.',
                 SmartyStreets::FORBIDDEN)
    assert_equal('Request timeout error.', SmartyStreets::REQUEST_TIMEOUT)
    assert_equal('Too Many Requests: The rate limit for your account has been exceeded.',
                 SmartyStreets::TOO_MANY_REQUESTS)
    assert_equal('Bad Gateway error.', SmartyStreets::BAD_GATEWAY)
  end

  def test_service_unavailable_error_given_for_503
    expected_exception = SmartyStreets::ServiceUnavailableError.new("#{SmartyStreets::SERVICE_UNAVAILABLE} Body:")
    expected_response = Response.new(nil, '503', nil, expected_exception)
    inner = MockSender.new(Response.new(nil, '503', nil, expected_exception))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_equal(expected_response.error, response.error)
    assert_equal(response.error, expected_exception)
  end

  def test_not_modified_is_not_an_error
    inner = MockSender.new(Response.new(nil, '304', {'etag' => 'server-refreshed-etag'}, nil))
    sender = StatusCodeSender.new(inner)

    response = sender.send(Request.new)

    assert_nil(response.error)
    assert_equal('304', response.status_code)
    assert_equal('server-refreshed-etag', response.find_header('etag'))
  end
end
