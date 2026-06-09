require 'minitest/autorun'
require_relative '../../../lib/smartystreets_ruby_sdk/exceptions'
require_relative '../../../test/mocks/request_capturing_sender'
require_relative '../../../test/mocks/fake_deserializer'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/client'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/lookup'

class TestBusinessSummary < Minitest::Test
  def test_business_summary_lookup_with_smarty_key_builds_url
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    client.send_business_lookup("1")
    assert_equal("/1/business", sender.request.url_components)
  end

  def test_business_summary_lookup_with_components_builds_url
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.street = "street"
    lookup.city = "city"
    lookup.state = "state"
    lookup.zipcode = "zipcode"

    client.send_business_lookup(lookup)
    assert_equal("/search/business", sender.request.url_components)
    assert_equal("street", sender.request.parameters["street"])
    assert_equal("city", sender.request.parameters["city"])
    assert_equal("state", sender.request.parameters["state"])
    assert_equal("zipcode", sender.request.parameters["zipcode"])
  end

  def test_business_summary_lookup_with_freeform_builds_url
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.freeform = "street city state zipcode"

    client.send_business_lookup(lookup)
    assert_equal("/search/business", sender.request.url_components)
    assert_equal("street city state zipcode", sender.request.parameters["freeform"])
  end

  def test_business_summary_lookup_with_business_name_search
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.freeform = "1600 Amphitheatre Pkwy, Mountain View, CA"
    lookup.business_name = "Google"
    lookup.city = "Mountain View"

    client.send_business_lookup(lookup)
    assert_equal("/search/business", sender.request.url_components)
    assert_equal("1600 Amphitheatre Pkwy, Mountain View, CA", sender.request.parameters["freeform"])
    assert_equal("Google", sender.request.parameters["business_name"])
    assert_equal("Mountain View", sender.request.parameters["city"])
  end

  def test_business_summary_lookup_without_business_name_omits_param
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.freeform = "1600 Amphitheatre Pkwy, Mountain View, CA"

    client.send_business_lookup(lookup)
    assert_equal("/search/business", sender.request.url_components)
    assert_nil(sender.request.parameters["business_name"])
  end

  def test_business_summary_lookup_with_business_name_only
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.business_name = "Style Studio"

    client.send_business_lookup(lookup)
    assert_equal("/search/business", sender.request.url_components)
    assert_equal("Style Studio", sender.request.parameters["business_name"])
  end

  def test_business_summary_response_wraps_businesses
    obj = {
      'smarty_key' => 'key-1',
      'data_set_name' => 'business',
      'businesses' => [
        {'company_name' => 'Acme Corp', 'business_id' => 'abc-1'},
        {'company_name' => 'Contoso',   'business_id' => 'xyz-2'},
      ],
    }
    response = SmartyStreets::USEnrichment::Business::Summary::Response.new(obj)

    assert_equal('key-1', response.smarty_key)
    assert_equal('business', response.data_set_name)
    assert_equal(2, response.businesses.length)
    assert_equal('Acme Corp', response.businesses[0].company_name)
    assert_equal('abc-1', response.businesses[0].business_id)
    assert_equal('Contoso', response.businesses[1].company_name)
    assert_equal('xyz-2', response.businesses[1].business_id)
  end

  def test_business_summary_response_handles_missing_businesses
    response = SmartyStreets::USEnrichment::Business::Summary::Response.new({'smarty_key' => 'k'})
    assert_equal([], response.businesses)
  end
end
