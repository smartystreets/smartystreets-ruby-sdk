require_relative '../request'
require_relative '../exceptions'
require_relative 'geolocation_type'
require_relative 'suggestion'

module SmartyStreets
  module USAutocomplete
    # It is recommended to instantiate this class using ClientBuilder.build_us_autocomplete_api_client
    class Client
      def initialize(sender, serializer)
        @sender = sender
        @serializer = serializer
      end

      # Sends a Lookup object to the US Autocomplete API and stores the result in the Lookup's result field.
      def send(lookup)
        if not lookup or not lookup.prefix
          raise SmartyStreets::SmartyError, 'Send() must be passed a Lookup with the prefix field set.'
        end

        request = build_request(lookup)

        response = @sender.send(request)

        result = @serializer.deserialize(response.payload)
        suggestions = convert_suggestions(result.fetch('suggestions', []))
        lookup.result = suggestions
      end


      def build_request(lookup)
        request = Request.new

        add_parameter(request, 'prefix', lookup.prefix)
        add_parameter(request, 'suggestions', lookup.max_suggestions.to_s)
        add_parameter(request, 'city_filter', build_filter_string(lookup.city_filter))
        add_parameter(request, 'state_filter', build_filter_string(lookup.state_filter))
        add_parameter(request, 'prefer', build_filter_string(lookup.prefer))
        add_parameter(request, 'prefer_ratio', lookup.prefer_ratio.to_s)
        if lookup.geolocate_type != GeolocationType::NONE
          request.parameters['geolocate'] = 'true'
          request.parameters['geolocate_precision'] = lookup.geolocate_type
        else
          request.parameters['geolocate'] = 'false'
        end

        request
      end

      def build_filter_string(filter_list)
        filter_list ? filter_list.join(',') : nil
      end

      def convert_suggestions(suggestion_hashes)
        converted_suggestions = []
        return converted_suggestions if suggestion_hashes.nil?

        suggestion_hashes.each do |suggestion|
          converted_suggestions.push(USAutocomplete::Suggestion.new(suggestion))
        end

        converted_suggestions
      end

      def add_parameter(request, key, value)
        request.parameters[key] = value unless value.nil? or value.empty?
      end
    end
  end
end
