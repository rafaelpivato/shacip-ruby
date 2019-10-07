# frozen_string_literal: true

require 'test_helper'

class TestUser < Minitest::Test
  include Shacip::Client

  def test_class_exist
    assert User
  end

  def test_empty_initialize
    assert User.new
  end

  def test_initialize_attrs
    user = User.new(email: 'foo@example.com', name: 'Foo Bar', nickname: 'Foo')
    assert_equal 'foo@example.com', user.email
    assert_equal 'Foo Bar', user.name
    assert_equal 'Foo', user.nickname
  end

  def test_change_attrs
    user = User.new(email: 'foo@example.com', name: 'Foo Bar', nickname: 'Foo')
    user.email = 'qux@example.com'
    user.name = 'Qux Bar'
    user.nickname = 'Qux'
    assert_equal 'qux@example.com', user.email
    assert_equal 'Qux Bar', user.name
    assert_equal 'Qux', user.nickname
  end

  def test_respond_to_interface
    user = User.new
    assert_respond_to user, :email
    assert_respond_to user, :name
    assert_respond_to user, :nickname
  end
end
