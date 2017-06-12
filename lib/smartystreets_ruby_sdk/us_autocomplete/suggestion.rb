module SmartyStreets
  module USAutocomplete
    # See "https://smartystreets.com/docs/cloud/us-autocomplete-api#http-response"
    class Suggestion

      attr_reader :text, :street_line, :state, :city

      def initialize(obj)
        @text = obj.fetch('text', nil)
        @street_line = obj.fetch('street_line', nil)
        @city = obj.fetch('city', nil)
        @state = obj.fetch('state', nil)
      end
    end
  end
end
