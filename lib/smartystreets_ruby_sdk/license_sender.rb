module SmartyStreets
  class LicenseSender
    def initialize(inner, licenses)
      @inner = inner
      @licenses = licenses
    end

    def send(request)
      if @licenses.length > 0
        request.parameters['license'] = @licenses.join(',')
      end
      @inner.send(request)
    end
  end
end
