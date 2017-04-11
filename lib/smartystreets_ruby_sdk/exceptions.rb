module Smartystreets
  class SmartyError < StandardError
  end

  class BadCredentialsError < SmartyError
  end

  class PaymentRequiredError < SmartyError
  end


  class RequestEntityTooLargeError < SmartyError
  end


  class BadRequestError < SmartyError
  end


  class TooManyRequestsError < SmartyError
  end


  class InternalServerError < SmartyError
  end


  class ServiceUnavailableError < SmartyError
  end
end
