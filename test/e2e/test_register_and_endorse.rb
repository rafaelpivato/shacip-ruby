# frozen_string_literal: true

require 'e2e_helper'
require 'securerandom'

class TestRegisterAndEndorse < End2EndTest
  include Shacip::Client

  step 'Create registration' do
    rnd = SecureRandom.hex(16)
    credentials = { email: "#{rnd}@example.com", password: 'foobar' }
    registration = Registration.create(credentials)
    assert registration.id, 'Registration has no ID'
    assert registration.accepted, 'Registration not accepted'
    store_context registration_id: registration.id,
                  credentials: credentials
  end

  step 'Load registration' do
    registration_id = load_context(:registration_id)
    registration = Registration.load(registration_id)
    refute_empty registration.email, 'Registration email not present'
  end

  step 'Confirm registration' do
    registration_id = load_context(:registration_id)
    registration = Registration.confirm(registration_id)
    assert registration.confirmed, 'Registration not confirmed'
  end

  step 'Endorse with same credentials' do
    credentials = load_context(:credentials)
    endorsement = Endorsement.create(credentials)
    assert endorsement.recognized, 'Endorsement not recognized'
  end

  step 'Refuse with different credentials' do
    credentials = load_context(:credentials).dup
    credentials[:password] = 'bad'
    endorsement = Endorsement.create(credentials)
    refute endorsement.recognized, 'Endorsement recognized'
  end
end
