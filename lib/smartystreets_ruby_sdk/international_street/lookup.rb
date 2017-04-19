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

    attr_accessor :freeform, :locality, :postal_code, :address3, :address2, :inputId, :address1,
                  :geocode, :administrative_area, :country, :organization, :language, :address4, :result

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

    def missing_country
      field_is_missing(@country)
    end

    def has_freeform
      field_is_set(@freeform)
    end

    def missing_address1
      field_is_missing(@address1)
    end

    def has_postal_code
      field_is_set(@postal_code)
    end

    def missing_locality_or_administrative_area
      field_is_missing(@locality) or field_is_missing(@administrative_area)
    end

    def field_is_missing(field)
      field.nil? or field.empty?
    end

    def field_is_set(field)
      not field_is_missing(field)
    end

    def ensure_enough_info
      raise UnprocessableEntityError, 'Country field is required.' if missing_country

      return true if has_freeform

      raise UnprocessableEntityError, 'Either freeform or address1 is required.' if missing_address1

      return true if has_postal_code

      if missing_locality_or_administrative_area
        raise UnprocessableEntityError, 'Insufficient information:'\
              'One or more required fields were not set on the lookup.'
      end
    end
  end
end