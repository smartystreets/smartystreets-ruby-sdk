require 'net/http'
require_relative 'version'
require_relative 'response'

class NativeSender
  def initialize(max_timeout=10000)
    @max_timeout = max_timeout
  end

  def send(smarty_request)
    request = self.class.build_request(smarty_request)
    uri = request.uri

    begin
      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true
      http.ssl_version = :TLSv1_2
      http.read_timeout = @max_timeout

      response = http.request(request)

      http.finish if http.started?
    rescue Exception => err
      return Response.new(nil, nil, err)
    end

    build_smarty_response(response)
  end

  def self.build_request(smarty_request)
    query = create_query(smarty_request)
    request = Net::HTTP::Post.new(URI.parse("#{smarty_request.url_prefix}?#{query}"))
    request.content_type = 'application/json'
    request['User-Agent'] = "smartystreets (sdk:ruby@#{SmartystreetsRubySdk::VERSION})"
    request['Referer'] = smarty_request.referer if smarty_request.referer != nil
    request.body = smarty_request.payload
    request
  end

  def build_smarty_response(native_response)
    Response.new(native_response.body, native_response.code)
  end

  def self.create_query(smarty_request)
    query_string = ''

    smarty_request.parameters.each do |key, value|
      query_string.concat("&#{key}=#{value}")
    end

    query_string[0] = ''
    query_string
  end
end