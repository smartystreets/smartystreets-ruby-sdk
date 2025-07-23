# frozen_string_literal: true

require_relative 'city'
require_relative 'zip_code'

module SmartyStreets
  module USZipcode
    # See "https://smartystreets.com/docs/cloud/us-zipcode-api#root"
    class Result
      attr_reader :reason, :input_id, :input_index, :cities, :zipcodes, :status

      def initialize(obj)
        @status = obj['status']
        @reason = obj['reason']
        @input_id = obj['input_id']
        @input_index = obj['input_index']
        @cities = obj.fetch('city_states', [])
        @zipcodes = obj.fetch('zipcodes', [])

        @cities = convert_cities
        @zipcodes = convert_zipcodes
      end

      def valid?
        @status.nil? and @reason.nil?
      end

      def convert_cities
        @cities.map do |city|
          City.new(city)
        end
      end

      def convert_zipcodes
        @zipcodes.map do |zipcode|
          ZipCode.new(zipcode)
        end
      end
    end
  end
end
