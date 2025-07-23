# frozen_string_literal: true

module SmartyStreets
  module USReverseGeo
    # See "https://smartystreets.com/docs/cloud/us-reverse-geo-api#coordinate"
    class Coordinate
      attr_reader :latitude, :longitude, :accuracy, :license

      def initialize(obj)
        @latitude = obj.fetch('latitude', nil)
        @longitude = obj.fetch('longitude', nil)
        @accuracy = obj.fetch('accuracy', nil)
        @license = obj.fetch('license', nil)
      end

      def get_license
        case @license
        when 1
          'SmartyStreets Proprietary'
        else
          'SmartyStreets'
        end
      end
    end
  end
end
