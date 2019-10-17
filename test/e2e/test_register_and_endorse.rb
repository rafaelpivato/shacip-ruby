# frozen_string_literal: true

require 'e2e_helper'
require 'securerandom'

class TestRegisterAndEndorse < End2EndTest
  include Shacip::Client

  step 'Create registration' do
    rnd = SecureRandom.hex(16)
    signup = { email: "#{rnd}@example.com", password: 'foobar' }
    registration = Registration.create(signup)
    assert registration.id, 'Registration has no ID'
    assert registration.accepted, 'Registration not accepted'
    ctx[:registration] = registration
  end

  step 'Load registration' do
    registration = Registration.load(ctx[:registration].id)
    refute_empty registration.email, 'Registration email not present'
  end

  step 'Confirm registration' do
    registration = Registration.confirm(ctx[:registration].id)
    assert registration.confirmed, 'Registration not confirmed'
  end
end
