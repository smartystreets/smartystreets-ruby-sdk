module SmartyStreets
  module USStreet
    class MatchInfo
      attr_reader :status, :change

      def initialize(obj = {})
        @status = obj['status']
        @change = obj['change'] || []
      end
    end

    class ComponentAnalysis
      attr_reader :primary_number, :street_predirection, :street_name, :street_postdirection,
                  :street_suffix, :secondary_number, :secondary_designator, :extra_secondary_number,
                  :extra_secondary_designator, :city_name, :state_abbreviation, :zipcode,
                  :plus4_code, :urbanization

      def initialize(obj = {})
        @primary_number = MatchInfo.new(obj.fetch('primary_number', {}))
        @street_predirection = MatchInfo.new(obj.fetch('street_predirection', {}))
        @street_name = MatchInfo.new(obj.fetch('street_name', {}))
        @street_postdirection = MatchInfo.new(obj.fetch('street_postdirection', {}))
        @street_suffix = MatchInfo.new(obj.fetch('street_suffix', {}))
        @secondary_number = MatchInfo.new(obj.fetch('secondary_number', {}))
        @secondary_designator = MatchInfo.new(obj.fetch('secondary_designator', {}))
        @extra_secondary_number = MatchInfo.new(obj.fetch('extra_secondary_number', {}))
        @extra_secondary_designator = MatchInfo.new(obj.fetch('extra_secondary_designator', {}))
        @city_name = MatchInfo.new(obj.fetch('city_name', {}))
        @state_abbreviation = MatchInfo.new(obj.fetch('state_abbreviation', {}))
        @zipcode = MatchInfo.new(obj.fetch('zipcode', {}))
        @plus4_code = MatchInfo.new(obj.fetch('plus4_code', {}))
        @urbanization = MatchInfo.new(obj.fetch('urbanization', {}))
      end
    end
  end
end
