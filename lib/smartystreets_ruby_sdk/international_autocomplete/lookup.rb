require_relative '../json_able'

module SmartyStreets
  module InternationalAutocomplete
    # In addition to holding all of the input data for this lookup, this class also will contain the result
    # of the lookup after it comes back from the API.
    class Lookup < JSONAble
      attr_accessor :result, :search, :address_id, :country, :max_results, :locality, :postal_code, :custom_param_hash

      def initialize(search = nil, address_id = nil, country = nil, max_results = nil, locality = nil,
                     postal_code = nil, _custom_param_hash = nil)
        @result = []
        @search = search
        @address_id = address_id
        @country = country
        @max_results = max_results
        @locality = locality
        @postal_code = postal_code
        @custom_param_hash = {}
      end

      def add_custom_parameter(parameter, value)
        @custom_param_hash[parameter] = value
      end
    end
  end
end
