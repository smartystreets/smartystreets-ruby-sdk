require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_autocomplete/suggestion'

class SuggestionTest < Minitest::Test
  def test_all_fields_get_filled_in_correctly
    response_dictionary = { 'text' => '1', 'street_line' => '2', 'city' => '3', 'state' => '4'}

    suggestion = USAutocomplete::Suggestion.new(response_dictionary)

    assert(suggestion)
    assert_equal('1', suggestion.text)
    assert_equal('2', suggestion.street_line)
    assert_equal('3', suggestion.city)
    assert_equal('4', suggestion.state)
  end
end
