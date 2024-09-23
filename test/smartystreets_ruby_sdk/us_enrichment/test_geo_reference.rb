require 'minitest/autorun'
require '../../../lib/smartystreets_ruby_sdk/us_enrichment/geo_reference/response'

class TestGeoReferenceResponse < Minitest::Test
  def test_all_fields_filled_correctly

    census_block_obj = {
      'accuracy' => 'accuracy',
      'geoid' => 'geoid'
    }
    
    census_county_division_obj = {
      'accuracy' => 'accuracy',
      'code' => 'code',
      'name' => 'name'
    }

    census_tract_obj = {
      'code' => 'code'
    }

    core_based_stat_area_obj = {
      'code' => 'code',
      'name' => 'name'
    }

    place_obj = {
      'accuracy' => 'accuracy',
      'code' => 'code',
      'name' => 'name',
      'type' => 'type'
    }
    
    attributes_obj = {
        'census_block' => census_block_obj,
        'census_county_division' => census_county_division_obj,
        'census_tract' => census_tract_obj,
        'core_based_stat_area' => core_based_stat_area_obj,
        'place' => place_obj,
    }

    obj = {
        'smarty_key' => 'xxx',
        'data_set' => 'geo-reference',
        'data_sub_set' => nil,
        'attributes' => attributes_obj
    }

    response = SmartyStreets::USEnrichment::GeoReference::Response.new(obj)

    assert_equal('xxx', response.smarty_key)
    assert_equal('geo-reference', response.data_set)

    attributes = response.attributes

    census_block = attributes.census_block

    assert_equal('accuracy', census_block.accuracy)
    assert_equal('geoid', census_block.geoid)

    census_county_division = attributes.census_county_division

    assert_equal('accuracy', census_county_division.accuracy)
    assert_equal('code', census_county_division.code)
    assert_equal('name', census_county_division.name)

    census_tract = attributes.census_tract

    assert_equal('code', census_tract.code)

    core_based_stat_area = attributes.core_based_stat_area

    assert_equal('code', core_based_stat_area.code)
    assert_equal('name', core_based_stat_area.name)

    place = attributes.place

    assert_equal('accuracy', place.accuracy)
    assert_equal('code', place.code)
    assert_equal('name', place.name)
    assert_equal('type', place.type)
  end
end