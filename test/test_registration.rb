# frozen_string_literal: true

require 'test_helper'

class TestRegistration < Minitest::Test
  include Shacip::Client

  def test_class_exist
    assert Registration
  end

  def test_empty_initialize
    assert Registration.new
  end

  def test_initialize_signup
    signup = { email: 'foo@example.com', password: 'foobar' }
    registration = Registration.new(signup)
    assert_equal 'foo@example.com', registration.email
    assert_equal 'foobar', registration.password
  end

  def test_respond_to_interface
    registration = Registration.new
    assert_respond_to registration, :accepted
    assert_respond_to registration, :confirmed
    assert_respond_to registration, :organization
    assert_respond_to registration, :user
  end
end
