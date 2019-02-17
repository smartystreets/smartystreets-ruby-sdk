module SmartyStreets
  class RetrySender
    MAX_BACKOFF_DURATION = 10
    STATUS_INTERNAL_SERVER_ERROR = 500

    def initialize(max_retries, inner, sleeper, logger)
      @max_retries = max_retries
      @inner = inner
      @sleeper = sleeper
      @logger = logger
    end

    def send(request)
      response = @inner.send(request)

      (0..@max_retries-1).each do |i|
        break if response.status_code.to_i < STATUS_INTERNAL_SERVER_ERROR

        backoff(i)

        response = @inner.send(request)
      end

      response
    end

    def backoff(attempt)
      backoff_duration = [attempt, MAX_BACKOFF_DURATION].min

      @logger.warn("There was an error processing the request. Retrying in #{backoff_duration} seconds...")
      @sleeper.sleep(backoff_duration)
    end
  end
end
