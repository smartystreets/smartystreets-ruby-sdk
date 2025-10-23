module SmartyStreets
  module USEnrichment
    module Secondary
      module Count
        class Response
          attr_reader :smarty_key, :matched_address, :count, :etag

          def initialize(obj, etag=nil)
            @smarty_key = obj['smarty_key']
            @matched_address = obj['matched_address']
            @count = obj['count']
            @etag = etag
          end
        end
      end
    end
  end
end