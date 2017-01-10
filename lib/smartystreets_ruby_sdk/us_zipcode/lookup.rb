require_relative '../json_able'

class Lookup < JSONAble
  attr_accessor :result, :state, :zipcode, :input_id, :city

  def initialize(city=nil, state=nil, zipcode=nil, input_id=nil)
    @result = nil
    @input_id = input_id
    @city = city
    @state = state
    @zipcode = zipcode
  end
end