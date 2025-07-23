# frozen_string_literal: true

require_relative 'address'
require_relative 'metadata'

module SmartyStreets
  module USExtract
    # See "https://smartystreets.com/docs/cloud/us-extract-api#http-response-status"
    class Result
      attr_reader :metadata, :addresses

      def initialize(obj)
        @metadata = USExtract::Metadata.new(obj.fetch('meta', {}))
        addresses = obj.fetch('addresses', [])
        @addresses = []

        addresses.each do |address|
          @addresses.push(SmartyStreets::USExtract::Address.new(address))
        end
      end
    end
  end
end
