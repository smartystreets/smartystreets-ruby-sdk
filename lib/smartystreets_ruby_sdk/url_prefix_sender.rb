module SmartyStreets
  class URLPrefixSender
    def initialize(url_prefix, inner)
      @url_prefix = url_prefix
      @inner = inner
    end

    def send(request)
      if request.url_components.nil?
        request.url_prefix = @url_prefix
      else
        request.url_prefix = @url_prefix + request.url_components
      end

      @inner.send(request)
    end
  end
end
