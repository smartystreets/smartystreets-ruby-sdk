module SmartyStreets
  module USEnrichment
    module Secondary
      module Count
        class Lookup
          attr_reader :smarty_key, :data_set, :data_sub_set
              
          def initialize(smarty_key)
            @smarty_key = smarty_key
            @data_set = "secondary"
            @data_sub_set = "count"
          end
        end
      end
    end
  end
end