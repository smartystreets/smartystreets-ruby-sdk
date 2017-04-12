require_relative '../request'
require_relative '../exceptions'

module USExtract
  # It is recommended to instantiate this class using ClientBuilder.build_us_extract_api_client()
  class Client
    def initialize(sender, serializer)
      @sender = sender
      @serializer = serializer
    end

    # Sends a Lookup object to the US Extract Code API and stores the result in the Lookup's result field.
    # It also returns the result directly.
    def send(lookup)
      if lookup.nil? or lookup.text.nil? or not lookup.text.is_a? String or lookup.text.empty?
        raise SmartyException.new('Client.send() requires a Lookup with the "text" field set')
      end

      request = build_request(lookup)
      response = @sender.send(request)
      result = Result.new(@serializer.deserialize(response.payload))

      lookup.result = result
    end

    def build_request(lookup)
      request = Request.new
      request.content_type = 'text/plain'
      request.payload = lookup.text

      add_parameter(request, 'html', lookup.html.to_s)
      add_parameter(request, 'aggressive', lookup.aggressive.to_s)
      add_parameter(request, 'addr_line_breaks', lookup.addresses_have_line_breaks.to_s)
      add_parameter(request, 'addr_per_line', lookup.addresses_per_line.to_s)

      request
    end

    def add_parameter(request, key, value)
      if value and not value.empty?
        request.parameters[key] = value
      end
    end
  end
end