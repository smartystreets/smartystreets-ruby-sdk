class Request
  attr_accessor :parameters, :payload, :url_prefix, :referer, :headers, :content_type

  def initialize
    @parameters = {}
    @payload = nil
    @url_prefix = nil
    @referer = nil
    @headers = {}
    @content_type = 'application/json'
  end
end