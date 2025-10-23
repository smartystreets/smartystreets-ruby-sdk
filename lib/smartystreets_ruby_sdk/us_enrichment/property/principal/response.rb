require_relative "attributes"

module SmartyStreets
    module USEnrichment
        module Property
            module Principal
                class Response
                    attr_reader :smarty_key, :data_set_name, :data_subset_name, :matched_address, :attributes, :etag
            
                    def initialize(obj, etag=nil)
                        @smarty_key = obj['smarty_key']
                        @data_set_name = obj['data_set_name']
                        @data_subset_name = obj['data_subset_name']
                        @matched_address = obj['matched_address']
                        @attributes = Attributes.new(obj['attributes'])
                        @etag = etag
                    end
                end
            end
        end
    end
end