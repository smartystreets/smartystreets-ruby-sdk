module SmartyStreets
  class CustomHeaderSender
    def initialize(inner, headers)
      @inner = inner
      @headers = headers
    end

    def send(request)
      request.headers = @headers
      @inner.send(request)
    end
  end
end
