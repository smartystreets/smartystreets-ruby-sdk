require_relative '../test_helper'
require 'minitest/autorun'
require_relative '../../lib/smartystreets_ruby_sdk/json_able'

class DummyJson < SmartyStreets::JSONAble
  attr_accessor :foo, :bar
  def initialize(foo = nil, bar = nil)
    @foo = foo
    @bar = bar
  end
end

class EmptyJson < SmartyStreets::JSONAble; end

class TestJSONAble < Minitest::Test
  def test_to_json_and_from_json_roundtrip
    obj = DummyJson.new('hello', 42)
    json = obj.to_json
    new_obj = DummyJson.new
    new_obj.from_json!(json)
    assert_equal 'hello', new_obj.foo
    assert_equal 42, new_obj.bar
  end

  def test_to_json_with_nil_values
    obj = DummyJson.new(nil, nil)
    json = obj.to_json
    assert_includes json, '"foo":null'
    assert_includes json, '"bar":null'
  end

  def test_from_json_with_extra_fields
    obj = DummyJson.new
    json = '{"foo":"abc","bar":123,"baz":999}'
    obj.from_json!(json)
    assert_equal 'abc', obj.foo
    assert_equal 123, obj.bar
    assert_equal 999, obj.instance_variable_get(:@baz)
  end

  def test_from_json_with_empty_string
    obj = DummyJson.new
    assert_raises(ArgumentError) { obj.from_json!("") }
  end

  def test_to_json_with_no_instance_variables
    obj = EmptyJson.new
    json = obj.to_json
    assert_equal '{}', json
  end
end 