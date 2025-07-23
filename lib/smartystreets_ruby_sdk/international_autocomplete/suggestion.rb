module SmartyStreets
  module InternationalAutocomplete
    class Suggestion
      attr_reader :street, :locality, :administrative_area, :administrative_area_short, :administrative_area_long,
                  :postal_code, :country_iso3, :entries, :address_text, :address_id

      def initialize(obj)
        @street = obj.fetch('street', nil)
        @locality = obj.fetch('locality', nil)
        @administrative_area = obj.fetch('administrative_area', nil)
        @administrative_area_short = obj.fetch('administrative_area_short', nil)
        @administrative_area_long = obj.fetch('administrative_area_long', nil)
        @postal_code = obj.fetch('postal_code', nil)
        @country_iso3 = obj.fetch('country_iso3', nil)
        # v2 fields
        @entries = obj.fetch('entries', nil)
        @address_text = obj.fetch('address_text', nil)
        @address_id = obj.fetch('address_id', nil)
      end
    end
  end
end
