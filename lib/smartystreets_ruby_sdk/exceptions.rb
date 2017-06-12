module SmartyStreets

  class SmartyError < StandardError
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
