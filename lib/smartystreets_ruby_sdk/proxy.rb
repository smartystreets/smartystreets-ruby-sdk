module SmartystreetsRubySdk
  # Contains information about the proxy through which all requests will be sent.
  #
  # host should not include a scheme
  class Proxy

    attr_reader :port, :host

    def initialize(host, port)
      @host = host
      @port = port
    end
  end
end