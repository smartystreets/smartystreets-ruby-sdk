require 'net/http'
require_relative 'version'
require_relative 'response'

module SmartyStreets
  class NativeSender
    def initialize(max_timeout = 10, proxy = nil, debug = false)
      @max_timeout = max_timeout
      @proxy = proxy
      @debug = debug
    end

    def send(smarty_request)
      response = make_request(smarty_request)

      Response.new(response[:body], response[:code], response[:error])
    end

    def build_request(smarty_request)
      query = create_query(smarty_request)

      if smarty_request.payload.nil?
        request = Net::HTTP::Get.new(URI.parse("#{smarty_request.url_prefix}?#{query}"))
      else
        request = Net::HTTP::Post.new(URI.parse("#{smarty_request.url_prefix}?#{query}"))
      end

      request.content_type = 'application/json'
      request.body = smarty_request.payload
      request['User-Agent'] = "smartystreets (sdk:ruby@#{SmartyStreets::VERSION})"
      request['Referer'] = smarty_request.referer unless smarty_request.referer.nil?
      set_custom_headers(smarty_request.headers, request)
      request
    end

    def build_http(request)
      uri = request.uri

      if @proxy.nil?
        http = Net::HTTP.new(uri.hostname, uri.port)
      else
        http = Net::HTTP.new(uri.hostname, uri.port, @proxy.host,
                             @proxy.port, @proxy.username, @proxy.password)
      end

      http.set_debug_output($stdout) if @debug
      http.use_ssl = true
      http.ssl_version = :TLSv1_2
      http.read_timeout = @max_timeout

      http
    end

    def create_query(smarty_request)
      URI.encode_www_form(smarty_request.parameters)
    end

    def set_custom_headers(smarty_headers, request)
      smarty_headers.each do |key, values|
        if values.respond_to? :each
          values.each do |value|
            request.add_field(key, value)
          end
        else
          request.add_field(key, values)
        end
      end
    end

    private

    def make_request(smarty_request)
      request = build_request(smarty_request)
      http = build_http(request)
      response = http.request(request)

      http.finish if http.started?

      { body: response.body, code: response.code, error: nil }
    rescue StandardError => e
      { body: nil, code: nil, error: e }
    end
  end
end
