require_relative 'result'
require_relative '../batch'
require_relative '../request'

module SmartyStreets
  module USZipcode
    # It is recommended to instantiate this class using ClientBuilder.build_us_zipcode_api_client.
    class Client
      def initialize(sender, serializer)
        @sender = sender
        @serializer = serializer
      end

      # Sends a Lookup object to the US ZIP Code API and stores the result in the Lookup's result field.
      def send_lookup(lookup)
        batch = Batch.new
        batch.add(lookup)
        send_batch(batch)
      end

      # Sends a Batch object containing no more than 100 Lookup objects to the US ZIP Code API and stores the
      # results in the result field of the Lookup object.
      def send_batch(batch)
        smarty_request = Request.new

        return if batch.empty?

        converted_lookups = remap_keys(batch.all_lookups)

        if batch.size > 1
          smarty_request.payload = @serializer.serialize(converted_lookups)
        else
          smarty_request.parameters = converted_lookups[0]
        end

        response = @sender.send(smarty_request)

        raise response.error if response.error

        results = @serializer.deserialize(response.payload)
        results = [] if results.nil?
        assign_results_to_lookups(batch, results)
      end

      def assign_results_to_lookups(batch, results)
        results.each do |raw_result|
          result = Result.new(raw_result)
          batch[result.input_index].result = result
        end
      end

      def remap_keys(obj)
        converted_obj = []
        obj.each do |lookup|
          converted_lookup = {}

          add_field(converted_lookup, 'city', lookup.city)
          add_field(converted_lookup, 'state', lookup.state)
          add_field(converted_lookup, 'zipcode', lookup.zipcode)

          for key in lookup.custom_param_hash.keys do
            add_field(converted_lookup, key, lookup.custom_param_hash[key])
          end

          converted_obj.push(converted_lookup)
        end

        converted_obj
      end

      def add_field(converted_lookup, key, value)
        converted_lookup[key] = value unless value.nil? or value.empty?
      end
    end
  end
end
