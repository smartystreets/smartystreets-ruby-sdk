module SmartyStreets
  class RetrySender
    MAX_BACKOFF_DURATION = 10
    STATUS_TOO_MANY_REQUESTS = 429
    STATUS_TO_RETRY = [408, 429, 500, 502, 503, 504]

    def initialize(max_retries, inner, sleeper, logger)
      @max_retries = max_retries
      @inner = inner
      @sleeper = sleeper
      @logger = logger
    end

    def send(request)
      response = @inner.send(request)

      (1..@max_retries).each do |i|

        break if STATUS_TO_RETRY.include?(response.status_code.to_i) == false

        if response.status_code.to_i == STATUS_TOO_MANY_REQUESTS
          seconds_to_backoff = 10
          if response.header.nil? == false
            # Use proper exception handling instead of deprecated pattern
            begin
              retry_after = Integer(response.header["Retry-After"])
              seconds_to_backoff = retry_after
            rescue ArgumentError, TypeError
              # Keep default value if parsing fails
              seconds_to_backoff = 10
            end
          end
          rate_limit_backoff(seconds_to_backoff)
        else
          backoff(i)
        end
        response = @inner.send(request)
      end

      response
    end

    def backoff(attempt)
      backoff_duration = [attempt, MAX_BACKOFF_DURATION].min

      @logger.log("There was an error processing the request. Retrying in #{backoff_duration} seconds...")
      @sleeper.sleep(backoff_duration)
    end

    def rate_limit_backoff(backoff_duration)
      @logger.log("Rate limit reached. Retrying in #{backoff_duration} seconds...")
      @sleeper.sleep(backoff_duration)
    end
  end
end
