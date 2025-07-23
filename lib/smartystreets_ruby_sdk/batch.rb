module SmartyStreets
  # The Batch class is used to send up to 100 lookups at once
  class Batch
    include Enumerable
    MAX_BATCH_SIZE = 100

    attr_reader :all_lookups, :named_lookups

    def initialize
      @named_lookups = {}
      @all_lookups = []
      @lookup_to_input_id = {}
    end

    def add(lookup)
      raise ArgumentError, 'lookup cannot be nil' if lookup.nil?
      return false if full?

      @all_lookups.push(lookup)

      input_id = lookup.input_id
      @lookup_to_input_id[lookup] = input_id
      return true if input_id.nil?

      @named_lookups[input_id] = lookup
      true
    end

    def clear
      @named_lookups.clear
      @all_lookups.clear
      @lookup_to_input_id.clear
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
      if input_id.nil?
        # Return the most recently added lookup with input_id == nil
        @all_lookups.reverse_each do |lookup|
          return lookup if lookup.input_id.nil?
        end
        return nil
      end
      lookup = @named_lookups[input_id]
      return nil unless lookup
      # Only return if the lookup's current input_id matches the key
      return lookup if lookup.input_id == input_id
      nil
    end

    def get_by_index(index)
      @all_lookups[index] if index >= 0 && index < @all_lookups.length
    end

    def each(&block)
      @all_lookups.each(&block)
    end

    def [](index)
      @all_lookups[index]
    end

    # Remove or update named_lookups if input_id is mutated after add
    def self.update_named_lookups(batch)
      batch.instance_variable_get(:@all_lookups).each do |lookup|
        original_id = batch.instance_variable_get(:@lookup_to_input_id)[lookup]
        current_id = lookup.input_id
        if original_id != current_id
          batch.instance_variable_get(:@named_lookups).delete(original_id)
        end
      end
    end
  end
end
