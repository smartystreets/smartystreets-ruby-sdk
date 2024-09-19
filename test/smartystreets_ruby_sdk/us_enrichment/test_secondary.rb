require 'minitest/autorun'
require '../../../lib/smartystreets_ruby_sdk/us_enrichment/secondary/response'

class TestSecondaryResponse < Minitest::Test
  def test_all_fields_filled_correctly

    root_address_obj = {
      'secondary_count' => 2,
      'smarty_key' => '123',
      'primary_number' => 'primary_number',
      'street_predirection' => 'street_predirection',
      'street_name' => 'street_name',
      'street_suffix' => 'street_suffix',
      'street_postdirection' => 'street_postdirection',
      'city_name' => 'city_name',
      'state_abbreviation' => 'state_abbreviation',
      'zipcode' => 'zipcode',
      'plus4_code' => 'plus4_code'
    }
    
    alias_1 = {
      'smarty_key' => '123',
      'primary_number' => 'primary_number_1',
      'street_predirection' => 'street_predirection',
      'street_name' => 'street_name',
      'street_suffix' => 'street_suffix',
      'street_postdirection' => 'street_postdirection',
      'city_name' => 'city_name',
      'state_abbreviation' => 'state_abbreviation',
      'zipcode' => 'zipcode',
      'plus4_code' => 'plus4_code'
    }

    alias_2 = {
      'smarty_key' => '123',
      'primary_number' => 'primary_number_2',
      'street_predirection' => 'street_predirection',
      'street_name' => 'street_name',
      'street_suffix' => 'street_suffix',
      'street_postdirection' => 'street_postdirection',
      'city_name' => 'city_name',
      'state_abbreviation' => 'state_abbreviation',
      'zipcode' => 'zipcode',
      'plus4_code' => 'plus4_code'
    }

    secondary_1 = {
      'smarty_key' => '234',
      'secondary_designator' => 'secondary_designator',
      'secondary_number' => 'secondary_number_1',
      'plus4_code' => 'plus4_code',
    }

    secondary_2 = {
      'smarty_key' => '345',
      'secondary_designator' => 'secondary_designator',
      'secondary_number' => 'secondary_number_2',
      'plus4_code' => 'plus4_code',
    }

    obj = {
        'smarty_key' => '123',
        'root_address' => root_address_obj,
        'aliases' => [alias_1, alias_2],
        'secondaries' => [secondary_1, secondary_2]
    }

    response = SmartyStreets::USEnrichment::Secondary::Response.new(obj)

    assert_equal('123', response.smarty_key)

    root_address = response.root_address

    assert_equal(2, root_address.secondary_count)
    assert_equal('123', root_address.smarty_key)
    assert_equal('primary_number', root_address.primary_number)
    assert_equal('street_predirection', root_address.street_predirection)
    assert_equal('street_name', root_address.street_name)
    assert_equal('street_suffix', root_address.street_suffix)
    assert_equal('street_postdirection', root_address.street_postdirection)
    assert_equal('city_name', root_address.city_name)
    assert_equal('state_abbreviation', root_address.state_abbreviation)
    assert_equal('zipcode', root_address.zipcode)
    assert_equal('plus4_code', root_address.plus4_code)

    alias1 = response.aliases[0]

    assert_equal('123', alias1.smarty_key)
    assert_equal('primary_number_1', alias1.primary_number)
    assert_equal('street_predirection', alias1.street_predirection)
    assert_equal('street_name', alias1.street_name)
    assert_equal('street_suffix', alias1.street_suffix)
    assert_equal('street_postdirection', alias1.street_postdirection)
    assert_equal('city_name', alias1.city_name)
    assert_equal('state_abbreviation', alias1.state_abbreviation)
    assert_equal('zipcode', alias1.zipcode)
    assert_equal('plus4_code', alias1.plus4_code)

    alias2 = response.aliases[1]

    assert_equal('123', alias2.smarty_key)
    assert_equal('primary_number_2', alias2.primary_number)
    assert_equal('street_predirection', alias2.street_predirection)
    assert_equal('street_name', alias2.street_name)
    assert_equal('street_suffix', alias2.street_suffix)
    assert_equal('street_postdirection', alias2.street_postdirection)
    assert_equal('city_name', alias2.city_name)
    assert_equal('state_abbreviation', alias2.state_abbreviation)
    assert_equal('zipcode', alias2.zipcode)
    assert_equal('plus4_code', alias2.plus4_code)

    secondary1 = response.secondaries[0]

    assert_equal('234', secondary1.smarty_key)
    assert_equal('secondary_designator', secondary1.secondary_designator)
    assert_equal('secondary_number_1', secondary1.secondary_number)
    assert_equal('plus4_code', secondary1.plus4_code)

    secondary2 = response.secondaries[1]

    assert_equal('345', secondary2.smarty_key)
    assert_equal('secondary_designator', secondary2.secondary_designator)
    assert_equal('secondary_number_2', secondary2.secondary_number)
    assert_equal('plus4_code', secondary2.plus4_code)
  end
end