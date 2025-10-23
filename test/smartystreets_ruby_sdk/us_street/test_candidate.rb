require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_street/candidate'
require './lib/smartystreets_ruby_sdk/us_street/components'
require './lib/smartystreets_ruby_sdk/us_street/metadata'
require './lib/smartystreets_ruby_sdk/us_street/analysis'
require './lib/smartystreets_ruby_sdk/us_street/component_analysis'

class TestCandidate < Minitest::Test
  def test_all_fields_filled_correctly

    obj = {
      'input_id' => "1234",
      'input_index' => 0,
      'candidate_index' => 1,
      'addressee' => '2',
      'delivery_line_1' => '3',
      'delivery_line_2' => '4',
      'last_line' => '5',
      'delivery_point_barcode' => '6',
      'smarty_key' => '112',
      'components' => {
        'urbanization' => '7',
        'primary_number' => '8',
        'street_name' => '9',
        'street_predirection' => '10',
        'street_postdirection' => '11',
        'street_suffix' => '12',
        'secondary_number' => '13',
        'secondary_designator' => '14',
        'extra_secondary_number' => '15',
        'extra_secondary_designator' => '16',
        'pmb_designator' => '17',
        'pmb_number' => '18',
        'city_name' => '19',
        'default_city_name' => '20',
        'state_abbreviation' => '21',
        'zipcode' => '22',
        'plus4_code' => '23',
        'delivery_point' => '24',
        'delivery_point_check_digit' => '25'
      },
      'metadata' => {
        'record_type' => '26',
        'zip_type' => '27',
        'county_fips' => '28',
        'county_name' => '29',
        'carrier_route' => '30',
        'congressional_district' => '31',
        'building_default_indicator' => '32',
        'rdi' => '33',
        'elot_sequence' => '34',
        'elot_sort' => '35',
        'latitude' => 36.0,
        'longitude' => 37.0,
        'precision' => '38',
        'time_zone' => '39',
        'utc_offset' => 40.0,
        'dst' => '41',
        'ews_match' => '42'
      },
      'analysis' => {
        'dpv_match_code' => '43',
        'dpv_footnotes' => '44',
        'dpv_cmra' => '45',
        'dpv_vacant' => '46',
        'active' => '47',
        'ews_match' => '48',
        'footnotes' => '49',
        'lacslink_code' => '50',
        'lacslink_indicator' => '51',
        'suitelink_match' => '52',
        'dpv_no_stat' => '53',
        'enhanced_match' => '54',
        'components' => {
          'primary_number' => { 'status' => 'confirmed', 'change' => ['added'] },
          'street_predirection' => { 'status' => 'unconfirmed', 'change' => ['spelling'] },
          'street_name' => { 'status' => 'confirmed', 'change' => ['replaced'] },
          'street_postdirection' => { 'status' => 'confirmed', 'change' => [] },
          'street_suffix' => { 'status' => 'confirmed', 'change' => ['spelling'] },
          'secondary_number' => { 'status' => 'unconfirmed', 'change' => ['added'] },
          'secondary_designator' => { 'status' => 'confirmed', 'change' => ['replaced'] },
          'extra_secondary_number' => { 'status' => 'confirmed', 'change' => ['spelling'] },
          'extra_secondary_designator' => { 'status' => 'confirmed', 'change' => ['added'] },
          'city_name' => { 'status' => 'unconfirmed', 'change' => ['replaced'] },
          'state_abbreviation' => { 'status' => 'confirmed', 'change' => [] },
          'zipcode' => { 'status' => 'confirmed', 'change' => ['spelling'] },
          'plus4_code' => { 'status' => 'confirmed', 'change' => ['added'] },
          'urbanization' => { 'status' => 'unconfirmed', 'change' => [] }
        }
      }
    }

    candidate = SmartyStreets::USStreet::Candidate.new(obj)

    assert_equal("1234", candidate.input_id)
    assert_equal(0, candidate.input_index)
    assert_equal(1, candidate.candidate_index)
    assert_equal('2', candidate.addressee)
    assert_equal('3', candidate.delivery_line_1)
    assert_equal('4', candidate.delivery_line_2)
    assert_equal('5', candidate.last_line)
    assert_equal('6', candidate.delivery_point_barcode)
    assert_equal('112', candidate.smarty_key)

    assert_equal('7', candidate.components.urbanization)
    assert_equal('8', candidate.components.primary_number)
    assert_equal('9', candidate.components.street_name)
    assert_equal('10', candidate.components.street_predirection)
    assert_equal('11', candidate.components.street_postdirection)
    assert_equal('12', candidate.components.street_suffix)
    assert_equal('13', candidate.components.secondary_number)
    assert_equal('14', candidate.components.secondary_designator)
    assert_equal('15', candidate.components.extra_secondary_number)
    assert_equal('16', candidate.components.extra_secondary_designator)
    assert_equal('17', candidate.components.pmb_designator)
    assert_equal('18', candidate.components.pmb_number)
    assert_equal('19', candidate.components.city_name)
    assert_equal('20', candidate.components.default_city_name)
    assert_equal('21', candidate.components.state_abbreviation)
    assert_equal('22', candidate.components.zipcode)
    assert_equal('23', candidate.components.plus4_code)
    assert_equal('24', candidate.components.delivery_point)
    assert_equal('25', candidate.components.delivery_point_check_digit)

    assert_equal('26', candidate.metadata.record_type)
    assert_equal('27', candidate.metadata.zip_type)
    assert_equal('28', candidate.metadata.county_fips)
    assert_equal('29', candidate.metadata.county_name)
    assert_equal('30', candidate.metadata.carrier_route)
    assert_equal('31', candidate.metadata.congressional_district)
    assert_equal('32', candidate.metadata.building_default_indicator)
    assert_equal('33', candidate.metadata.rdi)
    assert_equal('34', candidate.metadata.elot_sequence)
    assert_equal('35', candidate.metadata.elot_sort)
    assert_equal(36.0, candidate.metadata.latitude)
    assert_equal(37.0, candidate.metadata.longitude)
    assert_equal('38', candidate.metadata.precision)
    assert_equal('39', candidate.metadata.time_zone)
    assert_equal(40.0, candidate.metadata.utc_offset)
    assert_equal('41', candidate.metadata.obeys_dst)
    assert_equal('42', candidate.metadata.is_an_ews_match)

    assert_equal('43', candidate.analysis.dpv_match_code)
    assert_equal('44', candidate.analysis.dpv_footnotes)
    assert_equal('45', candidate.analysis.cmra)
    assert_equal('46', candidate.analysis.vacant)
    assert_equal('47', candidate.analysis.active)
    assert_equal('49', candidate.analysis.footnotes)
    assert_equal('50', candidate.analysis.lacs_link_code)
    assert_equal('51', candidate.analysis.lacs_link_indicator)
    assert_equal('52', candidate.analysis.is_suite_link_match)
    assert_equal('53', candidate.analysis.no_stat)
    assert_equal('54', candidate.analysis.enhanced_match)

    component_analysis = candidate.analysis.components

    assert_equal('confirmed', component_analysis.primary_number.status)
    assert_equal(['added'], component_analysis.primary_number.change)

    assert_equal('unconfirmed', component_analysis.street_predirection.status)
    assert_equal(['spelling'], component_analysis.street_predirection.change)

    assert_equal('confirmed', component_analysis.street_name.status)
    assert_equal(['replaced'], component_analysis.street_name.change)

    assert_equal('confirmed', component_analysis.street_postdirection.status)
    assert_equal([], component_analysis.street_postdirection.change)

    assert_equal('confirmed', component_analysis.street_suffix.status)
    assert_equal(['spelling'], component_analysis.street_suffix.change)

    assert_equal('unconfirmed', component_analysis.secondary_number.status)
    assert_equal(['added'], component_analysis.secondary_number.change)

    assert_equal('confirmed', component_analysis.secondary_designator.status)
    assert_equal(['replaced'], component_analysis.secondary_designator.change)

    assert_equal('confirmed', component_analysis.extra_secondary_number.status)
    assert_equal(['spelling'], component_analysis.extra_secondary_number.change)

    assert_equal('confirmed', component_analysis.extra_secondary_designator.status)
    assert_equal(['added'], component_analysis.extra_secondary_designator.change)

    assert_equal('unconfirmed', component_analysis.city_name.status)
    assert_equal(['replaced'], component_analysis.city_name.change)

    assert_equal('confirmed', component_analysis.state_abbreviation.status)
    assert_equal([], component_analysis.state_abbreviation.change)

    assert_equal('confirmed', component_analysis.zipcode.status)
    assert_equal(['spelling'], component_analysis.zipcode.change)

    assert_equal('confirmed', component_analysis.plus4_code.status)
    assert_equal(['added'], component_analysis.plus4_code.change)

    assert_equal('unconfirmed', component_analysis.urbanization.status)
    assert_equal([], component_analysis.urbanization.change)
  end
end