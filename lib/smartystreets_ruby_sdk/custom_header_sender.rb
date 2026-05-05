module SmartyStreets
  class CustomHeaderSender
    def initialize(inner, header, append_headers = {})
      @inner = inner
      @header = header
      @append_headers = append_headers || {}
    end

    def send(request)
      apply_headers.each { |key, value| request.header[key] = value }
      @inner.send(request)
    end

    def apply_headers
      result = {}
      @header.each do |key, values|
        if @append_headers.key?(key)
          separator = @append_headers[key]
          result[key] = values.respond_to?(:join) ? values.join(separator) : values.to_s
        else
          result[key] = values.dup
        end
      end
      result
    end
  end
end
