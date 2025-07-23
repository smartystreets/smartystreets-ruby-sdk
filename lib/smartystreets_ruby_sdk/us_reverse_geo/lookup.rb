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
      attr_accessor :latitude, :longitude, :source, :response, :custom_param_hash

      def initialize(latitude, longitude, source = nil, _custom_param_hash = nil)
        @latitude = format('%.8f', latitude)
        @longitude = format('%.8f', longitude)
        @source = source
        @custom_param_hash = {}
      end

      def add_custom_parameter(parameter, value)
        @custom_param_hash[parameter] = value
      end
    end
  end
end
