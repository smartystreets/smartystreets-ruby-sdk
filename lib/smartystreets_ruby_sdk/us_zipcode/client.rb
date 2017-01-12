require_relative 'result'
require_relative '../batch'
require_relative '../request'

module USZipcode
  class Client
    def initialize(sender, serializer)
      @sender = sender
      @serializer = serializer
    end

    def send_lookup(lookup)
      batch = Batch.new
      batch.add(lookup)
      send_batch(batch)
    end

    def send_batch(batch)
      smarty_request = Request.new

      return if batch.size == 0

      converted_lookups = remap_keys(batch.all_lookups)
      smarty_request.payload = @serializer.serialize(converted_lookups)

      response = @sender.send(smarty_request)

      raise response.error if response.error

      results = @serializer.deserialize(response.payload)
      results = [] if results == nil
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

        converted_lookup['city'] = lookup.city
        converted_lookup['state'] = lookup.state
        converted_lookup['zipcode'] = lookup.zipcode

        converted_obj.push(converted_lookup)
      end

      converted_obj
    end
  end
end
