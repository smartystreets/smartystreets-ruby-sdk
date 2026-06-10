require 'json'
require_relative 'exceptions'
require_relative 'errors'

module SmartyStreets
  class StatusCodeSender
    def initialize(inner)
      @inner = inner
    end

    def send(request)
      response = @inner.send(request)

      if response.status_code == '429'
        response.error = parse_rate_limit_response(response)
      end
      assign_exception(response) if response.error == nil

      response
    end

    private

    def parse_rate_limit_response(response)
      TooManyRequestsError.new(from_message(response, TOO_MANY_REQUESTS))
    end

    def from_message(response, fallback)
      return fallback if response.payload.nil?

      begin
        errors = JSON.parse(response.payload)["errors"]
      rescue JSON::ParserError, TypeError
        return fallback
      end
      return fallback if errors.nil? || errors.empty?

      message = errors.map { |error| error["message"] }.join(" ")
      message.empty? ? fallback : message
    end

    def assign_exception(response)
      response.error = case response.status_code.to_s
                         when '200'
                           nil
                         when '304'
                           NotModifiedInfo.new(NOT_MODIFIED, response.find_header('etag'))
                         when '401'
                           BadCredentialsError.new(from_message(response, BAD_CREDENTIALS))
                         when '402'
                           PaymentRequiredError.new(from_message(response, PAYMENT_REQUIRED))
                         when '403'
                           ForbiddenError.new(from_message(response, FORBIDDEN))
                         when '408'
                           RequestTimeoutError.new(from_message(response, REQUEST_TIMEOUT))
                         when '413'
                           RequestEntityTooLargeError.new(from_message(response, REQUEST_ENTITY_TOO_LARGE))
                         when '400'
                           BadRequestError.new(from_message(response, BAD_REQUEST))
                         when '422'
                           UnprocessableEntityError.new(from_message(response, UNPROCESSABLE_ENTITY))
                         when '429'
                           TooManyRequestsError.new(from_message(response, TOO_MANY_REQUESTS))
                         when '500'
                           InternalServerError.new(from_message(response, INTERNAL_SERVER_ERROR))
                         when '502'
                           BadGatewayError.new(from_message(response, BAD_GATEWAY))
                         when '503'
                           ServiceUnavailableError.new(from_message(response, SERVICE_UNAVAILABLE))
                         when '504'
                           GatewayTimeoutError.new(from_message(response, GATEWAY_TIMEOUT))
                         else
                           SmartyError.new(from_message(response, "The server returned an unexpected HTTP status code: #{response.status_code}"))
                       end
    end
  end
end
