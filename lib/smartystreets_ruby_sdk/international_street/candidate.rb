require_relative 'components'
require_relative 'metadata'
require_relative 'analysis'
require_relative 'rootlevel'

module SmartyStreets
  module InternationalStreet
    # A candidate is a possible match for an address that was submitted. A lookup can have multiple
    # candidates if the address was ambiguous.
    #
    # See "https://smartystreets.com/docs/cloud/international-street-api#root"
    class Candidate < RootLevel
      attr_reader :metadata, :components, :analysis

      def initialize(obj)
        @components = Components.new(obj.fetch('components', {}))
        @metadata = Metadata.new(obj.fetch('metadata', {}))
        @analysis = Analysis.new(obj.fetch('analysis', {}))
        super
      end
    end
  end
end
