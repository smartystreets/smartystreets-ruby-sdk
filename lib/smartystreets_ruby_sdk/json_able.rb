require 'json'

module Smartystreets
  class JSONAble
    def to_json(options={})
      hash = {}
      self.instance_variables.each do |var|
        hash[var.to_s.delete('@')] = self.instance_variable_get var
      end
      hash.to_json
    end

    def from_json!(string)
      JSON.load(string).each do |var, val|
        self.instance_variable_set var, val
      end
    end
  end
end
