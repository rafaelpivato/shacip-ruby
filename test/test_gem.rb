# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'
require 'shacip-client'

class TestGem < Minitest::Test
  def test_running
    assert true, 'Tests not running.'
  end

  def test_shacip_client_endorsement
    assert Shacip::Client::Endorsement
  end

  def test_shacip_client_organization
    assert Shacip::Client::Organization
  end

  def test_shacip_client_registration
    assert Shacip::Client::Registration
  end

  def test_shacip_client_user
    assert Shacip::Client::User
  end
end
