module SmartyStreets
    module USEnrichment
        module Property
            module Financial
                class Lookup
                    attr_reader :smarty_key, :data_set, :data_sub_set, :etag
                    
                    def initialize(smarty_key, etag=nil)
                        @smarty_key = smarty_key
                        @data_set = "property"
                        @data_sub_set = "financial"
                        @etag = etag
                    end
                end
            end
        end
    end
end