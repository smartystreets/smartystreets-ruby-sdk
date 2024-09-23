require 'minitest/autorun'
require_relative '../../../lib/smartystreets_ruby_sdk/exceptions'
require_relative '../../../test/mocks/request_capturing_sender'
require_relative '../../../test/mocks/fake_serializer'
require_relative '../../../test/mocks/fake_deserializer'
require_relative '../../../test/mocks/mock_sender'
require_relative '../../../test/mocks/mock_exception_sender'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/client'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/lookup'

class TestStreetClient < Minitest::Test

  def test_financial_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.street = "street"
    lookup.city = "city"
    lookup.state = "state"
    lookup.zipcode = "zipcode"
    freeform_lookup.freeform = "street city state zipcode"

    client.send_property_financial_lookup("123")
    assert_equal("/123/property/financial", sender.request.url_components)

    client.send_property_financial_lookup(lookup)
    assert_equal("/search/property/financial", sender.request.url_components)
    assert_equal("street", sender.request.parameters["street"])
    assert_equal("city", sender.request.parameters["city"])
    assert_equal("state", sender.request.parameters["state"])
    assert_equal("zipcode", sender.request.parameters["zipcode"])

    client.send_property_financial_lookup(freeform_lookup)
    assert_equal("/search/property/financial", sender.request.url_components)
    assert_equal("street city state zipcode", sender.request.parameters["freeform"])
  end

  def test_principal_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.street = "street"
    lookup.city = "city"
    lookup.state = "state"
    lookup.zipcode = "zipcode"
    freeform_lookup.freeform = "street city state zipcode"

    client.send_property_principal_lookup("123")
    assert_equal("/123/property/principal", sender.request.url_components)

    client.send_property_principal_lookup(lookup)
    assert_equal("/search/property/principal", sender.request.url_components)
    assert_equal("street", sender.request.parameters["street"])
    assert_equal("city", sender.request.parameters["city"])
    assert_equal("state", sender.request.parameters["state"])
    assert_equal("zipcode", sender.request.parameters["zipcode"])

    client.send_property_principal_lookup(freeform_lookup)
    assert_equal("/search/property/principal", sender.request.url_components)
    assert_equal("street city state zipcode", sender.request.parameters["freeform"])
  end

  def test_geo_reference_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.street = "street"
    lookup.city = "city"
    lookup.state = "state"
    lookup.zipcode = "zipcode"
    freeform_lookup.freeform = "street city state zipcode"

    client.send_geo_reference_lookup("123")
    assert_equal("/123/geo-reference", sender.request.url_components)

    client.send_geo_reference_lookup(lookup)
    assert_equal("/search/geo-reference", sender.request.url_components)
    assert_equal("street", sender.request.parameters["street"])
    assert_equal("city", sender.request.parameters["city"])
    assert_equal("state", sender.request.parameters["state"])
    assert_equal("zipcode", sender.request.parameters["zipcode"])

    client.send_geo_reference_lookup(freeform_lookup)
    assert_equal("/search/geo-reference", sender.request.url_components)
    assert_equal("street city state zipcode", sender.request.parameters["freeform"])
  end
    
  def test_secondary_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.street = "street"
    lookup.city = "city"
    lookup.state = "state"
    lookup.zipcode = "zipcode"
    freeform_lookup.freeform = "street city state zipcode"

    client.send_secondary_lookup("123")
    assert_equal("/123/secondary", sender.request.url_components)

    client.send_secondary_lookup(lookup)
    assert_equal("/search/secondary", sender.request.url_components)
    assert_equal("street", sender.request.parameters["street"])
    assert_equal("city", sender.request.parameters["city"])
    assert_equal("state", sender.request.parameters["state"])
    assert_equal("zipcode", sender.request.parameters["zipcode"])

    client.send_secondary_lookup(freeform_lookup)
    assert_equal("/search/secondary", sender.request.url_components)
    assert_equal("street city state zipcode", sender.request.parameters["freeform"])
  end

  def test_secondary_count_url_formatted_correctly
    sender = RequestCapturingSender.new
    client = SmartyStreets::USEnrichment::Client.new(sender, FakeDeserializer.new(nil))

    lookup = SmartyStreets::USEnrichment::Lookup.new
    freeform_lookup = SmartyStreets::USEnrichment::Lookup.new

    lookup.street = "street"
    lookup.city = "city"
    lookup.state = "state"
    lookup.zipcode = "zipcode"
    freeform_lookup.freeform = "street city state zipcode"

    client.send_secondary_count_lookup("123")
    assert_equal("/123/secondary/count", sender.request.url_components)

    client.send_secondary_count_lookup(lookup)
    assert_equal("/search/secondary/count", sender.request.url_components)
    assert_equal("street", sender.request.parameters["street"])
    assert_equal("city", sender.request.parameters["city"])
    assert_equal("state", sender.request.parameters["state"])
    assert_equal("zipcode", sender.request.parameters["zipcode"])

    client.send_secondary_count_lookup(freeform_lookup)
    assert_equal("/search/secondary/count", sender.request.url_components)
    assert_equal("street city state zipcode", sender.request.parameters["freeform"])
  end
end