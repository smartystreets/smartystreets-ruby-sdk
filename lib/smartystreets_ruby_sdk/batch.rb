module SmartyStreets
  # The Batch class is used to send up to 100 lookups at once
  class Batch
    include Enumerable
    MAX_BATCH_SIZE = 100

    attr_reader :all_lookups, :named_lookups

    def initialize
      @named_lookups = {}
      @all_lookups = []
    end

    def add(lookup)
      return false if full?

      @all_lookups.push(lookup)

      return true if lookup.input_id.nil?

      @named_lookups[lookup.input_id] = lookup
      true
    end

    def clear
      @named_lookups.clear
      @all_lookups.clear
    end

    def full?
      size >= MAX_BATCH_SIZE
    end

    def empty?
      size.zero?
    end

    def size
      @all_lookups.length
    end

    def get_by_input_id(input_id)
      @named_lookups[input_id]
    end

    def get_by_index(index)
      @all_lookups[index]
    end

    def each(&block)
      @all_lookups.each(&block)
    end

    def [](index)
      @all_lookups[index]
    end
  end
end
