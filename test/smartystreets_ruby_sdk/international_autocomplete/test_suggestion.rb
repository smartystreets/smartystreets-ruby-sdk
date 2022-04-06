require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/international_autocomplete/suggestion'

class InternationalAutocompleteSuggestionTest < Minitest::Test
  def test_all_fields_get_filled_in_correctly
    response_dictionary = { 'street' => '1', 'locality' => '2', 'administrative_area' => '3', 'postal_code' => '4', 'country_iso3' => '5'}

    suggestion = SmartyStreets::InternationalAutocomplete::Suggestion.new(response_dictionary)

    assert(suggestion)
    assert_equal('1', suggestion.street)
    assert_equal('2', suggestion.locality)
    assert_equal('3', suggestion.administrative_area)
    assert_equal('4', suggestion.postal_code)
    assert_equal('5', suggestion.country_iso3)
  end
end
