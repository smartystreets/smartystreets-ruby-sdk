module SmartyStreets
  module InternationalStreet
    class RootLevel
      attr_reader :input_id, :organization, :address1, :address2, :address3, :address4, :address5, :address6, :address7,
                  :address8

      def initialize(obj)
        @input_id = obj.fetch('input_id', nil)
        @organization = obj.fetch('organization', nil)
        @address1 = obj.fetch('address1', nil)
        @address2 = obj.fetch('address2', nil)
        @address3 = obj.fetch('address3', nil)
        @address4 = obj.fetch('address4', nil)
        @address5 = obj.fetch('address5', nil)
        @address6 = obj.fetch('address6', nil)
        @address7 = obj.fetch('address7', nil)
        @address8 = obj.fetch('address8', nil)
      end
    end
  end
end