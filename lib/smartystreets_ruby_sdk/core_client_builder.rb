require_relative 'native_serializer'
require_relative 'native_sender'
require_relative 'status_code_sender'
require_relative 'signing_sender'
require_relative 'retry_sender'
require_relative 'url_prefix_sender'

class CoreClientBuilder
  def initialize(signer)
    @signer = signer
    @serializer = NativeSerializer.new
    @http_sender = nil
    @max_retries = 5
    @max_timeout = 10000
    @url_prefix = ''
  end

  def retry_at_most(max_retries)
    @max_retries = max_retries
    self
  end

  def with_max_timeout(max_timeout)
    @max_timeout = max_timeout
    self
  end

  def with_serializer(serializer)
    @serializer = serializer
    self
  end

  def with_url(url_prefix)
    @url_prefix = url_prefix
    self
  end

  def build
    # Implemented in child classes
  end

  def build_sender
    return @http_sender if @http_sender != nil

    sender = NativeSender.new(@max_timeout)

    sender = StatusCodeSender.new(sender)

    sender = SigningSender.new(@signer, sender) if @signer != nil

    sender = RetrySender.new(@max_retries, sender) if @max_retries > 0

    URLPrefixSender.new(@url_prefix, sender)
  end
end