require_relative '../json_able'
module SmartyStreets
  module USEnrichment
    class Lookup < JSONAble
      attr_accessor :smarty_key, :data_set, :data_sub_set, :freeform, :street, :city, :state, :zipcode, :etag, :custom_param_hash
              
      def initialize(smarty_key=nil, data_set=nil, data_sub_set=nil, freeform=nil, street=nil, city=nil, state=nil, zipcode=nil, etag=nil, custom_param_hash=nil)
        @smarty_key = smarty_key
        @data_set = data_set
        @data_sub_set = data_sub_set
        @freeform = freeform
        @street = street
        @city = city
        @state = state
        @zipcode = zipcode
        @etag = etag
        @custom_param_hash = {}
      end

      def add_custom_parameter(parameter, value)
        @custom_param_hash[parameter] = value
      end
    end
  end
end