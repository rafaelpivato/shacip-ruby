# frozen_string_literal: true

require 'test_helper'

class TestEndorsementIntegration < Minitest::Test
  include Shacip::Client

  def test_create
    response = { data: { status: 'recognized' } }
    credentials = { email: 'foo@example.com', password: 'foobar' }
    args = [:endorsements, credentials]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :post, mock do
      endorsement = Endorsement.create(credentials)
      assert_kind_of Endorsement, endorsement
    end
    assert_mock mock
  end

  def test_unknown_credentials
    response = { data: { status: 'unknown', user: nil } }
    args = [:endorsements, { foo: 'bar' }]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :post, mock do
      endorsement = Endorsement.create foo: 'bar'
      assert_equal :unknown, endorsement.status
    end
  end

  def test_recognized_credentials
    user = { email: 'foo@bar.example.com', name: 'Foo Bar' }
    response = { data: { status: 'recognized', user: user } }
    args = [:endorsements, { foo: 'bar' }]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :post, mock do
      endorsement = Endorsement.create foo: 'bar'
      assert_equal :recognized, endorsement.status
    end
  end
end
