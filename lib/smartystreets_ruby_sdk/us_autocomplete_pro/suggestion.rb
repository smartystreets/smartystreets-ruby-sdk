# frozen_string_literal: true

module SmartyStreets
  module USAutocompletePro
    # See "https://smartystreets.com/docs/cloud/us-autocomplete-api#http-response"
    class Suggestion
      attr_reader :street_line, :secondary, :city, :state, :zipcode, :entries

      def initialize(obj)
        @street_line = obj.fetch('street_line', nil)
        @secondary = obj.fetch('secondary', nil)
        @city = obj.fetch('city', nil)
        @state = obj.fetch('state', nil)
        @zipcode = obj.fetch('zipcode', nil)
        @entries = obj.fetch('entries', 0)
      end
    end
  end
end
