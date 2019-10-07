# frozen_string_literal: true

require 'test_helper'

class TestOrganization < Minitest::Test
  include Shacip::Client

  def test_class_exist
    assert Organization
  end

  def test_empty_initialize
    assert Organization.new
  end

  def test_initialize_attrs
    org = Organization.new(name: 'Foo Account', number: '1234')
    assert_equal 'Foo Account', org.name
    assert_equal '1234', org.number
  end

  def test_change_attrs
    org = Organization.new(name: 'Foo Account', number: '1234')
    org.name = 'Qux Account'
    org.number = '5678'
    assert_equal 'Qux Account', org.name
    assert_equal '5678', org.number
  end

  def test_respond_to_interface
    org = Organization.new
    assert_respond_to org, :name
    assert_respond_to org, :number
  end
end
