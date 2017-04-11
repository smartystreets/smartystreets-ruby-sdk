module Smartystreets
  class SharedCredentials
    def initialize(id, host_name)
      @id = id
      @host_name = host_name
    end

    def sign(request)
      request.parameters['auth-id'] = @id
      request.referer = @host_name
    end
  end
end
