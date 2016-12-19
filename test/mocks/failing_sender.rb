require './lib/smartystreets_ruby_sdk/response'

class FailingSender
  attr_accessor :status_codes, :current_status_code_index

  def initialize(status_codes)
    @status_codes = status_codes
    @current_status_code_index = 0
  end

  def send(request)
    response = Response.new(nil, @status_codes[@current_status_code_index])
    @current_status_code_index += 1

    response
  end
end