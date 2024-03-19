module SmartyStreets
  class Request
    attr_accessor :parameters, :payload, :url_components, :url_prefix, :referer, :header, :content_type

    def initialize
      @parameters = {}
      @payload = nil
      @url_prefix = nil
      @url_components = nil
      @referer = nil
      @header = {}
      @content_type = 'application/json'
    end
  end
end