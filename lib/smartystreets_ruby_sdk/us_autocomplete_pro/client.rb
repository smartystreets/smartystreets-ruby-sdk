# frozen_string_literal: true

require_relative '../request'
require_relative '../exceptions'
require_relative 'geolocation_type'
require_relative 'suggestion'

module SmartyStreets
  module USAutocompletePro
    # It is recommended to instantiate this class using ClientBuilder.build_us_autocomplete_pro_api_client
    class Client
      def initialize(sender, serializer)
        @sender = sender
        @serializer = serializer
      end

      # Sends a Lookup object to the US Autocomplete Pro API and stores the result in the Lookup's result field.
      def send(lookup)
        if !lookup || !lookup.search
          raise SmartyStreets::SmartyError, 'Send() must be passed a Lookup with the prefix field set.'
        end

        request = build_request(lookup)

        response = @sender.send(request)

        raise response.error if response.error

        result = @serializer.deserialize(response.payload)
        suggestions = convert_suggestions(result.fetch('suggestions', []))
        lookup.result = suggestions
      end

      def build_request(lookup)
        request = Request.new

        add_parameter(request, 'search', lookup.search)
        add_parameter(request, 'max_results', lookup.max_results.to_s)
        add_parameter(request, 'include_only_cities', build_filter_string(lookup.city_filter))
        add_parameter(request, 'include_only_states', build_filter_string(lookup.state_filter))
        add_parameter(request, 'include_only_zip_codes', build_filter_string(lookup.zip_filter))
        add_parameter(request, 'exclude_states', build_filter_string(lookup.exclude_states))
        add_parameter(request, 'prefer_cities', build_filter_string(lookup.prefer_cities))
        add_parameter(request, 'prefer_states', build_filter_string(lookup.prefer_states))
        add_parameter(request, 'prefer_zip_codes', build_filter_string(lookup.prefer_zip_codes))
        add_parameter(request, 'prefer_ratio', lookup.prefer_ratio.to_s)
        add_parameter(request, 'source', lookup.source)
        if (lookup.prefer_zip_codes && lookup.prefer_zip_codes.any?) || (lookup.zip_filter && lookup.zip_filter.any?)
          request.parameters['prefer_geolocation'] = GeolocationType::NONE
        else
          add_parameter(request, 'prefer_geolocation', lookup.prefer_geolocation)
        end
        add_parameter(request, 'selected', lookup.selected)

        lookup.custom_param_hash.each_key do |key|
          add_parameter(request, key, lookup.custom_param_hash[key])
        end

        request
      end

      def build_filter_string(filter_list)
        filter_list&.join(';')
      end

      def convert_suggestions(suggestion_hashes)
        converted_suggestions = []
        return converted_suggestions if suggestion_hashes.nil?

        suggestion_hashes.each do |suggestion|
          converted_suggestions.push(USAutocompletePro::Suggestion.new(suggestion))
        end

        converted_suggestions
      end

      def add_parameter(request, key, value)
        request.parameters[key] = value unless value.nil? || value.empty?
      end
    end
  end
end
