class MockSender
  attr_reader :request

  def initialize(response)
    @response = response
    @request = nil
  end

  def send(request)
    @request = request
    @response
  end
end