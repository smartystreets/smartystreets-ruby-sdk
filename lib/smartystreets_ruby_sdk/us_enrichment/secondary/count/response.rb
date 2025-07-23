# frozen_string_literal: true

module SmartyStreets
  module USEnrichment
    module Secondary
      module Count
        class Response
          attr_reader :smarty_key, :count, :etag

          def initialize(obj, etag = nil)
            @smarty_key = obj['smarty_key']
            @count = obj['count']
            @etag = etag
          end
        end
      end
    end
  end
end
