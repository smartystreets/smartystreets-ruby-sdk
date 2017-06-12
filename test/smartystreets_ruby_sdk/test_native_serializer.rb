require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/native_serializer'
require_relative '../../lib/smartystreets_ruby_sdk/us_street/lookup'

class TestNativeSerializer < Minitest::Test
  def test_serialize
    serializer = SmartyStreets::NativeSerializer.new

    result = serializer.serialize([SmartyStreets::USStreet::Lookup.new('123 fake street')])

    assert(result.include?('"street":"123 fake street"'), "Result is: #{result}")
  end

  def test_deserialize
    expected_json_output = "[{\"input_index\":0,\"city_states\":[{\"city\":\"Washington\",\"state_abbreviation\":\
      \"DC\",\"state\":\"District of Columbia\",\"mailable_city\":true}],\"zipcodes\":[{\"zipcode\":\"20500\",\
      \"zipcode_type\":\"S\",\"default_city\":\"Washington\",\"county_fips\":\"11001\",\
      \"county_name\":\"District of Columbia\",\"latitude\":38.89769,\"longitude\":-77.03869}]},{\"input_index\":1,\
      \"input_id\":\"test id\",\"city_states\":[{\"city\":\"Provo\",\"state_abbreviation\":\"UT\",\"state\":\"Utah\",\
      \"default_city\":true,\"mailable_city\":true}],\"zipcodes\":[{\"zipcode\":\"84606\",\"zipcode_type\":\"S\",\
      \"county_fips\":\"11501\",\"county_name\":\"Utah\",\"latitude\":38.89769,\"longitude\":-77.03869}]},\
            {\"input_index\":2,\"status\":\"invalid_zipcode\",\"reason\":\"Invalid ZIP Code.\"}]"
    serializer = SmartyStreets::NativeSerializer.new

    results = serializer.deserialize(expected_json_output)

    assert(results, 'Not supposed to be nil')
    assert_equal(0, results[0]['input_index'])
    assert(results[0]['city_states'], 'Not supposed to be nil')
    assert_equal('Washington', results[0]['city_states'][0]['city'])
    assert_equal('20500', results[0]['zipcodes'][0]['zipcode'])

    assert(results[1], 'Not supposed to be nil')
    assert(!results[1].include?('status'), results[1])
    assert_equal('Utah', results[1]['city_states'][0]['state'])
    assert_equal(38.89769, results[1]['zipcodes'][0]['latitude'], 0.00001)

    assert(results[2], 'Not supposed to be nil')
    assert(!results[2].include?('city_states'), results[2])
    assert_equal('invalid_zipcode', results[2]['status'])
    assert_equal('Invalid ZIP Code.', results[2]['reason'])
  end
end