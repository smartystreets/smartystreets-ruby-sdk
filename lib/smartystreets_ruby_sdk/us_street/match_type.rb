module SmartyStreets
  module USStreet
    module MatchType
      STRICT = 'strict'.freeze
      RANGE = 'range'.freeze # Deprecated
      INVALID = 'invalid'.freeze
      ENHANCED = 'enhanced'.freeze
    end

    module OutputFormat
      DEFAULT = 'default'.freeze
      PROJECT_USA = 'project-usa'.freeze
      CASS = 'cass'.freeze
    end
  end
end
