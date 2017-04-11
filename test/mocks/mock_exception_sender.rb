class MockExceptionSender
  def initialize(exception)
    @exception = exception
  end

  def send(request)
    if not @exception
      nil
    else
      Smartystreets::Response.new(nil, nil, @exception)
    end
  end
end
