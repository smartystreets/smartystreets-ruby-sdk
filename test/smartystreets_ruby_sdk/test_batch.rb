# frozen_string_literal: true

require_relative '../test_helper'
require './lib/smartystreets_ruby_sdk/batch'
require './lib/smartystreets_ruby_sdk/us_street/lookup'

class TestBatch < Minitest::Test
  Lookup = SmartyStreets::USStreet::Lookup
  Batch = SmartyStreets::Batch

  def setup
    @batch = SmartyStreets::Batch.new
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

    (1..Batch::MAX_BATCH_SIZE).each do
      success = @batch.add(lookup)
    end

    assert(success, "Size is #{@batch.size}")
    success = @batch.add(lookup)

    assert(!success, "Size is #{@batch.size}")
  end

  def test_add_nil_lookup
    assert_raises(ArgumentError) { @batch.add(nil) }
  end

  def test_get_by_nonexistent_input_id
    assert_nil @batch.get_by_input_id('does-not-exist')
  end

  def test_get_by_out_of_bounds_index
    assert_nil @batch.get_by_index(-1)
    assert_nil @batch.get_by_index(100)
  end

  def test_duplicate_input_ids
    lookup1 = Lookup.new
    lookup1.input_id = 'dup'
    lookup2 = Lookup.new
    lookup2.input_id = 'dup'
    @batch.add(lookup1)
    @batch.add(lookup2)
    # Last one should win
    assert_equal lookup2, @batch.get_by_input_id('dup')
  end

  def test_clear_on_empty_batch
    @batch.clear
    assert_equal 0, @batch.size
  end

  def test_add_exactly_max_batch_size
    Batch::MAX_BATCH_SIZE.times { @batch.add(Lookup.new) }
    assert_equal Batch::MAX_BATCH_SIZE, @batch.size
  end

  def test_input_id_edge_cases
    lookup = Lookup.new
    lookup.input_id = ''
    @batch.add(lookup)
    assert_equal lookup, @batch.get_by_input_id('')
    lookup2 = Lookup.new
    lookup2.input_id = nil
    @batch.add(lookup2)
    assert_equal lookup2, @batch.get_by_input_id(nil)
    long_id = 'x' * 1000
    lookup3 = Lookup.new
    lookup3.input_id = long_id
    @batch.add(lookup3)
    assert_equal lookup3, @batch.get_by_input_id(long_id)
  end

  def test_mutation_after_add
    lookup = Lookup.new
    lookup.input_id = 'mutate'
    @batch.add(lookup)
    lookup.input_id = 'changed'
    # Should not be found under old id
    assert_nil @batch.get_by_input_id('mutate')
    # Should not be found under new id unless re-added
    assert_nil @batch.get_by_input_id('changed')
  end
end
