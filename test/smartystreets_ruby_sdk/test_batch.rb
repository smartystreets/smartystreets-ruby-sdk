require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/batch'
require './lib/smartystreets_ruby_sdk/us_street/lookup'

class TestBatch < Minitest::Test
  def setup
    @batch = Batch.new
  end

  def test_gets_lookup_by_input_id
    lookup = Lookup.new
    lookup.input_id = 'has input id'

    @batch.add(lookup)

    assert_equal lookup, @batch.get_by_input_id('has input id')
  end
end