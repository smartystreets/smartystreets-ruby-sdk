module Smartystreets
  class URLPrefixSender
    def initialize(url_prefix, inner)
      @url_prefix = url_prefix
      @inner = inner
    end

    def send(request)
      request.url_prefix = @url_prefix

      @inner.send(request)
    end
  end
end
