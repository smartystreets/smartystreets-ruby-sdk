module SmartyStreets
  module InternationalStreet
    # See "https://smartystreets.com/docs/cloud/international-street-api#metadata"
    class Metadata

      attr_reader :longitude, :geocode_precision, :geocode_classification, :max_geocode_precision, :latitude, :address_format, :occupant_use

      def initialize(obj)
        @latitude = obj.fetch('latitude', nil)
        @longitude = obj.fetch('longitude', nil)
        @geocode_precision = obj.fetch('geocode_precision', nil)
        @geocode_classification = obj.fetch('geocode_classification', nil)
        @max_geocode_precision = obj.fetch('max_geocode_precision', nil)
        @address_format = obj.fetch('address_format', nil)
        @occupant_use = obj.fetch('occupant_use', nil)
      end
    end
  end
end
