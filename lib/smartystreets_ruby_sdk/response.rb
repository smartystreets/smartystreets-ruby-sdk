class Response
  attr_accessor :payload, :status_code, :error

  def initialize(payload, status_code, error=nil)
    @payload = payload
    @status_code = status_code
    @error = error
  end
end