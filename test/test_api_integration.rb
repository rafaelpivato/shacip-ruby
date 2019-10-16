# frozen_string_literal: true

require 'test_helper'

class TestApiIntegration < Minitest::Test
  include Shacip::Client

  def setup
    @api = Api.new('http://foo', 'bar')
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

  def test_list
    body = { data: [{ id: 1 }] }
    args = ['resources', Hash]
    assert_http :get, body, args do
      response = @api.list 'resources'
      assert_equal body, response
    end
  end

  def test_post
    body = { data: { name: 'foobar' } }
    params = { name: 'foobar' }
    args = ['quxs', params, Hash]
    assert_http :post, body, args do
      response = @api.post 'quxs', params
      assert_equal body, response
    end
  end

  def test_get
    body = { data: { name: 'foobar' } }
    args = ['bars/1234', Hash]
    assert_http :get, body, args do
      response = @api.get 'bars', 1234
      assert_equal body, response
    end
  end

  def test_patch
    body = { data: { name: 'quxbaz' } }
    params = { name: 'quxbaz' }
    args = ['foos/4567', params, Hash]
    assert_http :patch, body, args do
      response = @api.patch 'foos', 4567, params
      assert_equal body, response
    end
  end
end
