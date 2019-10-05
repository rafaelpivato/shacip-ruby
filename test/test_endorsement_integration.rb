# frozen_string_literal: true

require 'test_helper'

class TestWIPEndorsementIntegration < Minitest::Test
  def test_create_api_called
    called = false
    Api.stub :post, ->(_, _) { called = true } do
      Endorsement.create(email: 'foo@example.com', password: 'foobar')
    end
    assert called
  end

  def test_create_api_resource
    called = false
    post_stub = lambda do |resource, _|
      called = true
      assert_equal('endorsement', resource)
    end
    Api.stub :post, post_stub do
      Endorsement.create(email: 'foo@example.com', password: 'foobar')
    end
    assert called
  end

  def test_create
    called = false
    post_stub = lambda do |_, params|
      called = true
      assert_equal({ email: 'foo@example.com', password: 'foobar' }, params)
    end
    Api.stub :post, post_stub do
      Endorsement.create(email: 'foo@example.com', password: 'foobar')
    end
    assert called
  end
end
