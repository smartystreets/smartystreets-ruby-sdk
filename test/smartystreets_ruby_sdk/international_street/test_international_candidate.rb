require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/international_street'
require './lib/smartystreets_ruby_sdk/native_serializer'

class TestInternationalCandidate < Minitest::Test
  def test_all_fields_filled_correctly
    response_payload = "[{\"input_id\":\"1234\",\"organization\":\"1\",\"address1\":\"2\",\"address2\":\"3\","\
                "\"address3\":\"4\",\"address4\":\"5\",\"address5\":\"6\",\"address6\":\"7\",\"address7\":\"8\","\
                "\"address8\":\"9\",\"address9\":\"10\",\"address10\":\"11\",\"address11\":\"12\",\"address12\":\"13\","\
                "\"components\":{\"country_iso_3\":\"14\",\"super_administrative_area\":\"15\","\
                "\"administrative_area\":\"16\",\"administrative_area_short\":\"16.1\",\"administrative_area_long\":\"16.2\","\
                "\"sub_administrative_area\":\"17\",\"dependent_locality\":\"18\","\
                "\"dependent_locality_name\":\"19\",\"double_dependent_locality\":\"20\",\"locality\":\"21\","\
                "\"postal_code\":\"22\",\"postal_code_short\":\"23\",\"postal_code_extra\":\"24\","\
                "\"premise\":\"25\",\"premise_extra\":\"26\",\"premise_number\":\"27\",\"premise_prefix_number\":\"27.5\","\
                "\"premise_type\":\"28\","\
                "\"thoroughfare\":\"29\",\"thoroughfare_predirection\":\"30\",\"thoroughfare_postdirection\":\"31\","\
                "\"thoroughfare_name\":\"32\",\"thoroughfare_trailing_type\":\"33\",\"thoroughfare_type\":\"34\","\
                "\"dependent_thoroughfare\":\"35\",\"dependent_thoroughfare_predirection\":\"36\","\
                "\"dependent_thoroughfare_postdirection\":\"37\",\"dependent_thoroughfare_name\":\"38\","\
                "\"dependent_thoroughfare_trailing_type\":\"39\",\"dependent_thoroughfare_type\":\"40\","\
                "\"building\":\"41\",\"building_leading_type\":\"42\",\"building_name\":\"43\","\
                "\"building_trailing_type\":\"44\",\"sub_building_type\":\"45\",\"sub_building_number\":\"46\","\
                "\"sub_building_name\":\"47\",\"sub_building\":\"48\",\"level_type\":\"48.1\",\"level_number\":\"48.2\","\
                "\"post_box\":\"49\",\"post_box_type\":\"50\","\
                "\"post_box_number\":\"51\"},\"metadata\":{\"latitude\":52.0,\"longitude\":53.0,"\
                "\"geocode_precision\":\"54\",\"max_geocode_precision\":\"55\", \"address_format\":\"56\"},"\
                "\"analysis\":{\"verification_status\":\"57\",\"address_precision\":\"58\","\
                "\"max_address_precision\":\"59\",\"changes\":{\"organization\":\"60\",\"address1\":\"61\","\
                "\"address2\":\"62\",\"address3\":\"63\",\"address4\":\"64\",\"address5\":\"65\",\"address6\":\"66\","\
                "\"address7\":\"67\",\"address8\":\"68\",\"address9\":\"69\",\"address10\":\"70\",\"address11\":\"71\","\
                "\"address12\":\"72\",\"components\":{\"super_administrative_area\":\"73\","\
                "\"administrative_area\":\"74\",\"administrative_area_short\":\"74.1\",\"administrative_area_long\":\"74.2\","\
                "\"sub_administrative_area\":\"75\",\"building\":\"76\",\"dependent_locality\":\"77\","\
                "\"dependent_locality_name\":\"78\",\"double_dependent_locality\":\"79\",\"country_iso_3\":\"80\","\
                "\"locality\":\"81\",\"postal_code\":\"82\",\"postal_code_short\":\"83\",\"postal_code_extra\":\"84\","\
                "\"premise\":\"85\",\"premise_extra\":\"86\",\"premise_number\":\"87\",\"premise_type\":\"88\","\
                "\"premise_prefix_number\":\"89\",\"thoroughfare\":\"90\",\"thoroughfare_predirection\":\"91\","\
                "\"thoroughfare_postdirection\":\"92\",\"thoroughfare_name\":\"93\",\"thoroughfare_trailing_type\":\"94\","\
                "\"thoroughfare_type\":\"95\",\"dependent_thoroughfare\":\"96\","\
                "\"dependent_thoroughfare_predirection\":\"97\",\"dependent_thoroughfare_postdirection\":\"98\","\
                "\"dependent_thoroughfare_name\":\"99\",\"dependent_thoroughfare_trailing_type\":\"100\","\
                "\"dependent_thoroughfare_type\":\"101\",\"building_leading_type\":\"102\",\"building_name\":\"103\","\
                "\"building_trailing_type\":\"104\",\"sub_building_type\":\"105\",\"sub_building_number\":\"106\","\
                "\"sub_building_name\":\"107\",\"sub_building\":\"108\",\"level_type\":\"108.1\",\"level_number\":\"108.2\","\
                "\"post_box\":\"109\",\"post_box_type\":\"110\","\
                "\"post_box_number\":\"111\"}}}}]"

    serializer = SmartyStreets::NativeSerializer.new
    candidate = SmartyStreets::InternationalStreet::Candidate.new(serializer.deserialize(response_payload)[0])

    assert_equal('1234', candidate.input_id)
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
    assert_equal('16.1', components.administrative_area_short)
    assert_equal('16.2', components.administrative_area_long)
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
    assert_equal('27.5', components.premise_prefix_number)
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
    assert_equal('48.1', components.level_type)
    assert_equal('48.2', components.level_number)
    assert_equal('49', components.post_box)
    assert_equal('50', components.post_box_type)
    assert_equal('51', components.post_box_number)

    metadata = candidate.metadata
    assert(metadata)
    assert_equal(52, metadata.latitude, 0.001)
    assert_equal(53, metadata.longitude, 0.001)
    assert_equal('54', metadata.geocode_precision)
    assert_equal('55', metadata.max_geocode_precision)
    assert_equal('56', metadata.address_format)

    analysis = candidate.analysis
    assert(analysis)
    assert_equal('57', analysis.verification_status)
    assert_equal('58', analysis.address_precision)
    assert_equal('59', analysis.max_address_precision)

    changes = analysis.changes
    assert(changes)
    assert_equal('60', changes.organization)
    assert_equal('61', changes.address1)
    assert_equal('62', changes.address2)
    assert_equal('63', changes.address3)
    assert_equal('64', changes.address4)
    assert_equal('65', changes.address5)
    assert_equal('66', changes.address6)
    assert_equal('67', changes.address7)
    assert_equal('68', changes.address8)
    assert_equal('69', changes.address9)
    assert_equal('70', changes.address10)
    assert_equal('71', changes.address11)
    assert_equal('72', changes.address12)

    components = changes.components
    assert(components)
    assert_equal('73', components.super_administrative_area)
    assert_equal('74', components.administrative_area)
    assert_equal('74.1', components.administrative_area_short)
    assert_equal('74.2', components.administrative_area_long)
    assert_equal('75', components.sub_administrative_area)
    assert_equal('76', components.building)
    assert_equal('77', components.dependent_locality)
    assert_equal('78', components.dependent_locality_name)
    assert_equal('79', components.double_dependent_locality)
    assert_equal('80', components.country_iso_3)
    assert_equal('81', components.locality)
    assert_equal('82', components.postal_code)
    assert_equal('83', components.postal_code_short)
    assert_equal('84', components.postal_code_extra)
    assert_equal('85', components.premise)
    assert_equal('86', components.premise_extra)
    assert_equal('87', components.premise_number)
    assert_equal('88', components.premise_type)
    assert_equal('89', components.premise_prefix_number)
    assert_equal('90', components.thoroughfare)
    assert_equal('91', components.thoroughfare_predirection)
    assert_equal('92', components.thoroughfare_postdirection)
    assert_equal('93', components.thoroughfare_name)
    assert_equal('94', components.thoroughfare_trailing_type)
    assert_equal('95', components.thoroughfare_type)
    assert_equal('96', components.dependent_thoroughfare)
    assert_equal('97', components.dependent_thoroughfare_predirection)
    assert_equal('98', components.dependent_thoroughfare_postdirection)
    assert_equal('99', components.dependent_thoroughfare_name)
    assert_equal('100', components.dependent_thoroughfare_trailing_type)
    assert_equal('101', components.dependent_thoroughfare_type)
    assert_equal('102', components.building_leading_type)
    assert_equal('103', components.building_name)
    assert_equal('104', components.building_trailing_type)
    assert_equal('105', components.sub_building_type)
    assert_equal('106', components.sub_building_number)
    assert_equal('107', components.sub_building_name)
    assert_equal('108', components.sub_building)
    assert_equal('108.1', components.level_type)
    assert_equal('108.2', components.level_number)
    assert_equal('109', components.post_box)
    assert_equal('110', components.post_box_type)
    assert_equal('111', components.post_box_number)

  end
end