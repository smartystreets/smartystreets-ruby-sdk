module SmartyStreets
  NOT_MODIFIED = 'Not Modified: This data has not been modified since the last request. Please remove the etag header to fetch this data'.freeze

  BAD_CREDENTIALS = 'Unauthorized: The credentials were provided incorrectly or did not match any existing,
 active credentials.'.freeze

  PAYMENT_REQUIRED = 'Payment Required: There is no active subscription
 for the account associated with the credentials submitted with the request.'.freeze

  FORBIDDEN = 'Because the international service is currently in a limited release phase, only approved accounts ' \
              'may access the service.'.freeze

  REQUEST_ENTITY_TOO_LARGE = 'Request Entity Too Large: The request body has exceeded the maximum size.'.freeze

  BAD_REQUEST = 'Bad Request (Malformed Payload): A GET request lacked a street field or the request body of a
 POST request contained malformed JSON, possibly because a value was submitted as a number rather than as a string.'.freeze

  UNPROCESSABLE_ENTITY = 'GET request lacked required fields.'.freeze

  TOO_MANY_REQUESTS = 'The rate limit has been exceeded.'.freeze

  INTERNAL_SERVER_ERROR = 'Internal Server Error.'.freeze

  SERVICE_UNAVAILABLE = 'Service Unavailable. Try again later.'.freeze

  GATEWAY_TIMEOUT = 'The upstream data provider did not respond in a timely fashion and the request failed. ' \
                    'A serious, yet rare occurrence indeed.'.freeze
end
