require_relative '../../test_helper'
require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/us_reverse_geo'
require './lib/smartystreets_ruby_sdk/native_serializer'
require_relative '../../mocks/mock_sender'
require_relative '../../mocks/fake_deserializer'

class TestUSReverseGeoResponse < Minitest::Test
  def test_all_fields_filled_correctly
    obj = {
      'results' => [
        {
          'coordinate' => {
            'latitude' => 1.1,
            'longitude' => 2.2,
            'accuracy' => '3',
            'license' => 4
          },
          'distance' => 5.5,
          'address' => {
            'street' => '6',
            'city' => '7',
            'state_abbreviation' => '8',
            'zipcode' => '9'
          }
        }
      ]
    }

    response = SmartyStreets::USReverseGeo::Response.new(obj)
    result = response.results[0]

    coordinate = result.coordinate
    assert_equal(1.1, coordinate.latitude)
    assert_equal(2.2, coordinate.longitude)
    assert_equal('3', coordinate.accuracy)
    assert_equal(4, coordinate.license)

    assert_equal(5.5, result.distance)

    address = result.address
    assert_equal('6', address.street)
    assert_equal('7', address.city)
    assert_equal('8', address.state_abbreviation)
    assert_equal('9', address.zipcode)
  end
end
