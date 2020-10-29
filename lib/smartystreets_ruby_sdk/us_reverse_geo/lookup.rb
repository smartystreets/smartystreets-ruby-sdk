module SmartyStreets
  module USReverseGeo
    # In addition to holding all of the input data for this lookup, this class also will contain the
    # result of the lookup after it comes back from the API.
    #
    # Note: Lookups must have certain required fields set with non-blank values.
    # These can be found at the URL below.
    #
    # See "https://smartystreets.com/docs/cloud/us-reverse-geo-api#http-request-input-fields"

    class Lookup

      attr_accessor :latitude, :longitude, :response

      def initialize(latitude, longitude)
        @latitude = sprintf('%.8f', latitude)
        @longitude = sprintf('%.8f', longitude)
      end
    end
  end
end
