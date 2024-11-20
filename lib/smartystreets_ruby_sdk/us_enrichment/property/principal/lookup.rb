module SmartyStreets
    module USEnrichment
        module Property
            module Principal
                class Lookup
                    attr_reader :smarty_key, :data_set, :data_sub_set, :etag, :custom_param_hash
                    
                    def initialize(smarty_key, etag=nil, custom_param_hash=nil)
                        @smarty_key = smarty_key
                        @data_set = "property"
                        @data_sub_set = "principal"
                        @etag = etag
                        @custom_param_hash = {}
                    end

                    def add_custom_parameter(parameter, value)
                        @custom_param_hash[parameter] = value
                    end
                end
            end
        end
    end
end