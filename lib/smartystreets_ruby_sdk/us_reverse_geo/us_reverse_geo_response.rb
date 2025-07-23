# frozen_string_literal: true

require_relative 'result'

module SmartyStreets
  module USReverseGeo
    class Response
      attr_reader :results

      def initialize(obj)
        @results = []

        obj['results'].each do |result|
          @results.push(Result.new(result))
        end
      end
    end
  end
end
