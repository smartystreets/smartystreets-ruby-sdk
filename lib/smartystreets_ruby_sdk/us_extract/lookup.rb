require_relative '../json_able'

module SmartyStreets
  module USExtract
    # In addition to holding all of the input data for this lookup, this class also will contain the result
    # of the lookup after it comes back from the API.
    #
    # See "https://smartystreets.com/docs/cloud/us-extract-api#http-request-input-fields"
    class Lookup < JSONAble
      attr_accessor :text, :result, :aggressive, :addresses_per_line, :html, :addresses_have_line_breaks, :match, :custom_param_hash

      def initialize(text=nil, html=nil, aggressive=nil, addresses_have_line_breaks=nil, addresses_per_line=nil, match=nil, custom_param_hash=nil)
        @text = text
        @html = html
        @aggressive = aggressive
        @addresses_have_line_breaks = addresses_have_line_breaks
        @addresses_per_line = addresses_per_line
        @match = match
        @result = nil
        @custom_param_hash = {}
      end

      def add_custom_parameter(parameter, value)
        @custom_param_hash[parameter] = value
      end
    end
  end
end