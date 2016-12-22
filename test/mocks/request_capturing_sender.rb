class RequestCapturingSender
  attr_reader :request

  def initialize
    @request = nil
  end

  def send(request)
    @request = request

    Response.new('[]', 200)
  end
end