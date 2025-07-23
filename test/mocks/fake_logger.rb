# frozen_string_literal: true

class FakeLogger
  attr_reader :log

  def initialize
    @log = []
  end

  def log(message)
    @log.push(message)
  end
end
