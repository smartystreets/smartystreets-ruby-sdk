require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/international_street'
require './lib/smartystreets_ruby_sdk/native_serializer'

class TestInternationalCandidate < Minitest::Test
  def test_all_fields_filled_correctly
    response_payload = "[{\"organization\":\"1\",\"address1\":\"2\",\"address2\":\"3\","\
                "\"address3\":\"4\",\"address4\":\"5\",\"address5\":\"6\",\"address6\":\"7\",\"address7\":\"8\","\
                "\"address8\":\"9\",\"address9\":\"10\",\"address10\":\"11\",\"address11\":\"12\",\"address12\":\"13\","\
                "\"components\":{\"country_iso_3\":\"14\",\"super_administrative_area\":\"15\","\
                "\"administrative_area\":\"16\",\"sub_administrative_area\":\"17\",\"dependent_locality\":\"18\","\
                "\"dependent_locality_name\":\"19\",\"double_dependent_locality\":\"20\",\"locality\":\"21\","\
                "\"postal_code\":\"22\",\"postal_code_short\":\"23\",\"postal_code_extra\":\"24\","\
                "\"premise\":\"25\",\"premise_extra\":\"26\",\"premise_number\":\"27\",\"premise_type\":\"28\","\
                "\"thoroughfare\":\"29\",\"thoroughfare_predirection\":\"30\",\"thoroughfare_postdirection\":\"31\","\
                "\"thoroughfare_name\":\"32\",\"thoroughfare_trailing_type\":\"33\",\"thoroughfare_type\":\"34\","\
                "\"dependent_thoroughfare\":\"35\",\"dependent_thoroughfare_predirection\":\"36\","\
                "\"dependent_thoroughfare_postdirection\":\"37\",\"dependent_thoroughfare_name\":\"38\","\
                "\"dependent_thoroughfare_trailing_type\":\"39\",\"dependent_thoroughfare_type\":\"40\","\
                "\"building\":\"41\",\"building_leading_type\":\"42\",\"building_name\":\"43\","\
                "\"building_trailing_type\":\"44\",\"sub_building_type\":\"45\",\"sub_building_number\":\"46\","\
                "\"sub_building_name\":\"47\",\"sub_building\":\"48\",\"post_box\":\"49\",\"post_box_type\":\"50\","\
                "\"post_box_number\":\"51\"},\"metadata\":{\"latitude\":52.0,\"longitude\":53.0,"\
                "\"geocode_precision\":\"54\",\"max_geocode_precision\":\"55\"},"\
                "\"analysis\":{\"verification_status\":\"56\",\"address_precision\":\"57\",\"max_address_precision\":\"58\"}}]"

    serializer = SmartyStreets::NativeSerializer.new
    candidate = SmartyStreets::InternationalStreet::Candidate.new(serializer.deserialize(response_payload)[0])

    assert_equal('1', candidate.organization)
    assert_equal('2', candidate.address1)
    assert_equal('3', candidate.address2)
    assert_equal('4', candidate.address3)
    assert_equal('5', candidate.address4)
    assert_equal('6', candidate.address5)
    assert_equal('7', candidate.address6)
    assert_equal('8', candidate.address7)
    assert_equal('9', candidate.address8)
    assert_equal('10', candidate.address9)
    assert_equal('11', candidate.address10)
    assert_equal('12', candidate.address11)
    assert_equal('13', candidate.address12)

    components = candidate.components
    assert(components)
    assert_equal('14', components.country_iso_3)
    assert_equal('15', components.super_administrative_area)
    assert_equal('16', components.administrative_area)
    assert_equal('17', components.sub_administrative_area)
    assert_equal('18', components.dependent_locality)
    assert_equal('19', components.dependent_locality_name)
    assert_equal('20', components.double_dependent_locality)
    assert_equal('21', components.locality)
    assert_equal('22', components.postal_code)
    assert_equal('23', components.postal_code_short)
    assert_equal('24', components.postal_code_extra)
    assert_equal('25', components.premise)
    assert_equal('26', components.premise_extra)
    assert_equal('27', components.premise_number)
    assert_equal('28', components.premise_type)
    assert_equal('29', components.thoroughfare)
    assert_equal('30', components.thoroughfare_predirection)
    assert_equal('31', components.thoroughfare_postdirection)
    assert_equal('32', components.thoroughfare_name)
    assert_equal('33', components.thoroughfare_trailing_type)
    assert_equal('34', components.thoroughfare_type)
    assert_equal('35', components.dependent_thoroughfare)
    assert_equal('36', components.dependent_thoroughfare_predirection)
    assert_equal('37', components.dependent_thoroughfare_postdirection)
    assert_equal('38', components.dependent_thoroughfare_name)
    assert_equal('39', components.dependent_thoroughfare_trailing_type)
    assert_equal('40', components.dependent_thoroughfare_type)
    assert_equal('41', components.building)
    assert_equal('42', components.building_leading_type)
    assert_equal('43', components.building_name)
    assert_equal('44', components.building_trailing_type)
    assert_equal('45', components.sub_building_type)
    assert_equal('46', components.sub_building_number)
    assert_equal('47', components.sub_building_name)
    assert_equal('48', components.sub_building)
    assert_equal('49', components.post_box)
    assert_equal('50', components.post_box_type)
    assert_equal('51', components.post_box_number)

    metadata = candidate.metadata
    assert(metadata)
    assert_equal(52, metadata.latitude, 0.001)
    assert_equal(53, metadata.longitude, 0.001)
    assert_equal('54', metadata.geocode_precision)
    assert_equal('55', metadata.max_geocode_precision)

    analysis = candidate.analysis
    assert(analysis)
    assert_equal('56', analysis.verification_status)
    assert_equal('57', analysis.address_precision)
    assert_equal('58', analysis.max_address_precision)
  end
end