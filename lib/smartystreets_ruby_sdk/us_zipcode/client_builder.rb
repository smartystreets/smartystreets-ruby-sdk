require_relative '../core_client_builder'
require_relative 'client'

module USZipcode
  class ClientBuilder < CoreClientBuilder
    def initialize(signer)
      super(signer)
      @url_prefix = 'https://us-zipcode.api.smartystreets.com/lookup'
    end

    def build
      Client.new(build_sender, @serializer)
    end
  end
end