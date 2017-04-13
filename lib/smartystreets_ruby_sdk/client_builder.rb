require_relative 'native_serializer'
require_relative 'native_sender'
require_relative 'status_code_sender'
require_relative 'signing_sender'
require_relative 'retry_sender'
require_relative 'url_prefix_sender'
require_relative 'sleeper'
require_relative 'logger'
require_relative 'us_street/client'
require_relative 'us_zipcode/client'
require_relative 'us_extract/client'

# The ClientBuilder class helps you build a client object for one of the supported SmartyStreets APIs.
# You can use ClientBuilder's methods to customize settings like maximum retries or timeout duration.
# These methods are chainable, so you can usually get set up with one line of code.
class ClientBuilder
  INTERNATIONAL_STREET_API_URL = 'https://international-street.api.smartystreets.com/verify'
  US_AUTOCOMPLETE_API_URL = 'https://us-autocomplete.api.smartystreets.com/suggest'
  US_EXTRACT_API_URL = 'https://us-extract.api.smartystreets.com/'
  US_STREET_API_URL = 'https://us-street.api.smartystreets.com/street-address'
  US_ZIP_CODE_API_URL = 'https://us-zipcode.api.smartystreets.com/lookup'

  def initialize(signer)
    @signer = signer
    @serializer = NativeSerializer.new
    @http_sender = nil
    @max_retries = 5
    @max_timeout = 10000
    @url_prefix = nil
  end

  # Sets the maximum number of times to retry sending the request to the API. (Default is 5)
  #
  # Returns self to accommodate method chaining.
  def retry_at_most(max_retries)
    @max_retries = max_retries
    self
  end

  # The maximum time (in milliseconds) to wait for a connection, and also to wait for
  # the response to be read. (Default is 10000)
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

  def build_sender
    return @http_sender if @http_sender != nil

    sender = NativeSender.new(@max_timeout)

    sender = StatusCodeSender.new(sender)

    sender = SigningSender.new(@signer, sender) if @signer != nil

    sender = RetrySender.new(@max_retries, sender, SmartystreetsRubySdk::Sleeper.new, SmartystreetsRubySdk::Logger.new) if @max_retries > 0

    URLPrefixSender.new(@url_prefix, sender)
  end

  def ensure_url_prefix_not_null(url)
    if @url_prefix.nil?
      @url_prefix = url
    end
  end
end