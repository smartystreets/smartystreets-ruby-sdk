module SmartyStreets
  module InternationalPostalCode
    # Holds the input data for a postal code lookup and the results returned by the API.
    # See https://smartystreets.com/docs/cloud/international-postal-code-api
    #
    # @language:: When not set, results are returned using the Latin character set.
    #     When set to language_mode.NATIVE (JPN only), results are returned in the native character set for that country.
    #     When set to language_mode.LATIN, results use the Latin character set with accents and other diacritics removed.
    # @max_results:: Optional. The maximum number of candidates to return. Omitted from the request when unset or 0.
    class Lookup

      attr_accessor :input_id, :country, :locality, :administrative_area, :postal_code, :language, :max_results,
                    :results

      def initialize
        @input_id = nil
        @country = nil
        @locality = nil
        @administrative_area = nil
        @postal_code = nil
        @language = nil
        @max_results = nil
        @results = []
      end
    end
  end
end


