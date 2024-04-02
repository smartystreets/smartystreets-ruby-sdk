require_relative '../json_able'
module SmartyStreets
  module USStreet
    # In addition to holding all of the input data for this lookup, this class also will contain
    # the result of the lookup after it comes back from the API.
    #
    # See "https://smartystreets.com/docs/cloud/us-street-api#input-fields"
    #
    # @match:: Must be set to 'strict', 'enhanced', or 'invalid'. Constants for these are in match_type.rb
    class Lookup < JSONAble
      attr_accessor :input_id, :street, :street2, :secondary, :city, :state, :zipcode, :lastline, :addressee, :urbanization,
                    :match, :candidates, :format, :result

      def initialize(street=nil, street2=nil, secondary=nil, city=nil, state=nil, zipcode=nil, lastline=nil,
                     addressee=nil, urbanization=nil, match=nil, candidates=0, input_id=nil, format=nil)
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
        @format = format
        @result = []
      end
    end
  end
end