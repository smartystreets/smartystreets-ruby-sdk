class SmartyException < Exception
end

class BadCredentialsError < SmartyException
end

class ForbiddenError < SmartyException
end

class PaymentRequiredError < SmartyException
end

class RequestEntityTooLargeError < SmartyException
end

class BadRequestError < SmartyException
end

class UnprocessableEntityError < SmartyException
end

class TooManyRequestsError < SmartyException
end

class InternalServerError < SmartyException
end

class ServiceUnavailableError < SmartyException
end

class GatewayTimeoutError < SmartyException
end

class BatchFullError < SmartyException
end
