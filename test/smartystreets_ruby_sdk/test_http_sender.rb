require_relative '../../lib/smartystreets_ruby_sdk/http_sender'
require 'net/http'

class TestHTTPSender < Minitest::Test
  Net::HTTP.class_eval do
    class MockResponse
      attr_reader :body, :code

      def initialize(payload, status_code)
        @body = payload
        @code = status_code
      end

      def json
        @body
      end
    end

    def request(request)
      if request.uri == 'http://localhost/error'
        mock_response = MockResponse.new('Error test', 400)
      else
        mock_response = MockResponse.new('This is the test payload.', 200)
      end

      mock_response
    end
  end

  def test_request_contains_correct_content
    smarty_request = Request.new
    smarty_request.url_prefix = 'http://localhost'
    smarty_request.payload = 'This is the test content.'

    request = HTTPSender.build_request(smarty_request)

    assert_equal('This is the test content.', request.body)
  end

  def test_smarty_response_contains_correct_payload
    sender = HTTPSender.new
    smarty_request = Request.new
    smarty_request.url_prefix = 'http://localhost'
    smarty_request.payload = 'This is the test content.'

    response = sender.send(smarty_request)

    assert_equal('This is the test payload.', response.payload)
  end
end