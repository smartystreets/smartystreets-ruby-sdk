module SmartyStreets
  module InternationalStreet
    # See "https://smartystreets.com/docs/cloud/international-street-api#metadata"
    class Metadata

      attr_reader :longitude, :geocode_precision, :max_geocode_precision, :latitude, :address_format

      def initialize(obj)
        @latitude = obj.fetch('latitude', nil)
        @longitude = obj.fetch('longitude', nil)
        @geocode_precision = obj.fetch('geocode_precision', nil)
        @max_geocode_precision = obj.fetch('max_geocode_precision', nil)
        @address_format = obj.fetch('address_format', nil)
      end
    end
  end
end
