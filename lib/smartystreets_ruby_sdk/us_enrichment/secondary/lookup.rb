module SmartyStreets
  module USEnrichment
    module Secondary
      class Lookup
        attr_reader :smarty_key, :data_set, :data_sub_set, :etag
              
        def initialize(smarty_key, etag=nil)
          @smarty_key = smarty_key
          @data_set = "secondary"
          @data_sub_set = nil
          @etag = etag
        end
      end
    end
  end
end