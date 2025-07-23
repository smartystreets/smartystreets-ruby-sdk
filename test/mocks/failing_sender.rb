require './lib/smartystreets_ruby_sdk/response'

class FailingSender
  attr_accessor :status_codes, :current_status_code_index, :header, :error

  def initialize(status_codes, header = nil, error = nil)
    @status_codes = status_codes
    @current_status_code_index = 0
    @header = header
    @error = error
  end

  def send(_request)
    response = SmartyStreets::Response.new(nil, @status_codes[@current_status_code_index], @header, @error)
    @current_status_code_index += 1

    response
  end
end
