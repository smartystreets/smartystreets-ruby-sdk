class FakeSerializer
  def initialize(output)
    @output = output
    @input = nil
  end

  def serialize(obj)
    @input = obj
    @output
  end

  def deserialize(payload)
      nil
    end
end