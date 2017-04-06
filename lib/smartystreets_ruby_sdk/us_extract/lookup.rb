require_relative '../json_able'

module USExtract
  # In addition to holding all of the input data for this lookup, this class also will contain the result
  # of the lookup after it comes back from the API.
  #
  # See "https://smartystreets.com/docs/cloud/us-extract-api#http-request-input-fields"
  class Lookup < JSONAble
    attr_accessor :text, :result, :aggressive, :addresses_per_line, :html, :addresses_have_line_breaks

    def initialize(text=nil, html=nil, aggressive=nil, addresses_have_line_breaks=nil, addresses_per_line=nil)
      @text = text
      @html = html
      @aggressive = aggressive
      @addresses_have_line_breaks = addresses_have_line_breaks
      @addresses_per_line = addresses_per_line
      @result = nil
    end
  end
end