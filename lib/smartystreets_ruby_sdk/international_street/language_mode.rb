require_relative '../exceptions'

module SmartyStreets
  module InternationalStreet
    # A closed set of valid Language values, the closest Ruby equivalent to an enum: a fixed set of frozen
    # instances rather than an arbitrary string.
    class LanguageMode < Data.define(:value)
      NATIVE = new('native')
      LATIN = new('latin')

      ALL = [NATIVE, LATIN].freeze

      # Resolves a LanguageMode instance or a raw value (eg. from user input or config) into a LanguageMode,
      # matching 'native'/'latin' regardless of case.
      def self.from_value(value)
        return value if value.is_a?(LanguageMode)

        match = ALL.find { |mode| mode.value.casecmp?(value.to_s) }
        raise SmartyStreets::UnprocessableEntityError,
              "invalid Language value; must be unset, 'native', or 'latin' (case-insensitive)" if match.nil?

        match
      end
    end
  end
end
