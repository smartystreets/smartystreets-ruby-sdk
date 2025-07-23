require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_autocomplete_pro/suggestion'
require_relative '../../test_helper'

class SuggestionTest < Minitest::Test
  def test_all_fields_get_filled_in_correctly
    response_dictionary = { 'street_line' => '1', 'secondary' => '2', 'city' => '3', 'state' => '4', 'zipcode' => '5',
                            'entries' => 6 }

    suggestion = SmartyStreets::USAutocompletePro::Suggestion.new(response_dictionary)

    assert(suggestion)
    assert_equal('1', suggestion.street_line)
    assert_equal('2', suggestion.secondary)
    assert_equal('3', suggestion.city)
    assert_equal('4', suggestion.state)
    assert_equal('5', suggestion.zipcode)
    assert_equal(6, suggestion.entries)
  end
end
