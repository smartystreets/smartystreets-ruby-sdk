require 'minitest/autorun'
require_relative '../../../lib/smartystreets_ruby_sdk/international_street/language_mode'
require_relative '../../../lib/smartystreets_ruby_sdk/exceptions'

class TestLanguageMode < Minitest::Test
  LanguageMode = SmartyStreets::InternationalStreet::LanguageMode

  def test_from_value_resolves_mixed_case
    assert_equal(LanguageMode::LATIN, LanguageMode.from_value('Latin'))
    assert_equal(LanguageMode::NATIVE, LanguageMode.from_value('NATIVE'))
    assert_equal(LanguageMode::LATIN, LanguageMode.from_value('latin'))
  end

  def test_from_value_returns_language_mode_instance_unchanged
    assert_equal(LanguageMode::NATIVE, LanguageMode.from_value(LanguageMode::NATIVE))
  end

  def test_from_value_rejects_invalid_value
    assert_raises SmartyStreets::UnprocessableEntityError do
      LanguageMode.from_value('Klingon')
    end
  end

  def test_values_are_lowercase
    assert_equal('native', LanguageMode::NATIVE.value)
    assert_equal('latin', LanguageMode::LATIN.value)
  end
end
