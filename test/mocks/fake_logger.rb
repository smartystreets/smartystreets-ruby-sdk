class FakeLogger
  attr_reader :log

  def initialize
    @log = []
  end

  def warn(message)
    @log.push(message)
  end
end