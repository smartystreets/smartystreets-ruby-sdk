# frozen_string_literal: true

require_relative 'components'
require_relative 'metadata'
require_relative 'analysis'

module SmartyStreets
  module USStreet
    # See "https://smartystreets.com/docs/cloud/us-street-api#metadata"
    class Candidate
      attr_reader :input_id, :input_index, :candidate_index, :addressee, :delivery_line_1, :delivery_line_2,
                  :last_line, :delivery_point_barcode, :smarty_key, :metadata, :components, :analysis

      def initialize(obj)
        @input_id = obj['input_id']
        @input_index = obj['input_index']
        @candidate_index = obj['candidate_index']
        @addressee = obj['addressee']
        @delivery_line_1 = obj['delivery_line_1']
        @delivery_line_2 = obj['delivery_line_2']
        @last_line = obj['last_line']
        @delivery_point_barcode = obj['delivery_point_barcode']
        @smarty_key = obj['smarty_key']
        @components = Components.new(obj.fetch('components', {}))
        @metadata = Metadata.new(obj.fetch('metadata', {}))
        @analysis = Analysis.new(obj.fetch('analysis', {}))
      end
    end
  end
end
