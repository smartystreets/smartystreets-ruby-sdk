# frozen_string_literal: true

module SmartyStreets
  module USZipcode
    # Known in the SmartyStreets US ZIP Code API documentation as a city_state
    # See "https://smartystreets.com/docs/cloud/us-zipcode-api#cities"
    class City
      attr_reader :mailable_city, :state_abbreviation, :state, :city

      def initialize(obj)
        @city = obj['city']
        @mailable_city = obj['mailable_city']
        @state_abbreviation = obj['state_abbreviation']
        @state = obj['state']
      end
    end
  end
end
