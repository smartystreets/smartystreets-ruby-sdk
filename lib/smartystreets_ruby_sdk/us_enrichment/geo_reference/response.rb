require_relative "attributes"

module SmartyStreets
  module USEnrichment
    module GeoReference
      class Response
        attr_reader :smarty_key, :data_set_name, :data_set_version, :matched_address, :attributes

        def initialize(obj)
          @smarty_key = obj['smarty_key']
          @data_set_name = obj['data_set_name']
          @data_set_version = obj['data_set_version']
          @matched_address = obj['matched_address']
          @attributes = Attributes.new(obj['attributes'])
        end
      end
    end
  end
end