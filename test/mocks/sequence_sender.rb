require_relative '../../lib/smartystreets_ruby_sdk/response'

class SequenceSender
  attr_reader :current_index

  def initialize(responses)
    @responses = responses
    @current_index = 0
  end

  def send(request)
    response = @responses[@current_index] || @responses.last
    @current_index += 1

    response
  end
end
