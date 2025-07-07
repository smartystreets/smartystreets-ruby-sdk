require_relative "attributes"

module SmartyStreets
  module USEnrichment
    module Risk
      class Response
        attr_reader :smarty_key, :data_set, :attributes, :etag

        def initialize(obj, etag=nil)
          @smarty_key = obj['smarty_key']
          @data_set = obj['data_set']
          @attributes = Attributes.new(obj['attributes'])
          @etag = etag
        end
      end
    end
  end
end