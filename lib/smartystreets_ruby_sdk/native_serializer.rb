require 'json'

module SmartyStreets
  class NativeSerializer
    def serialize(obj)
      obj.to_json
    end

    def deserialize(payload)
      JSON.load(payload)
    end
  end
end
