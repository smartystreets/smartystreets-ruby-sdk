# frozen_string_literal: true

module SmartyStreets
  module USEnrichment
    module GeoReference
      class CensusTractEntry
        attr_reader :code

        def initialize(obj)
          @code = obj['code']
        end
      end
    end
  end
end
