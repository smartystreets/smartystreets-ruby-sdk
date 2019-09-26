require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_zipcode/result'

class TestResult < Minitest::Test
  def test_all_fields_filled_correctly_when_valid
    obj = {
      'input_id' => "1234",
      'input_index' => 0,
      'city_states' => [{
          'city' => '1',
          'state_abbreviation' => '2',
          'state' => '3',
          'mailable_city' => '4'
                        }],
      'zipcodes' => [{
          'zipcode' => '5',
          'zipcode_type' => '6',
          'default_city' => '7',
          'county_fips' => '8',
          'county_name' => '9',
          'latitude' => 10,
          'longitude' => 11,
          'precision' => '12',
          'alternate_counties' => [{
              'county_fips' => '13',
              'county_name' => '14',
              'state_abbreviation' => '15',
              'state' => '16'
                                   }],
          'state_abbreviation' => '17',
          'state' => '18'
                     }]
    }

    result = SmartyStreets::USZipcode::Result.new(obj)

    assert_equal(0, result.input_index)
    assert_nil(result.status)
    assert_nil(result.reason)

    assert_equal('1234', result.input_id)
    assert_equal('1', result.cities[0].city)
    assert_equal('2', result.cities[0].state_abbreviation)
    assert_equal('3', result.cities[0].state)
    assert_equal('4', result.cities[0].mailable_city)

    assert_equal('5', result.zipcodes[0].zipcode)
    assert_equal('6', result.zipcodes[0].zipcode_type)
    assert_equal('7', result.zipcodes[0].default_city)
    assert_equal('8', result.zipcodes[0].county_fips)
    assert_equal('9', result.zipcodes[0].county_name)
    assert_equal(10, result.zipcodes[0].latitude)
    assert_equal(11, result.zipcodes[0].longitude)
    assert_equal('12', result.zipcodes[0].precision)
    assert_equal('13', result.zipcodes[0].alternate_counties[0].county_fips)
    assert_equal('14', result.zipcodes[0].alternate_counties[0].county_name)
    assert_equal('15', result.zipcodes[0].alternate_counties[0].state_abbreviation)
    assert_equal('16', result.zipcodes[0].alternate_counties[0].state)
    assert_equal('17', result.zipcodes[0].state_abbreviation)
    assert_equal('18', result.zipcodes[0].state)

    assert(result.valid?)
  end

  def test_fields_are_filled_correctly_when_invalid
    obj = {
        'status' => 'testing_status',
        'reason' => 'We are testing.'
    }

    result = SmartyStreets::USZipcode::Result.new(obj)

    assert_equal('testing_status', result.status)
    assert_equal('We are testing.', result.reason)

    assert(!result.valid?)
  end
end
