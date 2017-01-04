class ClientBuilder < CoreClientBuilder
  def initialize
    super
    @url_prefix = 'https://us-street.api.smartystreets.com/street-address'
  end
end