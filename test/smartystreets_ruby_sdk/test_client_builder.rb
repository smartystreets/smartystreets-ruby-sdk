require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/client_builder'
require_relative '../../lib/smartystreets_ruby_sdk/response'
require_relative '../../lib/smartystreets_ruby_sdk/request'
require_relative '../../lib/smartystreets_ruby_sdk/static_credentials'
require_relative '../../lib/smartystreets_ruby_sdk/shared_credentials'
require_relative '../../lib/smartystreets_ruby_sdk/us_street/lookup'
require_relative '../mocks/request_capturing_sender'

class TestClientBuilder < Minitest::Test
  def test_with_custom_query
    clientBuilder = SmartyStreets::ClientBuilder.new(SmartyStreets::SharedCredentials.new("key", "referer"))
      .with_custom_query("test", "result")
      .with_custom_query("other", "value")
    assert_equal(clientBuilder.instance_variable_get(:@queries)["test"], "result")
    assert_equal(clientBuilder.instance_variable_get(:@queries)["other"], "value")
  end

  def test_with_custom_comma_separated_query
    client = SmartyStreets::ClientBuilder.new(SmartyStreets::SharedCredentials.new("key", "referer"))
      .with_custom_comma_separated_query("test", "separated")
      .with_custom_comma_separated_query("test", "by")
      .with_custom_comma_separated_query("test", "commas")
    assert_equal(client.instance_variable_get(:@queries)["test"], "separated,by,commas")
  end

  def test_with_features_component_analysis
    client = SmartyStreets::ClientBuilder.new(SmartyStreets::SharedCredentials.new("key", "referer"))
      .with_feature_component_analysis()
    assert_equal(client.instance_variable_get(:@queries)["features"], "component-analysis")
  end

  def test_with_feature_iana_time_zone
    client = SmartyStreets::ClientBuilder.new(SmartyStreets::SharedCredentials.new("key", "referer"))
      .with_feature_iana_time_zone()
    assert_equal(client.instance_variable_get(:@queries)["features"], "iana-timezone")
  end

  def test_with_feature_iana_time_zone_and_component_analysis_should_append
    client = SmartyStreets::ClientBuilder.new(SmartyStreets::SharedCredentials.new("key", "referer"))
      .with_feature_component_analysis()
      .with_feature_iana_time_zone()
    assert_equal(client.instance_variable_get(:@queries)["features"], "component-analysis,iana-timezone")
  end

  def test_with_sender_throws_when_combined_with_max_timeout
    credentials = SmartyStreets::StaticCredentials.new("test-id", "test-token")
    builder = SmartyStreets::ClientBuilder.new(credentials)
      .with_sender(RequestCapturingSender.new)
      .with_max_timeout(5)
    assert_raises(ArgumentError) { builder.build_us_street_api_client }
  end

  def test_with_sender_throws_when_combined_with_proxy
    credentials = SmartyStreets::StaticCredentials.new("test-id", "test-token")
    builder = SmartyStreets::ClientBuilder.new(credentials)
      .with_sender(RequestCapturingSender.new)
      .with_proxy("localhost", 8080, nil, nil)
    assert_raises(ArgumentError) { builder.build_us_street_api_client }
  end

  def test_with_sender_wraps_with_middleware_chain
    capturing_sender = RequestCapturingSender.new
    credentials = SmartyStreets::StaticCredentials.new("test-id", "test-token")
    client = SmartyStreets::ClientBuilder.new(credentials)
      .with_sender(capturing_sender)
      .build_us_street_api_client

    lookup = SmartyStreets::USStreet::Lookup.new
    lookup.street = "1 Rosedale"
    client.send_lookup(lookup)

    assert_includes(capturing_sender.request.url_prefix, "us-street.api.smarty.com")
    assert_equal("test-id", capturing_sender.request.parameters["auth-id"])
    assert_equal("test-token", capturing_sender.request.parameters["auth-token"])
  end
end