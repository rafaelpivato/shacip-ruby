# frozen_string_literal: true

require 'test_helper'

class TestOrganizationIntegration < Minitest::Test
  include Shacip::Client

  def setup
    @organization = Organization.new(id: 5, email: 'foo@example.com',
                                     name: 'Foo Bar', nickname: 'Foo')
  end

  def test_load
    response = { data: { id: 2, name: 'Foo Org' } }
    args = [:organizations, 2]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :get, mock do
      organization = Organization.load 2
      assert_equal 'Foo Org', organization.name
      assert_equal 2, organization.id
    end
    assert_mock mock
  end

  def test_update
    response = { data: { id: 5, name: 'Qux Org', number: '1234' } }
    args = [:organizations, 5, { name: 'Qux Org' }]
    mock = Minitest::Mock.new.expect :call, response, args
    Api.stub :patch, mock do
      @organization.name = 'Qux Org'
      @organization.update
      assert_equal 'Qux Org', @organization.name
    end
    assert_mock mock
  end
end
