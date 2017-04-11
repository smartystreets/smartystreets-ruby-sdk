require_relative './address'
require_relative './metadata'

module Smartystreets
  module USExtract
    # See "https://smartystreets.com/docs/cloud/us-extract-api#http-response-status"
    class Result
      attr_reader :metadata, :addresses

      def initialize(obj)
        @metadata = Metadata.new(obj.fetch('meta', {}))
        addresses = obj.fetch('addresses', [])
        @addresses = []

        addresses.each { |address|
          @addresses.push(Address.new(address))
        }
      end
    end
  end
end
