require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/batch'
require './lib/smartystreets_ruby_sdk/us_street/lookup'

class TestBatch < Minitest::Test
  Lookup = USStreet::Lookup
  def setup
    @batch = Batch.new
  end

  def test_gets_lookup_by_input_id
    lookup = Lookup.new
    lookup.input_id = 'has input id'

    @batch.add(lookup)

    assert_equal lookup, @batch.get_by_input_id('has input id')
  end

  def test_gets_lookup_by_index
    lookup = Lookup.new

    @batch.add(lookup)

    assert_equal(lookup, @batch.get_by_index(0))
  end

  def test_returns_correct_size
    @batch.add(Lookup.new)
    @batch.add(Lookup.new)
    @batch.add(Lookup.new)

    assert_equal(3, @batch.size)
  end

  def test_clear_method_clears_both_lookup_collections
    lookup = Lookup.new
    lookup.input_id = 'test'
    @batch.add(lookup)

    @batch.clear

    assert_equal(0, @batch.all_lookups.length)
    assert_equal(0, @batch.named_lookups.length)
  end

  def test_adding_a_lookup_when_batch_is_full_returns_false
    lookup = Lookup.new

    success = nil

    (1..Batch::MAX_BATCH_SIZE).each {
        success = @batch.add(lookup)
    }

    assert(success, "Size is #{@batch.size}")
    success = @batch.add(lookup)

    assert(!success, "Size is #{@batch.size}")

  end

end