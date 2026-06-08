require_relative '../json_able'

module SmartyStreets
  module USEnrichment
    class LookupBase < JSONAble
      attr_accessor :request_etag, :response_etag, :include_array, :exclude_array, :features, :custom_param_hash

      def initialize
        @request_etag = nil
        @response_etag = nil
        @include_array = []
        @exclude_array = []
        @features = nil
        @custom_param_hash = {}
      end

      def add_custom_parameter(parameter, value)
        @custom_param_hash[parameter] = value
      end

      def add_include_attribute(attribute)
        @include_array << attribute unless @include_array.include?(attribute)
      end

      def add_exclude_attribute(attribute)
        @exclude_array << attribute unless @exclude_array.include?(attribute)
      end
    end

    class Lookup < LookupBase
      attr_accessor :smarty_key, :data_set, :data_sub_set, :freeform, :business_name, :street, :city, :state, :zipcode

      def initialize(smarty_key=nil, data_set=nil, data_sub_set=nil, freeform=nil, business_name=nil, street=nil, city=nil, state=nil, zipcode=nil, request_etag=nil, features=nil)
        super()
        @smarty_key = smarty_key
        @data_set = data_set
        @data_sub_set = data_sub_set
        @freeform = freeform
        @business_name = business_name
        @street = street
        @city = city
        @state = state
        @zipcode = zipcode
        @request_etag = request_etag
        @features = features
      end
    end

    class BusinessDetailLookup < LookupBase
      attr_accessor :business_id, :result

      def initialize(business_id=nil)
        super()
        @business_id = business_id
        @result = nil
      end
    end
  end
end
