class Candidate
  attr_reader :addressee, :input_index

  def initialize(obj)
    @input_index = obj['input_index']
    @addressee = obj['addressee']
  end
end