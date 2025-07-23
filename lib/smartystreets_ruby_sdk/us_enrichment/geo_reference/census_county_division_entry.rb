# frozen_string_literal: true

module SmartyStreets
  module USEnrichment
    module GeoReference
      class CensusCountyDivisionEntry
        attr_reader :accuracy, :code, :name

        def initialize(obj)
          @accuracy = obj['accuracy']
          @code = obj['code']
          @name = obj['name']
        end
      end
    end
  end
end
