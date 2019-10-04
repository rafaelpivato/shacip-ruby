# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'
require 'shacip-client'

class TestEndorsement < Minitest::Test
  include Shacip::Client

  def test_class_exist
    assert Endorsement
  end

  def test_empty_initialize
    assert Endorsement.new
  end

  def test_initialize_credentials
    credentials = { email: 'foo@example.com', password: 'foobar' }
    endorsement = Endorsement.new(credentials)
    assert_equal 'foo@example.com', endorsement.email
    assert_equal 'foobar', endorsement.password
  end

  def test_set_credentials
    endorsement = Endorsement.new
    endorsement.email = 'foobar@example.com'
    endorsement.password = 'foobar'
    assert_equal 'foo@example.com', endorsement.email
    assert_equal 'foobar', endorsement.password
  end

  def test_respond_to_interface
    endorsement = Endorsement.new
    assert_respond_to endorsement, :recognized
    assert_respond_to endorsement, :organization
    assert_respond_to endorsement, :user
  end
end
