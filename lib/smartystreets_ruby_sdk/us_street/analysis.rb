module USStreet
  class Analysis
    attr_reader :lacs_link_code, :active, :footnotes, :lacs_link_indicator, :dpv_match_code, :is_suite_link_match,
                :is_ews_match, :dpv_footnotes, :cmra, :vacant

    def initialize(obj)
      @dpv_match_code = obj['dpv_match_code']
      @dpv_footnotes = obj['dpv_footnotes']
      @cmra = obj['dpv_cmra']
      @vacant = obj['dpv_vacant']
      @active = obj['active']
      @is_ews_match = obj['ews_match']
      @footnotes = obj['footnotes']
      @lacs_link_code = obj['lacslink_code']
      @lacs_link_indicator = obj['lacslink_indicator']
      @is_suite_link_match = obj['suitelink_match']
    end
  end
end