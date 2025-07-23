# frozen_string_literal: true

module SmartyStreets
  module USEnrichment
    module GeoReference
      class CensusBlockEntry
        attr_reader :accuracy, :geoid

        def initialize(obj)
          @accuracy = obj['accuracy']
          @geoid = obj['geoid']
        end
      end
    end
  end
end
