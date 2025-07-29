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
      request = self.class.build_request(smarty_request)

      begin
        http = build_http(request)
        http.use_ssl = true
        
        # Try TLS 1.3 first, fallback to TLS 1.2 if not supported
        begin
          http.ssl_version = :TLSv1_3
        rescue NotImplementedError
          # Fallback to TLS 1.2 for older Ruby versions or systems
          http.ssl_version = :TLSv1_2
        end
        
        http.open_timeout = @max_timeout
        http.read_timeout = @max_timeout

        response = http.request(request)

        http.finish if http.started?
      rescue StandardError => err
        if response.nil?
          return Response.new(nil, nil, nil, err)
        else
          return Response.new(nil, nil, response.header, err)
        end
      end

      build_smarty_response(response)
    end

    def self.build_request(smarty_request)
      query = create_query(smarty_request)
      url = "#{smarty_request.url_prefix}?#{query}"
      
      # Validate URL to prevent potential injection issues
      validated_uri = validate_url(url)

      if smarty_request.payload.nil?
        request = Net::HTTP::Get.new(validated_uri)
      else
        request = Net::HTTP::Post.new(validated_uri)
      end

      request.content_type = 'application/json'
      request.body = smarty_request.payload
      request['User-Agent'] = "smartystreets (sdk:ruby@#{SmartyStreets::VERSION})"
      request['Referer'] = smarty_request.referer unless smarty_request.referer.nil?
      set_custom_headers(smarty_request.header, request)
      request
    end

    def self.validate_url(url)
      uri = URI.parse(url)
      # Only allow HTTP and HTTPS schemes
      unless ['http', 'https'].include?(uri.scheme)
        raise ArgumentError, "Invalid URL scheme: #{uri.scheme}. Only HTTP and HTTPS are allowed."
      end
      uri
    rescue URI::InvalidURIError => e
      raise ArgumentError, "Invalid URL format: #{e.message}"
    end

    def build_smarty_response(native_response)
      if native_response.header.nil?
        Response.new(native_response.body, native_response.code)
      else
        Response.new(native_response.body, native_response.code, native_response.header)
      end
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

      http
    end

    def self.create_query(smarty_request)
      URI.encode_www_form(smarty_request.parameters)
    end

    def self.set_custom_headers(smarty_header, request)
      smarty_header.each do |key, values|
        if values.respond_to? :each
          values.each do |value|
            request.add_field(key, value)
          end
        else
          request.add_field(key, values)
        end
      end
    end
  end
end
