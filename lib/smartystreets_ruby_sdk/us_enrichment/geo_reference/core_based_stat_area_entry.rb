# frozen_string_literal: true

module SmartyStreets
  module USEnrichment
    module GeoReference
      class CoreBasedStatAreaEntry
        attr_reader :code, :name

        def initialize(obj)
          @code = obj['code']
          @name = obj['name']
        end
      end
    end
  end
end
