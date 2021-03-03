require_relative 'native_serializer'
require_relative 'native_sender'
require_relative 'status_code_sender'
require_relative 'signing_sender'
require_relative 'retry_sender'
require_relative 'url_prefix_sender'
require_relative 'license_sender'
require_relative 'sleeper'
require_relative 'logger'
require_relative 'proxy'
require_relative 'custom_header_sender'
require_relative 'us_street/client'
require_relative 'us_zipcode/client'
require_relative 'us_extract/client'
require_relative 'us_autocomplete/client'
require_relative 'international_street/client'
require_relative 'us_reverse_geo/client'
require_relative 'us_autocomplete_pro/client'

module SmartyStreets
  # The ClientBuilder class helps you build a client object for one of the supported SmartyStreets APIs.
  # You can use ClientBuilder's methods to customize settings like maximum retries or timeout duration.
  # These methods are chainable, so you can usually get set up with one line of code.
  class ClientBuilder
    INTERNATIONAL_STREET_API_URL = 'https://international-street.api.smartystreets.com/verify'.freeze
    US_AUTOCOMPLETE_API_URL = 'https://us-autocomplete.api.smartystreets.com/suggest'.freeze
    US_AUTOCOMPLETE_PRO_API_URL = 'https://us-autocomplete-pro.api.smartystreets.com/lookup'.freeze
    US_EXTRACT_API_URL = 'https://us-extract.api.smartystreets.com/'.freeze
    US_STREET_API_URL = 'https://us-street.api.smartystreets.com/street-address'.freeze
    US_ZIP_CODE_API_URL = 'https://us-zipcode.api.smartystreets.com/lookup'.freeze
    US_REVERSE_GEO_API_URL = 'https://us-reverse-geo.api.smartystreets.com/lookup'.freeze

    def initialize(signer)
      @signer = signer
      @serializer = NativeSerializer.new
      @http_sender = nil
      @max_retries = 5
      @max_timeout = 10
      @url_prefix = nil
      @proxy = nil
      @headers = nil
      @licenses = %w()
      @debug = nil
    end

    # Sets the maximum number of times to retry sending the request to the API. (Default is 5)
    #
    # Returns self to accommodate method chaining.
    def retry_at_most(max_retries)
      @max_retries = max_retries
      self
    end

    # The maximum time (in seconds) to wait for the response to be read. (Default is 10)
    #
    # Returns self to accommodate method chaining.
    def with_max_timeout(max_timeout)
      @max_timeout = max_timeout
      self
    end

    # Default is a series of nested senders. (See build_sender()
    #
    # Returns self to accommodate method chaining.
    def with_sender(sender)
      @http_sender = sender
      self
    end

    # Changes the Serializer from the default.
    #
    # Returns self to accommodate method chaining.
    def with_serializer(serializer)
      @serializer = serializer
      self
    end

    # This may be useful when using a local installation of the SmartyStreets APIs.
    # base_url is a string that defaults to the URL for the API corresponding to the Client object being built.
    #
    # Returns self to accommodate method chaining.
    def with_base_url(base_url)
      @url_prefix = base_url
      self
    end

    # Assigns a proxy through which all requests will be sent.
    # proxy is a Proxy object from this module.
    #
    # Returns self to accommodate method chaining.
    def with_proxy(host, port, username, password)
      @proxy = SmartyStreets::Proxy.new(host, port, username, password)
      self
    end

    # Allows you to submit custom headers using a Hash.
    # headers is a Hash object.
    #
    # Returns self to accommodate method chaining.
    def with_custom_headers(headers)
      @headers = headers
      self
    end

    # Allows the caller to specify the subscription license (aka "track") they wish to use.
    #
    # Returns self to accommodate method chaining.
    def with_licenses(licenses)
      @licenses.concat licenses
      self
    end

    # Enables debug mode, which will print information about the HTTP request and response to $stdout.
    #
    # Returns self to accommodate method chaining.
    def with_debug
      @debug = true
      self
    end

    # <editor-fold desc="Build methods">

    def build_international_street_api_client
      ensure_url_prefix_not_null(INTERNATIONAL_STREET_API_URL)
      InternationalStreet::Client.new(build_sender, @serializer)
    end

    def build_us_autocomplete_api_client
      ensure_url_prefix_not_null(US_AUTOCOMPLETE_API_URL)
      USAutocomplete::Client.new(build_sender, @serializer)
    end

    def build_us_autocomplete_pro_api_client
      ensure_url_prefix_not_null(US_AUTOCOMPLETE_PRO_API_URL)
      USAutocompletePro::Client.new(build_sender, @serializer)
    end

    def build_us_extract_api_client
      ensure_url_prefix_not_null(US_EXTRACT_API_URL)
      USExtract::Client.new(build_sender, @serializer)
    end

    def build_us_street_api_client
      ensure_url_prefix_not_null(US_STREET_API_URL)
      USStreet::Client.new(build_sender, @serializer)
    end

    def build_us_zipcode_api_client
      ensure_url_prefix_not_null(US_ZIP_CODE_API_URL)
      USZipcode::Client.new(build_sender, @serializer)
    end

    def build_us_reverse_geo_api_client
      ensure_url_prefix_not_null(US_REVERSE_GEO_API_URL)
      USReverseGeo::Client.new(build_sender, @serializer)
    end

    # </editor-fold>

    def build_sender
      return @http_sender unless @http_sender.nil?

      sender = NativeSender.new(@max_timeout, @proxy, @debug)

      sender = StatusCodeSender.new(sender)

      sender = CustomHeaderSender.new(sender, @headers) unless @headers.nil?

      sender = SigningSender.new(@signer, sender) unless @signer.nil?

      sender = RetrySender.new(@max_retries, sender, SmartyStreets::Sleeper.new,SmartyStreets::Logger.new) if @max_retries > 0

      sender = LicenseSender.new(sender, @licenses)

      URLPrefixSender.new(@url_prefix, sender)
    end

    def ensure_url_prefix_not_null(url)
      @url_prefix = url if @url_prefix.nil?
    end
  end
end
