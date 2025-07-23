# frozen_string_literal: true

class MockExceptionSender
  def initialize(exception)
    @exception = exception
  end

  def send(_request)
    return unless @exception

    SmartyStreets::Response.new(nil, nil, nil, @exception)
  end
end
