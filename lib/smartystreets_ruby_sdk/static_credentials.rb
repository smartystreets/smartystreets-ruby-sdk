module Smartystreets
  class StaticCredentials
    def initialize(auth_id, auth_token)
      @auth_id = auth_id
      @auth_token = auth_token
    end

    def sign(request)
      request.parameters['auth-id'] = @auth_id
      request.parameters['auth-token'] = @auth_token
    end
  end
end
