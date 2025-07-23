require_relative '../json_able'

module SmartyStreets
  module USZipcode
    # In addition to holding all of the input data for this lookup, this class also
    #   will contain the result of the lookup after it comes back from the API.
    #
    #   See "https://smartystreets.com/docs/cloud/us-zipcode-api#http-request-input-fields"
    class Lookup < JSONAble
      attr_accessor :result, :state, :zipcode, :input_id, :city, :custom_param_hash

      def initialize(city = nil, state = nil, zipcode = nil, input_id = nil, _custom_param_hash = nil)
        @result = nil
        @input_id = input_id
        @city = city
        @state = state
        @zipcode = zipcode
        @custom_param_hash = {}
      end

      def add_custom_parameter(parameter, value)
        @custom_param_hash[parameter] = value
      end
    end
  end
end
