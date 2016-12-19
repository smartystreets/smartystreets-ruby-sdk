require './test/mocks/failing_sender'
require './lib/smartystreets_ruby_sdk/request'
require './lib/smartystreets_ruby_sdk/retry_sender'

class TestRetrySender < Minitest::Test
  @sleep_durations = []

  RetrySender.class_eval do
    def backoff(attempt)
      @sleep_durations.push([attempt, 10].min)
    end
  end

  def setup
    @sleep_durations = []
  end

  def test_success_does_not_retry
    inner = FailingSender.new([200])

    send_with_retry(5, inner)

    assert_equal(1, inner.current_status_code_index)
  end

  def test_retry_until_success
    inner = FailingSender.new([401, 402, 400, 200, 500])

    send_with_retry(10, inner)

    assert_equal(4, inner.current_status_code_index)
  end

  def test_return_response_if_retry_limit_exceeded
    inner = FailingSender.new([500, 500, 500, 500, 500, 500])

    response, retry_sender = send_with_retry(4, inner)

    assert(response)
    assert_equal(5, inner.current_status_code_index)
    assert_equal([0,1,2,3], retry_sender.sleep_durations)
    assert_equal(500, response.status_code)
  end

  def test_backoff_does_not_exceed_max
    inner = FailingSender.new([401, 402, 400, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 200])

    _, retry_sender = send_with_retry(20, inner)

    assert_equal([0,1,2,3,4,5,6,7,8,9,10,10,10], retry_sender.sleep_durations)
  end

end

def send_with_retry(retries, inner)
  request = Request.new
  sender = RetrySender.new(retries, inner)

  [sender.send(request), sender]
end

