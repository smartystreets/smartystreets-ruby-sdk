require './lib/smartystreets_ruby_sdk/us_street/candidate'
require './lib/smartystreets_ruby_sdk/us_street/components'
require './lib/smartystreets_ruby_sdk/us_street/metadata'
require './lib/smartystreets_ruby_sdk/us_street/analysis'

class TestCandidate < Minitest::Test
  def test_all_fields_filled_correctly
    obj = {
        'input_index' => 0,
        'candidate_index' => 1,
        'addressee' => '2',
        'delivery_line_1' => '3',
        'delivery_line_2' => '4',
        'last_line' => '5',
        'delivery_point_barcode' => '6',
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
            'dst' => '41'
        },
        'analysis' => {
            'dpv_match_code' => '42',
            'dpv_footnotes' => '43',
            'dpv_cmra' => '44',
            'dpv_vacant' => '45',
            'active' => '46',
            'ews_match' => '47',
            'footnotes' => '48',
            'lacslink_code' => '49',
            'lacslink_indicator' => '50',
            'suitelink_match' => '51'
        }
    }

    candidate = USStreet::Candidate.new(obj)

    assert_equal(0, candidate.input_index)
    assert_equal(1, candidate.candidate_index)
    assert_equal('2', candidate.addressee)
    assert_equal('3', candidate.delivery_line_1)
    assert_equal('4', candidate.delivery_line_2)
    assert_equal('5', candidate.last_line)
    assert_equal('6', candidate.delivery_point_barcode)

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

    assert_equal('42', candidate.analysis.dpv_match_code)
    assert_equal('43', candidate.analysis.dpv_footnotes)
    assert_equal('44', candidate.analysis.cmra)
    assert_equal('45', candidate.analysis.vacant)
    assert_equal('46', candidate.analysis.active)
    assert_equal('47', candidate.analysis.is_ews_match)
    assert_equal('48', candidate.analysis.footnotes)
    assert_equal('49', candidate.analysis.lacs_link_code)
    assert_equal('50', candidate.analysis.lacs_link_indicator)
    assert_equal('51', candidate.analysis.is_suite_link_match)
  end
end