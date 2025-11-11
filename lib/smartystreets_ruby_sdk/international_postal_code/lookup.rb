module SmartyStreets
  module InternationalPostalCode
    # Holds the input data for a postal code lookup and the results returned by the API.
    # See https://smartystreets.com/docs/cloud/international-postal-code-api
    class Lookup

      attr_accessor :input_id, :country, :locality, :administrative_area, :postal_code, :results

      def initialize
        @input_id = nil
        @country = nil
        @locality = nil
        @administrative_area = nil
        @postal_code = nil
        @results = []
      end
    end
  end
end


