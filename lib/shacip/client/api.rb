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
  def resource_uri(*args)
    resource, id = shift_resource(args)
    current = base_uri
    until id.nil?
      current = URI.join current, resource, id || ''
      resource, id = shift_resource(args)
    end
    current
  end

  # Headers for an HTTP request
  def headers
    { 'Content-Type': 'application/json' }
  end

  # GET a list of resources from Shacip back-end
  def self.list(*args)
    Api.instance.list(*args)
  end

  # POST a JSON hash to Shacip back-end
  def self.post(resource, params)
    Api.instance.post(resource, params)
  end

  # GET a JSON resource from Shacip back-end
  def self.get(resource, id)
    Api.instance.get(resource, id)
  end

  # PATCH a JSON hash to Shacip back-end
  def self.patch(resource, id, params)
    Api.instance.patch(resource, id, params)
  end

  private

  def shift_resource(args)
    resource = args.shift
    if resource.is_a? Resource
      [resource, resource.id]
    else
      [resource, args.shift]
    end
  end

  def to_name(resource)
    if resource.is_a? Resource
      resource.class.resource_name.to_s
    else
      resource.to_s
    end
  end

  def list(*args)
    response = Net::HTTP.get resource_uri(*args), headers
    JSON.parse(response.read_body) if response.value
  end

  def post(resource, params)
    response = Net::HTTP.post resource_uri(resource), params, headers
    JSON.parse(response.read_body) if response.value
  end

  def get(resource, id)
    response = Net::HTTP.get resource_uri(resource, id), headers
    JSON.parse(response.read_body) if response.value
  end

  def patch(resource, id, params)
    response = Net::HTTP.patch resource_uri(resource, id), params, headers
    JSON.parse(response.read_body) if response.value
  end
end
