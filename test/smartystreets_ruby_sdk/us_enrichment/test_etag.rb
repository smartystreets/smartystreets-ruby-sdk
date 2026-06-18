require 'minitest/autorun'
require_relative '../../../lib/smartystreets_ruby_sdk/exceptions'
require_relative '../../../test/mocks/request_capturing_sender'
require_relative '../../../test/mocks/fake_deserializer'
require_relative '../../../test/mocks/mock_sender'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/client'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/lookup'

class TestEnrichmentEtag < Minitest::Test
  def test_enrichment_summary_lookup_sends_etag_header
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.street = "street"
    lookup.city = "city"
    lookup.state = "state"
    lookup.zipcode = "zipcode"
    lookup.request_etag = "abc-123"

    client.send_property_principal_lookup(lookup)
    assert_equal("abc-123", sender.request.header['Etag'])
  end

  def test_summary_captures_response_etag_on_lookup
    response = SmartyStreets::Response.new('[]', 200, {'etag' => 'server-etag'}, nil)
    sender = MockSender.new(response)
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new([]))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.smarty_key = "1"
    client.send_property_principal_lookup(lookup)

    assert_equal('server-etag', lookup.response_etag)
  end

  def test_response_etag_does_not_clobber_request_etag
    response = SmartyStreets::Response.new('[]', 200, {'etag' => 'server-side'}, nil)
    sender = MockSender.new(response)
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new([]))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.smarty_key = "1"
    lookup.request_etag = "client-side"
    client.send_property_principal_lookup(lookup)

    assert_equal("client-side", lookup.request_etag)
    assert_equal("server-side", lookup.response_etag)
  end

  def test_response_etag_case_insensitive
    response = SmartyStreets::Response.new('[]', 200, {'ETag' => 'server-etag'}, nil)
    sender = MockSender.new(response)
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new([]))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.smarty_key = "1"
    client.send_property_principal_lookup(lookup)

    assert_equal('server-etag', lookup.response_etag)
  end

  def test_response_etag_nil_when_header_absent
    response = SmartyStreets::Response.new('[]', 200, {}, nil)
    sender = MockSender.new(response)
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new([]))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.smarty_key = "1"
    client.send_property_principal_lookup(lookup)

    assert_nil lookup.response_etag
  end

  def test_rejects_whitespace_smarty_key_on_summary_lookup
    client = SmartyStreets::USEnrichment::Client.new(RequestCapturingSender.new, FakeDeserializer.new(nil))

    assert_raises(SmartyStreets::SmartyError) do
      client.send_business_lookup("   ")
    end
  end

  def test_rejects_whitespace_on_all_standard_lookup_fields
    client = SmartyStreets::USEnrichment::Client.new(RequestCapturingSender.new, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    lookup.smarty_key = "   "
    lookup.street = "   "
    lookup.freeform = "   "

    assert_raises(SmartyStreets::SmartyError) do
      client.send_property_principal_lookup(lookup)
    end
  end
end

class TestEnrichmentNotModified < Minitest::Test
  def test_304_is_success_with_refreshed_etag_and_untouched_result
    response = SmartyStreets::Response.new(nil, '304', {'etag' => 'refreshed-etag'}, nil)
    sender = SmartyStreets::StatusCodeSender.new(MockSender.new(response))
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::BusinessDetailLookup.new("ABC")
    lookup.request_etag = 'old-etag'
    lookup.result = 'prior'

    result = client.send_business_detail_lookup(lookup)

    assert_equal('refreshed-etag', lookup.response_etag)
    assert_equal('prior', lookup.result)
    assert_equal('prior', result)
  end
end
