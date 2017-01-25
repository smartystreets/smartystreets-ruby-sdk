require 'minitest/autorun'
require 'net/http'
require_relative '../../lib/smartystreets_ruby_sdk/native_sender'
require_relative '../../lib/smartystreets_ruby_sdk/request'

class TestNativeSender < Minitest::Test
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
      if request.uri == URI.parse('http://localhost/error?')
        mock_response = MockResponse.new('Error test', '400')
      elsif request.uri == URI.parse('http://localhost/exception?')
        raise SmartyException
      else
        mock_response = MockResponse.new('This is the test payload.', '200')
      end

      mock_response
    end
  end

  def test_native_request_contains_post
    smarty_request = Request.new
    smarty_request.url_prefix = 'http://localhost'
    smarty_request.payload = 'Test Payload'

    request = NativeSender.build_request(smarty_request)

    assert_equal('POST', request.method)
  end

  def test_query_contains_correct_parameters
    smarty_request = Request.new
    smarty_request.url_prefix = 'http://localhost'
    smarty_request.payload = 'Test Payload'
    smarty_request.parameters = {'auth-id' => 'testID', 'auth-token' => 'testToken'}

    query = NativeSender.create_query(smarty_request)

    assert_equal('auth-id=testID&auth-token=testToken', query)
  end

  def test_request_contains_correct_content
    smarty_request = Request.new
    smarty_request.url_prefix = 'http://localhost'
    smarty_request.payload = 'This is the test content.'

    request = NativeSender.build_request(smarty_request)

    assert_equal('This is the test content.', request.body)
  end

  def test_smarty_response_contains_correct_payload
    sender = NativeSender.new
    smarty_request = Request.new
    smarty_request.url_prefix = 'http://localhost'
    smarty_request.payload = 'This is the test content.'

    response = sender.send(smarty_request)

    assert_equal('This is the test payload.', response.payload)
  end

  def test_smartyresponse_contains_status_code_200_on_success
    sender = NativeSender.new
    smarty_request = Request.new
    smarty_request.url_prefix = 'http://localhost'

    response = sender.send(smarty_request)

    assert_equal('200', response.status_code)
  end

  def test_smartyresponse_contains_status_code_400_when_server_gives_a_400
    sender = NativeSender.new
    smarty_request = Request.new
    smarty_request.url_prefix = 'http://localhost/error'

    response = sender.send(smarty_request)

    assert_equal('400', response.status_code)
  end

  def test_properly_handles_exceptions
    sender = NativeSender.new
    smarty_request = Request.new
    smarty_request.url_prefix = 'http://localhost/exception'

    response = sender.send(smarty_request)

    assert_instance_of(SmartyException, response.error)
  end

  def test_request_has_all_added_custom_headers
    smarty_request = Request.new
    smarty_request.url_prefix = 'http://localhost'
    smarty_request.headers = {'User-Agent' => ['Some plugin', 'Some other plugin'], 'X-Something' => ['X value']}

    native_request = NativeSender.build_request(smarty_request)

    assert_equal('smartystreets (sdk:ruby@0.0.0), Some plugin, Some other plugin', native_request['User-Agent'])
    assert_equal('X value', native_request['X-Something'])
  end
end