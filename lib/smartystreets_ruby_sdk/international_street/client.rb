require_relative '../request'
require_relative 'candidate'

module SmartyStreets
  module InternationalStreet
    # It is recommended to instantiate this class using ClientBuilder.build_international_street_api_client()
    class Client
      def initialize(sender, serializer)
        @sender = sender
        @serializer = serializer
      end

      # Sends a Lookup object to the International Street API and stores the result in the Lookup's result field.
      # Deprecated, please use send_lookup instead.
      def send(lookup)
        lookup.ensure_enough_info
        request = build_request(lookup)

        response = @sender.send(request)

        raise response.error if response.error

        candidates = convert_candidates(@serializer.deserialize(response.payload))
        lookup.result = candidates
      end

      # Sends a Lookup object to the International Street API and stores the result in the Lookup's result field.
      def send_lookup(lookup)
        lookup.ensure_enough_info
        request = build_request(lookup)

        response = @sender.send(request)

        raise response.error if response.error

        candidates = convert_candidates(@serializer.deserialize(response.payload))
        lookup.result = candidates
      end

      def build_request(lookup)
        request = SmartyStreets::Request.new

        add_parameter(request, 'input_id', lookup.input_id)
        add_parameter(request, 'country', lookup.country)
        add_parameter(request, 'geocode', lookup.geocode.to_s)
        add_parameter(request, 'language', lookup.language)
        add_parameter(request, 'freeform', lookup.freeform)
        add_parameter(request, 'address1', lookup.address1)
        add_parameter(request, 'address2', lookup.address2)
        add_parameter(request, 'address3', lookup.address3)
        add_parameter(request, 'address4', lookup.address4)
        add_parameter(request, 'organization', lookup.organization)
        add_parameter(request, 'locality', lookup.locality)
        add_parameter(request, 'administrative_area', lookup.administrative_area)
        add_parameter(request, 'postal_code', lookup.postal_code)

        request
      end

      def add_parameter(request, key, value)
        request.parameters[key] = value unless value.nil? or value.empty?
      end

      def convert_candidates(raw_candidates)
        candidates = []

        unless raw_candidates.nil?
          raw_candidates.each do |candidate|
            candidates.push(Candidate.new(candidate))
          end
        end

        candidates
      end
    end
  end
end
