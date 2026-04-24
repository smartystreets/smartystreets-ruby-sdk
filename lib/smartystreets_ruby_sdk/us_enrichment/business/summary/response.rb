require_relative 'business_entry'

module SmartyStreets
  module USEnrichment
    module Business
      module Summary
        class Response
          attr_reader :smarty_key, :data_set_name, :businesses

          def initialize(obj)
            @smarty_key = obj['smarty_key']
            @data_set_name = obj['data_set_name']
            @businesses = build_businesses(obj['businesses'])
          end

          def build_businesses(entries)
            return [] if entries.nil?
            entries.map { |entry| Business::Summary::BusinessEntry.new(entry) }
          end
        end
      end
    end
  end
end
