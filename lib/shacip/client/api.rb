# frozen_string_literal: true

require 'net/http'
require 'singleton'

##
# Handles Shacip back-end communication
#
class Api
  include Singleton

  attr_reader :base_uri

  # Initializes configured to connect to localhost:3000
  def initialize(base = 'http://localhost:3000/')
    base = URI.parse(base) unless base.is_a? URI
    @base_uri = base
  end

  # Gets URI for a resource
  def resource_uri(resource)
    URI.join base_uri, resource.to_s
  end

  # Headers for an HTTP request
  def headers
    { 'Content-Type': 'application/json' }
  end

  # POST a JSON hash to Shacip back-end
  def self.post(resource, params)
    Api.instance.post(resource, params)
  end

  private

  def post(resource, params)
    response = Net::HTTP.post resource_uri(resource), params, headers
    JSON.parse(response.read_body) if response.value
  end
end
