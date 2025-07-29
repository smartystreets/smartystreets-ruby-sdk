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
      parsed = JSON.parse(string)
      parsed.each do |var, val|
        # Only allow setting instance variables that already exist on this object
        # This prevents arbitrary code execution while maintaining functionality
        var_name = var.to_s.start_with?('@') ? var : "@#{var}"
        if instance_variables.include?(var_name.to_sym)
          instance_variable_set var_name, val
        end
      end
    end
  end
end
