require_relative '../json_able'

module SmartyStreets
  module USAutocompletePro
    # In addition to holding all of the input data for this lookup, this class also will contain the result
    # of the lookup after it comes back from the API.
    #
    # See "https://smartystreets.com/docs/cloud/us-autocomplete-api#http-request-input-fields"
    class Lookup < JSONAble

      attr_accessor :result, :search, :max_results, :city_filter, :state_filter, :zip_filter,
                    :exclude_states, :prefer_cities, :prefer_states, :prefer_zip_codes, :prefer_ratio, :prefer_geolocation, :selected

      def initialize(search=nil, max_results=nil, city_filter=nil, state_filter=nil, zip_filter=nil,
                     exclude_states=nil, prefer_cities=nil, prefer_states=nil, prefer_zips=nil, prefer_ratio=nil,
                     prefer_geolocation=nil, selected=nil)
        @result = []
        @search = search
        @max_results = max_results
        @city_filter = city_filter ? city_filter : []
        @state_filter = state_filter ? state_filter : []
        @zip_filter = zip_filter ? zip_filter : []
        @exclude_states = exclude_states ? exclude_states : []
        @prefer_cities = prefer_cities ? prefer_cities : []
        @prefer_states = prefer_states ? prefer_states : []
        @prefer_zip_codes = prefer_zips ? prefer_zips : []
        @prefer_ratio = prefer_ratio
        @prefer_geolocation = prefer_geolocation
        @selected = selected
      end

      def add_city_filter(city)
        @city_filter.push(city)
      end

      def add_state_filter(state)
        @state_filter.push(state)
      end

      def add_zip_filter(zip)
        @zip_filter.push(zip)
      end

      def add_state_exclusion(state)
        @exclude_states.push(state)
      end

      def add_preferred_city(city)
        @prefer_cities.push(city)
      end

      def add_preferred_state(state)
        @prefer_states.push(state)
      end

      def add_preferred_zip(zip)
        @prefer_zip_codes.push(zip)
      end
    end
  end
end