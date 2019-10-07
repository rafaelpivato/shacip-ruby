# frozen_string_literal: true

require 'test_helper'

class TestUserIntegration < Minitest::Test
  include Shacip::Client

  def setup
    @user = User.new(id: 3, email: 'foo@example.com', name: 'Foo Bar',
                     nickname: 'Foo')
  end

  def test_load
    response = { data: { id: 2, email: 'foo@example.com' } }
    args = [:users, 2]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :get, mock do
      user = User.load 2
      assert_equal 'foo@example.com', user.email
      assert_equal 2, user.id
    end
    assert_mock mock
  end

  def test_update
    response = { data: { id: 3, email: 'qux@example.com',
                         name: 'Foo Bar', nickname: 'Foo' } }
    args = [:users, 3, { email: 'qux@example.com' }]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :patch, mock do
      @user.email = 'qux@example.com'
      @user.update
      assert_equal 'qux@example.com', @user.email
    end
    assert_mock mock
  end
end
