require_relative 'attributes'

module SmartyStreets
  module USEnrichment
    module Business
      module Detail
        class Response
          attr_reader :smarty_key, :data_set_name, :business_id, :attributes

          def initialize(obj)
            @smarty_key = obj['smarty_key']
            @data_set_name = obj['data_set_name']
            @business_id = obj['business_id']
            @attributes = Attributes.new(obj['attributes'])
          end
        end
      end
    end
  end
end
