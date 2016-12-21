require './lib/smartystreets_ruby_sdk/json_able'

class Lookup < JSONAble
  attr_accessor :input_id, :street, :street2, :secondary, :city, :state, :zipcode, :lastline, :addressee, :urbanization,
                :match, :candidates, :result

  def initialize(street=nil, street2=nil, secondary=nil, city=nil, state=nil, zipcode=nil, lastline=nil,
                 addressee=nil, urbanization=nil, match=nil, candidates=1, input_id=nil)
    @input_id = input_id
    @street = street
    @street2 = street2
    @secondary = secondary
    @city = city
    @state = state
    @zipcode = zipcode
    @lastline = lastline
    @addressee = addressee
    @urbanization = urbanization
    @match = match
    @candidates = candidates
    @result = []
  end
end