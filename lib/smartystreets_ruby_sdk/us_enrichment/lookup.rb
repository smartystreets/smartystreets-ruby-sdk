require_relative '../json_able'
module SmartyStreets
  module USEnrichment
    class Lookup < JSONAble
      attr_accessor :smarty_key, :data_set, :data_sub_set, :freeform, :street, :city, :state, :zipcode, :etag
              
      def initialize(smarty_key=nil, data_set=nil, data_sub_set=nil, freeform=nil, street=nil, city=nil, state=nil, zipcode=nil, etag=nil)
        @smarty_key = smarty_key
        @data_set = data_set
        @data_sub_set = data_sub_set
        @freeform = freeform
        @street = street
        @city = city
        @state = state
        @zipcode = zipcode
        @etag = etag
      end
    end
  end
end