module SmartyStreets
  class CustomHeaderSender
    def initialize(inner, header)
      @inner = inner
      @header = header
    end

    def send(request)
      request.header = @header
      @inner.send(request)
    end
  end
end
