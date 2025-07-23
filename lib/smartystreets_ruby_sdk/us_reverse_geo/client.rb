# frozen_string_literal: true

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
        request = build_request(lookup)

        response = @sender.send(request)

        raise response.error if response.error

        lookup.response = Response.new(@serializer.deserialize(response.payload))
      end

      def build_request(lookup)
        request = SmartyStreets::Request.new

        add_parameter(request, 'latitude', lookup.latitude)
        add_parameter(request, 'longitude', lookup.longitude)
        add_parameter(request, 'source', lookup.source)

        lookup.custom_param_hash.each_key do |key|
          add_parameter(request, key, lookup.custom_param_hash[key])
        end

        request
      end

      def add_parameter(request, key, value)
        request.parameters[key] = value unless value.nil? || value.empty?
      end
    end
  end
end
