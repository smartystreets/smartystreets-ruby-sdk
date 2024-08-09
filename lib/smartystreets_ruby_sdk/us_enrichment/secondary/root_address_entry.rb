module SmartyStreets
  module USEnrichment
    module Secondary
      class RootAddressEntry
        attr_reader :secondary_count, :smarty_key, :primary_number, :street_predirection, :street_name, :street_suffix, :street_postdirection,
        :city_name, :state_abbreviation, :zipcode, :plus4_code

        def initialize(obj)
          @secondary_count = obj['secondary_count']
          @smarty_key = obj['smarty_key']
          @primary_number = obj['primary_number']
          @street_predirection = obj['street_predirection']
          @street_name = obj['street_name']
          @street_suffix = obj['street_suffix']
          @street_postdirection = obj['street_postdirection']
          @city_name = obj['city_name']
          @state_abbreviation = obj['state_abbreviation']
          @zipcode = obj['zipcode']
          @plus4_code = obj['plus4_code']
        end
      end
    end
  end
end