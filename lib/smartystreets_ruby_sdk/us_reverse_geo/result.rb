require_relative 'coordinate'
require_relative 'address'

module SmartyStreets
  module USReverseGeo
    # A result is a possible match for an geocode that was submitted. A lookup can have multiple results.
    #
    # See "https://smartystreets.com/docs/cloud/us-reverse-geo-api#result"
    class Result
      attr_reader :address, :coordinate, :distance

      def initialize(obj)
        @address = Address.new(obj.fetch('address', {}))
        @coordinate = Coordinate.new(obj.fetch('coordinate', {}))
        @distance = obj['distance']
      end
    end
  end
end
