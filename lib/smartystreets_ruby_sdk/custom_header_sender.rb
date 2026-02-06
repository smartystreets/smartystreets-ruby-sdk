module SmartyStreets
  class CustomHeaderSender
    def initialize(inner, header, append_headers = {})
      @inner = inner
      @header = header
      @append_headers = append_headers || {}
    end

    def send(request)
      request.header = @header
      request.append_headers = @append_headers
      @inner.send(request)
    end
  end
end
