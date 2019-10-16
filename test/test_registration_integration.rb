# frozen_string_literal: true

require 'test_helper'

class TestRegistrationIntegration < Minitest::Test
  include Shacip::Client

  def test_create
    response = { data: { status: 'accepted' } }
    credentials = { email: 'foo@example.com', password: 'foobar' }
    args = [:registrations, credentials]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :post, mock do
      registration = Registration.create(credentials)
      assert_kind_of Registration, registration
      assert_equal :accepted, registration.status
    end
    assert_mock mock
  end

  def test_rejected_signup
    response = { data: { status: 'rejected' } }
    args = [:registrations, { foo: 'bar' }]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :post, mock do
      registration = Registration.create foo: 'bar'
      assert_equal :rejected, registration.status
    end
    assert_mock mock
  end

  def test_confirmed_signup
    response = { data: { status: 'confirmed' } }
    appdomain = 'foo.example.com'
    args = [:registrations, 1, { confirmed: appdomain }]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :patch, mock do
      registration = Registration.confirm 1, appdomain
      assert_equal :confirmed, registration.status
    end
    assert_mock mock
  end

  def test_load
    response = { data: { id: 2, status: 'foobar', email: 'foo@example.com' } }
    args = [:registrations, 2]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :get, mock do
      registration = Registration.load 2
      assert_equal :foobar, registration.status
      assert_equal 2, registration.id
    end
    assert_mock mock
  end
end
