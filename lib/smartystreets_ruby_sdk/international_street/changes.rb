require_relative 'rootlevel'
require_relative 'components'

module SmartyStreets
  module InternationalStreet
    class Changes < RootLevel
      attr_reader :components

      def initialize(obj)
        @components = Components.new(obj.fetch('components', {}))
        super(obj)
      end
    end
  end
end