require 'minitest/autorun'
require './test/mocks/failing_sender'
require './test/mocks/fake_sleeper'
require './test/mocks/fake_logger'
require './lib/smartystreets_ruby_sdk/request'
require './lib/smartystreets_ruby_sdk/retry_sender'

class TestRetrySender < Minitest::Test

  def test_success_does_not_retry
    inner = FailingSender.new(['200'])

    send_with_retry(5, inner, FakeSleeper.new)

    assert_equal(1, inner.current_status_code_index)
  end

  def test_client_error_does_not_retry
    inner = FailingSender.new(['422'])
    send_with_retry(5, inner, FakeSleeper.new)

    assert_equal(1, inner.current_status_code_index)
  end

  def test_retry_until_success
    inner = FailingSender.new(%w(500 500 500 200 500))

    send_with_retry(10, inner, FakeSleeper.new)

    assert_equal(4, inner.current_status_code_index)
  end

  def test_return_response_if_retry_limit_exceeded
    inner = FailingSender.new(%w(500 500 500 500 500 500))
    sleeper = FakeSleeper.new

    response = send_with_retry(4, inner, sleeper)

    assert(response)
    assert_equal(5, inner.current_status_code_index)
    assert_equal([0,1,2,3], sleeper.sleep_durations)
    assert_equal('500', response.status_code)
  end

  def test_backoff_does_not_exceed_max
    inner = FailingSender.new(%w(500 500 500 500 500 500 500 500 500 500 500 500 500 200))
    sleeper = FakeSleeper.new

    send_with_retry(20, inner, sleeper)

    assert_equal([0,1,2,3,4,5,6,7,8,9,10,10,10], sleeper.sleep_durations)
  end

end

def send_with_retry(retries, inner, sleeper)
  request = SmartyStreets::Request.new
  sender = SmartyStreets::RetrySender.new(retries, inner, sleeper, FakeLogger.new)

  sender.send(request)
end
