module SmartyStreets
  class Request
    attr_accessor :parameters, :payload, :url_components, :url_prefix, :referer, :header, :content_type, :auth_id, :auth_token

    def initialize
      @parameters = {}
      @payload = nil
      @url_prefix = nil
      @url_components = nil
      @referer = nil
      @header = {}
      @content_type = 'application/json'
      @auth_id = nil
      @auth_token = nil
    end
  end
end