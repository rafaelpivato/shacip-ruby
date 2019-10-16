# frozen_string_literal: true

require 'test_helper'

class TestApi < Minitest::Test
  include Shacip::Client

  def test_class_exist
    assert Api
  end

  def test_empty_initialize
    assert Api.new
  end

  def test_initialize_attrs
    api = Api.new('http://foobar/', 'foobar')
    assert_equal 'http://foobar/', api.server_url
    assert_equal 'foobar', api.api_key
  end

  def test_wont_change_attrs
    api = Api.new('http://foobar/', 'foobar')
    assert_raises { api.server_url = 'qux' }
    assert_raises { api.api_key = 'baz' }
  end

  def test_respond_to_interface
    api = Api.new
    assert_respond_to api, :list
    assert_respond_to api, :post
    assert_respond_to api, :get
    assert_respond_to api, :patch
  end

  def test_class_interface
    assert_respond_to Api, :list
    assert_respond_to Api, :post
    assert_respond_to Api, :get
    assert_respond_to Api, :patch
  end
end
