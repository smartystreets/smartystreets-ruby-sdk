class Candidate
  attr_reader :input_index, :addressee

  def initialize(obj)
    @input_index = obj['input_index']
    @addressee = obj['addressee']
  end
end