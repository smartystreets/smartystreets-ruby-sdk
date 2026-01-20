require_relative '../request'
require_relative '../exceptions'
require_relative 'result'
require_relative '../us_street/match_type'


module SmartyStreets
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
        send_with_auth(lookup, nil, nil)
      end

      # Sends a Lookup object with per-request credentials to the US Extract API and stores the result in the Lookup's result field.
      # If auth_id and auth_token are both non-empty, they will be used for this request instead of the client-level credentials.
      # This is useful for multi-tenant scenarios where different requests require different credentials.
      def send_with_auth(lookup, auth_id, auth_token)
        if lookup.nil? or lookup.text.nil? or not lookup.text.is_a? String or lookup.text.empty?
          raise SmartyError, 'Client.send() requires a Lookup with the "text" field set'
        end

        request = build_request(lookup)

        if !auth_id.nil? && !auth_id.empty? && !auth_token.nil? && !auth_token.empty?
          request.auth_id = auth_id
          request.auth_token = auth_token
        end

        response = @sender.send(request)
        raise response.error if response.error
        result = USExtract::Result.new(@serializer.deserialize(response.payload))

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
        if lookup.match !=  SmartyStreets::USStreet::MatchType::STRICT && lookup.match != nil
          add_parameter(request, 'match', lookup.match)
        end

        for key in lookup.custom_param_hash.keys do
          add_parameter(request, key, lookup.custom_param_hash[key])
        end

        request
      end

      def add_parameter(request, key, value)
        if value and not value.empty?
          request.parameters[key] = value
        end
      end
    end
  end
end
