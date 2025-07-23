# frozen_string_literal: true

module SmartyStreets
  module USZipcode
    # See "https://smartystreets.com/docs/cloud/us-zipcode-api#zipcodes"
    class AlternateCounty
      attr_reader :state_abbreviation, :state, :county_name, :county_fips

      def initialize(obj)
        @county_fips = obj.fetch('county_fips', nil)
        @county_name = obj.fetch('county_name', nil)
        @state_abbreviation = obj.fetch('state_abbreviation', nil)
        @state = obj.fetch('state', nil)
      end
    end
  end
end
