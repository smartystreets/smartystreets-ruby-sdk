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
    smartyrequest = Request.new

    return if batch.size == 0

    converted_lookups = remap_keys(batch.all_lookups)
    smartyrequest.payload = @serializer.serialize(converted_lookups)

    response = @sender.send(smartyrequest)

    raise response.error if response.error

    candidates = @serializer.deserialize(response.payload)
    candidates = [] if candidates == nil

    assign_candidates_to_lookups(batch, candidates)
  end

  def remap_keys(obj)
    converted_obj = []
    obj.each { |lookup|
      converted_lookup = {}

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

      converted_obj.push(converted_lookup)
    }
      converted_obj
  end

  def assign_candidates_to_lookups(batch, candidates)
    candidates.each { |raw_candidate|
        candidate = Candidate.new(raw_candidate)
    batch.get_by_index(candidate.input_index).result.push(candidate)
    }
  end
end