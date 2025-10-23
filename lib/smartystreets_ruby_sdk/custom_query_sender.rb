module SmartyStreets
  class CustomQuerySender
    def initialize(inner, queries)
      @inner = inner
      @queries = queries
    end

    def send(request)
      request.parameters.merge!(@queries)
      @inner.send(request)
    end
  end
end
