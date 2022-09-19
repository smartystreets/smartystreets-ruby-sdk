module SmartyStreets
  class Response
    attr_accessor :payload, :status_code, :header, :error

    def initialize(payload, status_code, header = nil, error = nil)
      @payload = payload
      @status_code = status_code
      @header = header
      @error = error
    end
  end
end
