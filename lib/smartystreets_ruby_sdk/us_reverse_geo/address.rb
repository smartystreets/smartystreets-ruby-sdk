module SmartyStreets
  module USReverseGeo
    # See "https://smartystreets.com/docs/cloud/us-reverse-geo-api#address"
    class Address
      attr_reader :street, :city, :state_abbreviation, :zipcode, :source, :smartykey

      def initialize(obj)
        @street = obj['street']
        @city = obj['city']
        @state_abbreviation = obj['state_abbreviation']
        @zipcode = obj['zipcode']
        @source = obj['source']
        @smartykey = obj['smarty_key']
      end
    end
  end
end
