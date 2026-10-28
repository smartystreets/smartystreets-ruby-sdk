require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/max_results'
require_relative '../../lib/smartystreets_ruby_sdk/exceptions'

class TestMaxResults < Minitest::Test
  MaxResults = SmartyStreets::MaxResults

  def test_whole_numbers_are_converted_and_sent
    assert_equal('5', MaxResults.normalize(5))
    assert_equal('5', MaxResults.normalize('5'))
    assert_equal('7', MaxResults.normalize(' 7 '))
    assert_equal('5', MaxResults.normalize(5.0))
    assert_equal('3', MaxResults.normalize('+3'))
    assert_equal('1000', MaxResults.normalize(1000))
  end

  def test_unset_and_values_not_above_zero_are_not_sent
    [nil, '', '  ', 0, '0', -1, '-2'].each do |value|
      assert_nil(MaxResults.normalize(value), "expected #{value.inspect} to not be sent")
    end
  end

  def test_values_that_are_not_whole_numbers_raise
    ['abc', '1.5', 1.5, true].each do |value|
      assert_raises(SmartyStreets::UnprocessableEntityError, "expected #{value.inspect} to raise") do
        MaxResults.normalize(value)
      end
    end
  end
end
