require 'json'

class StandardSerializer
  def serialize(obj)
    obj.to_json
  end

  def deserialize(payload)
    JSON.load(payload)
  end
end