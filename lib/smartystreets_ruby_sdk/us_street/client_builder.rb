require_relative '../core_client_builder'
require_relative 'client'

class ClientBuilder < CoreClientBuilder
  def initialize(signer)
    super(signer)
    @url_prefix = 'https://us-street.api.smartystreets.com/street-address'
  end

  def build
    Client.new(build_sender, @serializer)
  end
end