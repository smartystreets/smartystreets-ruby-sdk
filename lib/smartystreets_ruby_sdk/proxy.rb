module SmartyStreets
  # Contains information about the proxy through which all requests will be sent.
  #
  # host should not include a scheme
  class Proxy

    attr_accessor :port, :host, :username, :password

    def initialize(host, port, username = nil, password = nil)
      @host = host
      @port = port
      @username = username
      @password = password
    end
  end
end
