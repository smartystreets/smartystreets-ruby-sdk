require 'net/http'
require_relative 'version'
require_relative 'response'

class HTTPSender
  def initialize(max_timeout=10000)
    @max_timeout = max_timeout
  end

  def send(smarty_request)
    request = self.class.build_request(smarty_request)
    uri = request.uri

    begin
      http = Net::HTTP.new(uri.hostname)
      http.use_ssl = uri.scheme == 'https'
      response = http.request(request)
      http.finish if http.started?
    rescue Exception => err
      return Response.new(nil, nil, err)
    end

    build_smarty_response(response)
  end

  def self.build_request(smarty_request)
    request = Net::HTTP::Post.new(URI(smarty_request.url_prefix))
    request.content_type = 'application/json'
    request['User-Agent'] = "smartystreets (sdk:ruby@#{SmartystreetsRubySdk::VERSION})"
    request['Referer'] = smarty_request.referer if smarty_request.referer != nil
    request.body = smarty_request.payload
    request
  end

  def build_smarty_response(inner_response)
    Response.new(inner_response.body, inner_response.code)
  end
end