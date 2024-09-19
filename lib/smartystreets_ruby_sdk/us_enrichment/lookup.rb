<<<<<<< HEAD
require_relative '../json_able'
module SmartyStreets
  module USEnrichment
    class Lookup < JSONAble
      attr_accessor :smarty_key, :data_set, :data_sub_set, :freeform, :street, :city, :state, :zipcode
              
      def initialize(smarty_key=nil, data_set=nil, data_sub_set=nil, freeform=nil, street=nil, city=nil, state=nil, zipcode=nil)
        @smarty_key = smarty_key
        @data_set = data_set
        @data_sub_set = data_sub_set
        @freeform = freeform
        @street = street
        @city = city
        @state = state
        @zipcode = zipcode
=======
module SmartyStreets
  module USEnrichment
    class Lookup
      attr_reader :smarty_key, :data_set, :data_sub_set
              
      def initialize(smarty_key, data_set, data_sub_set)
        @smarty_key = smarty_key
        @data_set = data_set
        @data_sub_set = data_sub_set
>>>>>>> 48dda29c9382c5cd28b751e3595b772f6427acc8
      end
    end
  end
end