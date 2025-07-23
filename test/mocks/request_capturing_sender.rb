# frozen_string_literal: true

require_relative '../../lib/smartystreets_ruby_sdk/response'

class RequestCapturingSender
  attr_reader :request

  def initialize
    @request = nil
  end

  def send(request)
    @request = request

    SmartyStreets::Response.new('[]', 200)
  end
end
