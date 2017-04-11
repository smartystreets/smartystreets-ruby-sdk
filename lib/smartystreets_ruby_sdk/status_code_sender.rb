require_relative 'exceptions'
require_relative 'errors'

module Smartystreets
  class StatusCodeSender
    def initialize(inner)
      @inner = inner
    end

    def send(request)
      response  = @inner.send(request)

      assign_exception(response) if response.error == nil

      response
    end

    def assign_exception(response)
      response.error = case response.status_code
                         when '401'
                           BadCredentialsError.new(BAD_CREDENTIALS)
                         when '402'
                           PaymentRequiredError.new(PAYMENT_REQUIRED)
                         when '413'
                           RequestEntityTooLargeError.new(REQUEST_ENTITY_TOO_LARGE)
                         when '400'
                           BadRequestError.new(BAD_REQUEST)
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
