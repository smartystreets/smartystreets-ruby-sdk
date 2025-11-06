require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/international_postal_code/lookup'

class TestInternationalPostalCodeLookup < Minitest::Test
  Lookup = SmartyStreets::InternationalPostalCode::Lookup

  def test_initial_state
    lookup = Lookup.new
    assert_nil lookup.input_id
    assert_nil lookup.country
    assert_nil lookup.locality
    assert_nil lookup.administrative_area
    assert_nil lookup.postal_code
    assert_equal [], lookup.results
  end
end


