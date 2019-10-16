# frozen_string_literal: true

require 'test_helper'

class TestConfiguration < Minitest::Test
  include Shacip::Client

  def test_instance_defaults
    cobj = Configuration.new
    refute_empty cobj.server_url
    refute_empty cobj.app_name
    assert_nil cobj.api_key
  end

  def test_instance_changes
    cobj = Configuration.new
    cobj.server_url = 'http://example.com/api/'
    assert_equal 'http://example.com/api/', cobj.server_url
  end

  def test_instance_dup
    cobj = Configuration.new
    dupped = cobj.dup
    cobj.server_url = 'http://foobar'
    refute_equal 'http://foobar', dupped.server_url
  end

  def test_global_configuration
    refute_empty Shacip::Client.configuration.server_url
  end

  def test_configure
    assert_nil Shacip::Client.configuration.api_key
    Shacip::Client.configure do |config|
      config.api_key = 'foobar'
    end
    assert_equal 'foobar', Shacip::Client.configuration.api_key
  end
end
