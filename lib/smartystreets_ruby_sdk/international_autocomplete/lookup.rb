require_relative '../json_able'

module SmartyStreets
  module InternationalAutocomplete
    # In addition to holding all of the input data for this lookup, this class also will contain the result
    # of the lookup after it comes back from the API.
    class Lookup < JSONAble

      attr_accessor :result, :search, :country, :max_results, :distance, :geolocation, :administrative_area, :locality, :postal_code, :latitude, :longitude

      def initialize(search = nil, country = nil, max_results = nil, distance = nil, geolocation = nil, administrative_area = nil, locality = nil, postal_code = nil, latitude = nil, longitude = nil)
        @result = []
        @search = search
        @country = country
        @max_results = max_results
        @distance = distance
        @geolocation = geolocation
        @administrative_area = administrative_area
        @locality = locality
        @postal_code = postal_code
        @latitude = latitude
        @longitude = longitude
      end
    end
  end
end