# frozen_string_literal: true

require_relative '../test_helper'
require 'minitest/autorun'
require 'smartystreets_ruby_sdk/exceptions'

class TestExceptions < Minitest::Test
  def test_all_exceptions_inherit_from_smarty_error
    exception_classes = [
      SmartyStreets::SmartyError,
      SmartyStreets::NotModifiedInfo,
      SmartyStreets::BadCredentialsError,
      SmartyStreets::ForbiddenError,
      SmartyStreets::PaymentRequiredError,
      SmartyStreets::RequestEntityTooLargeError,
      SmartyStreets::BadRequestError,
      SmartyStreets::UnprocessableEntityError,
      SmartyStreets::TooManyRequestsError,
      SmartyStreets::InternalServerError,
      SmartyStreets::ServiceUnavailableError,
      SmartyStreets::GatewayTimeoutError,
      SmartyStreets::BatchFullError
    ]
    exception_classes.each do |klass|
      next if klass == SmartyStreets::SmartyError

      assert klass < SmartyStreets::SmartyError
      assert klass < StandardError
    end
  end

  def test_exceptions_can_be_raised_and_rescued
    assert_raises(SmartyStreets::BadRequestError) { raise SmartyStreets::BadRequestError, 'bad' }
    assert_raises(SmartyStreets::BatchFullError) { raise SmartyStreets::BatchFullError, 'full' }
  end
end
