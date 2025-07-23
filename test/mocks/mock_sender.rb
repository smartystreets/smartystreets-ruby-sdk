# frozen_string_literal: true

class MockSender
  def initialize(response)
    @response = response
    @request = nil
  end

  def send(request)
    @request = request
    @response
  end
end
