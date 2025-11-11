require_relative '../request'
require_relative '../exceptions'
require_relative 'candidate'

module SmartyStreets
  module InternationalPostalCode
    # It is recommended to instantiate this class using ClientBuilder.build_international_postal_code_api_client
    class Client
      def initialize(sender, serializer)
        @sender = sender
        @serializer = serializer
      end

      # Sends a Lookup object to the International Postal Code API and stores the result in the Lookup's results field.
      def send_lookup(lookup)
        raise SmartyStreets::SmartyError, 'Send() must be passed a Lookup.' if lookup.nil?

        request = build_request(lookup)

        response = @sender.send(request)

        raise response.error if response.error

        candidate_hashes = @serializer.deserialize(response.payload) || []
        candidates = convert_candidates(candidate_hashes)
        lookup.results = candidates
        candidates
      end

      def build_request(lookup)
        request = SmartyStreets::Request.new

        add_parameter(request, 'input_id', lookup.input_id)
        add_parameter(request, 'country', lookup.country)
        add_parameter(request, 'locality', lookup.locality)
        add_parameter(request, 'administrative_area', lookup.administrative_area)
        add_parameter(request, 'postal_code', lookup.postal_code)

        request
      end

      def convert_candidates(candidate_hashes)
        converted = []
        return converted if candidate_hashes.nil?

        candidate_hashes.each do |obj|
          converted.push(InternationalPostalCode::Candidate.new(obj))
        end

        converted
      end

      def add_parameter(request, key, value)
        request.parameters[key] = value unless value.nil? or value.empty?
      end
    end
  end
end


