# frozen_string_literal: true

require_relative 'changes'
module SmartyStreets
  module InternationalStreet
    # See "https://smartystreets.com/docs/cloud/international-street-api#analysis"
    class Analysis
      attr_reader :max_address_precision, :verification_status, :address_precision, :changes

      def initialize(obj)
        @verification_status = obj.fetch('verification_status', nil)
        @address_precision = obj.fetch('address_precision', nil)
        @max_address_precision = obj.fetch('max_address_precision', nil)
        @changes = Changes.new(obj.fetch('changes', {}))
      end
    end
  end
end
