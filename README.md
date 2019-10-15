# Shacip Ruby Client

[![CircleCI](https://circleci.com/gh/rafaelpivato/shacip-ruby.svg?style=svg)](https://circleci.com/gh/rafaelpivato/shacip-ruby) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/3881d92ad5d744e19d1acc756f9ad05f)](https://www.codacy.com/manual/rafaelpivato/shacip-ruby?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=rafaelpivato/shacip-ruby&amp;utm_campaign=Badge_Grade) [![Codacy Badge](https://api.codacy.com/project/badge/Coverage/3881d92ad5d744e19d1acc756f9ad05f)](https://www.codacy.com/manual/rafaelpivato/shacip-ruby?utm_source=github.com&utm_medium=referral&utm_content=rafaelpivato/shacip-ruby&utm_campaign=Badge_Coverage)

**A client library for connecting with [Shacip](https://github.com/rafaelpivato/shacip)**

## Hypothesis

This is in early alpha stage. The idea is to be able to use it like seen in
following sections.

### Configuration

```ruby
require 'shacip-client'

Shacip::Client.configure do |config|
  config.url = 'http://localhost:3001'
  config.app = 'myapp.example.com'
end
```

### Registration

```ruby
include Shacip::Client

# Start by creating a registration object against Shacip
credentials = { email: 'john@example.com', password: 'johndoe' }
registration = Registration.create(credentials)
if registration.accepted
  puts 'Send John a token with registration id'
  registration_id = registration.id
else
  raise StandarError, 'Registration not accepted'
end

# Optionally loads registration information
registration = Registration.load(registration_id)
puts "Email: #{registration.email}"

# Confirm registration by its identifier
registration = Registration.confirm(registration_id)
if registration.confirmed
  puts "User #{registration.user.id} created at Shacip"
  user = registration.user
  organization = registration.organization
end
```

## Authentication

```ruby
include Shacip::Client

# We authenticate by creating an endorsement
credentials = { email: 'john@example.com', password: 'johndoe' }
endorsement = Endorsement.create(credentials)
if endorsement.recognized
  puts "Let the user sign in"
  user = endorsement.user
end
```

## User Profile and Organization

```ruby
include Shacip::Client

user_id = 1234
user = User.load(user_id)
user.organizations.each do |org|
  puts "Organization #{org.name}"
end

organization_id = 2345
organization = Organization.load(organization_id)
puts "Owner #{organization.owner.email}"
User.list(organization).each do |user|
  puts "User #{user.email}"
end
```
