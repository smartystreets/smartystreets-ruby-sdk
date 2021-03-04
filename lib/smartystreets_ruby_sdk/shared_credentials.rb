module SmartyStreets
  class SharedCredentials
    def initialize(id, host_name)
      @id = id
      @host_name = host_name
    end

    def sign(request)
      request.parameters['key'] = @id
      request.referer = @host_name
    end
  end
end
