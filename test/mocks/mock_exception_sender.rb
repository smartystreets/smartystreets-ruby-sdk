class MockExceptionSender
  def initialize(exception)
    @exception = exception
  end

  def send(request)
    if not @exception
      nil
    else
      SmartyStreets::Response.new(nil, nil, @exception)
    end
  end
end