module SmartyStreets
  module InternationalStreet
    # See "https://smartystreets.com/docs/cloud/international-street-api#components"
    class Components
      attr_reader :premise, :thoroughfare_trailing_type, :sub_building, :locality, :post_box_number,
                  :thoroughfare_name, :thoroughfare_postdirection, :dependent_thoroughfare, :premise_prefix_number,
                  :thoroughfare, :dependent_thoroughfare_name, :postal_code_short, :dependent_thoroughfare_trailing_type,
                  :administrative_area, :administrative_area_short, :administrative_area_long, :post_box,
                  :building_leading_type, :dependent_locality_name, :thoroughfare_type,
                  :dependent_thoroughfare_postdirection, :double_dependent_locality, :premise_number,
                  :dependent_thoroughfare_type, :post_box_type, :building, :sub_administrative_area, :postal_code_extra,
                  :sub_building_name, :postal_code, :dependent_locality, :premise_type, :sub_building_number,
                  :super_administrative_area, :premise_extra, :dependent_thoroughfare_predirection,
                  :building_trailing_type, :thoroughfare_predirection, :building_name, :level_type, :level_number,
                  :country_iso_3, :sub_building_type, :additional_content, :delivery_installation, :delivery_installation_type,
                  :delivery_installation_qualifier_name, :route, :route_number, :route_type

      def initialize(obj)
        @country_iso_3 = obj.fetch('country_iso_3', nil)
        @super_administrative_area = obj.fetch('super_administrative_area', nil)
        @administrative_area = obj.fetch('administrative_area', nil)
        @administrative_area_short = obj.fetch('administrative_area_short', nil)
        @administrative_area_long = obj.fetch('administrative_area_long', nil)
        @sub_administrative_area = obj.fetch('sub_administrative_area', nil)
        @dependent_locality= obj.fetch('dependent_locality', nil)
        @dependent_locality_name = obj.fetch('dependent_locality_name', nil)
        @double_dependent_locality = obj.fetch('double_dependent_locality', nil)
        @locality = obj.fetch('locality', nil)
        @postal_code = obj.fetch('postal_code', nil)
        @postal_code_short = obj.fetch('postal_code_short', nil)
        @postal_code_extra = obj.fetch('postal_code_extra', nil)
        @premise = obj.fetch('premise', nil)
        @premise_extra = obj.fetch('premise_extra', nil)
        @premise_number = obj.fetch('premise_number', nil)
        @premise_prefix_number = obj.fetch('premise_prefix_number', nil)
        @premise_type = obj.fetch('premise_type', nil)
        @thoroughfare = obj.fetch('thoroughfare', nil)
        @thoroughfare_predirection = obj.fetch('thoroughfare_predirection', nil)
        @thoroughfare_postdirection = obj.fetch('thoroughfare_postdirection', nil)
        @thoroughfare_name = obj.fetch('thoroughfare_name', nil)
        @thoroughfare_trailing_type = obj.fetch('thoroughfare_trailing_type', nil)
        @thoroughfare_type = obj.fetch('thoroughfare_type', nil)
        @dependent_thoroughfare = obj.fetch('dependent_thoroughfare', nil)
        @dependent_thoroughfare_predirection = obj.fetch('dependent_thoroughfare_predirection', nil)
        @dependent_thoroughfare_postdirection = obj.fetch('dependent_thoroughfare_postdirection', nil)
        @dependent_thoroughfare_name = obj.fetch('dependent_thoroughfare_name', nil)
        @dependent_thoroughfare_trailing_type = obj.fetch('dependent_thoroughfare_trailing_type', nil)
        @dependent_thoroughfare_type = obj.fetch('dependent_thoroughfare_type', nil)
        @building = obj.fetch('building', nil)
        @building_leading_type = obj.fetch('building_leading_type', nil)
        @building_name = obj.fetch('building_name', nil)
        @building_trailing_type = obj.fetch('building_trailing_type', nil)
        @sub_building_type = obj.fetch('sub_building_type', nil)
        @sub_building_number = obj.fetch('sub_building_number', nil)
        @sub_building_name = obj.fetch('sub_building_name', nil)
        @sub_building = obj.fetch('sub_building', nil)
        @level_type = obj.fetch('level_type', nil)
        @level_number = obj.fetch('level_number', nil)
        @post_box = obj.fetch('post_box', nil)
        @post_box_type = obj.fetch('post_box_type', nil)
        @post_box_number = obj.fetch('post_box_number', nil)
        @additional_content = obj.fetch('additional_content', nil)
        @delivery_installation = obj.fetch('delivery_installation', nil)
        @delivery_installation_type = obj.fetch('delivery_installation_type', nil)
        @delivery_installation_qualifier_name = obj.fetch('delivery_installation_qualifier_name', nil)
        @route = obj.fetch('route', nil)
        @route_number = obj.fetch('route_number', nil)
        @route_type = obj.fetch('route_type', nil)
      end
    end
  end
end
