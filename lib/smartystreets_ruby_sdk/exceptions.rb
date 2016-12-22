class SmartyException < Exception
end

class BadCredentialsError < SmartyException
end

class PaymentRequiredError < SmartyException
end


class RequestEntityTooLargeError < SmartyException
end


class BadRequestError < SmartyException
end


class TooManyRequestsError < SmartyException
end


class InternalServerError < SmartyException
end


class ServiceUnavailableError < SmartyException
end