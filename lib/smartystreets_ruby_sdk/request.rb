class Request
  attr_accessor :parameters, :payload, :url_prefix, :referer

  def initialize
    @parameters = {}
    @payload = nil
    @url_prefix = nil
    @referer = nil
  end
end