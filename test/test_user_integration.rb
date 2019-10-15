# frozen_string_literal: true

require 'test_helper'

class TestWIPUserIntegration < Minitest::Test
  include Shacip::Client

  def setup
    @user = User.new(id: 3, email: 'foo@example.com', name: 'Foo Bar',
                     nickname: 'Foo')
  end

  def test_list
    response = { data: [{ id: 1, email: 'foo@bar' }, { id: 2 }, { id: 3 }] }
    organization = Minitest::Mock.new
    args = [organization]
    assert_api :list, response, args do
      users = User.list(organization)
      assert_equal 'foo@bar', users.first.email
      assert_equal 3, users.length
    end
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
