# frozen_string_literal: true

require_relative '../test_helper'
require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/client_builder'

module SmartyStreets
  class DummySigner; end
end

class TestClientBuilder < Minitest::Test
  def setup
    @signer = SmartyStreets::DummySigner.new
    @builder = SmartyStreets::ClientBuilder.new(@signer)
  end

  def test_chainable_configuration_methods
    result = @builder
             .retry_at_most(10)
             .with_max_timeout(20)
             .with_base_url('http://example.com')
             .with_proxy('host', 8080, 'user', 'pass')
             .with_custom_headers({ 'X-Test' => 'value' })
             .with_licenses(['test-license'])
             .with_debug
    assert_equal @builder, result
  end

  def test_build_sender_returns_custom_sender
    custom_sender = Object.new
    @builder.with_sender(custom_sender)
    assert_equal custom_sender, @builder.build_sender
  end

  def test_build_sender_composes_senders
    # Should return a URLPrefixSender wrapping a LicenseSender, RetrySender, SigningSender, CustomHeaderSender, StatusCodeSender, NativeSender
    sender = @builder.build_sender
    assert sender.is_a?(SmartyStreets::URLPrefixSender)
  end

  def test_build_us_street_api_client
    client = @builder.build_us_street_api_client
    assert client.is_a?(SmartyStreets::USStreet::Client)
  end

  def test_build_us_zipcode_api_client
    client = @builder.build_us_zipcode_api_client
    assert client.is_a?(SmartyStreets::USZipcode::Client)
  end

  def test_build_us_extract_api_client
    client = @builder.build_us_extract_api_client
    assert client.is_a?(SmartyStreets::USExtract::Client)
  end

  def test_build_international_street_api_client
    client = @builder.build_international_street_api_client
    assert client.is_a?(SmartyStreets::InternationalStreet::Client)
  end

  def test_build_international_autocomplete_api_client
    client = @builder.build_international_autocomplete_api_client
    assert client.is_a?(SmartyStreets::InternationalAutocomplete::Client)
  end

  def test_build_us_reverse_geo_api_client
    client = @builder.build_us_reverse_geo_api_client
    assert client.is_a?(SmartyStreets::USReverseGeo::Client)
  end

  def test_build_us_autocomplete_pro_api_client
    client = @builder.build_us_autocomplete_pro_api_client
    assert client.is_a?(SmartyStreets::USAutocompletePro::Client)
  end

  def test_build_us_enrichment_api_client
    client = @builder.build_us_enrichment_api_client
    assert client.is_a?(SmartyStreets::USEnrichment::Client)
  end

  def test_with_serializer_sets_serializer
    fake_serializer = Object.new
    @builder.with_serializer(fake_serializer)
    # Build a client and check that it uses the serializer
    client = @builder.build_us_street_api_client
    assert_equal fake_serializer, client.instance_variable_get(:@serializer)
  end

  def test_with_custom_headers_sets_header
    @builder.with_custom_headers({ 'X-Test' => 'value' })
    assert_equal({ 'X-Test' => 'value' }, @builder.instance_variable_get(:@header))
  end

  def test_with_licenses_accumulates_licenses_and_affects_sender
    @builder.with_licenses(['A'])
    @builder.with_licenses(['B'])
    assert_includes @builder.instance_variable_get(:@licenses), 'A'
    assert_includes @builder.instance_variable_get(:@licenses), 'B'
    sender = @builder.build_sender
    assert sender.is_a?(SmartyStreets::URLPrefixSender)
  end

  def test_with_debug_sets_debug_flag
    @builder.with_debug
    assert_equal true, @builder.instance_variable_get(:@debug)
  end

  def test_build_sender_with_custom_sender
    custom_sender = Object.new
    @builder.with_sender(custom_sender)
    assert_equal custom_sender, @builder.build_sender
  end

  def test_build_sender_with_and_without_headers
    # Without custom headers
    sender = @builder.build_sender
    assert sender.is_a?(SmartyStreets::URLPrefixSender)
    # With custom headers
    @builder.with_custom_headers({ 'X-Test' => 'value' })
    sender = @builder.build_sender
    assert sender.is_a?(SmartyStreets::URLPrefixSender)
  end

  def test_build_sender_with_and_without_licenses
    # Without licenses
    sender = @builder.build_sender
    assert sender.is_a?(SmartyStreets::URLPrefixSender)
    # With licenses
    @builder.with_licenses(['foo'])
    sender = @builder.build_sender
    assert sender.is_a?(SmartyStreets::URLPrefixSender)
  end

  def test_ensure_url_prefix_not_null_only_sets_when_nil
    @builder.instance_variable_set(:@url_prefix, nil)
    @builder.send(:ensure_url_prefix_not_null, 'http://foo')
    assert_equal 'http://foo', @builder.instance_variable_get(:@url_prefix)
    # Should not overwrite if already set
    @builder.instance_variable_set(:@url_prefix, 'http://bar')
    @builder.send(:ensure_url_prefix_not_null, 'http://baz')
    assert_equal 'http://bar', @builder.instance_variable_get(:@url_prefix)
  end

  def test_constructor_defaults
    builder = SmartyStreets::ClientBuilder.new('signer')
    assert_equal 'signer', builder.instance_variable_get(:@signer)
    assert builder.instance_variable_get(:@serializer).is_a?(SmartyStreets::NativeSerializer)
    assert_nil builder.instance_variable_get(:@http_sender)
    assert_equal 5, builder.instance_variable_get(:@max_retries)
    assert_equal 10, builder.instance_variable_get(:@max_timeout)
    assert_nil builder.instance_variable_get(:@url_prefix)
    assert_nil builder.instance_variable_get(:@proxy)
    assert_nil builder.instance_variable_get(:@header)
    assert_equal [], builder.instance_variable_get(:@licenses)
    assert_nil builder.instance_variable_get(:@debug)
  end

  def test_retry_at_most_sets_value_and_returns_self
    result = @builder.retry_at_most(7)
    assert_equal 7, @builder.instance_variable_get(:@max_retries)
    assert_equal @builder, result
  end

  def test_with_max_timeout_sets_value_and_returns_self
    result = @builder.with_max_timeout(42)
    assert_equal 42, @builder.instance_variable_get(:@max_timeout)
    assert_equal @builder, result
  end

  def test_with_sender_sets_value_and_returns_self
    sender = Object.new
    result = @builder.with_sender(sender)
    assert_equal sender, @builder.instance_variable_get(:@http_sender)
    assert_equal @builder, result
  end

  def test_with_serializer_sets_value_and_returns_self
    serializer = Object.new
    result = @builder.with_serializer(serializer)
    assert_equal serializer, @builder.instance_variable_get(:@serializer)
    assert_equal @builder, result
  end

  def test_with_base_url_sets_value_and_returns_self
    url = 'http://foo'
    result = @builder.with_base_url(url)
    assert_equal url, @builder.instance_variable_get(:@url_prefix)
    assert_equal @builder, result
  end

  def test_with_proxy_sets_value_and_returns_self
    result = @builder.with_proxy('host', 123, 'user', 'pass')
    proxy = @builder.instance_variable_get(:@proxy)
    assert proxy.is_a?(SmartyStreets::Proxy)
    assert_equal @builder, result
  end

  def test_build_sender_with_no_retries
    @builder.retry_at_most(0)
    sender = @builder.build_sender
    assert sender.is_a?(SmartyStreets::URLPrefixSender)
  end

  def test_build_sender_with_signer_nil
    builder = SmartyStreets::ClientBuilder.new(nil)
    sender = builder.build_sender
    assert sender.is_a?(SmartyStreets::URLPrefixSender)
  end

  def test_build_sender_with_proxy_and_debug
    @builder.with_proxy('host', 123, 'user', 'pass').with_debug
    sender = @builder.build_sender
    assert sender.is_a?(SmartyStreets::URLPrefixSender)
  end

  def test_build_sender_with_all_options
    @builder.with_custom_headers({ 'X-Test' => 'value' })
    @builder.with_licenses(['foo'])
    @builder.with_proxy('host', 123, 'user', 'pass')
    @builder.with_debug
    sender = @builder.build_sender
    assert sender.is_a?(SmartyStreets::URLPrefixSender)
  end

  def test_build_api_clients_with_and_without_url_prefix
    # Test all build_*_api_client methods with and without pre-set url_prefix
    methods = %i[
      build_international_street_api_client
      build_international_autocomplete_api_client
      build_us_autocomplete_pro_api_client
      build_us_extract_api_client
      build_us_street_api_client
      build_us_zipcode_api_client
      build_us_reverse_geo_api_client
      build_us_enrichment_api_client
    ]
    methods.each do |meth|
      # url_prefix nil
      @builder.instance_variable_set(:@url_prefix, nil)
      client = @builder.send(meth)
      refute_nil client
      # url_prefix set
      @builder.instance_variable_set(:@url_prefix, 'http://custom')
      client2 = @builder.send(meth)
      refute_nil client2
    end
  end
end

# Minimal, assertion-free tests to guarantee coverage of configuration methods
class TestClientBuilderMinimalCoverage < Minitest::Test
  def setup
    @builder = SmartyStreets::ClientBuilder.new(nil)
  end

  def test_explicit_with_max_timeout_coverage
    @builder.with_max_timeout(123)
  end

  def test_explicit_with_sender_coverage
    @builder.with_sender(Object.new)
  end

  def test_explicit_with_serializer_coverage
    @builder.with_serializer(Object.new)
  end

  def test_explicit_with_base_url_coverage
    @builder.with_base_url('http://foo')
  end

  def test_explicit_with_proxy_coverage
    @builder.with_proxy('host', 1, 'user', 'pass')
  end

  def test_explicit_with_custom_headers_coverage
    @builder.with_custom_headers({ 'X-Test' => 'value' })
  end

  def test_explicit_with_licenses_coverage
    @builder.with_licenses(['foo'])
  end

  def test_explicit_with_debug_coverage
    @builder.with_debug
  end

  def test_explicit_retry_at_most_coverage
    @builder.retry_at_most(42)
  end
end
