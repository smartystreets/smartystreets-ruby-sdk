require_relative 'exceptions'

module SmartyStreets
  # Shared handling for the max_results input: accepts a whole number (or a string holding one),
  # and returns it as a string only when it is above 0, so it can be sent as a query parameter.
  # Unset (nil or blank) returns nil; anything that isn't a whole number raises.
  module MaxResults
    WHOLE_NUMBER = /\A\s*[+-]?\d+\s*\z/

    def self.normalize(value)
      return nil if value.nil? || (value.is_a?(String) && value.strip.empty?)

      number = case value
               when Integer then value
               when Float then value.to_i if value.finite? && value == value.floor
               when String then value.to_i if value.match?(WHOLE_NUMBER)
               end
      raise SmartyStreets::UnprocessableEntityError, 'invalid max_results value; must be a whole number' if number.nil?

      number.positive? ? number.to_s : nil
    end
  end
end
