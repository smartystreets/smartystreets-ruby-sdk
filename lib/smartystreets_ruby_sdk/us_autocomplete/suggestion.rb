module SmartyStreets
  module USAutocomplete
    # See "https://www.smarty.com/docs/apis/us-autocomplete-v2/reference#http-response-status"
    class Suggestion

      attr_reader :smarty_key, :entry_id, :street_line, :secondary, :city, :state, :zipcode, :entries, :source

      def initialize(obj)
        @smarty_key = obj.fetch('smarty_key', nil)
        @entry_id = obj.fetch('entry_id', nil)
        @street_line = obj.fetch('street_line', nil)
        @secondary = obj.fetch('secondary', nil)
        @city = obj.fetch('city', nil)
        @state = obj.fetch('state', nil)
        @zipcode = obj.fetch('zipcode', nil)
        @entries = obj.fetch('entries', 0)
        @source = obj.fetch('source', nil)
      end
    end
  end
end
