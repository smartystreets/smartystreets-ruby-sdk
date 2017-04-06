module USExtract
  # See "https://smartystreets.com/docs/cloud/us-extract-api#http-response-status"
  class Metadata
    def initialize(obj)
      @lines = obj['lines']
      @unicode = obj['unicode']
      @address_count = obj['address_count']
      @verified_count = obj['verified_count']
      @bytes = obj['bytes']
      @character_count = obj['character_count']
    end
  end
end
