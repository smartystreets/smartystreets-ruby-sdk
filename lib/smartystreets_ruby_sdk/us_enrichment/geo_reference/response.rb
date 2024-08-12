require_relative "attributes"

module SmartyStreets
  module USEnrichment
    module GeoReference
      class Response
        attr_reader :smarty_key, :data_set, :attributes

        def initialize(obj)
          @smarty_key = obj['smarty_key']
          @data_set = 'geo-reference'
          @attributes = Attributes.new(obj['attributes'])
        end
      end
    end
  end
end