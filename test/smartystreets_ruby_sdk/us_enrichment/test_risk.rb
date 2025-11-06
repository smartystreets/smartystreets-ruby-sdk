require 'minitest/autorun'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/risk/response'

class TestRiskResponse < Minitest::Test
  def test_some_fields_filled_correctly

    attributes_obj = {
        'AGRIVALUE' => 'AGRIVALUE',
        'ALR_NPCTL' => 'ALR_NPCTL',
        'ALR_VALA' => 'ALR_VALA',
    }

    obj = {
        'smarty_key' => '123',
        'data_set_name' => 'risk',
        'attributes' => attributes_obj
    }

    response = SmartyStreets::USEnrichment::Risk::Response.new(obj)

    assert_equal('123', response.smarty_key)
    assert_equal('risk', response.data_set_name)

    attributes = response.attributes

    assert_equal('AGRIVALUE', attributes.AGRIVALUE)
    assert_equal('ALR_NPCTL', attributes.ALR_NPCTL)
    assert_equal('ALR_VALA', attributes.ALR_VALA)
  end
end