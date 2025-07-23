# frozen_string_literal: true

require 'json'

module SmartyStreets
  class NativeSerializer
    def serialize(obj)
      obj.to_json
    end

    def deserialize(payload)
      JSON.parse(payload)
    end
  end
end
