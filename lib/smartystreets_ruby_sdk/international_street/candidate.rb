require_relative 'components'
require_relative 'metadata'
require_relative 'analysis'

module SmartyStreets
  module InternationalStreet
    # A candidate is a possible match for an address that was submitted. A lookup can have multiple
    # candidates if the address was ambiguous.
    #
    # See "https://smartystreets.com/docs/cloud/international-street-api#root"
    class Candidate
      attr_reader :metadata, :address3, :address11, :address2, :address12, :address1, :address10,
                  :address9, :address8, :address7, :organization, :address6, :address5, :address4, :components, :analysis

      def initialize(obj)
        @organization = obj.fetch('organization', nil)
        @address1 = obj.fetch('address1', nil)
        @address2 = obj.fetch('address2', nil)
        @address3 = obj.fetch('address3', nil)
        @address4 = obj.fetch('address4', nil)
        @address5 = obj.fetch('address5', nil)
        @address6 = obj.fetch('address6', nil)
        @address7 = obj.fetch('address7', nil)
        @address8 = obj.fetch('address8', nil)
        @address9 = obj.fetch('address9', nil)
        @address10 = obj.fetch('address10', nil)
        @address11 = obj.fetch('address11', nil)
        @address12 = obj.fetch('address12', nil)
        @components = Components.new(obj.fetch('components', {}))
        @metadata = Metadata.new(obj.fetch('metadata', {}))
        @analysis = Analysis.new(obj.fetch('analysis', {}))
      end
    end
  end
end
