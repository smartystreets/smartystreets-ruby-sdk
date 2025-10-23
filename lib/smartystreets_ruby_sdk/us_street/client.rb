require_relative '../batch'
require_relative '../request'
require_relative 'candidate'

module SmartyStreets
  module USStreet
    # It is recommended to instantiate this class using ClientBuilder.build_us_street_api_client
    class Client
      def initialize(sender, serializer)
        @sender = sender
        @serializer = serializer
      end

      # Sends a Lookup object to the US Street API and stores the result in the Lookup's result field.
      def send_lookup(lookup)
        batch = SmartyStreets::Batch.new
        batch.add(lookup)
        send_batch(batch)
      end

      # Sends a Batch object containing no more than 100 Lookup objects to the US Street API and stores the
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

        candidates = @serializer.deserialize(response.payload)
        candidates = [] if candidates.nil?

        assign_candidates_to_lookups(batch, candidates)
      end

      def remap_keys(obj)
        converted_obj = []
        obj.each do |lookup|
          converted_lookup = {}
          lookup.candidates = 5 if lookup.match == "enhanced" && lookup.candidates == 0

          converted_lookup['input_id'] = lookup.input_id
          converted_lookup['street'] = lookup.street
          converted_lookup['street2'] = lookup.street2
          converted_lookup['secondary'] = lookup.secondary
          converted_lookup['city'] = lookup.city
          converted_lookup['state'] = lookup.state
          converted_lookup['zipcode'] = lookup.zipcode
          converted_lookup['lastline'] = lookup.lastline
          converted_lookup['addressee'] = lookup.addressee
          converted_lookup['urbanization'] = lookup.urbanization
          converted_lookup['match'] = lookup.match
          converted_lookup['candidates'] = lookup.candidates
          converted_lookup['format'] = lookup.format
          converted_lookup['county_source'] = lookup.county_source

          for key in lookup.custom_param_hash.keys do
            converted_lookup[key] = lookup.custom_param_hash[key]
          end

          converted_obj.push(converted_lookup)
        end
        converted_obj
      end

      def assign_candidates_to_lookups(batch, candidates)
        candidates.each do |raw_candidate|
          candidate = Candidate.new(raw_candidate)
          batch[candidate.input_index].result.push(candidate)
        end
      end
    end
  end
end
