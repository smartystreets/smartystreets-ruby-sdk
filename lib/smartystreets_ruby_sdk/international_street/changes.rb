require_relative 'rootlevel'
require_relative 'components'

module SmartyStreets
  module InternationalStreet
    class Changes < RootLevel
      attr_reader :country, :components

      def initialize(obj)
        @country = obj.fetch('country', nil)
        @components = Components.new(obj.fetch('components', {}))
        super(obj)
      end
    end
  end
end