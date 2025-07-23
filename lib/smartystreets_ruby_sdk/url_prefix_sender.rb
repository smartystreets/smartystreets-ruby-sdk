# frozen_string_literal: true

module SmartyStreets
  class URLPrefixSender
    def initialize(url_prefix, inner)
      @url_prefix = url_prefix
      @inner = inner
    end

    def send(request)
      request.url_prefix = if request.url_components.nil?
                             @url_prefix
                           else
                             @url_prefix + request.url_components
                           end

      @inner.send(request)
    end
  end
end
