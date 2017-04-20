require_relative '../json_able'
module USZipcode
  # In addition to holding all of the input data for this lookup, this class also
  #   will contain the result of the lookup after it comes back from the API.
  #
  #   See "https://smartystreets.com/docs/cloud/us-zipcode-api#http-request-input-fields"
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
end