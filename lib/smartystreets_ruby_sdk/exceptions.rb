module SmartyStreets

  class SmartyError < StandardError
  end

  class NotModifiedInfo < SmartyError
    attr_reader :response_etag

    def initialize(message = nil, response_etag = nil)
      super(message)
      @response_etag = response_etag
    end
  end

  class BadCredentialsError < SmartyError
  end

  class ForbiddenError < SmartyError
  end

  class PaymentRequiredError < SmartyError
  end

  class RequestEntityTooLargeError < SmartyError
  end

  class BadRequestError < SmartyError
  end

  class UnprocessableEntityError < SmartyError
  end

  class TooManyRequestsError < SmartyError
  end

  class InternalServerError < SmartyError
  end

  class ServiceUnavailableError < SmartyError
  end

  class GatewayTimeoutError < SmartyError
  end

  class BatchFullError < SmartyError
  end

end
