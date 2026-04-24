module SmartyStreets
  module USEnrichment
    module Secondary
      module Count
        class Response
          attr_reader :smarty_key, :matched_address, :count

          def initialize(obj)
            @smarty_key = obj['smarty_key']
            @matched_address = obj['matched_address']
            @count = obj['count']
          end
        end
      end
    end
  end
end