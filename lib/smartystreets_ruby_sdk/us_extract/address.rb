require_relative '../us_street/candidate'

module SmartyStreets
  module USExtract
    # See "https://smartystreets.com/docs/cloud/us-extract-api#http-response-status"
    class Address
      attr_reader :text, :start, :verified, :end, :line, :candidates

      def initialize(obj)
        @text = obj['text']
        @verified = obj['verified']
        @line = obj['line']
        @start = obj['start']
        @end = obj['end']
        candidates = obj.fetch('api_output', [])
        @candidates = []

        candidates.each {|candidate|
          @candidates.push(USStreet::Candidate.new(candidate))
        }
      end
    end
  end
end
