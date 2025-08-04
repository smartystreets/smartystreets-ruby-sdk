require_relative "attributes"

module SmartyStreets
  module USEnrichment
    module Risk
      class Response
        attr_reader :smarty_key, :data_set_name, :matched_address, :attributes, :etag

        def initialize(obj, etag=nil)
          @smarty_key = obj['smarty_key']
          @data_set_name = obj['data_set_name']
          @matched_address = obj['matched_address']
          @attributes = Attributes.new(obj['attributes'])
          @etag = etag
        end
      end
    end
  end
end