require 'minitest/autorun'
require_relative '../../../lib/smartystreets_ruby_sdk/exceptions'
require_relative '../../../test/mocks/request_capturing_sender'
require_relative '../../../test/mocks/fake_deserializer'
require_relative '../../../test/mocks/mock_sender'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/client'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/lookup'

class TestBusinessDetail < Minitest::Test
  def make_client(sender, deserialized = nil)
    SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(deserialized))
  end

  def test_business_detail_builds_url
    sender = RequestCapturingSender.new
    client = make_client(sender)

    client.send_business_detail_lookup("ABC123")
    assert_equal("/business/ABC123", sender.request.url_components)
  end

  def test_business_detail_url_encodes_reserved_chars
    sender = RequestCapturingSender.new
    client = make_client(sender)

    client.send_business_detail_lookup("a/b?c#d")
    assert_equal("/business/a%2Fb%3Fc%23d", sender.request.url_components)
  end

  def test_business_detail_sends_etag_header
    sender = RequestCapturingSender.new
    client = make_client(sender)

    lookup = SmartyStreets::USEnrichment::BusinessDetailLookup.new("ABC")
    lookup.request_etag = "xyz-789"

    client.send_business_detail_lookup(lookup)
    assert_equal("xyz-789", sender.request.header['Etag'])
  end

  def test_business_detail_include_fields_in_params
    sender = RequestCapturingSender.new
    client = make_client(sender)

    lookup = SmartyStreets::USEnrichment::BusinessDetailLookup.new("ABC")
    lookup.add_include_attribute("phone")
    lookup.add_include_attribute("email")

    client.send_business_detail_lookup(lookup)
    assert_equal("phone,email", sender.request.parameters['include'])
  end

  def test_business_detail_exclude_fields_in_params
    sender = RequestCapturingSender.new
    client = make_client(sender)

    lookup = SmartyStreets::USEnrichment::BusinessDetailLookup.new("ABC")
    lookup.add_exclude_attribute("fax")

    client.send_business_detail_lookup(lookup)
    assert_equal("fax", sender.request.parameters['exclude'])
  end

  def test_business_detail_custom_parameters_in_params
    sender = RequestCapturingSender.new
    client = make_client(sender)

    lookup = SmartyStreets::USEnrichment::BusinessDetailLookup.new("ABC")
    lookup.add_custom_parameter("source", "qa")

    client.send_business_detail_lookup(lookup)
    assert_equal("qa", sender.request.parameters['source'])
  end

  def test_business_detail_include_exclude_custom_combined
    sender = RequestCapturingSender.new
    client = make_client(sender)

    lookup = SmartyStreets::USEnrichment::BusinessDetailLookup.new("ABC")
    lookup.add_include_attribute("phone")
    lookup.add_exclude_attribute("fax")
    lookup.add_custom_parameter("source", "qa")
    lookup.request_etag = "e1"

    client.send_business_detail_lookup(lookup)
    assert_equal("phone", sender.request.parameters['include'])
    assert_equal("fax", sender.request.parameters['exclude'])
    assert_equal("qa", sender.request.parameters['source'])
    assert_equal("e1", sender.request.header['Etag'])
  end

  def test_business_detail_rejects_empty_business_id
    client = make_client(RequestCapturingSender.new)
    assert_raises(SmartyStreets::SmartyError) do
      client.send_business_detail_lookup("")
    end
  end

  def test_business_detail_rejects_nil_business_id
    client = make_client(RequestCapturingSender.new)
    assert_raises(SmartyStreets::SmartyError) do
      client.send_business_detail_lookup(nil)
    end
  end

  def test_business_detail_rejects_whitespace_business_id
    client = make_client(RequestCapturingSender.new)
    assert_raises(SmartyStreets::SmartyError) do
      client.send_business_detail_lookup("   ")
    end
  end

  def test_business_detail_rejects_multiple_results
    sender = RequestCapturingSender.new
    client = make_client(sender, [
      {'business_id' => 'one', 'attributes' => {}},
      {'business_id' => 'two', 'attributes' => {}},
    ])

    assert_raises(SmartyStreets::SmartyError) do
      client.send_business_detail_lookup("ABC")
    end
  end

  def test_business_detail_accepts_single_result
    sender = RequestCapturingSender.new
    raw = {
      'smarty_key' => 'k1',
      'data_set_name' => 'business',
      'business_id' => 'ABC',
      'attributes' => {'company_name' => 'Acme Corp', 'phone' => '555-1212'},
    }
    client = make_client(sender, [raw])

    lookup = SmartyStreets::USEnrichment::BusinessDetailLookup.new("ABC")
    response = client.send_business_detail_lookup(lookup)

    refute_nil response
    assert_equal('ABC', response.business_id)
    assert_equal('k1', response.smarty_key)
    assert_equal('business', response.data_set_name)
    assert_equal('Acme Corp', response.attributes.company_name)
    assert_equal('555-1212', response.attributes.phone)
    assert_same(response, lookup.result)
  end

  def test_business_detail_accepts_empty_results
    sender = RequestCapturingSender.new
    client = make_client(sender, [])

    lookup = SmartyStreets::USEnrichment::BusinessDetailLookup.new("ABC")
    result = client.send_business_detail_lookup(lookup)

    assert_nil result
    assert_nil lookup.result
  end

  def test_business_detail_captures_response_etag
    response = SmartyStreets::Response.new('[]', 200, {'etag' => 'server-etag-1'}, nil)
    sender = MockSender.new(response)
    client = make_client(sender)

    lookup = SmartyStreets::USEnrichment::BusinessDetailLookup.new("ABC")
    client.send_business_detail_lookup(lookup)

    assert_equal('server-etag-1', lookup.response_etag)
  end

  def test_business_detail_case_insensitive_response_etag_header
    response = SmartyStreets::Response.new('[]', 200, {'ETag' => 'server-etag-2'}, nil)
    sender = MockSender.new(response)
    client = make_client(sender)

    lookup = SmartyStreets::USEnrichment::BusinessDetailLookup.new("ABC")
    client.send_business_detail_lookup(lookup)

    assert_equal('server-etag-2', lookup.response_etag)
  end
end
