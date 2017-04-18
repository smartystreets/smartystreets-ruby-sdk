module InternationalStreet
  # In addition to holding all of the input data for this lookup, this class also will contain the
  # result of the lookup after it comes back from the API.
  #
  # Note: Lookups must have certain required fields set with non-blank values.
  # These can be found at the URL below.
  #
  # See "https://smartystreets.com/docs/cloud/international-street-api#http-input-fields"
  #
  # @geocode:: Disabled by default. Set to true to enable.
  # @language:: When not set, the output language will match the language of the input values.
  #     When set to language_mode.NATIVE, the results will always be in the language of the output country.
  #     When set to language_mode.LATIN, the results will always be provided using a Latin character set.
  class Lookup
    def initialize(freeform=nil, country=nil)
      @result = []

      @inputId = nil
      @country = country
      @geocode = nil
      @language = nil
      @freeform = freeform
      @address1 = nil
      @address2 = nil
      @address3 = nil
      @address4 = nil
      @organization = nil
      @locality = nil
      @administrative_area = nil
      @postal_code = nil
    end
  end
end