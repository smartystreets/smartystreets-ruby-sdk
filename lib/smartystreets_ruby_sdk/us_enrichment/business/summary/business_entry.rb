module SmartyStreets
  module USEnrichment
    module Business
      module Summary
        class BusinessEntry
          attr_reader :company_name, :business_id

          def initialize(obj)
            @company_name = obj['company_name']
            @business_id = obj['business_id']
          end
        end
      end
    end
  end
end
