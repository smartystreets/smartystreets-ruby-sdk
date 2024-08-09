module SmartyStreets
  module USEnrichment
    class Lookup
      attr_reader :smarty_key, :data_set, :data_sub_set
              
      def initialize(smarty_key, data_set, data_sub_set)
        @smarty_key = smarty_key
        @data_set = data_set
        @data_sub_set = data_sub_set
      end
    end
  end
end