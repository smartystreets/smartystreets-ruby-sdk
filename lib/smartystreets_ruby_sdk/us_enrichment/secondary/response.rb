require_relative 'root_address_entry'
require_relative 'aliases_entry'
require_relative 'secondaries_entry'

module SmartyStreets
  module USEnrichment
    module Secondary
      class Response
        attr_reader :smarty_key, :matched_address, :root_address, :aliases, :secondaries, :etag

        def initialize(obj, etag=nil)
          @smarty_key = obj['smarty_key']
          @matched_address = obj['matched_address']
          @root_address = Secondary::RootAddressEntry.new(obj['root_address'])
          if !obj['aliases'].nil?
            @aliases = createAliasesArray(obj['aliases'])
          end
          @secondaries = createSecondariesArray(obj['secondaries'])
          @etag=etag
        end

        def createAliasesArray(obj)
          aliasesArray = []
          for item in obj do
            aliasesArray << Secondary::AliasesEntry.new(item)
          end
          return aliasesArray
        end

        def createSecondariesArray(obj)
          secondariesArray = []
          for item in obj do
            secondariesArray << Secondary::SecondariesEntry.new(item)
          end
          return secondariesArray
        end
      end
    end
  end
end