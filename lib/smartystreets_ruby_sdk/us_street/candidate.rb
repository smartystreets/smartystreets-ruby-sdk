require_relative 'Components'
require_relative 'Metadata'
require_relative 'Analysis'

module USStreet
  class Candidate
    attr_reader :input_index, :candidate_index, :addressee, :delivery_line_1, :delivery_line_2, :delivery_point_barcode,
                :last_line, :metadata, :components, :analysis

    def initialize(obj)
      @input_index = obj['input_index']
      @candidate_index = obj['candidate_index']
      @addressee = obj['addressee']
      @delivery_line_1 = obj['delivery_line_1']
      @delivery_line_2 = obj['delivery_line_2']
      @last_line = obj['last_line']
      @delivery_point_barcode = obj['delivery_point_barcode']
      @components = Components.new(obj.fetch('components', {}))
      @metadata = Metadata.new(obj.fetch('metadata', {}))
      @analysis = Analysis.new(obj.fetch('analysis', {}))
    end
  end
end