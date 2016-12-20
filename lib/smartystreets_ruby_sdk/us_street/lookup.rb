require './lib/smartystreets_ruby_sdk/json_able'

class Lookup < JSONAble
  attr_accessor :input_id, :street

  def initialize(street=nil)
    @input_id = nil
    @street = street
  end
end