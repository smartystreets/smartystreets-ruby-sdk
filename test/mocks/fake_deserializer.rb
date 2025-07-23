# frozen_string_literal: true

class FakeDeserializer
  attr_reader :input

  def initialize(output)
    @output = output
    @input = nil
  end

  def serialize(_obj)
    ''
  end

  def deserialize(body)
    @input = body
    @output
  end
end
