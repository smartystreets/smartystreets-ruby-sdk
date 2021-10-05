require_relative '../json_able'

module SmartyStreets
  module InternationalAutocomplete
    # In addition to holding all of the input data for this lookup, this class also will contain the result
    # of the lookup after it comes back from the API.
    class Lookup < JSONAble

      attr_accessor :result, :search, :country, :administrative_area, :locality, :postal_code

      def initialize(search=nil, country=nil, administrative_area=nil, locality=nil, postal_code=nil)
        @result = []
        @search = search
        @country = country
        @administrative_area = administrative_area
        @locality = locality
        @postal_code = postal_code
      end
    end
  end
end