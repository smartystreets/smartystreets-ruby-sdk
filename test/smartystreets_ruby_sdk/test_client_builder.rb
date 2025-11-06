require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/client_builder'
require_relative '../../lib/smartystreets_ruby_sdk/response'
require_relative '../../lib/smartystreets_ruby_sdk/request'

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
end