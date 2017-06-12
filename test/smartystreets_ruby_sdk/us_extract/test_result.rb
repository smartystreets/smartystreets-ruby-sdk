require './lib/smartystreets_ruby_sdk/us_extract/result'

class TestResult < Minitest::Test
  def test_all_fields_filled_correctly
    obj = {
        'meta' => {
            'lines' => 1,
            'unicode' => true,
            'address_count' => 2,
            'verified_count' => 3,
            'bytes' => 4,
            'character_count' => 5
        },
        'addresses' => [
            {
                'text' => '6',
                'verified' => true,
                'line' => 7,
                'start' => 8,
                'end' => 9,
                'api_output' => [{}]
            },
            {'text' => '10'}
        ]
    }

    result = SmartyStreets::USExtract::Result.new(obj)

    metadata = result.metadata
    assert(metadata)
    assert_equal(1, metadata.lines)
    assert_equal(true, metadata.unicode)
    assert_equal(2, metadata.address_count)
    assert_equal(3, metadata.verified_count)
    assert_equal(4, metadata.bytes)
    assert_equal(5, metadata.character_count)

    address = result.addresses[0]
    assert(address)
    assert_equal('6', address.text)
    assert_equal(true, address.verified)
    assert_equal(7, address.line)
    assert_equal(8, address.start)
    assert_equal(9, address.end)
    assert_equal('10', result.addresses[1].text)

    candidates = address.candidates
    assert(candidates)
  end
end