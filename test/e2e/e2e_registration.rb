# frozen_string_literal: true

require 'e2e_helper'
require 'securerandom'

class TestRegistration < Minitest::Test
  include Shacip::Client

  def setup
    @rnd = SecureRandom.hex(16)
  end

  def test_create
    signup = { email: "#{@rnd}@example.com", password: 'foobar' }
    registration = Registration.create(signup)
    refute_nil registration
  end
end
