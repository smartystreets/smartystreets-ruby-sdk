require_relative '../request'
require_relative 'us_reverse_geo_response'

module SmartyStreets
  module USReverseGeo
    # It is recommended to instantiate this class using ClientBuilder.build_us_reverse_geo_api_client()
    class Client
      def initialize(sender, serializer)
        @sender = sender
        @serializer = serializer
      end

      # Sends a Lookup object to the US Reverse Geo API and stores the result in the Lookup's response field.
      def send(lookup)
        send_with_auth(lookup, nil, nil)
      end

      # Sends a Lookup object with per-request credentials to the US Reverse Geo API and stores the result in the Lookup's response field.
      # If auth_id and auth_token are both non-empty, they will be used for this request instead of the client-level credentials.
      # This is useful for multi-tenant scenarios where different requests require different credentials.
      def send_with_auth(lookup, auth_id, auth_token)
        request = build_request(lookup)

        if !auth_id.nil? && !auth_id.empty? && !auth_token.nil? && !auth_token.empty?
          request.auth_id = auth_id
          request.auth_token = auth_token
        end

        response = @sender.send(request)

        raise response.error if response.error

        lookup.response = Response.new(@serializer.deserialize(response.payload))
      end

      def build_request(lookup)
        request = SmartyStreets::Request.new

        add_parameter(request, 'latitude', lookup.latitude)
        add_parameter(request, 'longitude', lookup.longitude)
        add_parameter(request, 'source', lookup.source)

        for key in lookup.custom_param_hash.keys do
          add_parameter(request, key, lookup.custom_param_hash[key])
        end

        request
      end

      def add_parameter(request, key, value)
        request.parameters[key] = value unless value.nil? or value.empty?
      end
    end
  end
end
