module SmartyStreets
  module InternationalPostalCode
    # Represents a single candidate returned by the International Postal Code API.
    # See https://smartystreets.com/docs/cloud/international-postal-code-api
    class Candidate
      attr_reader :input_id,
                  :administrative_area,
                  :sub_administrative_area,
                  :super_administrative_area,
                  :country_iso_3,
                  :locality,
                  :dependent_locality,
                  :dependent_locality_name,
                  :double_dependent_locality,
                  :postal_code,
                  :postal_code_extra

      def initialize(obj)
        @input_id = obj['input_id']
        @administrative_area = obj['administrative_area']
        @sub_administrative_area = obj['sub_administrative_area']
        @super_administrative_area = obj['super_administrative_area']
        @country_iso_3 = obj['country_iso_3']
        @locality = obj['locality']
        @dependent_locality = obj['dependent_locality']
        @dependent_locality_name = obj['dependent_locality_name']
        @double_dependent_locality = obj['double_dependent_locality']
        @postal_code = obj['postal_code']
        @postal_code_extra = obj['postal_code_extra']
      end
    end
  end
end


