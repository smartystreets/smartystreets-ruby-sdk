module SmartyStreets
  module USEnrichment
    module Secondary
      class SecondariesEntry
        attr_reader :smarty_key, :secondary_designator, :secondary_number, :plus4_code

        def initialize(obj)
          @smarty_key = obj['smarty_key']
          @secondary_designator = obj['secondary_designator']
          @secondary_number = obj['secondary_number']
          @plus4_code = obj['plus4_code']
        end
      end
    end
  end
end
