# frozen_string_literal: true

class FakeSleeper
  attr_reader :sleep_durations

  def initialize
    @sleep_durations = []
  end

  def sleep(seconds)
    @sleep_durations.push(seconds)
  end
end
