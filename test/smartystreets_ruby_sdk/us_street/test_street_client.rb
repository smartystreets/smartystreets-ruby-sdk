require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/exceptions'
require './test/mocks/request_capturing_sender'
require './test/mocks/fake_serializer'
require './test/mocks/fake_deserializer'
require './test/mocks/mock_sender'
require './test/mocks/mock_exception_sender'
require './lib/smartystreets_ruby_sdk/us_street/client'
require './lib/smartystreets_ruby_sdk/us_street/candidate'
require './lib/smartystreets_ruby_sdk/us_street/match_type'
require './lib/smartystreets_ruby_sdk/response'
require './lib/smartystreets_ruby_sdk/native_serializer'

class TestStreetClient < Minitest::Test
  Lookup = SmartyStreets::USStreet::Lookup
  Candidate = SmartyStreets::USStreet::Candidate
  Client = SmartyStreets::USStreet::Client
  Batch = SmartyStreets::Batch
  Response = SmartyStreets::Response

  def test_freeform_assigned_to_street_field
    lookup = Lookup.new('freeform address')

    assert_equal('freeform address', lookup.street)
  end

  def test_send_populated_lookup
    sender = RequestCapturingSender.new
    expected_parameters = {
        'input_id' => '1',
        'street' => '2',
        'street2' => '3',
        'secondary' => '4',
        'city' => '5',
        'state' => '6',
        'zipcode' => '7',
        'lastline' => '8',
        'addressee' => '9',
        'urbanization' => '10',
        'candidates' => '11',
        'match' => SmartyStreets::USStreet::MatchType::INVALID
    }
    serializer = FakeSerializer.new(expected_parameters)
    client = Client.new(sender, serializer)
    lookup = Lookup.new
    lookup.input_id = '1'
    lookup.street = '2'
    lookup.street2 = '3'
    lookup.secondary = '4'
    lookup.city = '5'
    lookup.state = '6'
    lookup.zipcode = '7'
    lookup.lastline = '8'
    lookup.addressee = '9'
    lookup.urbanization = '10'
    lookup.candidates = '11'
    lookup.match = SmartyStreets::USStreet::MatchType::INVALID

    client.send_lookup(lookup)

    assert_equal(expected_parameters, sender.request.parameters)
  end

  def test_empty_batch_not_sent
    sender = RequestCapturingSender.new
    client = Client.new(sender, nil)

    client.send_batch(Batch.new)

    assert_nil(sender.request)
  end

  def test_successfully_sends_batch
    expected_payload = 'Hello, World!'
    sender = RequestCapturingSender.new
    serializer = FakeSerializer.new(expected_payload)
    client = Client.new(sender, serializer)
    batch = Batch.new
    batch.add(Lookup.new)
    batch.add(Lookup.new)

    client.send_batch(batch)

    assert_equal(expected_payload, sender.request.payload)
  end

  def test_deserialize_called_with_response_body
    response = Response.new('Hello, World!', 0)
    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new(nil)
    client = Client.new(sender, deserializer)

    client.send_lookup(Lookup.new)

    assert_equal(response.payload, deserializer.input)
  end

  def test_candidates_correctly_assigned_to_corresponding_lookup
    candidate0 = {'input_index' => 0, 'candidate_index' => 0, 'addressee' => 'Mister 0'}
    candidate1 = {'input_index' => 1, 'candidate_index' => 0, 'addressee' => 'Mister 1'}
    candidate2 = {'input_index' => 1, 'candidate_index' => 1, 'addressee' => 'Mister 2'}
    raw_candidates = [candidate0, candidate1, candidate2]

    expected_candidates = [Candidate.new(candidate0), Candidate.new(candidate1), Candidate.new(candidate2)]
    batch = Batch.new
    batch.add(Lookup.new)
    batch.add(Lookup.new)
    sender = MockSender.new(Response.new('[]', 0))
    deserializer = FakeDeserializer.new(raw_candidates)
    client = Client.new(sender, deserializer)

    client.send_batch(batch)

    assert_equal(expected_candidates[0].addressee, batch.get_by_index(0).result[0].addressee)
    assert_equal(expected_candidates[1].addressee, batch.get_by_index(1).result[0].addressee)
    assert_equal(expected_candidates[2].addressee, batch.get_by_index(1).result[1].addressee)
  end

  def test_raises_exception_when_response_has_error
    exception = SmartyStreets::BadCredentialsError
    client = Client.new(MockExceptionSender.new(exception), FakeSerializer.new(nil))

    assert_raises exception do
      client.send_lookup(Lookup.new)
    end
  end

  def test_full_json_response_deserialization
    body = %q{{
           	"input_id": "blah",
               "input_index": 0,
               "candidate_index": 4242,
           	"addressee": "John Smith",
               "delivery_line_1": "3214 N University Ave # 409",
               "delivery_line_2": "blah blah",
               "last_line": "Provo UT 84604-4405",
               "delivery_point_barcode": "846044405140",
               "components": {
                 "primary_number": "3214",
                 "street_predirection": "N",
                 "street_postdirection": "Q",
                 "street_name": "University",
                 "street_suffix": "Ave",
                 "secondary_number": "409",
                 "secondary_designator": "#",
                 "extra_secondary_number": "410",
                 "extra_secondary_designator": "Apt",
                 "pmb_number": "411",
                 "pmb_designator": "Box",
                 "city_name": "Provo",
                 "default_city_name": "Provo",
                 "state_abbreviation": "UT",
                 "zipcode": "84604",
                 "plus4_code": "4405",
                 "delivery_point": "14",
                 "delivery_point_check_digit": "0",
                 "urbanization": "urbanization"
               },
               "metadata": {
                 "record_type": "S",
                 "zip_type": "Standard",
                 "county_fips": "49049",
                 "county_name": "Utah",
                 "carrier_route": "C016",
                 "congressional_district": "03",
           	  "building_default_indicator": "hi",
                 "rdi": "Commercial",
                 "elot_sequence": "0016",
                 "elot_sort": "A",
                 "latitude": 40.27658,
                 "longitude": -111.65759,
                 "precision": "Zip9",
                 "time_zone": "Mountain",
                 "utc_offset": -7,
                 "dst": true,
           	  "ews_match": true
               },
               "analysis": {
                 "dpv_match_code": "S",
                 "dpv_footnotes": "AACCRR",
                 "dpv_cmra": "Y",
                 "dpv_vacant": "N",
                 "active": "Y",
                 "footnotes": "footnotes",
                 "lacslink_code": "lacslink_code",
                 "lacslink_indicator": "lacslink_indicator",
                 "suitelink_match": true
               }
             }}

    serializer = SmartyStreets::NativeSerializer.new
    object = serializer.deserialize(body)
    candidate = Candidate.new(object)
    assert_equal(0, candidate.input_index)
    assert_equal(4242, candidate.candidate_index)
    assert_equal("John Smith", candidate.addressee)
    assert_equal("3214 N University Ave # 409", candidate.delivery_line_1)
    assert_equal("blah blah", candidate.delivery_line_2)
    assert_equal("Provo UT 84604-4405", candidate.last_line)
    assert_equal("846044405140", candidate.delivery_point_barcode)
    assert_equal("3214", candidate.components.primary_number)
    assert_equal("N", candidate.components.street_predirection)
    assert_equal("University", candidate.components.street_name)
    assert_equal("Q", candidate.components.street_postdirection)
    assert_equal("Ave", candidate.components.street_suffix)
    assert_equal("409", candidate.components.secondary_number)
    assert_equal("#", candidate.components.secondary_designator)
    assert_equal("410", candidate.components.extra_secondary_number)
    assert_equal("Apt", candidate.components.extra_secondary_designator)
    assert_equal("411", candidate.components.pmb_number)
    assert_equal("Box", candidate.components.pmb_designator)
    assert_equal("Provo", candidate.components.city_name)
    assert_equal("Provo", candidate.components.default_city_name)
    assert_equal("UT", candidate.components.state_abbreviation)
    assert_equal("84604", candidate.components.zipcode)
    assert_equal("4405", candidate.components.plus4_code)
    assert_equal("14", candidate.components.delivery_point)
    assert_equal("0", candidate.components.delivery_point_check_digit)
    assert_equal("urbanization", candidate.components.urbanization)
    assert_equal("S", candidate.metadata.record_type)
    assert_equal("Standard", candidate.metadata.zip_type)
    assert_equal("49049", candidate.metadata.county_fips)
    assert_equal("Utah", candidate.metadata.county_name)
    assert_equal("C016", candidate.metadata.carrier_route)
    assert_equal("03", candidate.metadata.congressional_district)
    assert_equal("hi", candidate.metadata.building_default_indicator)
    assert_equal("Commercial", candidate.metadata.rdi)
    assert_equal("0016", candidate.metadata.elot_sequence)
    assert_equal("A", candidate.metadata.elot_sort)
    assert_equal(40.27658, candidate.metadata.latitude)
    assert_equal(-111.65759, candidate.metadata.longitude)
    assert_equal("Zip9", candidate.metadata.precision)
    assert_equal("Mountain", candidate.metadata.time_zone)
    assert_equal(-7, candidate.metadata.utc_offset)
    assert_equal(true, candidate.metadata.obeys_dst)
    assert_equal(true, candidate.metadata.is_an_ews_match)
    assert_equal("S", candidate.analysis.dpv_match_code)
    assert_equal("AACCRR", candidate.analysis.dpv_footnotes)
    assert_equal("Y", candidate.analysis.cmra)
    assert_equal("N", candidate.analysis.vacant)
    assert_equal("Y", candidate.analysis.active)
    assert_equal("footnotes", candidate.analysis.footnotes)
    assert_equal("lacslink_code", candidate.analysis.lacs_link_code)
    assert_equal("lacslink_indicator", candidate.analysis.lacs_link_indicator)
    assert_equal(true, candidate.analysis.is_suite_link_match)
  end
end