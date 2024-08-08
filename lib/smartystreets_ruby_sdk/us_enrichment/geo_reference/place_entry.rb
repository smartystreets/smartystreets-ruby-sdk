module SmartyStreets
  module USEnrichment
    module GeoReference
      class PlaceEntry
        attr_reader :accuracy, :code, :name, :type
        
        def initialize(obj)
          @accuracy = obj['accuracy']
          @code = obj['code']
          @name = obj['name']
          @type = obj['type']
        end
      end
    end
  end
end