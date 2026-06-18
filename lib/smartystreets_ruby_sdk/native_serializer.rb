require 'json'

module SmartyStreets
  class NativeSerializer
    def serialize(obj)
      obj.to_json
    end

    def deserialize(payload)
      return {} if payload.nil? || payload.empty?
      JSON.load(payload)
    end
  end
end
