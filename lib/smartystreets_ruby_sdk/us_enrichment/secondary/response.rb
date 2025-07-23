# frozen_string_literal: true

require_relative 'root_address_entry'
require_relative 'aliases_entry'
require_relative 'secondaries_entry'

module SmartyStreets
  module USEnrichment
    module Secondary
      class Response
        attr_reader :smarty_key, :root_address, :aliases, :secondaries, :etag

        def initialize(obj, etag = nil)
          @smarty_key = obj['smarty_key']
          @root_address = Secondary::RootAddressEntry.new(obj['root_address'])
          @aliases = createAliasesArray(obj['aliases']) unless obj['aliases'].nil?
          @secondaries = createSecondariesArray(obj['secondaries'])
          @etag = etag
        end

        def createAliasesArray(obj)
          obj.map do |item|
            Secondary::AliasesEntry.new(item)
          end
        end

        def createSecondariesArray(obj)
          obj.map do |item|
            Secondary::SecondariesEntry.new(item)
          end
        end
      end
    end
  end
end
