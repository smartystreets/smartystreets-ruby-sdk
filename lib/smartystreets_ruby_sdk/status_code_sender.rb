require_relative 'exceptions'
require_relative 'errors'

module SmartyStreets
  class StatusCodeSender
    def initialize(inner)
      @inner = inner
    end

    def send(request)
      response = @inner.send(request)

      message = response_message(response)

      assign_exception(message, response) if response.error.nil?

      response
    end

    def assign_exception(message, response)
      response.error =
        case response.status_code
        when '401'
          BadCredentialsError.new(BAD_CREDENTIALS)
        when '402'
          PaymentRequiredError.new(PAYMENT_REQUIRED)
        when '413'
          RequestEntityTooLargeError.new(REQUEST_ENTITY_TOO_LARGE)
        when '400'
          BadRequestError.new(BAD_REQUEST)
        when '422'
          UnprocessableEntityError.new(message || UNPROCESSABLE_ENTITY)
        when '429'
          TooManyRequestsError.new(message || TOO_MANY_REQUESTS)
        when '500'
          InternalServerError.new(INTERNAL_SERVER_ERROR)
        when '503'
          ServiceUnavailableError.new(SERVICE_UNAVAILABLE)
        else
          nil
       end
    end

    def response_message(response)
      return unless response.payload

      payload = JSON.parse(response.payload)

      # For status 200, the payload is an Array. We exit in
      # that case because the next line will crash
      return unless payload.is_a?(Hash)

      message = payload['errors'].map { |error| error['message'] }.join(', ')

      message == '' ? nil : message
    end
  end
end
