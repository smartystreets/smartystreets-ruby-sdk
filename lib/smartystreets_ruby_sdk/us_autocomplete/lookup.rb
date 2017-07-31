require_relative '../json_able'

module SmartyStreets
  module USAutocomplete
    # In addition to holding all of the input data for this lookup, this class also will contain the result
    # of the lookup after it comes back from the API.
    #
    # See "https://smartystreets.com/docs/cloud/us-autocomplete-api#http-request-input-fields"
    class Lookup < JSONAble

      attr_accessor :result, :prefix, :state_filter, :prefer, :prefer_ratio, :max_suggestions, :geolocate_type, :city_filter

      def initialize(prefix=nil, suggestions=nil, city_filter=nil, state_filter=nil,
                     prefer=nil, prefer_ratio=nil, geolocate_type=nil)
        @result = []
        @prefix = prefix
        @max_suggestions = suggestions
        @city_filter = city_filter ? city_filter : []
        @state_filter = state_filter ? state_filter : []
        @prefer = prefer ? prefer : []
        @prefer_ratio = prefer_ratio
        @geolocate_type = geolocate_type
      end

      def add_city_filter(city)
        @city_filter.push(city)
      end

      def add_state_filter(state)
        @state_filter.push(state)
      end

      def add_prefer(prefer)
        @prefer.push(prefer)
      end
    end
  end
end