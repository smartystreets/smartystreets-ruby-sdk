module SmartyStreets
  class Response
    attr_accessor :payload, :status_code, :header, :error

    def initialize(payload, status_code, header = nil, error = nil)
      @payload = payload
      @status_code = status_code
      @header = header
      @error = error
    end

    # Case-insensitive lookup that works on both plain Hash (used by mocks)
    # and Net::HTTPResponse (returned by the live HTTP transport, which
    # exposes each_header but not each_pair).
    def find_header(name)
      return nil if @header.nil?
      target = name.to_s.downcase
      iterator = @header.respond_to?(:each_header) ? :each_header : :each_pair
      @header.send(iterator) do |k, v|
        return v if k.to_s.downcase == target
      end
      nil
    end
  end
end
