# frozen_string_literal: true

class FakeLogger
  attr_reader :messages

  def initialize
    @messages = []
  end

  def log(message)
    @messages.push(message)
  end
end
