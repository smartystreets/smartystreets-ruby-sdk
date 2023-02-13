module SmartyStreets
  module InternationalAutocomplete
    class Suggestion

      attr_reader :street, :locality, :administrative_area, :super_administrative_area, :sub_administrative_area, :postal_code, :country_iso3

      def initialize(obj)
        @street = obj.fetch('street', nil)
        @locality = obj.fetch('locality', nil)
        @administrative_area = obj.fetch('administrative_area', nil)
        @super_administrative_area = obj.fetch('super_administrative_area', nil)
        @sub_administrative_area = obj.fetch('sub_administrative_area', nil)
        @postal_code = obj.fetch('postal_code', nil)
        @country_iso3 = obj.fetch('country_iso3', nil)
      end
    end
  end
end
