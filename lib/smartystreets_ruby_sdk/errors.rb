module SmartyStreets
  NOT_MODIFIED = 'Not Modified: The requested record has not been modified since the previous request' \
                 ' with the Etag value.'.freeze

  BAD_CREDENTIALS = 'Unauthorized: The credentials were provided incorrectly or did not match any existing,' \
                    ' active credentials.'.freeze

  PAYMENT_REQUIRED = 'Payment Required: There is no active subscription for the account associated with the' \
                     ' credentials submitted with the request.'.freeze

  FORBIDDEN = 'Forbidden: The request contained valid data and was understood by the server, but the server' \
              ' is refusing action.'.freeze

  REQUEST_TIMEOUT = 'Request timeout error.'.freeze

  REQUEST_ENTITY_TOO_LARGE = 'Request Entity Too Large: The request body has exceeded the maximum size.'.freeze

  BAD_REQUEST = 'Bad Request (Malformed Payload): A GET request lacked a required field or the request body' \
                ' of a POST request contained malformed JSON.'.freeze

  UNPROCESSABLE_ENTITY = 'GET request lacked required fields.'.freeze

  TOO_MANY_REQUESTS = 'Too Many Requests: The rate limit for your account has been exceeded.'.freeze

  INTERNAL_SERVER_ERROR = 'Internal Server Error.'.freeze

  BAD_GATEWAY = 'Bad Gateway error.'.freeze

  SERVICE_UNAVAILABLE = 'Service Unavailable. Try again later.'.freeze

  GATEWAY_TIMEOUT = 'The upstream data provider did not respond in a timely fashion and the request failed. ' \
                    'A serious, yet rare occurrence indeed.'.freeze
end
