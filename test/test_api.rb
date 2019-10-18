# frozen_string_literal: true

require 'test_helper'

class TestApi < Minitest::Test
  include Shacip::Client

  def setup
    @api = Api.new('http://foo', 'bar')
  end

  def test_class_exist
    assert Api
  end

  def test_empty_initialize
    assert Api.new
  end

  def test_initialize_attrs
    api = Api.new('http://foobar/', 'foobar')
    assert_equal 'http://foobar/', api.server_uri.to_s
    assert_equal 'foobar', api.api_key
  end

  def test_wont_change_attrs
    api = Api.new('http://foobar/', 'foobar')
    assert_raises { api.server_uri = 'qux' }
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

  def test_content_type
    assert_equal 'application/json', @api.headers['Content-Type']
  end

  def test_authorization
    assert_equal 'ShacipKey bar', @api.headers['Authorization']
  end

  def test_resource_path_collection
    assert_equal 'bars', @api.resource_path('bars')
  end

  def test_resource_path_detail
    assert_equal 'bars/123', @api.resource_path('bars', 123)
  end

  def test_resource_path_nested
    assert_equal 'a/456/b', @api.resource_path('a', 456, 'b')
  end

  def test_resource_path_object
    bar = Minitest::Mock.new.expect(:is_a?, true, [Resource])
    bar.expect(:id, 8).expect(:resource_name, 'bars')
    bar.expect(:is_a?, false, [URI::Generic])
    assert_equal 'bars/8/quxs', @api.resource_path(bar, 'quxs')
  end
end
