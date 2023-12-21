require_relative "attributes"

module SmartyStreets
    module USEnrichment
        module Property
            module Financial
                class Response
                    attr_reader :smarty_key, :data_set, :data_sub_set, :attributes
            
                    def initialize(obj)
                        @smarty_key = obj['smarty_key']
                        @data_set = obj['data_set']
                        @data_sub_set = obj['data_sub_set']
                        @attributes = Attributes.new(obj['attributes'])
                    end
                end
            end
        end
    end
end