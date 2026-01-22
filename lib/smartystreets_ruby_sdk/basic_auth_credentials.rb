module SmartyStreets
  class BasicAuthCredentials
    def initialize(auth_id, auth_token)
      raise ArgumentError, 'credentials (auth id, auth token) required' if auth_id.nil? || auth_id.empty? || auth_token.nil? || auth_token.empty?

      @auth_id = auth_id
      @auth_token = auth_token
    end

    def sign(request)
      request.basic_auth = [@auth_id, @auth_token]
    end
  end
end
