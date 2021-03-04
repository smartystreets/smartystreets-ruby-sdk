module SmartyStreets
  module USStreet
    # See "https://smartystreets.com/docs/cloud/us-street-api#analysis"
    class Analysis
      attr_reader :lacs_link_code, :active, :footnotes, :lacs_link_indicator, :dpv_match_code, :is_suite_link_match,
                  :is_ews_match, :dpv_footnotes, :cmra, :vacant, :no_stat

      def initialize(obj)
        @dpv_match_code = obj['dpv_match_code']
        @dpv_footnotes = obj['dpv_footnotes']
        @cmra = obj['dpv_cmra']
        @vacant = obj['dpv_vacant']
        @no_stat = obj['dpv_no_stat']
        @active = obj['active']
        @is_ews_match = obj['ews_match']
        @footnotes = obj['footnotes']
        @lacs_link_code = obj['lacslink_code']
        @lacs_link_indicator = obj['lacslink_indicator']
        @is_suite_link_match = obj['suitelink_match']
      end
    end
  end
end
