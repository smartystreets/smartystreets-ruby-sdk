require 'json'

module SmartyStreets
  class JSONAble
    def to_json(options={})
      hash = {}
      instance_variables.each do |var|
        hash[var.to_s.delete('@')] = instance_variable_get var
      end
      hash.to_json
    end

    def from_json!(string)
      raise ArgumentError, 'Input JSON string cannot be empty or nil' if string.nil? || string.strip.empty?
      JSON.load(string).each do |var, val|
        instance_variable_set("@#{var}", val)
      end
    end
  end
end
