require_relative '../../test_helper'
require 'smartystreets_ruby_sdk/us_street/analysis'

module SmartyStreets
  module USStreet
    class TestAnalysis < Minitest::Test
      def test_attribute_assignment
        sample = {
          'dpv_match_code' => 'Y',
          'dpv_footnotes' => 'AABB',
          'dpv_cmra' => 'N',
          'dpv_vacant' => 'N',
          'dpv_no_stat' => 'N',
          'active' => true,
          'ews_match' => false,
          'footnotes' => 'FOOT',
          'lacslink_code' => 'L',
          'lacslink_indicator' => 'I',
          'suitelink_match' => true,
          'enhanced_match' => false
        }
        a = Analysis.new(sample)
        assert_equal 'Y', a.dpv_match_code
        assert_equal 'AABB', a.dpv_footnotes
        assert_equal 'N', a.cmra
        assert_equal 'N', a.vacant
        assert_equal 'N', a.no_stat
        assert_equal true, a.active
        assert_equal false, a.is_ews_match
        assert_equal 'FOOT', a.footnotes
        assert_equal 'L', a.lacs_link_code
        assert_equal 'I', a.lacs_link_indicator
        assert_equal true, a.is_suite_link_match
        assert_equal false, a.enhanced_match
      end

      def test_missing_keys_are_nil
        a = Analysis.new({})
        assert_nil a.dpv_match_code
        assert_nil a.active
      end
    end
  end
end
