class Batch
  MAX_BATCH_SIZE = 100

  attr_reader :all_lookups, :named_lookups

  def initialize
    @named_lookups = {}
    @all_lookups = []
    @current_index = 0
  end

  def add(lookup)
    return false if is_full

    @all_lookups.push(lookup)

    return true if lookup.input_id == nil

    @named_lookups[lookup.input_id] = lookup
    true
  end

  def clear
    @named_lookups.clear
    @all_lookups.clear
  end

  def is_full
    size >= MAX_BATCH_SIZE
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

end