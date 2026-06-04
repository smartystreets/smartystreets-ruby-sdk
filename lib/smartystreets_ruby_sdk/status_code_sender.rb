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
      error_message = ""
      if !response.payload.nil?
        response_json = JSON.parse(response.payload)
        response_json["errors"].each do |error|
          error_message += (" " + error["message"])
        end
        error_message.strip!
      end
      if error_message == ""
        error_message = TOO_MANY_REQUESTS
      end
      TooManyRequestsError.new(error_message)
    end

    def from_message(response, fallback)
      return fallback if response.payload.nil?

      errors = JSON.parse(response.payload)["errors"]
      return fallback if errors.nil? || errors.empty?

      message = errors.map { |error| error["message"] }.join(" ")
      message.empty? ? fallback : message
    end

    def assign_exception(response)
      response.error = case response.status_code
                         when '304'
                           NotModifiedInfo.new(NOT_MODIFIED, response.find_header('etag'))
                         when '401'
                           BadCredentialsError.new(from_message(response, BAD_CREDENTIALS))
                         when '402'
                           PaymentRequiredError.new(from_message(response, PAYMENT_REQUIRED))
                         when '413'
                           RequestEntityTooLargeError.new(from_message(response, REQUEST_ENTITY_TOO_LARGE))
                         when '400'
                           BadRequestError.new(from_message(response, BAD_REQUEST))
                         when '422'
                           UnprocessableEntityError.new(from_message(response, UNPROCESSABLE_ENTITY))
                         when '429'
                           TooManyRequestsError.new(TOO_MANY_REQUESTS)
                         when '500'
                           InternalServerError.new(INTERNAL_SERVER_ERROR)
                         when '503'
                           ServiceUnavailableError.new(SERVICE_UNAVAILABLE)
                         else
                           nil
                       end
    end
  end
end
