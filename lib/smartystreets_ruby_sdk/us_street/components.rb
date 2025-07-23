# frozen_string_literal: true

module SmartyStreets
  module USStreet
    # This class contains the matched address broken down into its fundamental pieces.
    #
    # See "https://smartystreets.com/docs/cloud/us-street-api#components"
    class Components
      attr_reader :street_postdirection, :delivery_point_check_digit, :secondary_designator, :secondary_number, :zipcode,
                  :pmb_number, :state_abbreviation, :extra_secondary_designator, :urbanization, :street_name, :city_name,
                  :default_city_name, :street_suffix, :primary_number, :plus4_code, :street_predirection, :pmb_designator,
                  :extra_secondary_number, :delivery_point

      def initialize(obj)
        @urbanization = obj['urbanization']
        @primary_number = obj['primary_number']
        @street_name = obj['street_name']
        @street_predirection = obj['street_predirection']
        @street_postdirection = obj['street_postdirection']
        @street_suffix = obj['street_suffix']
        @secondary_number = obj['secondary_number']
        @secondary_designator = obj['secondary_designator']
        @extra_secondary_number = obj['extra_secondary_number']
        @extra_secondary_designator = obj['extra_secondary_designator']
        @pmb_designator = obj['pmb_designator']
        @pmb_number = obj['pmb_number']
        @city_name = obj['city_name']
        @default_city_name = obj['default_city_name']
        @state_abbreviation = obj['state_abbreviation']
        @zipcode = obj['zipcode']
        @plus4_code = obj['plus4_code']
        @delivery_point = obj['delivery_point']
        @delivery_point_check_digit = obj['delivery_point_check_digit']
      end
    end
  end
end
