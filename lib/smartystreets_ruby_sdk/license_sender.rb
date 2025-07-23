# frozen_string_literal: true

module SmartyStreets
  class LicenseSender
    def initialize(inner, licenses)
      @inner = inner
      @licenses = licenses
    end

    def send(request)
      request.parameters['license'] = @licenses.join(',') if @licenses.length.positive?
      @inner.send(request)
    end
  end
end
