module SmartyStreets
  class SigningSender
    def initialize(signer, inner)
      @signer = signer
      @inner = inner
    end

    def send(request)
      @signer.sign(request)
      @inner.send(request)
    end
  end
end
