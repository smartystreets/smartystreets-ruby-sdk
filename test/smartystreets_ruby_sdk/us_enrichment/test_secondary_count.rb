require 'minitest/autorun'
require '../../../lib/smartystreets_ruby_sdk/us_enrichment/secondary/count/response'

class TestSecondaryCountResponse < Minitest::Test
  def test_all_fields_filled_correctly

    obj = {
        'smarty_key' => '123',
        'count' => 2
    }

    response = SmartyStreets::USEnrichment::Secondary::Count::Response.new(obj)

    assert_equal('123', response.smarty_key)
    assert_equal(2, response.count)
  end
end