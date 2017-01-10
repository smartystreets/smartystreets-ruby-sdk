class RetrySender
  MAX_BACKOFF_DURATION = 10
  STATUS_OK = '200'

  attr_reader :sleep_durations

  def initialize(max_retries, inner)
    @max_retries = max_retries
    @inner = inner
    @sleep_durations = []
  end

  def send(request)
    response = @inner.send(request)

    for i in (0..@max_retries-1)
      if response.status_code == STATUS_OK
        break
      end

      backoff(i)

      response = @inner.send(request)
    end

  response
  end

  def backoff(attempt)
    backoff_duration = [attempt, MAX_BACKOFF_DURATION].min

    puts("There was an error processing the request. Retrying in #{backoff_duration} seconds...")
    sleep(backoff_duration)
  end
end