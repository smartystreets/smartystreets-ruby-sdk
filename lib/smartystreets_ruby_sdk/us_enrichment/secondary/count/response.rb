module SmartyStreets
  module USEnrichment
    module Secondary
      module Count
        class Response
          attr_reader :smarty_key, :count

          def initialize(obj)
            @smarty_key = obj['smarty_key']
            @count = obj['count']
          end
        end
      end
    end
  end
end