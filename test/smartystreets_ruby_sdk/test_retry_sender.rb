require './test/mocks/failing_sender'
require './test/mocks/fake_sleeper'
require './lib/smartystreets_ruby_sdk/request'
require './lib/smartystreets_ruby_sdk/retry_sender'

class TestRetrySender < Minitest::Test

  # RetrySender.class_eval do
  #   def backoff(attempt)
  #     @sleep_durations.push([attempt, 10].min)
  #   end
  # end

  # Kernel.class_eval do
  #   def sleep(seconds)
  #     @sleep_durations.push(seconds)
  #   end
  # end


  def test_success_does_not_retry
    inner = FailingSender.new(['200'])

    send_with_retry(5, inner, FakeSleeper.new)

    assert_equal(1, inner.current_status_code_index)
  end

  def test_retry_until_success
    inner = FailingSender.new(['401', '402', '400', '200', '500'])

    send_with_retry(10, inner, FakeSleeper.new)

    assert_equal(4, inner.current_status_code_index)
  end

  def test_return_response_if_retry_limit_exceeded
    inner = FailingSender.new(['500', '500', '500', '500', '500', '500'])
    sleeper = FakeSleeper.new

    response = send_with_retry(4, inner, sleeper)

    assert(response)
    assert_equal(5, inner.current_status_code_index)
    assert_equal([0,1,2,3], sleeper.sleep_durations)
    assert_equal('500', response.status_code)
  end

  def test_backoff_does_not_exceed_max
    inner = FailingSender.new(['401', '402', '400', '500', '500', '500', '500', '500', '500', '500', '500', '500', '500', '200'])
    sleeper = FakeSleeper.new

    send_with_retry(20, inner, sleeper)

    assert_equal([0,1,2,3,4,5,6,7,8,9,10,10,10], sleeper.sleep_durations)
  end

end

def send_with_retry(retries, inner, sleeper)
  request = Request.new
  sender = RetrySender.new(retries, inner, sleeper)

  sender.send(request)
end

