# frozen_string_literal: true

require 'e2e_helper'
require 'securerandom'

class TestLoadRegisteredUser < End2EndTest
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

  step 'Confirm registration' do
    registration_id = load_context(:registration_id)
    registration = Registration.confirm(registration_id)
    assert registration.confirmed, 'Registration not confirmed'
    assert registration.user, 'Missing user information'
    store_context user_id: registration.user.id
  end

  step 'Load registered user' do
    user_id = load_context(:user_id)
    user = User.load(user_id)
    assert user, 'User not loaded'
    assert_equal user_id, user.id
    store_context user: user
  end

  step 'List loaded user organizations' do
    user = load_context(:user)
    organizations = Organization.list(user)
    assert organizations, 'Organizations not listed'
    assert_equal 1, organizations.length
    assert organizations.first.id, 'Organization has no ID'
    store_context organization: organizations.first
  end

  step 'List first organization users' do
    user_id = load_context(:user_id)
    organization = load_context(:organization)
    users = User.list(organization)
    assert users, 'Users not listed'
    assert_equal 1, users.length
    assert_equal user_id, users.first.id
  end
end
